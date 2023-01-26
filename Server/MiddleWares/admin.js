const jwt = require('jsonwebtoken');
const User= require('../Models/user');
const admin = async(req, res, next) =>{
    try{
        const token = req.header('x-auth-token');
        if(!token){
            return res.status(401).json({msg:"No auth token, Access Denied"});
        }
        const verifyToken = jwt.verify(token, 'passwordKey');
        if(!verifyToken){
            return res.status(401).json({msg: "Token Verification Failed"});
        }
        const user = await User.findById(verifyToken.id);
        if(user.type== 'user' || user.type== 'seller'){
            return res.status(401).json({msg: "You are not an admin"});
        }
        req.user= verifyToken.id;
        req.token= token;
        next();

    }catch(e){
        res.status(500).json({error: e.message});
    }
}
module.exports = admin;