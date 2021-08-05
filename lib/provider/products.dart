import 'package:flutter/cupertino.dart';
import 'package:shop_app/provider/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Shoe1',
      amount: 89.0,
      description: 'Lovely',
      imageUrl:
          'https://cdn.pixabay.com/photo/2013/07/12/18/20/shoes-153310__340.png',
    ),
    Product(
      id: 'p2',
      title: 'Shoe2',
      amount: 59.0,
      description: 'Lovely',
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/03/27/22/16/fashion-1284496__340.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Shoe3',
      amount: 159.0,
      description: 'Lovely',
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/11/19/18/06/feet-1840619__340.jpg',
    ),
    Product(
      id: 'p4',
      title: 'White T-SHirt',
      amount: 100.0,
      description: 'Lovely',
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/06/03/17/35/shoes-1433925__340.jpg',
    ),
    Product(
      id: 'p5',
      title: 'White T-SHirt',
      amount: 209.0,
      description: 'Lovely',
      imageUrl:
          'https://cdn.pixabay.com/photo/2017/01/13/04/56/blank-1976334__340.png',
    ),
    Product(
      id: 'p6',
      title: 'Black-brown T-SHirt',
      amount: 209.0,
      description: 'Lovely',
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/01/19/14/45/person-1148941__480.jpg',
    ),
    Product(
      id: 'p7',
      title: 'Watch1',
      amount: 500.0,
      description: 'Lovely',
      imageUrl:
          'https://cdn.pixabay.com/photo/2018/01/18/19/06/time-3091031__480.jpg',
    ),
    Product(
      id: 'p8',
      title: 'Watch2',
      amount: 700.0,
      description: 'Lovely',
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/11/29/13/39/analog-watch-1869928__340.jpg',
    ),
    Product(
      id: 'p9',
      title: 'Watch3',
      amount: 900.0,
      description: 'Lovely',
      imageUrl:
          'https://cdn.pixabay.com/photo/2013/09/30/21/58/male-watch-188782__340.jpg',
    ),
    Product(
      id: '10',
      title: 'Watch4',
      amount: 1500.0,
      description: 'Lovely',
      imageUrl:
          'https://cdn.pixabay.com/photo/2013/07/12/15/50/ticker-150395__340.png',
    ),
    Product(
      id: '11',
      title: 'Women Shoe',
      amount: 1500.0,
      description: 'Lovely',
      imageUrl:
          'https://cdn.pixabay.com/photo/2017/07/25/14/50/shoe-2538424__340.jpg',
    ),
    Product(
      id: '12',
      title: 'Sneaker',
      amount: 1500.0,
      description: 'Lovely',
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/12/10/16/57/shoes-1897708__340.jpg',
    ),
  ];
//another alternative for filtering between showing favorite and all
  // var _showFavoriteOnly = false;

//Getter that allow to get access to the private variable _items
  List<Product> get item {
    //another alternative for filtering between showing favorite and all
    // if (_showFavoriteOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

//show favorite
  List<Product> get favoritesItem {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  //find item based on their id
  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  //To add New Product
  void addProduct(Product product) {
    var newProduct = Product(
      title: product.title,
      amount: product.amount,
      description: product.description,
      id: DateTime.now().toString(),
      imageUrl: product.imageUrl,
    );

    _items.add(newProduct);

    //To add at the start
    // _items.insert(0, newProduct);
    notifyListeners();
  }

  //to update product when editing a existing product
  void updateproduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('.....');
    }
  }

  //to remove or delete product
  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }

  //another alternative for filtering between showing favorite and all
  // void showFavorite() {
  //   _showFavoriteOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoriteOnly = false;
  //   notifyListeners();
  // }
}
