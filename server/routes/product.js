const express = require('express');
const auth = require('../middleware/auth');
const productRouter = express.Router();
const { Product } = require('../models/product');

productRouter.get('/api/products/search', auth, async (req, res) => {
    const minPrice = req.query.minPrice;
    const maxPrice = req.query.maxPrice;
    const hasDiscounts = req.query.hasDiscounts;
    const searchByDiscount = req.query.searchDiscount;
    const searchQuery = req.query.searchQuery;
    try {
        let products;
        if (searchByDiscount == true) {
            products = await Product.find({
                $and: [
                    { $or: [{ "name": { $regex: searchQuery, $options: "i" } }, { "details.adjective": { $regex: searchQuery, $options: "i" } }] },
                    { price: { $lte: maxPrice, $gte: minPrice } },
                    { hasDiscount: hasDiscounts }
                ]
            });
        }
        else {
            products = await Product.find({
                $and: [
                    { $or: [{ "name": { $regex: searchQuery, $options: "i" } }, { "details.adjective": { $regex: searchQuery, $options: "i" } }] },
                    { price: { $lte: maxPrice, $gte: minPrice } },
                ]
            });
        }
        res.json(products);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

productRouter.post('/api/rate-product', auth, async (req, res) => {
    try {
        let { id, rating, comment, date, userName } = req.body;

        if (!comment) {
            comment = ' ';
        }

        let product = await Product.findById(id);

        for (let i = 0; i < product.ratings.length; i++) {
            if (product.ratings[i].userId = req.user) {
                product.ratings.splice(i, 1);
            }
        }

        const ratingSchema = {
            userId: req.user,
            userName: userName,
            rating: rating,
            comment: comment,
            date: date,
        }

        product.ratings.push(ratingSchema);

        product = product.save();

    } catch (error) {
        console.log(error.message);
        res.status(500).json({ error: error.message });
    }
});

productRouter.get('/api/products-with-discount/:isForHomeDisplay', auth, async (req, res) => {
    try {
        console.log(req.params.isForHomeDisplay);
        let products = null;
        if (req.params.isForHomeDisplay == true) {
            // products = await Product.find({ hasDiscount: true }).limit(6);
            products = await Product.aggregate([
                { $match: { hasDiscount: true } },
                { $sample: { size: 6 } }
            ]);
        }
        else {
            products = await Product.find({ hasDiscount: true });
        }

        console.log(products.length);

        return res.json((products == null) ? [] : products);

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

productRouter.get('/api/more-products', auth, async (req, res) => {
    try {
        const products = await Product.aggregate([{ $sample: { size: 10 } }]);
        // const products = await Product.find().limit(10);
        return res.json(products);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

productRouter.get('/api/product-details', auth, async (req, res) => {
    try {
        const product = await Product.findById(req.query.id);
        res.json(product);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = productRouter;