import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:store/widgets/custom_text_field_add.dart';

import '../../model/product_model.dart';
import '../../utils/contants.dart';
import '../../view_model/home_view_model.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _detailsController = TextEditingController();
  TextEditingController _colorController = TextEditingController();
  TextEditingController _sizeController = TextEditingController();
  XFile? image;

  final ImagePicker picker = ImagePicker();
  bool selectTv1 = false;
  bool selectTv2 = false;
  String type = '';

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

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeViewModel>();
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [maincolor, Colors.black],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Row(
          children: [
            SizedBox(width: 130),
            Text(
              'Add items',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
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
                                                MediaQuery.of(context)
                                                    .size
                                                    .width,
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
                                                MediaQuery.of(context)
                                                    .size
                                                    .width,
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
                              child: const Text("Add photo"),
                            ),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: image == null
                                      ? const Text("Upload image")
                                      : Image(
                                          image: FileImage(File(image!.path))),
                                ),
                              );
                            },
                            icon: const Icon(
                              CupertinoIcons.eye,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Addtextfield(name: 'name', controller: _nameController),
                      const SizedBox(height: 20),
                      Addtextfield(name: 'price', controller: _priceController),
                      const SizedBox(height: 20),
                      Addtextfield(name: 'Size', controller: _sizeController),
                      const SizedBox(height: 20),
                      Addtextfield(
                          name: 'colour', controller: _colorController),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Text("Jacket:", style: TextStyle(fontSize: 16)),
                          Checkbox(
                            activeColor: Colors.amber,
                            value: selectTv1,
                            onChanged: (value) {
                              selectTv1 = value!;
                              type = 'jacket';
                              setState(() {
                                selectTv2 = false;
                              });
                            },
                          ),
                          const Text("Sneakers:",
                              style: TextStyle(fontSize: 16)),
                          Checkbox(
                            activeColor: Colors.amber,
                            value: selectTv2,
                            onChanged: (value) {
                              selectTv2 = value!;
                              type = 'Sneakers';
                              setState(() {
                                selectTv1 = false;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        minLines: 6,
                        maxLines: 200,
                        controller: _detailsController,
                        decoration: const InputDecoration(
                          label: Text('Add details...'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: CupertinoColors.inactiveGray),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: CupertinoColors.inactiveGray),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: CupertinoColors.activeBlue),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () {
                            Productmodel newproduct = Productmodel(
                              name: _nameController.text,
                              category: type,
                              colour: _colorController.text,
                              details: _detailsController.text,
                              price: int.parse(_priceController.text),
                              size: int.parse(_sizeController.text),
                            );

                            provider.addProduct(
                                product: newproduct,
                                imageFile: File(image!.path),
                                context: context);
                          },
                          child: Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
