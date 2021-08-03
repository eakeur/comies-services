import 'package:comies/core.dart';
import 'package:datacontext/datacontext.dart';
import 'package:flutter/material.dart';

import 'customer-form.dart';
import 'phones-form.dart';

class CustomerScreen extends StatefulWidget {
  final String? id;
  final String? name;

  const CustomerScreen({Key? key, this.id, this.name}) : super(key: key);

  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  late int? editPhoneIndex;

  DataSet<Customer> get customers => getProvider(context).customers;
  DataSet<Phone> get phones => customers.rel<Phone>('phones', parentId: widget.id);

  @override
  void initState() {
    if (!isNew) {
      customers.getOne(widget.id).then((customer) {
        phones.data = Phone();
        phones.get();
      });
    }
    super.initState();
  }

  bool get isNew => widget.id == 'new';

  Widget get customerform {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: CustomerForm(isNew: isNew, customer: customers.data, onSubmit: () => customers.add(customers.data!), submitStatus: customers.changeStatus.value),
    );
  }

  Widget get phonesForm {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: LoadStatusWidget(
        status: phones.loadStatus,
        loadWidget: (context) => PhonesForm(
          phones: phones.list,
          data: phones.data!,
          onSave: (p) => phones.add(p),
          onEdit: (p) => phones.data = p,
          onCancel: () => phones.data = Phone(),
          onDelete: (p) => phones.remove(p.id),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: isWidthSmall(context) ? 0 : 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              LoadStatusWidget(
                status: customers.loadStatus,
                loadWidget: (context) => Flex(
                  direction: getRelativeAxis(context),
                  children: [
                    Expanded(flex: getRelativeFlex(context), child: customerform),
                    Expanded(
                      flex: getRelativeFlex(context),
                      child: IsNullWidget<String>(
                          value: isNew ? null : widget.id,
                          child: (context, val, child) => phonesForm,
                          nullWidget: (context, val, child) => Container(child: Text('Aqui vão informações sobre o telefone'))),
                    )
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
