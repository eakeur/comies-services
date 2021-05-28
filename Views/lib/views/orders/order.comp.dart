import 'package:comies/components/async.comp.dart';
import 'package:comies/components/responsebar.comp.dart';
import 'package:comies/components/titlebox.comp.dart';
import 'package:comies/controllers/kitchen.controller.dart' if(dart.library.html) 'package:comies/controllers/kitchenweb.controller.dart' if(dart.library.io) 'package:comies/controllers/kitchen.controller.dart';
import 'package:comies/structures/structures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderBottomSheet extends StatefulWidget {
  final Order order;
  final bool showButtons;
  OrderBottomSheet({this.order, this.showButtons});
  @override
  _OrderBottomSheetState createState() => _OrderBottomSheetState();
}

class _OrderBottomSheetState extends State<OrderBottomSheet> {

  void updateOrder(Status status){
    Status oldStatus = widget.order.status;
    Provider.of<KitchenController>(context, listen: false).updateOrder((){widget.order.status = status; return widget.order;})
      .then((value) => ScaffoldMessenger.of(context).showSnackBar(ResponseBar(value, action:() => updateOrder(oldStatus))))
      .catchError((value) => ScaffoldMessenger.of(context).showSnackBar(ResponseBar(value, action: () => updateOrder(status))));
  }

  
  @override
  Widget build(BuildContext context) {
    return Consumer<KitchenController>(builder: (context, data, child){
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TitleBox("PEDIDO Nº "+widget.order.id.toString(),
            subtitle: "R\$${widget.order.price.toString()} | ${widget.order.status.toString().replaceFirst('.', ": ").replaceFirst("pending", "pendente").replaceFirst("preparing", "preparando")}",
          ),
          if (widget.order.items.isNotEmpty) 
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                columns: [
                  DataColumn(label: Text("Nº")), DataColumn(label: Text("Produto")), DataColumn(label: Text("Quantidade")), if (widget.order.status == Status.preparing) DataColumn(label: Text("Praparado"))
                ],
                rows: [
                  for (var item in widget.order.items)
                  DataRow(
                    cells:[
                      DataCell(Text(item.group.toString())),
                      DataCell(Text(item.product.name.toString())),
                      DataCell(Text(item.quantity.toString())),
                      if (widget.order.status == Status.preparing) DataCell(Checkbox(value: item.done, onChanged: (boo) => setState(() =>item.done = boo)))
                    ]
                  )
                ],
              )
          ),
          if (widget.showButtons)widget.order.status == Status.preparing ? AsyncButton(text: "Entregar", icon: Icon(Icons.delivery_dining), isLoading: data.prepareOrderPending, onPressed:() => updateOrder(Status.waiting)) : AsyncButton(text: "Produzir", icon: Icon(Icons.restaurant_menu), isLoading: data.prepareOrderPending, onPressed:() => updateOrder(Status.preparing))
        ],
      );
    });
  }
}