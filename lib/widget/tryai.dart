import 'package:ammarcafe/models/drink_class.dart';
import 'package:flutter/material.dart';
class DrinkCard extends StatelessWidget {
  final Drink drink;
  final VoidCallback onTap;

  const DrinkCard({required this.drink, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xFF212325),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(drink.image, height: 80, width: 80),
            SizedBox(height: 8),
            Text(
              drink.name,
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            IconButton(
              icon: Icon(Icons.add, color: Colors.white),
              onPressed: () {
                // Add to cart logic
              },
            ),
          ],
        ),
      ),
    );
  }
}