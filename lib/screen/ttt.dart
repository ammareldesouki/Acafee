import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ammarcafe/models/item_class.dart';

class ProductDetailWidget extends StatefulWidget {
  final Item item;
  const ProductDetailWidget({
    required this.item,
    super.key,
  });

  @override
  State<ProductDetailWidget> createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget>
    with TickerProviderStateMixin {
  // Example product data
  Item? item;

  String? coffeeSizeOptionsValue;

  @override
  void initState() {
    super.initState();
    item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            alignment: const AlignmentDirectional(0, -1),
            children: [
              Align(
                alignment: const AlignmentDirectional(0, -1),
                child: Image.asset(
                  item!.imageUrl,
                  width: double.infinity,
                  height: 500,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(0, 1),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 300, 0, 0),
                          child: Container(
                            width: double.infinity,
                            height: 700,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF8F7FA),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 12, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    item!.name,
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 30, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          'Coffee Size',
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  DropdownButton<String>(
                                    value: coffeeSizeOptionsValue,
                                    hint: const Text("Select Coffee Size"),
                                    items: <String>['Small', 'Medium', 'Large']
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        coffeeSizeOptionsValue = newValue;
                                      });
                                    },
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            16, 50, 16, 0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Add to cart functionality goes here.
                                      },
                                      child: Text(
                                          'Add to Cart - \$${item!.price}'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ).animate(
                            effects: [
                              MoveEffect(
                                curve: Curves.easeInOut,
                                delay: 0.ms,
                                duration: 300.ms,
                                begin: const Offset(0.0, 100.0),
                                end: const Offset(0.0, 0.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Example product class
