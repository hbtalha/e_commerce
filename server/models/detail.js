const mongoose = require('mongoose');

const detailSchema = mongoose.Schema({
    material: {
        type: String,
        required: true,
    },
    adjective: {
        type: String,
        required: true,
    }
});

module.exports = detailSchema;