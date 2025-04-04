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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(widget.item.imageUrl, height: 200, width: 200),
            const SizedBox(height: 10),
            Text(widget.item.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(widget.item.description, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            Row(
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
            const SizedBox(height: 20),
            
            Center(
              child: Row(
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
            ),
     
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}