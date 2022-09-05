const express = require('express');
const auth = require('../middleware/auth');
const { Product } = require('../models/product');
const User = require('../models/user');
const userRouter = express.Router();
// add product


userRouter.post('/api/modify-cart', auth, async (req, res) => {
    try {
        const { id, quantity } = req.body;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);

        let isProductFound = false;
        for (let i = 0; i < user.cart.length; ++i) {
            if (user.cart[i].product._id.equals(product._id)) {
                user.cart[i].quantity = quantity;
                isProductFound = true;
                break;
            }
        }

        if (!isProductFound) {
            user.cart.push({ product, quantity: 1 });
        }

        user = await user.save();
        res.json(user);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

userRouter.delete('/api/remove-from-cart', auth, async (req, res) => {
    try {
        const { ids } = req.body;
        const products = await Product.find().where('_id').in(ids).exec();
        let user = await User.findById(req.user);

        for (let i = user.cart.length - 1; i >= 0; --i) {
            if (products.some((element) => element._id.equals(user.cart[i].product._id))) {
                user.cart.splice(i, 1);
            }
        }

        user = await user.save();
        res.json(user);
    } catch (error) {
        console.log(error.message);
        res.status(500).json({ error: error.message });
    }
});

module.exports = userRouter;