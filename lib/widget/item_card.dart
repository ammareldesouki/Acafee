import 'package:ammarcafe/contest/colors.dart';
import 'package:ammarcafe/models/cart.dart';
import 'package:ammarcafe/models/item_class.dart';
import 'package:ammarcafe/screen/signleitem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final VoidCallback onAddToCart;
  const ItemCard({
    required this.item,
    required this.onAddToCart,
  });



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 13),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.cardAccent,
          boxShadow: [
            BoxShadow(
              color: AppColors.cardBackground,
              spreadRadius: 1,
              blurRadius: 8,
            ), // BoxShadow
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SingleItemScreen(item:item )));
            },
            child: Container(
              margin: EdgeInsets.all(10),
              child: Image(
                image: AssetImage(item.imageUrl),
                width: 120,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Align(
              alignment: Alignment.center,
              child: Column(children: [
                Text(
                  item.name,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.cardText),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "best Coffe",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ]),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Text(
                  "${item.price}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                SizedBox(width: 30,),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    onPressed: onAddToCart,
                    // () {
                    //   CartModel tt = new CartModel();
                    //   // Create a CartItem object and add it to the cart
                    //   final cartItem = CartItem(
                    //     name: item.name,
                    //     photo: item.imageUrl,
                    //     price: item.price,
                    //     quantity: 1, // Default quantity is 1
                    //   );
                    //   tt.addToCart(cartItem);
                    // },
                    icon: Icon(
                      CupertinoIcons.add,
                      size: 20,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
