import 'package:flutter/cupertino.dart';

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

  void isToggled() {
    isFavorite = !isFavorite;
    notifyListeners();
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
