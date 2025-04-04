import 'package:ammarcafe/admin/item/edite_item.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../category/category_view.dart';
class ItemPage extends StatefulWidget {
  final String categoryId;
  final String ItemId;
  final String ItemName;

  const ItemPage(
      {super.key,
      required this.categoryId,
      required this.ItemId,
      required this.ItemName});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  DocumentSnapshot? item;
  bool isLoading = true;

  getData() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("categories")
          .doc(widget.categoryId)
          .collection("items")
          .doc(widget.ItemId)
          .get();

      setState(() {
        item = doc;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching item: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  void deleteItem(BuildContext context) async {
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
          .collection("items")
          .doc(widget.ItemId)
          .delete();
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CategoryPage(
                  categoryId: widget.categoryId,
                  categoryName: "iiii",
                )),
      ); // Close loading dialog
    } catch (e) {
      Navigator.pop(context); // Close loading dialog
      print("Error deleting Item: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.ItemName)),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : item == null
              ? const Center(child: Text("Item not found"))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset("assets/images/folder.png",
                            height: 120),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Item Name: ${item!["name"]}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditItemScreen(
                                    categoryId: widget.categoryId,
                                    itemId: widget.ItemId,
                           
                                  ),
                                ),
                              );
                            },
                            child: const Text("Edit Item",
                                style: TextStyle(color: Colors.black)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.question,
                                title: "Delete Item",
                                desc:
                                    "Are you sure you want to delete this item?",
                                animType: AnimType.rightSlide,
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 2),
                                btnOkOnPress: () {
                                  deleteItem(context);
                                },
                                btnCancelOnPress: () {},
                              ).show();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            child: Text("Delete Item",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
    );
  }
}
