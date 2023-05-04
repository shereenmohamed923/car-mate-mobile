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

  Future<void> fetchAndSetProducts() async {
    var url =
        Uri.parse('https://car-mate-t012.onrender.com/api/v1/prodcuts');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<dynamic, dynamic>;
      //print(extractedData);
       List<Product> loadedProducts = [];
      extractedData['product'].forEach((prodData) {
        loadedProducts.add(Product(
          ratings: prodData['Ratings'],
          ratingsAverage: prodData['RatingsAverage'],
          ratingsSum: prodData['RatingsSum'],
          images: prodData['Images'],
          sold: prodData['Sold'],
          buyers: prodData['Buyers'],
          id: prodData['_id'],
          name: prodData['Name'],
          condition: prodData['Condition'],
          description: prodData['Description'],
          price: prodData['Price'],
          quantity: prodData['Quantity'],
          //location: prodData['Location'],
          owner: prodData['Owner'],
          address: prodData['Address'],
          type: prodData['Type'],
          imageCover: prodData['imageCover'],
        ),);
      }
      );
      print(loadedProducts[2].ratingsAverage);
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

}
