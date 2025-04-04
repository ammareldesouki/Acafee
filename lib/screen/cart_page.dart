import 'package:ammarcafe/contest/colors.dart';
import 'package:ammarcafe/widget/botton_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ammarcafe/models/cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartModel = Provider.of<CartModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: AppColors.primaryVariant,
      ),
      body: ListView.builder(
        itemCount: cartModel.cartItems.length,
        itemBuilder: (context, index) {
          final itemOncart = cartModel.cartItems[index];
          return ListTile(

            leading: Image.asset(itemOncart.item.imageUrl),
            title: Text(itemOncart.item.name),
            subtitle: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    cartModel.decrementQuantity(itemOncart.item);
                  },
                ),    IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    cartModel.incrementQuantity(itemOncart.item);
                  },
                ),
                
                Text('Quantity: ${itemOncart.quantity}'),
              ],
            ),
            trailing: Text('\$${itemOncart.item.price * itemOncart.quantity}'),
          );
        },
      ),
      bottomSheet: Container(
        color:AppColors.textLight,
      
        height: 200,
       
        child: Expanded(
          child: Column(
                
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                
              children: [


                
                Row(





                  
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                
                    const Text(
                      'Subtotal: ',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                
                
                    Text("\$${cartModel.totalAmount}")
                
                
                  ],
                ),      Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                
                    const Text(
                      'Subtotal: ',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                
                
                    Text("\$${cartModel.totalAmount}")
                
                
                  ],
                ),      Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                
                    const Text(
                      'Subtotal: ',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                
                
                    Text("\$${cartModel.totalAmount}")
                
                
                  ],
                ),
                
                MaterialButton(onPressed: (){
                
                
                },
                  padding: const EdgeInsets.all(18),
                
                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color: Colors.red,
                  textColor: AppColors.textLight,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Go to Check out "),
                
                
                    ],
                
                
                  ),
                
                
                
                ),
               ]
                
          ),
        ),
      
      ),
      bottomNavigationBar: const BottomNavBar(),

    );
  }
}



