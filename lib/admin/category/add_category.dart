import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  TextEditingController categoryController = TextEditingController();
  bool isLooding = false;
  final CollectionReference category =
      FirebaseFirestore.instance.collection("categories");

  Future<void> addCategory() async {
    String categoryName = categoryController.text.trim();

    if (categoryName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Category name cannot be empty")),
      );
    } else {
      try {
        isLooding = true;
        setState(() {});
        DocumentReference response = await category.add({"name": categoryName});
        Navigator.of(context)
            .pushNamedAndRemoveUntil("AdminPanel", (route) => false);
      } catch (e) {
        isLooding = false;
        setState(() {});
        print("ERORR $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Category")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: isLooding? const Center(child: CircularProgressIndicator(),): Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: categoryController,
              decoration: const InputDecoration(
                labelText: "Category Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: addCategory,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text("Add"),
            ),
          ],
        ),
      ),
    );
  }
}
