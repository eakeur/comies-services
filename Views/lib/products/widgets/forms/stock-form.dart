import 'package:comies/core.dart';
import 'package:datacontext/datacontext.dart';
import 'package:flutter/material.dart';
import 'package:comies/components.dart';

class StockForm extends StatefulWidget {
  final Stock? stock;

  final LoadStatus submitStatus;

  final Function() onSubmit;

  final bool isNew;

  const StockForm({Key? key, required this.stock, required this.onSubmit, required this.submitStatus, this.isNew = true}) : super(key: key);

  @override
  _StockFormState createState() => _StockFormState();
}

class _StockFormState extends State<StockForm> {
  late TextEditingController minimumController;
  late TextEditingController maximumController;
  late TextEditingController placeController;
  late TextEditingController actualController;
  late GlobalKey<FormState> formState;

  late DataSet<CategoryView> categories;

  void setFields() {
    minimumController = TextEditingController(text: getDoubleView(widget.stock?.minimum, 2))..addListener(() => widget.stock?.minimum = getDoubleValue(minimumController.text));
    maximumController = TextEditingController(text: getDoubleView(widget.stock?.maximum, 2))..addListener(() => widget.stock?.maximum = getDoubleValue(maximumController.text));
    placeController = TextEditingController(text: getTextView(widget.stock?.location))..addListener(() => widget.stock?.location = getTextValue(placeController.text));
    actualController = TextEditingController(text: getDoubleView(widget.stock?.actual, 2))..addListener(() => widget.stock?.actual = getDoubleValue(actualController.text));
  }

  @override
  void initState() {
    super.initState();
    formState = GlobalKey<FormState>();
    categories = getProvider(context).categoryViews;
    setFields();
  }

  @override
  void didUpdateWidget(StockForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    setFields();
  }

  String? isCodeValid(String? code) => code != null
      ? code.length >= 3 && code.length <= 6
          ? null
          : 'Ops! O código precisa ter de 3 a 6 caracteres'
      : 'Ops! Precisamos de um código para esse produto.';

  String? isNameValid(String? name) => name != null
      ? name.length >= 3 && name.length <= 150
          ? null
          : 'Ops! O nome precisa ter de 3 a 150 caracteres'
      : 'Ops! Precisamos de um nome para esse produto.';

  String? isExibNameValid(String? name) => name != null
      ? name.length >= 3 && name.length <= 70
          ? null
          : 'Ops! O nome de exibição precisa ter de 3 a 70 caracteres'
      : 'Ops! Precisamos de um nome para esse produto ser mostrado aos seus clientes.';

  String? isPriceValid(String? name) => name != null
      ? name.length >= 0
          ? null
          : 'Ops! O preço é inválido'
      : 'Ops! O preço é inválido.';

  String? isMinimumValid(String? name) => name != null
      ? name.length >= 0
          ? null
          : 'Ops! O preço é inválido'
      : 'Ops! O preço é inválido.';

  Widget get secondRow => Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: TextFormField(
          controller: placeController,
          maxLines: 3,
          maxLength: 500,
          decoration: InputDecoration(labelText: 'Descrição', helperText: 'Descrição do produto. Pode ser algo relacionado à sua composição ou a história dele no restaurante'),
        ),
      );

  Widget get fourthRow => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Flex(
          direction: isWidthSmall(context) ? Axis.vertical : Axis.horizontal,
          children: [
            Expanded(
              flex: isWidthSmall(context) ? 0 : 33,
              child: TextFormField(
                controller: minimumController,
                validator: isPriceValid,
                decoration: InputDecoration(labelText: 'Custo', helperText: 'O valor qur você investe para produzir esse produto', prefix: Text('R\$   ')),
              ),
            ),
            SizedBox(width: isWidthSmall(context) ? 0 : 20, height: isWidthSmall(context) ? 20 : 0),
            Expanded(
              flex: isWidthSmall(context) ? 0 : 33,
              child: TextFormField(
                controller: maximumController,
                validator: isPriceValid,
                decoration: InputDecoration(labelText: 'Preço de venda', helperText: 'O preço que você venderá esses produtos', prefix: Text('R\$   ')),
              ),
            ),
            SizedBox(width: isWidthSmall(context) ? 0 : 20, height: isWidthSmall(context) ? 20 : 0),
            Expanded(
              flex: isWidthSmall(context) ? 0 : 33,
              child: TextFormField(
                controller: actualController,
                validator: isPriceValid,
                decoration: InputDecoration(labelText: 'Desconto máximo', helperText: 'O máximo de desconto que pode ser aplicado', suffix: Text('%')),
              ),
            ),
          ],
        ),
      );

  Widget get formActions => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: MainButton(
              label: 'Salvar',
              loadingLabel: 'Salvando...',
              isLoading: widget.submitStatus == LoadStatus.LOADING,
              onTap: () {
                if (formState.currentState!.validate()) {
                  widget.onSubmit();
                }
              },
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formState,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [secondRow, fourthRow, formActions],
        ),
      ),
    );
  }
}
