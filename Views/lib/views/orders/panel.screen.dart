import 'package:comies/controllers/kitchen.controller.dart' if(dart.library.html) 'package:comies/controllers/kitchenweb.controller.dart' if(dart.library.io) 'package:comies/controllers/kitchen.controller.dart';
import 'package:comies/structures/enum.dart';
import 'package:comies/utils/declarations/environment.dart';
import 'package:comies/views/orders/order.comp.dart';
import 'package:comies/views/orders/spoon.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class OrdersPanelScreen extends StatefulWidget {
  @override
  OrdersPanel createState() => OrdersPanel();
}

class OrdersPanel extends State<OrdersPanelScreen> {
  TextEditingController c = new TextEditingController();
  String type;

  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (type){
      case "spoon": child = SpoonScreen(code: c.text); break;
      case "pan": child = PanScreen(); break;
      default: child = Scaffold(
        appBar: AppBar(title: Text("Selecione sua função")),
        body: Builder(
          builder: (context){
            return Wrap(
              children: [
                ElevatedButton(child: Text("SOU COLHER"), onPressed: (){
                  Scaffold.of(context).showBottomSheet((context) => Container(
                    child: TextFormField(
                      controller: c,
                      onFieldSubmitted: (s){Navigator.pop(context); setState((){type = "spoon";});},
                      decoration: InputDecoration(
                        labelText: "Código da panela",
                        hintMaxLines: 3,
                        hintText: "Este código aparecerá na tela em que você que se conectar",
                        suffix: IconButton(icon: Icon(Icons.add), onPressed: (){
                          Navigator.pop(context);
                          setState((){type = "spoon";});
                        })
                      ),
                    )
                  ));
                }),
                ElevatedButton(child: Text("SOU PANELA"), onPressed: (){setState((){type = "pan";});})
              ],
            );
          },
        )
      ); break;
    }

    return child;

  }
}



class PanScreen extends StatefulWidget {
  final ScrollController scroll = new ScrollController();
  @override
  _PanScreenState createState() => _PanScreenState();
}

class _PanScreenState extends State<PanScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => KitchenController("pan", controller: widget.scroll),
      child: Consumer<KitchenController>(
        builder: (context, ctx, child){
          return Scaffold(
            appBar: AppBar(
              title: Text("Cozinha" + (ctx.code == "" ? "" : " - ID: ${ctx.code}")),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Wrap(
                    children: [
                      Chip(label: Text("Filtro: "+ctx.statusName), elevation: 8, backgroundColor: Theme.of(context).accentColor)
                    ],
                  ),
                )
              ),
            ),
            body: Consumer<KitchenController>(
              builder: (context, ctx, child){
                return StaggeredGridView.count(
                  controller: widget.scroll,
                  crossAxisCount: MediaQuery.of(context).size.width > (widthDivisor + 220) ? 2 : 1,
                  children: [
                    for (var order in ctx.orders) Container(child:Card(child: OrderBottomSheet(order:order, showButtons: false)))
                  ],
                  staggeredTiles: [for (int i = 0; i < ctx.orders.length; i++) StaggeredTile.fit(1)],
                );
              }
            )
          );
        }
      )
    );
  }
}



