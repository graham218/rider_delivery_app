const express = require("express");
// we are basically making own router so instead of app.get or app.post 
// we use authRouter.get etc
const authRouter = express.Router();
const bcryptjs = require("bcryptjs");
const User = require("../models/user");
const jwt = require('jsonwebtoken');
const auth = require("../middleware/auth");

// SIGN UP
authRouter.post("/api/signup", async (req, res)=>{
     try{
       //STEP 1 : Extract User Input (name, email and password) destructuring
       // name = req.body.name
       const {name, email, password }=req.body;
       //STEP 2: Look for any existing user 
       const existingUser = await User.findOne({email});
       if(existingUser){
        return res.status(400).json({msg:"User with same email already exists! "});
       }

       // STEP 3: Hash/Encrypt password.if user does not exist then Hash the password and store in Database
       const hashedPassword = await bcryptjs.hash(password, 8);

       // STEP 4 : Create User Model
       let user = new User({
        email,
        password: hashedPassword,
        name
       });
       // here mongoDB will add _id and version
       user = await user.save();
       res.json(user);
     }catch(e){
        // STEP 5 :	Throw any server error
        res.status(500).json({error: e.message})
     }
});

// SIGN IN / LOG IN
authRouter.post("/api/signin", async (req, res) => {
    try{
        // Extract User Input
       const {email, password} = req.body;

       // find that email
       const user = await User.findOne({email});

       // if there is no user
       if(!user){
        return res.status(400).json({msg:"User with this email does not exist! "});
       }

       // check password typed in matchs with one in database
       // as passwords in DB are hashed so
       // compare(password that user typed, which user to compare )
       const isMatch = await bcryptjs.compare(password, user.password);

       if(!isMatch){
        return res.status(400).json({msg: "Incorrect Password"});
       }

       // we store this token to local storage (shared prefences) 
       // so we can use that to known we are already logedin or not
       const token = jwt.sign({id:user._id}, "passwordKey");
       // sending token and doc of that user NOTE: don't send all users data
       res.json({token, ...user._doc})
    }catch(e){
        res.status(500).json({error: e.message});
    }
});

authRouter.post("/tokenIsValid", async (req, res) => {
    try{
        const token = req.header("x-auth-token");
        if(!token){
            return res.json(false);
        }
        // if there is token, the we verify it
        const verified = jwt.verify(token, "passwordKey");
        if(!verified){
            return res.json(false);
        }

        const user = await User.findById(verified.id);
        if(!user){
            return res.json(false);
        }
        res.json(true);
    }catch (e){
        res.status(500).json({ error: e.message });
    }
});

// get user data
// auth is a middleware, whic will extract the token, 
// and lets us know the user is authenticated or not
// and this auth is present in middleware/auth.js
authRouter.get("/", auth, async (req, res)=>{
    const user = await User.findById(req.user);
    res.json({...user._doc, token: req.token});
    
});

// exportingauthRouter, so we can use in index.js
module.exports = authRouter;
