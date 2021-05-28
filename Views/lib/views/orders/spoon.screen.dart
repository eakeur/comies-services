import 'package:comies/components/titlebox.comp.dart';
import 'package:comies/controllers/kitchen.controller.dart' if(dart.library.html) 'package:comies/controllers/kitchenweb.controller.dart' if(dart.library.io) 'package:comies/controllers/kitchen.controller.dart';
import 'package:comies/structures/structures.dart';
import 'package:comies/views/orders/order.comp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpoonScreen extends StatefulWidget {
  final String code;
  SpoonScreen({this.code});
  @override
  _SpoonScreenState createState() => _SpoonScreenState();
}

class _SpoonScreenState extends State<SpoonScreen> with SingleTickerProviderStateMixin {
  TabController con;
  @override
  void initState(){
    super.initState();
    con = new TabController(length: 4, vsync: this, initialIndex: 1);
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => KitchenController("spoon", panID: widget.code),
      child: Consumer<KitchenController>(
        builder: (context, ctx, child){
          return Scaffold(
            appBar: AppBar(
              title: Text("Cozinha" + (ctx.code == "" ? "" : " - ID: ${ctx.code}")),
              bottom: TabBar(
                controller: con,
                tabs: [
                  Tab(icon:(Icon(Icons.filter_list))),
                  Tab(child:Text("Deslizador")),
                  Tab(child:Text("Pendentes")),
                  Tab(child:Text("Preparando")),
                ],
              ), 
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
            body: Builder(
              builder: (ct){
                return TabBarView(
                  controller: con,
                  children: [
                    OrderFilterDialog(),
                    Column(
                      children: [
                        Expanded(flex: 100,
                          child: GestureDetector(
                            onVerticalDragUpdate: (details){
                              details.delta.dy > 0 
                              ? ctx.sendToPan("scroll", details.delta.distanceSquared * -1)
                              : ctx.sendToPan("scroll", details.delta.distanceSquared);
                            },
                            child: Container(
                              child: Card(child: Center(child:Text("Deslize para mexer na panela")))
                            ),
                          ),
                        ),
                      ]
                    ),
                    Consumer<KitchenController>(
                      builder: (context, ctx, child){
                        return Column(
                          children: [child,
                            Expanded(flex:90,
                              child: ctx.pending.isNotEmpty ? ListView(
                                children: ListTile.divideTiles(context: context, tiles: [
                                  for (var ord in ctx.pending)
                                  ListTile(
                                    onTap: () => openOrderDialog(ord, context),
                                    title: Text("Pedido Nº ${ord.id}"),
                                    subtitle: Text("R\$${ord.price.toString()} | ${ord.status.toString().replaceFirst('.', ": ").replaceFirst("pending", "pendente")}"),
                                  )
                                ]).toList()
                              ) : Center(child:Text("Nenhum pedido pendente")),
                            )
                          ],
                        );
                      },
                      child: Expanded(flex: 10, child: TitleBox("Pedidos pendentes")),
                    ),
                    Column(
                      children: [
                        Expanded(flex: 10, child: TitleBox("Pedidos em preparo")),
                        Expanded(flex:90,
                          child: ctx.preparing.isNotEmpty ? ListView(
                            children: ListTile.divideTiles(context: ct, tiles: [
                              for (var ord in ctx.preparing)
                              ListTile(
                                onTap: () => openOrderDialog(ord, ct),
                                title: Text("Pedido Nº ${ord.id}"),
                                subtitle: Text("R\$${ord.price.toString()} | ${ord.status.toString().replaceFirst('.', ": ").replaceFirst("preparing", "preparando")}"),
                              )
                            ]).toList()
                          ) : Center(child:Text("Nenhum pedido nesta etapa")),
                        )
                      ],
                    )
                  ],
                );
              },
            ),
          );
        }
      )
    );
  }
    void openOrderDialog(Order order, BuildContext ctx){
  Scaffold.of(ctx).showBottomSheet((ctx){
      return Card(elevation: 8,child: Container(child: OrderBottomSheet(order: order, showButtons: true)));
    });
  }
}


class OrderFilterDialog extends StatefulWidget {
  @override
  _OrderFilterDialogState createState() => _OrderFilterDialogState();
}

class _OrderFilterDialogState extends State<OrderFilterDialog> {
  @override
  Widget build(BuildContext context) {
    return Consumer<KitchenController>(
      builder:(context, controller, child){
        return Container(
          child: ListView(
            children: [
              Card(
                child: Column(
                  children: [
                    TitleBox("FILTRAR POR STATUS"),
                    RadioListTile(title: Text("Pendente"), value: Status.pending, groupValue: controller.status, onChanged: (Status st) => setState(() => controller.status = st)),
                    RadioListTile(title: Text("Preparando"), value: Status.preparing, groupValue: controller.status, onChanged: (Status st) => setState(() => controller.status = st)),
                    RadioListTile(title: Text("Aguardando"), value: Status.waiting, groupValue: controller.status, onChanged: (Status st) => setState(() => controller.status = st)),
                    RadioListTile(title: Text("A caminho"), value: Status.onTheWay, groupValue: controller.status, onChanged: (Status st) => setState(() => controller.status = st))
                  ],
                )
              )
            ],
          )
        );
      }
    );
  }
}