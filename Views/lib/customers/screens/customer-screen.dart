import 'package:comies/core.dart';
import 'package:comies/customers/controller.dart';
import 'package:comies/customers/widgets.dart';
import 'package:flutter/material.dart';

class CustomerScreen extends StatefulWidget {
  final String? id;
  final String? name;

  const CustomerScreen({Key? key, this.id, this.name}) : super(key: key);

  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  late CustomerController controller;

  @override
  void initState() {
    controller = CustomerController(context);
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
                return CustomerForm(isNew: isNew, customer: controller.model, onSubmit: controller.save, submitStatus: status);
              },
            ),
          ),
          Expanded(flex: isWidthSmall(context) ? 0 : 50, child: Center(child: Container(child: Text('Aqui vão informações sobre o telefone')))),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomerScreenAppBar(
      //   onCopy: controller.copyCustomer,
      //   onDelete: controller.delete,
      //   status: controller.status,
      //   isNew: isNew,
      //   stockLevel: 75,
      //   name: isNew ? 'Novo produto' : (controller.model != null ? controller.model!.name! : widget.name ?? ''),
      // ),
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
