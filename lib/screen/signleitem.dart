import 'package:ammarcafe/contest/colors.dart';
import 'package:ammarcafe/models/item_class.dart';
import 'package:ammarcafe/widget/botton_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ammarcafe/models/cart.dart';

class SingleItemScreen extends StatefulWidget {
  final Item item;

  const SingleItemScreen({
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
      SnackBar(
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
            SizedBox(height: 10),
            Text(widget.item.name, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(widget.item.description, textAlign: TextAlign.center),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: _decreaseQuantity,
                ),
                Text('$quantity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _increaseQuantity,
                ),
              ],
            ),
            SizedBox(height: 20),
            
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _addToCart(context),
                    
                    icon: Icon(Icons.shopping_cart,color: Colors.white,),
                    label: Text('Add to Cart', style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      textStyle: TextStyle(fontSize: 18),
                      backgroundColor: AppColors.primaryColor,
                      minimumSize: Size(100, 50),
                    ),
                  ),
                             ElevatedButton.icon(
                         
              
              
                    icon: Icon(Icons.favorite_border,color: Colors.white,),
                                label: Text('Like !',style: TextStyle(color: Colors.white,)),
              
              onPressed: () {
                // Handle favorite button action
              },
                          style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontSize: 18),
                      backgroundColor: AppColors.primaryColor,
                      minimumSize: Size(60, 50),
                    ),
                        ),
                ],
              ),
            ),
     
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}