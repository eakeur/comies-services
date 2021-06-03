import 'package:comies/core.dart' as Core;
import 'package:comies/routes.dart' as declared;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'item-widget.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> with TickerProviderStateMixin, NavigatorObserver {
  late AnimationController controller;

  @override
  void initState() {
    controller = new AnimationController(vsync: this, duration: Duration(milliseconds: 500), reverseDuration: Duration(milliseconds: 500));
    super.initState();
  }

  void navigate(String? route, String? actual) {
    if (route != actual) {
      controller.reverse();
      Future.delayed(Duration(milliseconds: 100), () => Navigator.pushNamed(context, route!));
    }
  }

  List<Widget> getMenuEntries(List<Core.Route> routes, String? route) {
    return [
      Container(
                  height: 15,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Core.ComponentBG,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(route?.startsWith(routes.first.path) ?? false ? 10 : 0),
                    ),
                  ),
                ),
                for (var i = 0; i < routes.length; i++)
                  MenuItemWidget(
                    controller: controller,
                    onTap: () => navigate(routes[i].path, route),
                    isBeforeSelected: Core.isWidthSmall(context) ? false : i + 1 != routes.length ? route == routes[i + 1].path : false,
                    isAfterSelected: Core.isWidthSmall(context) ? false :  i > 0 ? route == routes[i - 1].path : false,
                    isSelected: route == routes[i].path,
                    title: routes[i].name,
                    icon: routes[i].icon,
                  ),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Core.ComponentBG,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(route?.startsWith(routes.last.path) ?? false ? 10 : 0),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: route != '/auth' && !Core.isWidthSmall(context) ? Consumer<Core.ComiesController>(
                      builder: (context, prov, child) {
                        return MenuItemWidget(
                            controller: controller,
                            onTap: (){},
                            isBeforeSelected: true,
                            isAfterSelected: route?.startsWith(routes.last.path) ?? false,
                            isSelected: false,
                            title: prov.operatorName ?? '',
                            icon: Icons.face,
                          );
                      }
                    ) : null,
                  ),
                ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var route = ModalRoute.of(context)?.settings.name;
    List<Core.Route> routes = <Core.Route>[];
    if (route == '/auth')
      routes = declared.routes.where((r) => r.isAuth).toList();
    else
      routes = declared.routes.where((r) => !r.isAuth && !r.isSplash && r.encapsulate).toList();

    return !Core.isWidthSmall(context) ? Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))),
      width: 77,
      child: CustomPaint(
        painter: ShapesPainter(),
        child: Padding(
          padding: EdgeInsets.only(left: 6),
          child: Material(
            borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
            color: Colors.transparent,
            child: Column(
              children: getMenuEntries(routes, route),
            ),
          ),
        ),
      ),
    ) :
    Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))),
      height: 60,
      child: CustomPaint(
        painter: ShapesPainterHorizontal(),
        child: Padding(
          padding: const EdgeInsets.only(bottom:10.0),
          child: Material(
            borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
            color: Colors.transparent,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: getMenuEntries(routes, route),
            ),          
          ),
        ),
      )
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class ShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Core.ComponentBG;

    canvas.drawRect(Offset(0, 0) & Size(size.width * 0.80, size.height), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class ShapesPainterHorizontal extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Core.ComponentBG;

    canvas.drawRect(Offset(0, 0) & Size(size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
