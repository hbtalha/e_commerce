const mongoose = require('mongoose');

const ratingSchema = mongoose.Schema({
    userId: {
        type: String,
        required: true,
    },
    userName: {
        type: String,
        required: true,
    },
    rating: {
        type: Number,
        required: true,
    },
    comment: {
        type: String,
        required: false,
    },
    date: {
        type: String,
        required: true,
    }
});

module.exports = ratingSchema;