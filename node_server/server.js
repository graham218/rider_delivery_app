// importing
const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");
require('dotenv').config();

// Use environment variables
const PORT = process.env.PORT || 3000;
const DB = process.env.MONGO_DB_URI;
// initillize express into a variable
const app = express();

// middleware, this basically make shore that whatever request
// which is coming to our server get passed in json format
app.use(express.json());
app.use(authRouter);

// connecting to database
mongoose.connect(DB).then(()=>{
    console.log("Connection Successful to DB")
}).catch((e) => {
    console.log("Mongo DB Connection wasn't successful");
});
// listening to port
// 0.0.0.0 means accessable from anywhere
app.listen(PORT, "0.0.0.0", () => {
    console.log(`connected at port ${PORT}`);
});