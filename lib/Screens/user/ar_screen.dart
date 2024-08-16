import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_model/home_view_model.dart';

class ArScreen extends StatefulWidget {
  ArScreen({super.key, required this.index, required this.screen});

  final int index;
  final int screen;

  @override
  _CameraOverlayScreenState createState() => _CameraOverlayScreenState();
}

class _CameraOverlayScreenState extends State<ArScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // Obtain a list of the available cameras on the device.
    availableCameras().then((cameras) {
      // Ensure that the list of cameras is not empty
      if (cameras.isNotEmpty) {
        // Get a specific camera from the list of available cameras.
        _controller = CameraController(
          cameras[0], // Use the first available camera
          ResolutionPreset.medium,
        );

        // Next, initialize the controller.
        _initializeControllerFuture = _controller.initialize();
        setState(() {}); // Trigger a rebuild to ensure FutureBuilder is updated
      } else {
        // Handle the case when no cameras are available
        throw StateError('No cameras available');
      }
    }).catchError((error) {
      // Handle errors if fetching cameras fails
      throw StateError('Failed to fetch cameras: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeViewModel>();
    final data = widget.screen == 1
        ? provider.products
        : widget.screen == 2
            ? provider.jackets
            : provider.sneakers;

    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              // Handle errors during initialization
              return Center(
                  child: Text('Error initializing camera: ${snapshot.error}'));
            }
            return Stack(
              children: [
                // Camera preview full screen
                Positioned.fill(
                  child: CameraPreview(_controller),
                ),

                // Image overlay
                Center(
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            NetworkImage(data[widget.index].image ?? 'image'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: Text('Failed to load camera'));
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
