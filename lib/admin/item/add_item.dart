import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddItemScreen extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  const AddItemScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  TextEditingController itemController = TextEditingController();
  bool isLoading = false;

  // Firestore reference initialized once
  late CollectionReference items;

  @override
  void initState() {
    super.initState();
    items = FirebaseFirestore.instance
        .collection("categories")
        .doc(widget.categoryId)
        .collection("items");
  }

  Future<void> addItem() async {
    String itemName = itemController.text.trim();

    if (itemName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Item name cannot be empty")),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      await items.add({
        "name": itemName,
        "createdAt": FieldValue.serverTimestamp(),
      });

      // Reset text field after adding item
      itemController.clear();

      // Navigate after successful addition
      if (mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil("AdminPanel", (route) => false);
      }
    } catch (e) {
      print("ERROR: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to add item: $e")),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    itemController.dispose();
    super.dispose(); // Call super.dispose() at the end
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Item")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: itemController,
                    decoration: const InputDecoration(
                      labelText: "Item Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: addItem,
                    child: const Text("Add"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
