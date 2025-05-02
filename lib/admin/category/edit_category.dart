import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditCategory extends StatefulWidget {
  final String categoryID;
  final String oldName;

  const EditCategory(
      {super.key, required this.categoryID, required this.oldName});
  @override
  _EditCategoryState createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  TextEditingController categoryController = TextEditingController();
  bool isLooding = false;
  final CollectionReference category =
      FirebaseFirestore.instance.collection("categories");

  Future<void> editCategory() async {
    String categoryName = categoryController.text.trim();

    if (categoryName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Category name cannot be empty")),
      );
    } else {
      try {
        isLooding = true;
        setState(() {});
        await category.doc(widget.categoryID).update({
        "name": categoryController.text


        });
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
  void initState() {
    
    super.initState();
    categoryController.text = widget.oldName;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Category")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: isLooding
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
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
                    onPressed: editCategory,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    child: const Text("Edit"),
                  ),
                ],
              ),
      ),
    );
  }
}
