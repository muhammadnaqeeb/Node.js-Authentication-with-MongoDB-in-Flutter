const express = require("express");
// we are basically making own router so instead of app.get or app.post 
// we use authRouter.get etc
const authRouter = express.Router();
const bcryptjs = require("bcryptjs");
const User = require("../models/user");

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

// exportingauthRouter, so we can use in index.js
module.exports = authRouter;
