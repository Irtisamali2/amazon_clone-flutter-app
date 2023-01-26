//IMPORT
const mongoose =require('mongoose');

console.log('Hello, World');

//IMPORT FROM OTHER FILES
const authRouter = require('./Routes/auth');



//INIT
const DB = "mongodb+srv://irtisam:irtisam123@cluster0.y0npxwt.mongodb.net/?retryWrites=true&w=majority";
const PORT =3000;
// CREATNING AN API
// Get, Put, Post, Delete, Update -> CRUD
const express =require('express');
const adminRoute = require('./Routes/admin');
const productRouter = require('./Routes/product');
const userRouter = require('./Routes/user');


const app = express();

//const express =require('express');

//MiddleWare
app.use(express.json());
app.use(authRouter);
app.use(adminRoute);
app.use(productRouter);
app.use(userRouter);
//Connection
mongoose
    .connect(DB)
    .then(()=>{
        console.log("Connection Successful");
    }).catch((e)=>{
        console.log(e);
    });

// app.get('/Hello-world',(req, res)=>{
//  res.json({hi:'Hello World'});
// });
// app.get('/',(req, res) =>{
//     res.json({name:'Irtisam Ali'});
// });
app.listen(PORT,"0.0.0.0" ,() =>{
console.log(`connected at port ${PORT}`);
});
//localhost
//127.0.0.1
