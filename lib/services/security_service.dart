import 'dart:io';

import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:path_provider/path_provider.dart';

class SecurityService {
  Future<bool> isNoFaceDetected(String photoUrl) async {
    final File image = await convertURLToFile(photoUrl);
    final InputImage inputImage = InputImage.fromFile(image);
    final FaceDetector faceDetector = FaceDetector(
      options: FaceDetectorOptions(),
    );
    final List<Face> faces = await faceDetector.processImage(inputImage);
    print("------");
    print(faces);
    print("------");
    return faces.isEmpty;
  }

  Future<File> convertURLToFile(String imageUrl) async {
    HttpClient httpClient = HttpClient();
    File file;
    try {
      Uri url = Uri.parse(imageUrl);
      HttpClientRequest request = await httpClient.getUrl(url);
      HttpClientResponse response = await request.close();

      if (response.statusCode == 200) {
        String fileName = imageUrl.split("/").last;
        Directory appDocDir =
            await getTemporaryDirectory(); // Mendapatkan direktori penyimpanan eksternal.
        String appDocPath = appDocDir.path;
        String filePath = '$appDocPath/$fileName'; // Membuat path lengkap file.

        file = File(filePath);
        IOSink sink = file.openWrite();
        await response.pipe(sink);
        await sink.close();
      } else {
        throw Exception("Failed to load image");
      }
    } catch (e) {
      throw Exception("Failed to load image: $e");
    } finally {
      httpClient.close();
    }
    return file;
  }
}
