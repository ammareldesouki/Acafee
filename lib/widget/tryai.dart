import 'package:ammarcafe/models/item_class.dart';
import 'package:flutter/material.dart';
class DrinkCard extends StatelessWidget {
  final Item drink;
  final VoidCallback onTap;

  const DrinkCard({super.key, required this.drink, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFF212325),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 8,
              ),
            ],
          ),
          child: Expanded(
            child: Column(
              children: [
                Image.asset(drink.imageUrl, height: 80, width: 80),
                Text(
                  drink.name,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                Expanded(child: Text(drink.description)),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.white),
                  onPressed: () {
                    // Add to cart logic
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}