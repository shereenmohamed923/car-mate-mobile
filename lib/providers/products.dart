import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items{
    return [..._items];
  }

  // Product findById(String id) {
  //   return _items.firstWhere((prod) => prod.id == id);
  // }

  Future<void> fetchAndSetProducts() async {
    var url =
        Uri.parse('https://car-mate-t012.onrender.com/api/v1/prodcuts?sort=-Price&limit=5&page=2');
    try {
      final response = await http.get(url, headers: {
          'content-type': 'application/json',
          'Accept': 'application/json',
        },);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(extractedData);
      
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          ratings: prodData['data']['product']['Ratings'],
          images: prodData['data']['product']['Images'],
          sold: prodData['data']['product']['Sold'],
          buyers: prodData['data']['product']['Buyers'],
          id: prodData['data']['product']['_id'],
          name: prodData['product']['Name'],
          condition: prodData['data']['Condition'],
          description: prodData['data']['product']['Description'],
          price: prodData['data']['product']['Price'],
          quantity: prodData['data']['product']['Quantity'],
          location: prodData['data']['product']['Location'],
          owner: prodData['data']['product']['Owner'],
          address: prodData['data']['product']['Address'],
          type: prodData['data']['product']['Type'],
          imageCover: prodData['imageCover'],
        ));
        
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

}
