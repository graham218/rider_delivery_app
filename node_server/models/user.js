const mongoose = require("mongoose");

// userSchema is basically the structure of how user look like
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
        // validate if it is a proper email or not
        validate: {
            validator: (value) => {
                // for validation we use regex
                const re =  /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re)
            },
            message: "Please enter a valid email address",
        },
    },
    password: {
        required: true,
        type: String,
        // you can also put some validation here like password should be 8 character long etc
    }

});

// convert schema to User and export it
// model(name of schema , then Schema itself)
const User = mongoose.model("User", userSchema);


// export user
module.exports = User;