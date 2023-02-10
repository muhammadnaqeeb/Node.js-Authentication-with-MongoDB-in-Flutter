// importing
const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");

const PORT = process.env.PORT || 3000;

// initillize express into a variable
const app = express();

// middleware, this basically make shore that whatever request 
// which is coming to our server get passed in json format
app.use(express.json());
app.use(authRouter);

const DB = "mongodb://naqeeb:Naqeeb410.@ac-vcbmo23-shard-00-00.nwzebzg.mongodb.net:27017,ac-vcbmo23-shard-00-01.nwzebzg.mongodb.net:27017,ac-vcbmo23-shard-00-02.nwzebzg.mongodb.net:27017/?ssl=true&replicaSet=atlas-nyq25d-shard-0&authSource=admin&retryWrites=true&w=majority";

// connecting to database
mongoose.connect(DB).then(()=>{
    console.log("Connection Successful to DB")
}).catch((e) => {
    console.log(e);
});
// listening to port
// 0.0.0.0 means accessable from anywhere
app.listen(PORT, "0.0.0.0", () => {
    console.log(`connected at port ${PORT}`);
});