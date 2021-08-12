import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double amount;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavVal(bool newVal) {
    isFavorite = newVal;
    notifyListeners();
  }

  Future<void> isToggled() async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    var url = Uri.parse(
        'https://myshopapp-cfd09-default-rtdb.firebaseio.com/products/$id.json');
    try {
      var response = await http.patch(
        url,
        body: json.encode({
          'isFavorite': isFavorite,
        }),
      );
      if (response.statusCode >= 400) {
        _setFavVal(oldStatus);
      }
    } catch (error) {}
    _setFavVal(oldStatus);
  }
}


// https://unsplash.com/photos/LxVxPA1LOVM
// https://unsplash.com/photos/164_6wVEHfI
// https://unsplash.com/photos/NUoPWImmjCU
// white shirt
// https://unsplash.com/photos/WWesmHEgXDs
// black shirt
// https://unsplash.com/photos/6Nub980bI3I
// blacl-BorderTween
// https://unsplash.com/photos/0fG6zACWGJY
// MojoWatchCallback
// https://unsplash.com/photos/TJrkkhdB39E
// https://unsplash.com/photos/OvcuGfIwHuc
// https://unsplash.com/photos/moJvG_1AwMU
// https://unsplash.com/photos/nJaRLGPIQu4
