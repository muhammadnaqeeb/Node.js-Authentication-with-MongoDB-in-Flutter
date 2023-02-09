// importing
const express = require("express");
const mongoose = require("mongoose");

const PORT = process.env.PORT || 3000;

// initillize express into a variable
const app = express();

// middleware, this basically make shore that whatever request 
// which is coming to our server get passed in json format
app.use(express.json());

// listening to port
// 0.0.0.0 means accessable from anywhere
app.listen(PORT, "0.0.0.0", () => {
    console.log(`connected at port ${PORT}`);
});