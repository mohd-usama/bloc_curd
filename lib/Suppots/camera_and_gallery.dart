import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraAndGallery extends StatefulWidget {
  final String type;
  const CameraAndGallery(this.type, {Key? key}) : super(key: key);

  @override
  _CameraAndGalleryState createState() => _CameraAndGalleryState();
}

class _CameraAndGalleryState extends State<CameraAndGallery> {
  CameraController? controller;
  XFile? takeImage;
  String _img64 = "", imageB64 = "", imageExt = "", imageName = "";
  final picker = ImagePicker();
  List<CameraDescription> cameras = [];
  Uint8List? data;
  ImagePicker imagePicker = ImagePicker();
  bool isCapturing = false;

  @override
  void initState() {
    super.initState();
    if (widget.type == "camera") {
      getCameraIntialised();
    } else {
      getImageFromGallery();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: controller != null
          ? Stack(
              alignment: Alignment.topLeft,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: CameraPreview(controller!),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                if (isCapturing) Center(child: CircularProgressIndicator()),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
      floatingActionButton: controller != null
          ? FloatingActionButton(
              backgroundColor: Colors.redAccent,
              child: isCapturing ? CircularProgressIndicator(color: Colors.white) : const Icon(Icons.camera),
              onPressed: () async {
                await getImageFromCamera();
              },
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future<void> getImageFromCamera() async {
    setState(() => isCapturing = true);
    try {
      takeImage = await controller!.takePicture();
      Uint8List compressedFile = await File(takeImage!.path).readAsBytes();
      String path = takeImage!.path;
      _img64 = base64Encode(compressedFile);
      imageName = path.split('/').last;
      imageExt = path.split('.').last;
      Map<String, dynamic> map = {
        "imageExt": imageExt,
        "imageName": imageName,
        "image64": _img64,
      };
      Navigator.pop(context, map);
    } catch (e) {
      debugPrint("Error capturing image: $e");
    } finally {
      setState(() => isCapturing = false);
    }
  }

  Future<void> getImageFromGallery() async {
    XFile? imageFromGallery = await imagePicker.pickImage(source: ImageSource.gallery);
    if (imageFromGallery != null) {
      Uint8List compressedFile = await File(imageFromGallery.path).readAsBytes();
      String path = imageFromGallery.path;
      _img64 = base64Encode(compressedFile);
      imageName = path.split('/').last;
      imageExt = path.split('.').last;
      Map<String, dynamic> map = {
        "imageExt": imageExt,
        "imageName": imageName,
        "image64": _img64,
      };
      Navigator.pop(context, map);
    } else {
      Navigator.pop(context);
    }
  }







  Future<void> getCameraIntialised() async {
    try {
      cameras = await availableCameras();
      if (cameras.isEmpty) {
        return;
      }
      controller = CameraController(cameras[0], ResolutionPreset.high, enableAudio: false);
      await controller!.initialize();
      if (mounted) setState(() {});
    } catch (e) {
      debugPrint("Camera initialization error: $e");
    }
  }
}
