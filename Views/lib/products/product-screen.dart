import 'package:comies/core.dart';
import 'package:datacontext/datacontext.dart';
import 'package:flutter/material.dart';
import 'product-form.dart';
import 'product-screen-bar.dart';

class ProductScreen extends StatefulWidget {
  final String? id;
  final String? name;

  const ProductScreen({Key? key, this.id, this.name}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late DataSet<Product> products;

  @override
  void initState() {
    products = getProvider(context).products;
    products.getOne(widget.id);
    super.initState();
  }

  bool get isNew => widget.id == 'new';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProductScreenAppBar(
        onCopy: (){}, onDelete: () => products.remove(products.data!.id),
        status: products.loadStatus, isNew: isNew, stockLevel: 75,
        name: isNew ? 'Novo produto' : (products.data != null ? products.data!.name! : widget.name ?? ''),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: isWidthSmall(context) ? 0 : 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              LoadStatusWidget(
                status: products.loadStatus, 
                loadWidget: (context) => Flex(
                  direction: getRelativeAxis(context),
                  children: [
                    Expanded(flex: getRelativeFlex(context), child: ProductForm(isNew: isNew, product: products.data, onSubmit: () => products.add(products.data!), submitStatus: products.changeStatus.value)),
                    Expanded(flex: getRelativeFlex(context), child: Center(child: Container(child: Text('Aqui vão informações sobre o estoque')))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
