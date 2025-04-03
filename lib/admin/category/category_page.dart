import 'package:ammarcafe/admin/category/edit_category.dart';
import 'package:ammarcafe/admin/item/add_item.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class CategoryPage extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  CategoryPage({required this.categoryId, required this.categoryName});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  void deleteCategory(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    try {
      await FirebaseFirestore.instance
          .collection("categories")
          .doc(widget.categoryId)
          .delete();
      Navigator.pop(context); // Close loading dialog
      Navigator.pushReplacementNamed(
          context, "AdminPanel"); // Navigate to admin panel
    } catch (e) {
      Navigator.pop(context); // Close loading dialog
      print("Error deleting category: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryName)),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditCategory(
                        categoryID: widget.categoryId,
                        oldName: widget.categoryName,
                      ),
                    ),
                  );
                },
                child: Text("Edit Category",
                    style: TextStyle(color: Colors.black)),
              ),
              ElevatedButton(
                onPressed: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.question,
                    title: "Delete Category",
                    desc: "Are you sure you want to delete this category?",
                    animType: AnimType.rightSlide,
                    borderSide: BorderSide(color: Colors.red, width: 2),
                    btnOkOnPress: () {
                      deleteCategory(context);
                    },
                    btnCancelOnPress: () {},
                  ).show();
                },
                child: Text("Delete Category",
                    style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("AddItem");
                },
                child: Text("Add Item",
                    style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ],
      ),
             floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.blue,
        children: [
          SpeedDialChild(
            child: Icon(Icons.category, color: Colors.white),
            backgroundColor: Colors.green,
            label: "Add Item",
            onTap: () {
                  Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddItemScreen(
                                categoryId: widget.categoryId,
                                categoryName:widget.categoryName,
                              ),
                            ),
                          );
            },
          ),

        ],
      ),
    );
  }
}
