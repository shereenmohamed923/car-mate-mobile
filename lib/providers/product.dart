import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
   dynamic ratings;
   dynamic images;
   dynamic sold;
   dynamic buyers;
   dynamic id;
   dynamic name;
   dynamic condition;
   dynamic description;
   dynamic price;
   dynamic quantity;
   dynamic ratingsAverage;
   dynamic ratingsSum;
 // final Map location;
   dynamic address;
   dynamic owner;
   dynamic type;
   dynamic imageCover;

  Product({
    @required this.ratings ,
    @required this.images,
    @required this.sold,
    @required this.buyers,
    @required this.id,
    @required this.name,
    @required this.condition,
    @required this.description,
    @required this.price,
    @required this.quantity,
    @required this.ratingsAverage,
    @required this.ratingsSum,
    //@required this.location,
    @required this.owner,
    @required this.address,
    @required this.type,
    @required this.imageCover,
  });

}
