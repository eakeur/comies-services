import 'package:comies/core.dart';
import 'package:comies/products/controller.dart';
import 'package:comies/products/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  final String? id;
  final String? name;

  const ProductScreen({Key? key, this.id, this.name}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late ProductController controller;

  @override
  void initState() {
    controller = ProductController(context);
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Material(
          color: Colors.transparent,
          child: Text(widget.name ?? '', style: getPageTitle()),
        ),
        bottom: PreferredSize(
          child: StockLevelWidget(value: 75, message: 'O nível de estoque desse produto relacionado ao seu total'),
          preferredSize: Size.fromHeight(15),
        ),
      ),
      body: ListTile(
        title: Text(widget.id ?? ''),
      ),
    );
  }
}
