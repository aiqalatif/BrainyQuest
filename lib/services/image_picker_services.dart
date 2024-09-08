import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerServices {
  static final FirebaseStorage storage = FirebaseStorage.instance;
  static final ImagePicker picker = ImagePicker();

  static Future<String?> pickImageAndUpload() async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image == null) {
        print("No image selected.");
        return null;
      }

      // Convert the XFile to a File
      File file = File(image.path);

      // Check if the file actually exists
      if (!await file.exists()) {
        print("File not found at path: ${file.path}");
        return null;
      }

      // Create a unique file name using the current timestamp
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      // Define a storage reference and upload the file
      Reference storageRef = storage.ref().child('images/$fileName');
      UploadTask uploadTask = storageRef.putFile(file);

      // Wait for the upload to complete and get the download URL
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      print("<<< DownloadURL >>> : $downloadUrl");

      // Return the download URL
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      throw Exception('Error uploading image: $e');
    }
  }
}
