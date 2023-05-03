// import'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;


// class products extends StatefulWidget{
//   @override
//   State<products> createState() => _productsState();
// }

// class _productsState extends State<products> {
//   var _isInit = true;
//   var _isLoading = false;

//   @override
//   void didChangeDependencies() {
//     if (_isInit) {
//         Provider.of(context).fetchAndSetProducts();
//     }
//     _isInit = false;
//     super.didChangeDependencies();
//   }

//   @override 
//   Widget build(BuildContext context){
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('MyShop'),
//       ),
//       body: Container()
//       // GridView.builder(
//       //   padding: const EdgeInsets.all(10.0),
//       //   //itemCount: loadedProducts.length,
//       //   itemBuilder: (context, index){
//       //     responseData[index]['data']['imageCover'];
//       //   }  ,
        
//       //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//       //     crossAxisCount: 2,
//       //     childAspectRatio: 3 / 2,
//       //     crossAxisSpacing: 10,
//       //     mainAxisSpacing: 10,
//       //   ),
//       // ),
//     );
//   }
// }