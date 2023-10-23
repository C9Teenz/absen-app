import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker extends StatefulWidget {
  final String label;
  final String? value;
  final String? hint;
  final String? helper;
  final String? Function(String?)? validator;
  final bool obscure;
  final Function(String) onChanged;
  final String? provider;

  const CustomImagePicker({
    Key? key,
    required this.label,
    this.value,
    this.validator,
    this.hint,
    this.helper,
    required this.onChanged,
    this.obscure = false,
    this.provider = "cloudinary",
  }) : super(key: key);

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  String? imageUrl;
  bool loading = false;
  late TextEditingController controller;
  @override
  void initState() {
    imageUrl = widget.value;
    controller = TextEditingController(
      text: widget.value ?? "-",
    );
    super.initState();
  }

  Future<String?> getFileMultiplePlatform() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        "png",
        "jpg",
      ],
      allowMultiple: false,
    );
    if (result == null) return null;
    return result.files.first.path;
  }

  Future<String?> getFileAndroidIosAndWeb() async {
    XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
    );
    String? filePath = image?.path;
    if (filePath == null) return null;
    return filePath;
  }

  Future<String?> getImageCameraAndroidIosAndWeb() async {
    XFile? image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 40,
    );
    String? filePath = image?.path;
    if (filePath == null) return null;
    return filePath;
  }

  Future<String?> uploadFile(String filePath) async {
    if (widget.provider == "cloudinary") {
      return await uploadToCloudinary(filePath);
    }
    return await uploadToImgBB(filePath);
  }

  Future<String> uploadToImgBB(String filePath) async {
    final formData = FormData.fromMap({
      'image': MultipartFile.fromBytes(
        File(filePath).readAsBytesSync(),
        filename: "upload.jpg",
      ),
    });

    var res = await Dio().post(
      'https://api.imgbb.com/1/upload?key=b55ef3fd02b80ab180f284e479acd7c4',
      data: formData,
    );

    var data = res.data["data"];
    var url = data["url"];
    widget.onChanged(url);
    return url;
  }

  Future<String> uploadToCloudinary(String filePath) async {
    String cloudName = "dotz74j1p";
    String apiKey = "983354314759691";

    final formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(
        File(filePath).readAsBytesSync(),
        filename: "upload.jpg",
      ),
      'upload_preset': 'yogjjkoh',
      'api_key': apiKey,
    });

    var res = await Dio().post(
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
      data: formData,
    );

    String url = res.data["secure_url"];
    return url;
  }

  browsePhoto() async {
    if (loading) return;

    String? filePath;
    loading = true;
    setState(() {});

    if (!kIsWeb && Platform.isWindows) {
      filePath = await getFileMultiplePlatform();
    } else {
      filePath = await getFileAndroidIosAndWeb();
    }
    if (filePath == null) return;

    imageUrl = await uploadFile(filePath);
    loading = false;

    if (imageUrl != null) {
      widget.onChanged(imageUrl!);
      controller.text = imageUrl!;
    }
    setState(() {});
  }

  takePhoto() async {
    if (loading) return;

    String? filePath;
    loading = true;
    setState(() {});

    if (!kIsWeb && Platform.isWindows) {
      filePath = await getFileMultiplePlatform();
    } else {
      filePath = await getImageCameraAndroidIosAndWeb();
    }
    if (filePath == null) return;

    imageUrl = await uploadFile(filePath);
    loading = false;

    if (imageUrl != null) {
      widget.onChanged(imageUrl!);
      controller.text = imageUrl!;
    }
    setState(() {});
  }

  String? get currentValue {
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 12.0,
      ),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Pilih Gambar"),
                content: Container(
                  padding: const EdgeInsets.all(10.0),
                  width: 150.0,
                  height: 100.0,
                  // Sesuaikan dengan lebar yang Anda inginkan
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          takePhoto();
                        },
                        child: const Column(
                          children: <Widget>[
                            Icon(Icons.camera_alt, size: 48.0),
                            Text("Kamera"),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          browsePhoto();
                        },
                        child: const Column(
                          children: <Widget>[
                            Icon(Icons.photo_library, size: 48.0),
                            Text("Galeri"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Container(
          height: 120.0,
          width: 120.0,
          margin: const EdgeInsets.only(
            top: 8.0,
          ),
          decoration: BoxDecoration(
            color: loading ? Colors.blueGrey[900] : null,
            image: loading
                ? null
                : DecorationImage(
                    image: NetworkImage(
                      imageUrl == null
                          ? "https://i.ibb.co/S32HNjD/no-image.jpg"
                          : imageUrl!,
                    ),
                    fit: BoxFit.cover,
                  ),
            borderRadius: const BorderRadius.all(
              Radius.circular(
                16.0,
              ),
            ),
          ),
          child: Visibility(
            visible: loading == true,
            child: const SizedBox(
              width: 30,
              height: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                    ),
                  ),
                  SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    "Uploading...",
                    style: TextStyle(
                      fontSize: 9.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
