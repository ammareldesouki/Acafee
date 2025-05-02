import 'package:ammarcafe/contest/colors.dart';
import 'package:ammarcafe/models/item_class.dart';
import 'package:ammarcafe/widget/botton_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ammarcafe/models/cart.dart';

class SingleItemScreen extends StatefulWidget {
  final Item item;

  const SingleItemScreen({super.key, 
    required this.item,
  });

  @override
  _SingleItemScreenState createState() => _SingleItemScreenState();
}

class _SingleItemScreenState extends State<SingleItemScreen> {
  int quantity = 1;

  void _increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  void _addToCart(BuildContext context) {
    Provider.of<CartModel>(context, listen: false).addToCart(widget.item);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Added to Cart'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.name),
        backgroundColor: AppColors.primaryVariant,
      
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40,),
          Row(
        mainAxisAlignment:MainAxisAlignment.center,
            children: [
              Container(
                width: 320,
                height: 320,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.red.shade100,
                ),
                 child: Image.asset(widget.item.imageUrl,fit: BoxFit.cover,),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             Padding(
               padding: const EdgeInsets.only(left: 20.0),
               child: Text(widget.item.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
             ),
                   Padding(
                     padding: const EdgeInsets.only(right: 20.0),
                     child: Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   IconButton(
                                     icon: const Icon(Icons.remove),
                                     onPressed: _decreaseQuantity,
                                   ),
                                   Text('$quantity', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                   IconButton(
                                     icon: const Icon(Icons.add),
                                     onPressed: _increaseQuantity,
                                   ),
                             
                               
                              
                                  
                                 ],
                               ),
                   ),

            ],
          ),

          Row(
            children: [
           Text(widget.item.description,style: const TextStyle(fontSize: 20), ),


            ],
          ),
          
        
    
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: () => _addToCart(context),
                
                icon: const Icon(Icons.shopping_cart,color: Colors.white,),
                label: const Text('Add to Cart', style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  textStyle: const TextStyle(fontSize: 18),
                  backgroundColor: AppColors.primaryColor,
                  minimumSize: const Size(100, 50),
                ),
              ),
                         ElevatedButton.icon(
                     
          
          
                icon: const Icon(Icons.favorite_border,color: Colors.white,),
                            label: const Text('Like !',style: TextStyle(color: Colors.white,)),
          
          onPressed: () {
            // Handle favorite button action
          },
                      style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 18),
                  backgroundColor: AppColors.primaryColor,
                  minimumSize: const Size(60, 50),
                ),
                    ),
            ],
          ),
           
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}