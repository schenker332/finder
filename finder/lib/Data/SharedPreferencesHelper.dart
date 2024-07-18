import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _imageKey = 'image';

  /// Saves an image as a base64 string in SharedPreferences.
  ///
  /// [imageBytes] The byte array of the image to be saved.
  /// Returns a boolean indicating success or failure.
  static Future<bool> saveImage(List<int> imageBytes) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String base64Image = base64Encode(imageBytes);
      return prefs.setString(_imageKey, base64Image);
    } catch (e) {
      print("Error saving image: $e");
      return false;
    }
  }

  /// Retrieves an image from SharedPreferences and returns it as a Flutter [Image] widget.
  ///
  /// Returns an [Image] widget if successful, or null if no image is found.
  static Future<Image?> getImage() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? base64Image = prefs.getString(_imageKey);
      if (base64Image != null) {
        Uint8List bytes = base64Decode(base64Image);
        return Image.memory(bytes);
      }
    } catch (e) {
      print("Error retrieving image: $e");
    }
    return null;
  }

  /// Loads an image from the assets and saves it to SharedPreferences.
  ///
  /// [assetPath] The path to the asset image.
  /// Returns a boolean indicating success or failure.
  static Future<bool> saveImageFromAssets(String assetPath) async {
    try {
      ByteData bytes = await rootBundle.load(assetPath);
      return saveImage(bytes.buffer.asUint8List());
    } catch (e) {
      print("Error loading image from assets: $e");
      return false;
    }
  }

  /// Loads an image from a network URL and saves it to SharedPreferences.
  ///
  /// [url] The URL of the image to be saved.
  /// Returns a boolean indicating success or failure.
  static Future<bool> saveImageFromNetwork(String url) async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return saveImage(response.bodyBytes);
      } else {
        print("Error fetching image from network: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error fetching image from network: $e");
      return false;
    }
  }
}
