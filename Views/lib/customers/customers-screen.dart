import 'package:comies/components.dart';
import 'package:comies/components/layouts/general-list.dart';
import 'package:comies/core.dart';
import 'package:datacontext/datacontext.dart';
import 'package:flutter/material.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({Key? key}) : super(key: key);

  @override
  _CustomersScreenState createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  late DataSet<CustomerView> customers;

  @override
  void initState() {
    customers = getProvider(context).customerViews;
    customers.get();
    super.initState();
  }

  Widget get list {
    return LoadStatusWidget(
      status: customers.loadStatus,
      loadWidget: (context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: GeneralList<CustomerView>(
            modelList: customers.list,
            onTap: (p) => Navigator.pushNamed(context, '/customers/${p.id}', arguments: p.name),
            titleGetter: (p) => getTextView(p.name),
            subtitleGetter: (p) => '+55 (${getTextView(p.phone?.ddd)}) ${getTextView(p.phone?.number)}',
          ),
        ),
      ),
    );
  }

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
