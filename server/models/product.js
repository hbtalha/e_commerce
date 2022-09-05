const mongoose = require("mongoose");
const detailSchema = require("./detail");
const ratingSchema = require("./rating");

const productSchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true,
  },
  description: {
    type: String,
    required: true,
    trim: true,
  },
  gallery: [
    {
      type: String,
      required: true,
    },
  ],
  price: {
    type: Number,
    required: true,
  },
  hasDiscount: {
    type: Boolean,
    required: true,
  },
  discountValue: {
    type: Number,
    required: true,
  },

  ratings: [ratingSchema],
  details: detailSchema
});

const Product = mongoose.model("Product", productSchema);
module.exports = { Product, productSchema };