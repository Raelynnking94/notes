import express from 'express';
import multer from 'multer';
import sharp from 'sharp';
import path from 'path';
import { verifyToken } from '../middleware/auth.js';
import Transaction from '../models/Transaction.js';

const router = express.Router();

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/receipts/');
  },
  filename: (req, file, cb) => {
    cb(null, `${req.userId}-${Date.now()}${path.extname(file.originalname)}`);
  }
});

const upload = multer({
  storage,
  fileFilter: (req, file, cb) => {
    if (file.mimetype.startsWith('image/')) {
      cb(null, true);
    } else {
      cb(new Error('Only image files allowed'));
    }
  }
});

router.use(verifyToken);

// Upload receipt and attach to transaction
router.post('/receipt/:transactionId', upload.single('receipt'), async (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({ error: 'No file uploaded' });
    }

    // Compress image with sharp
    const compressedPath = `uploads/receipts/compressed-${req.file.filename}`;
    await sharp(req.file.path)
      .resize(1200, 1200, { fit: 'inside', withoutEnlargement: true })
      .jpeg({ quality: 80 })
      .toFile(compressedPath);

    // Update transaction with receipt URL
    const transaction = await Transaction.findByIdAndUpdate(
      req.params.transactionId,
      {
        receiptUrl: `/receipts/${compressedPath}`,
        updatedAt: new Date()
      },
      { new: true }
    );

    res.json({
      message: 'Receipt uploaded successfully',
      receiptUrl: transaction.receiptUrl
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

export default router;
