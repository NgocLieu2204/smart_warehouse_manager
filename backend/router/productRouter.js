const express = require('express');
const productController = require('../controllers/productController');


const router = express.Router();

// Route to get all products
router.get('/getAllProduct', productController.getAllProducts);
router.get('/getProductById/:id', productController.getProductById);
module.exports = router;