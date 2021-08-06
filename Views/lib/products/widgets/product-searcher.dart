import 'package:comies/components.dart';
import 'package:comies/core.dart';
import 'package:comies/core/utils.dart';
import 'package:flutter/material.dart';

class ProductSearcher extends StatefulWidget {
  final VoidCallback onCancel;
  final Function(ProductFilter) onSearch;
  const ProductSearcher({Key? key, required this.onSearch, required this.onCancel}) : super(key: key);

  @override
  _ProductSearcherState createState() => _ProductSearcherState();
}

class _ProductSearcherState extends State<ProductSearcher> {
  ProductFilter filter = ProductFilter();

  int value = 1;

  void onCancel() {
    setState(() {
      filter = ProductFilter();
    });
    widget.onCancel();
  }

  void onFiltering() {
    showDialog(
      context: context,
      builder: (context) {
        return ProductFilterForm(filter: filter, onTap: () => widget.onSearch(filter));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onEditingComplete: () => widget.onSearch(filter),
      onFieldSubmitted: (s) => widget.onSearch(filter),
      onChanged: (v) => setState(() {
        filter.code = v;
      }),
      decoration: InputDecoration(
        labelText: 'Pesquise por código ou pelos filtros',
        suffix: Container(
          constraints: BoxConstraints(maxWidth: getWidth(context) * 0.25, minWidth: getWidth(context) * 0.1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (filter.code != null || filter.name != null || filter.tag != null) IconButton(icon: Icon(Icons.close), onPressed: onCancel, tooltip: 'Cancelar'),
              IconButton(icon: Icon(Icons.filter_list), onPressed: onFiltering, tooltip: 'Filtrar'),
              IconButton(icon: Icon(Icons.search), onPressed: () => widget.onSearch(filter), tooltip: 'Pesquisar'),
            ],
          ),
        ),
      ),
    );
    // return Row(
    //   children: [
    //     Flexible(
    //       flex: 30,
    //       child: DropdownButtonFormField<int>(
    //         value: value,
    //         onChanged: (v) => setState(() => value = v ?? 0),
    //         items: [
    //           DropdownMenuItem<int>(
    //             child: Text('Pesquisar por código'),
    //             value: 0,
    //           ),
    //           DropdownMenuItem<int>(
    //             child: Text('Pesquisar por nome'),
    //             value: 1,
    //           ),
    //           DropdownMenuItem<int>(
    //             child: Text('Pesquisar por tag'),
    //             value: 2,
    //           ),
    //         ],
    //       ),
    //     ),
    //     Flexible(
    //       flex: 60,
    //       child: TextFormField(
    //         //controller: text,
    //         decoration: InputDecoration(
    //           labelText: 'Pesquise por ${value == 0 ? 'código' : value == 1 ? 'nome' : 'tag'}',
    //         ),
    //         onChanged: (v) => widget.onSearch(value, v),
    //       ),
    //     ),
    //   ],
    // );
  }
}

class ProductFilterForm extends StatelessWidget {
  final ProductFilter filter;
  final VoidCallback onTap;
  const ProductFilterForm({Key? key, required this.filter, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(100),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Flex(
                  direction: isWidthSmall(context) ? Axis.vertical : Axis.horizontal,
                  children: [
                    Expanded(
                      flex: isWidthSmall(context) ? 0 : 30,
                      child: TextFormField(
                        onChanged: (v) => filter.code = v,
                        maxLength: 6,
                        decoration: InputDecoration(labelText: 'Código', helperText: 'Código do produto'),
                      ),
                    ),
                    SizedBox(width: isWidthSmall(context) ? 0 : 20, height: isWidthSmall(context) ? 20 : 0),
                    Expanded(
                      flex: isWidthSmall(context) ? 0 : 70,
                      child: TextFormField(
                        onChanged: (v) => filter.name = v,
                        maxLength: 150,
                        decoration: InputDecoration(labelText: 'Nome', helperText: 'Nome do produto'),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  onChanged: (v) => filter.tag = v,
                  maxLength: 200,
                  decoration: InputDecoration(labelText: 'Tags', helperText: 'Tags para categorizar os produtos e facilitar pesquisas'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: MainButton(
                      label: 'Pesquisar',
                      onTap: onTap,
                    ),
                  ),
                  Expanded(
                    child: DefaultButton(
                      label: 'Cancelar',
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
