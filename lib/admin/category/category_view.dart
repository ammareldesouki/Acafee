import 'package:ammarcafe/admin/category/edit_category.dart';
import 'package:ammarcafe/admin/item/add_item.dart';
import 'package:ammarcafe/admin/item/item._view.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class CategoryPage extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  const CategoryPage({super.key, required this.categoryId, required this.categoryName});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<QueryDocumentSnapshot> items = [];
  bool isLoading = true;

  getData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("categories").doc(widget.categoryId).collection("items").get();
    setState(() {
      items = querySnapshot.docs;
      isLoading = false;
    });
  }

 @override
  void initState() {
    getData();
    super.initState();
  }


  void deleteCategory(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
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
      body: Column(
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
                child: const Text("Edit Category",
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
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                    btnOkOnPress: () {
                      deleteCategory(context);
                    },
                    btnCancelOnPress: () {},
                  ).show();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text("Delete Category",
                    style: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("AddItem");
                },
                child: const Text("Add Item",
                    style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
           Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, mainAxisExtent: 150),
                    itemCount: items.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ItemPage(
                                categoryId: widget.categoryId,
                                ItemId: items[i].id,
                                ItemName: items[i]["name"],
                              ),
                            ),
                          );
                        },
                        child: Card(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Image.asset("assets/images/folder.png", height: 80),
                                const SizedBox(height: 10),
                                Text(
                                  "${items[i]["name"]}",
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
             floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.blue,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.category, color: Colors.white),
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
