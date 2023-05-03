import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final int ratings;
  final List images;
  final bool sold;
  final List buyers;
  final String id;
  final String name;
  final String condition;
  final String description;
  final double price;
  final String quantity;
  final Map location;
  final String address;
  final String owner;
  final String type;
  final String imageCover;

  Product({
    @required this.ratings,
    @required this.images,
    @required this.sold,
    @required this.buyers,
    @required this.id,
    @required this.name,
    @required this.condition,
    @required this.description,
    @required this.price,
    @required this.quantity,
    @required this.location,
    @required this.owner,
    @required this.address,
    @required this.type,
    @required this.imageCover,
  });

}
