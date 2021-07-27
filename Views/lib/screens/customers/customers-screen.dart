import 'package:comies/components.dart';
import 'package:comies/components/layouts/general-list.dart';
import 'package:comies/core.dart';
import 'package:comies/controllers/customers-controller.dart';
import 'package:flutter/material.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({Key? key}) : super(key: key);

  @override
  _CustomersScreenState createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  late CustomerController controller;

  @override
  void initState() {
    controller = CustomerController(context);
    controller.loadMany();
    super.initState();
  }

  Widget get list => ValueListenableBuilder<LoadStatus>(
        valueListenable: controller.listStatus,
        builder: (context, status, child) {
          return status == LoadStatus.LOADED
              ? Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: GeneralList<CustomerView>(
                      modelList: controller.list,
                      onTap: (p) => Navigator.pushNamed(context, '/customers/${p.id}', arguments: p.name),
                      titleGetter: (p) => getTextView(p.name),
                      subtitleGetter: (p) => '+55 (${getTextView(p.phone?.ddd)}) ${getTextView(p.phone?.number)}',
                    ),
                  ),
                )
              : ErrorWidget2(message: 'Ops! Não encontramos nenhum cliente');
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(tooltip: 'Adicionar cliente', child: Icon(Icons.add), onPressed: () => Navigator.pushNamed(context, '/customers/new', arguments: '')),
      appBar: AppBar(title: Text('Clientes', style: getPageTitle())),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: isWidthSmall(context) ? 0 : 20),
        child: ResponsiveWidget(
          flexes: [30, 70],
          children: [list, Container()],
        ),
      ),
    );
  }
}
