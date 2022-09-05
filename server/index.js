//PACKAGE IMPORTS
const express = require("express");
const mongoose = require("mongoose");

//FILES IMPORTS
const authRouter = require("./routes/auth");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");

//INIT
const PORT = 3000;
const app = express();
const DB = "mongodb+srv://helder:NuSaBomDemais@cluster0.0yno4ol.mongodb.net/?retryWrites=true&w=majority";

//MIDDLEWARE
app.use(express.json())
app.use(authRouter);
app.use(productRouter);
app.use(userRouter);

mongoose.connect(DB).then(() => {
    console.log("Connected to db");
}).catch((e) => {
    console.log(e);
});

app.listen(PORT, "localhost", () => {
    console.log(`Connected at port ${PORT}`);
});