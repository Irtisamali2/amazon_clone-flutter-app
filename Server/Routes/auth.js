const express =require('express');
const User =require('../Models/user');
const bcryptjs= require('bcryptjs');
const authRouter =express.Router();
const jwt = require('jsonwebtoken');
const { request } = require('http');
const auth = require('../MiddleWares/auth');

authRouter.post('/api/signup', async (req,res)=>{
     try{
        const {name, email, password} =req.body; //get the data from client
        const existingUser = await User.findOne({email});
        if(existingUser){
             return res.status(400).json({msg :'User with same email already exists'});
        }
        const hashedPassword =await bcryptjs.hash(password, 8);
        let user = new User({
         email,
         password: hashedPassword,
         name,
 
        });
        user = await user.save();
        res.json(user);
        //post data in database
 
        //return that data to user

     }catch(e){
        res.status(500).json({error: e.message});
     }
});

//Sign In Route
authRouter.post('/api/signin',async (req,res) =>{
   try{
      const {email, password} = req.body;
      const user = await User.findOne({email: email});
      if(!user){
         return res.status(400).json({msg: 'User not found'});
      }
      const isMatch = await bcryptjs.compare(password, user.password);
      if(!isMatch){
         return res.status(400).json({msg: 'Incorrect password'});
      }
      //token
      const token = jwt.sign({id:user._id},"passwordKey");
      res.json({token,...user._doc});
   }catch(e){
      res.status(500).json({error: e.message});
   }

});

authRouter.post('/tokenIsValid',async (req, res)=>{

   try{
      const token = req.header('x-auth-token');
      if(!token){
         res.json(false);
      }
     const verified = jwt.verify(token, 'passwordKey')
     if(!verified){
      res.json(false);
   }
   const user = await User.findById(verified.id);
   if(!user){
      res.json(false);
   }
   res.json(true);
      
   }catch(e){
      return res.status(500).json({error: e.message});
   }
});

//get user data
authRouter.get('/',auth,async (req, res) => {
   const user = await User.findById(req.user);
   res.json({...user._doc,token:req.token});
});

module.exports = authRouter;