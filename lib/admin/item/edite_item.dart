import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class EditItemScreen extends StatefulWidget {
  final String categoryId;
  final String itemId;

  const EditItemScreen({
    super.key,
    required this.categoryId,
    required this.itemId,
  });

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  TextEditingController itemController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  String selectedSize = "Medium";
  bool isLoading = false;
  File? _image;

  late DocumentReference itemRef;

  @override
  void initState() {
    super.initState();
    itemRef = FirebaseFirestore.instance
        .collection("categories")
        .doc(widget.categoryId)
        .collection("items")
        .doc(widget.itemId);
    fetchItemData();
  }

  Future<void> fetchItemData() async {
    try {
      DocumentSnapshot doc = await itemRef.get();
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        setState(() {
          itemController.text = data["name"];
          descriptionController.text = data["description"];
          priceController.text =
              data["price"].toString().replaceAll(" EGP", "");
          imageController.text = data["image"].split("/").last;
          selectedSize = data["size"] ?? "Medium";
        });
      }
    } catch (e) {
      print("ERROR: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch item: $e")),
      );
    }
  }

  Future<void> updateItem() async {
    String itemName = itemController.text.trim();
    String description = descriptionController.text.trim();
    String price = priceController.text.trim();
    String image = imageController.text.trim();

    if (itemName.isEmpty ||
        description.isEmpty ||
        price.isEmpty ||
        image.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required")),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      await itemRef.update({
        "name": itemName,
        "description": description,
        "price": "$price EGP",
        "image": "assets/image/drinks/$image",
        "size": selectedSize,
      });

      if (mounted) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("AdminPanel", (route) => false);
      }
    } catch (e) {
      print("ERROR: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update item: $e")),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _pickAndSaveImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    final File tempImage = File(pickedFile.path);
    final String fileName = path.basename(tempImage.path);

    // Save to assets/image/drinks directory
    final String savedImagePath = 'assets/image/drinks/$fileName';
    await tempImage.copy(savedImagePath);

    setState(() {
      _image = tempImage;
      imageController.text = fileName;
    });

    print('Image saved to: $savedImagePath');
  }

  @override
  void dispose() {
    itemController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Item")),
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
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: "Description",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Price (EGP)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: imageController,
                    decoration: const InputDecoration(
                      labelText: "Image Name (e.g., coffee.png)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _pickAndSaveImage,
                    child: const Text("Pick Image"),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: selectedSize,
                    decoration: const InputDecoration(
                      labelText: "Cup Size",
                      border: OutlineInputBorder(),
                    ),
                    items: ["Small", "Medium", "Large"].map((size) {
                      return DropdownMenuItem(
                        value: size,
                        child: Text(size),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedSize = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: updateItem,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                    ),
                    child: const Text("Update"),
                  ),
                ],
              ),
      ),
    );
  }
}
