const mongoose = require('mongoose');

const productSchema = new mongoose.Schema({
  id: { type: String, required: true }, // Nếu bạn muốn dùng _id mặc định của Mongo thì có thể bỏ trường này
  name: { type: String, required: true },
  description: { type: String },
  quantity: { type: Number, required: true },
  unit: { type: String, required: true },
  barcode: { type: String },
  expiryDate: { type: Date },
  location: { type: String },
  imageUrl: { type: String }
}, {
  timestamps: true // Tự động thêm createdAt, updatedAt
});

module.exports = mongoose.model('Product', productSchema);
