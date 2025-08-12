const { get } = require('mongoose');
const  Product = require('../models/product');


const productController = {
    getAllProducts : async (req, res) => {
    try {
        const products = await Product.find();
        res.status(200).json(products);
    } catch (error) {
        res.status(500).json({ message: 'Error fetching products', error: error.message });
    }
    },
    getProductById: async (req, res) => {
        const productId = req.params.id; 
        try {
             const product = await Product.findOne({ id: productId });
            if (!product) {
                return res.status(404).json({ message: 'Product not found' });
            }
            res.status(200).json(product);
        } catch (error) {
            res.status(500).json({ message: 'Error fetching product', error: error.message });
        }  
    },
}



module.exports = productController;