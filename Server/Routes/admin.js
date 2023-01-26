const express = require('express');
const adminRoute = express.Router();
const admin = require('../MiddleWares/admin');
const {Product} = require('../Models/product');
const Order = require('../Models/order');

//Add the product
adminRoute.post('/admin/add-product',admin,async (req,res)=>{
    try{
        const {name, description,images,quantity,price,category} =req.body;
        let product = new Product({
            name,
            description,
            images,
            quantity,
            price,
            category,
        });
        product = await  product.save();
        res.json(product);

    }catch(e){
        res.status(500).json({error:e.message});
    }
});

// Get all your products
adminRoute.get("/admin/get-products", admin, async (req, res) => {
    try {
      const products = await Product.find({});
      res.json(products);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });

//Delete the products
adminRoute.post('/admin/delete-product',admin,async(req,res)=>{
    try{
        const {id}=req.body;
        const product= await Product.findByIdAndDelete(id);
       // product= await product.save();
        res.json(product);
    }catch(e){
        res.status(500).json({ error: e.message });
    }
});

// Get all your Orders
adminRoute.get("/admin/get-orders", admin, async (req, res) => {
    try {
      const orders = await Order.find({});
      res.json(orders);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });

adminRoute.post('/admin/change-order-status',admin,async(req,res)=>{
    try{
        const {id,status}=req.body;
        let order= await Order.findById(id);
        order.status=status;
        order= await order.save();
        res.json(order);
    }catch(e){
        res.status(500).json({ error: e.message });
    }
});

adminRoute.get('/admin/analytics',admin,async(req,res)=>{
  try{
    const orders =await Order.find();
    let totalEarnings =0;
    for(let i=0; i<orders.length; i++){
      for(let j=0; j<orders[i].products.length; j++){
        totalEarnings+= orders[i].products[j].quantity* orders[i].products[j].product.price;
      }
    }
    // Category Wise Order Fetching
   let mobileEarnings= await fetchCategoryWiseProduct('Mobiles');
   let essentialEarnings= await fetchCategoryWiseProduct('Essentials');
   let applianceEarnings= await fetchCategoryWiseProduct('Appliances');
   let booksEarnings= await fetchCategoryWiseProduct('Books');
   let fashionEarnings= await fetchCategoryWiseProduct('Fashions');

   let earnings ={
    totalEarnings,
    mobileEarnings,
    essentialEarnings,
    booksEarnings,
    applianceEarnings,
    fashionEarnings
   }
   res.json(earnings);

  }catch(e){
    res.status(500).json({ error: e.message });

  }
})

async function fetchCategoryWiseProduct(category){
  let categoryOrders= await Order.find({'products.product.category':category,});
  let earnings=0;
  for(let i=0; i<categoryOrders.length; i++){
    for(let j=0; j<categoryOrders[i].products.length; j++){
      earnings+= categoryOrders[i].products[j].quantity* categoryOrders[i].products[j].product.price;
    }
  }
  return earnings;

}

module.exports = adminRoute;
