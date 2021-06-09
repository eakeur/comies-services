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
    controller.loadProduct(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Material(
          color: Colors.transparent,
          child: Text(controller.product == null ? widget.name ?? '' : controller.product!.name, style: getPageTitle()),
        ),
        bottom: PreferredSize(
          child: StockLevelWidget(value: 75, message: 'O nível de estoque desse produto relacionado ao seu total'),
          preferredSize: Size.fromHeight(15),
        ),
      ),
      body: ValueListenableBuilder<LoadStatus>(
        valueListenable: controller.productStatus,
        builder: (context, status, child){
          switch (status) {
            case LoadStatus.LOADING: return Center(child: CircularProgressIndicator());
            case LoadStatus.FAILED: return Center(child: Text('Ops! Error'));
            case LoadStatus.START: return Center(child: Text('Ops! start'));
            case LoadStatus.LOADED: return ProductForm(product: controller.product, isNew: true, onSubmit: (e){}, submitStatus: status);
          }
        },
      )
    );
  }
}
