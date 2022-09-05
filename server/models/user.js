const mongoose = require("mongoose");
const { productSchema } = require('../models/product');

const userSchema = mongoose.Schema({
    name: {
        required: true,
        type: String,
        trim: true,
    },
    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re)
            }
        },
        message: "Please enter a valid address"
    },
    password: {
        required: true,
        type: String,
    },
    address: {
        type: String,
        default: ''
    },
    type: {
        type: String,
        default: ''
    },
    cart: [
        {
            product: productSchema,
            quantity: {
                type: Number,
                require: true,
            }
        }
    ],
});

const User = mongoose.model("User", userSchema);

module.exports = User;