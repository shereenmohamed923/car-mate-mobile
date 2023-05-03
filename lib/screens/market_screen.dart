import 'package:car_mate/providers/product.dart';
import'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../providers/product.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


class ProductsOverviewScreen extends StatefulWidget{
  static const routeName = '/market-screen';
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _isInit = true;
  var _isLoading = false;


  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); // WON'T WORK!
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }
  @override
  void didChangeDependencies() {
   if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override 
  Widget build(BuildContext context){
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
    final product = Provider.of<Product>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 100,
        leading: PopupMenuButton(
          position: PopupMenuPosition.under,
        icon: Icon(Icons.sort_sharp,),
        itemBuilder: (_) => [
          PopupMenuItem(child: Text('Sorting'),),
          PopupMenuItem(child: Text('Filtering'),),
        ]),
        title: Text('Car Mate',),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: _isLoading ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
            padding: const EdgeInsets.all(10.0),
             itemCount: products.length,
             itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            value: products[i],
            child: GridTile(child: GestureDetector(
              onTap: (){} ,
              child: Image.network(product.imageCover, fit: BoxFit.cover,),
            ),
            footer: GridTileBar(backgroundColor: Colors.black87,
            title: Text(product.name, textAlign: TextAlign.center,),
            ),
            ),
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),)
    );
  }
}