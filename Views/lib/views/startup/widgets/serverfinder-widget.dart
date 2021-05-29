import 'package:comies/components.dart';
import 'package:comies/core.dart';
import 'package:flutter/material.dart';

class ServerFinderWidget extends StatefulWidget {
  final ConnectionType connectionType;
  final void Function(ConnectionType) onTypeChange;

  const ServerFinderWidget({Key key, this.connectionType, this.onTypeChange}) : super(key: key);

  @override
  _ServerFinderWidgetState createState() => _ServerFinderWidgetState();
}

class _ServerFinderWidgetState extends State<ServerFinderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(children: [
        Padding(padding: const EdgeInsets.only(bottom: 10), child: Text('Como vamos trabalhar?', style: title, textAlign: TextAlign.left)),
        Text(
              'Você vai usar o aplicativo online ou em uma rede fornecida pelo seu trabalho? ' +
                  'Se for na rede do seu trabalho, deixa que a gente a procura pra você. Se você preferir, pergunte a um responsável sobre o endereço da rede.',
              softWrap: true,
              textAlign: TextAlign.left
        ),
        GroupSelection<ConnectionType>(
          onSelectChange: widget.onTypeChange,
          children: [
            Selection<ConnectionType>(value: ConnectionType.ONLINE, child: Text('Online', style: legend), selected: ConnectionType.ONLINE == widget.connectionType),
            Selection<ConnectionType>(value: ConnectionType.LOCAL, child: Text('Rede do trabalho', style: legend), selected: ConnectionType.LOCAL == widget.connectionType),
          ],
        )
      ]),
    );
  }
}
