import'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/products_grid.dart';


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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 100,
        leading: PopupMenuButton(
          position: PopupMenuPosition.under,
        icon: Icon(Icons.subject,),
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
          : ProductsGrid(),
    );
  }
}

class ProductsGrid {
}