import 'package:comies/core.dart';
import 'package:comies/controllers.dart';
import 'package:flutter/material.dart';
import 'package:comies/components.dart';

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
    controller.loadOne(widget.id);
    super.initState();
  }

  bool get isNew => widget.id == 'new';

  Widget get firstRow => Flex(
        direction: isWidthSmall(context) ? Axis.vertical : Axis.horizontal,
        children: [
          Expanded(
            flex: isWidthSmall(context) ? 0 : 50,
            child: ValueListenableBuilder<LoadStatus>(
              valueListenable: controller.status,
              builder: (context, status, child) {
                return ProductForm(isNew: isNew, product: controller.model, onSubmit: controller.save, submitStatus: status);
              },
            ),
          ),
          Expanded(flex: isWidthSmall(context) ? 0 : 50, child: Center(child: Container(child: Text('Aqui vão informações sobre o estoque')))),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProductScreenAppBar(
        onCopy: controller.copyProduct,
        onDelete: controller.delete,
        status: controller.status,
        isNew: isNew,
        stockLevel: 75,
        name: isNew ? 'Novo produto' : (controller.model != null ? controller.model!.name! : widget.name ?? ''),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: isWidthSmall(context) ? 0 : 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              firstRow,
            ],
          ),
        ),
      ),
    );
  }
}
