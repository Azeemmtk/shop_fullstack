import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:store/model/product_model.dart';

import '../../utils/contants.dart';
import '../../view_model/home_view_model.dart';
import '../../widgets/custom_text_field_add.dart';

class EditScreen extends StatefulWidget {
  EditScreen({
    super.key,
    required this.index,
  });

  final int index; // Use 'final' instead of mutable 'int'

  @override
  State<EditScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<EditScreen> {
  int selectedIndex = 0;

  dynamic onSizeSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  bool selectTv1 = false;
  bool selectTv2 = false;
  String type = '';
  final ImagePicker picker = ImagePicker();
  XFile? image;

  void _getFromCamera() async {
    image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {});
  }

  void _getFromGallery() async {
    image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {});
  }

  TextEditingController _namecontrol = TextEditingController();
  TextEditingController _pricecontrol = TextEditingController();
  TextEditingController _colorcontrol = TextEditingController();
  TextEditingController _detailscontrol = TextEditingController();
  TextEditingController _sizecontrol = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = context.read<HomeViewModel>();
    final product = provider.products[widget.index];

    // Initialize controllers with existing product data
    _namecontrol.text = product.name!;
    _pricecontrol.text = product.price.toString();
    _colorcontrol.text = product.colour!;
    _detailscontrol.text = product.details!;
    _sizecontrol.text = product.size.toString();

    if (product.category == 'jacket') {
      selectTv1 = true;
      type = 'jacket';
    } else if (product.category == 'sneakers') {
      selectTv2 = true;
      type = 'sneakers';
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeViewModel>();
    final product = provider.products[widget.index];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 220,
                  width: 220,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.red.shade100),
                  child: Hero(
                    tag: product.image!,
                    child: image == null
                        ? Image.network(product.image ?? 'image')
                        : Image.file(File(image!.path)),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 523,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: secindLighter,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            fixedSize: const Size(150, 50),
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) => Container(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          fixedSize: Size(
                                            MediaQuery.of(context).size.width,
                                            50,
                                          ),
                                        ),
                                        onPressed: () {
                                          _getFromCamera();
                                          Navigator.pop(context);
                                        },
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.camera_alt_outlined),
                                            Text("Take a photo")
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          fixedSize: Size(
                                            MediaQuery.of(context).size.width,
                                            50,
                                          ),
                                        ),
                                        onPressed: () {
                                          _getFromGallery();
                                          Navigator.pop(context);
                                        },
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(CupertinoIcons
                                                .photo_on_rectangle),
                                            Text("Upload from gallery")
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: const Text("Edit photo"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Addtextfield(
                    name: 'Name',
                    controller: _namecontrol,
                  ),
                  const SizedBox(height: 10),
                  Addtextfield(
                    name: 'Price',
                    controller: _pricecontrol,
                  ),
                  const SizedBox(height: 10),
                  Addtextfield(
                    name: 'Size',
                    controller: _sizecontrol,
                  ),
                  const SizedBox(height: 10),
                  Addtextfield(
                    name: 'Colour',
                    controller: _colorcontrol,
                  ),
                  const SizedBox(height: 10),
                  Addtextfield(
                    name: 'Details',
                    controller: _detailscontrol,
                  ),
                  Row(
                    children: [
                      const Text("Jacket:", style: TextStyle(fontSize: 16)),
                      Checkbox(
                        activeColor: maincolor,
                        value: selectTv1,
                        onChanged: (value) {
                          setState(() {
                            selectTv1 = value!;
                            type = 'jacket';
                            selectTv2 = false;
                          });
                        },
                      ),
                      const Text("Sneakers:", style: TextStyle(fontSize: 16)),
                      Checkbox(
                        activeColor: maincolor,
                        value: selectTv2,
                        onChanged: (value) {
                          setState(() {
                            selectTv2 = value!;
                            type = 'sneakers';
                            selectTv1 = false;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: maincolor,
                        ),
                        onPressed: () {
                          Productmodel updatedproduct = Productmodel(
                            name: _namecontrol.text,
                            size: _sizecontrol.text,
                            price: int.parse(_pricecontrol.text),
                            details: _detailscontrol.text,
                            colour: _colorcontrol.text,
                            category: type,
                            sId: product.sId,
                          );
                          // Call the updateProduct method and pass all updated data
                          provider.updateProduct(
                            product: updatedproduct,
                            imageFile: image != null ? File(image!.path) : null,
                            context: context,
                          );
                        },
                        child: const Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent.shade100,
                        ),
                        onPressed: () {
                          provider.deleteProduct(
                              productId: product.sId!, context: context);
                        },
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
