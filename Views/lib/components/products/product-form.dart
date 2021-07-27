import 'package:comies/core.dart';
import 'package:flutter/material.dart';
import 'package:comies/components.dart';

class ProductForm extends StatefulWidget {
  final Product? product;

  final LoadStatus submitStatus;

  final Function() onSubmit;

  final bool isNew;

  const ProductForm({Key? key, required this.product, required this.onSubmit, required this.submitStatus, this.isNew = true}) : super(key: key);

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  late TextEditingController codeController;
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController displayController;
  late TextEditingController tagsController;
  late TextEditingController priceController;
  late TextEditingController valueController;
  late TextEditingController discountController;
  late GlobalKey<FormState> formState;

  void setFields() {
    codeController = TextEditingController(text: getTextView(widget.product?.code))..addListener(() => widget.product?.code = getTextValue(codeController.text));
    nameController = TextEditingController(text: getTextView(widget.product?.name))..addListener(() => widget.product?.name = getTextValue(nameController.text));
    descriptionController = TextEditingController(text: getTextView(widget.product?.description))..addListener(() => widget.product?.description = getTextValue(descriptionController.text));
    displayController = TextEditingController(text: getTextView(widget.product?.display))..addListener(() => widget.product?.display = getTextValue(displayController.text));
    tagsController = TextEditingController(text: getTextView(widget.product?.tags))..addListener(() => widget.product?.tags = getTextValue(tagsController.text));
    priceController = TextEditingController(text: getCurrencyView(widget.product?.price))..addListener(() => widget.product?.price = getDoubleValue(priceController.text));
    valueController = TextEditingController(text: getCurrencyView(widget.product?.value))..addListener(() => widget.product?.value = getDoubleValue(valueController.text));
    discountController = TextEditingController(text: getCurrencyView(widget.product?.discount))..addListener(() => widget.product?.discount = getDoubleValue(discountController.text));
  }

  @override
  void initState() {
    super.initState();
    formState = GlobalKey<FormState>();
    setFields();
  }

  @override
  void didUpdateWidget(ProductForm oldWidget) {
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

  Widget get firstRow => Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Flex(
          direction: isWidthSmall(context) ? Axis.vertical : Axis.horizontal,
          children: [
            Expanded(
              flex: isWidthSmall(context) ? 0 : 30,
              child: TextFormField(
                controller: codeController,
                validator: isCodeValid,
                maxLength: 6,
                decoration: InputDecoration(labelText: 'Código', helperText: 'Código do produto'),
              ),
            ),
            SizedBox(width: isWidthSmall(context) ? 0 : 20, height: isWidthSmall(context) ? 20 : 0),
            Expanded(
              flex: isWidthSmall(context) ? 0 : 70,
              child: TextFormField(
                controller: nameController,
                validator: isNameValid,
                maxLength: 150,
                decoration: InputDecoration(labelText: 'Nome', helperText: 'Nome do produto'),
              ),
            ),
          ],
        ),
      );

  Widget get secondRow => Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: TextFormField(
          controller: descriptionController,
          maxLines: 3,
          maxLength: 500,
          decoration: InputDecoration(labelText: 'Descrição', helperText: 'Descrição do produto. Pode ser algo relacionado à sua composição ou a história dele no restaurante'),
        ),
      );

  Widget get thirdRow => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Flex(
          direction: isWidthSmall(context) ? Axis.vertical : Axis.horizontal,
          children: [
            Expanded(
              flex: isWidthSmall(context) ? 0 : 50,
              child: TextFormField(
                controller: displayController,
                validator: isExibNameValid,
                maxLength: 70,
                decoration: InputDecoration(labelText: 'Nome de exibição', helperText: 'O nome que irá aparecer para seus clientes'),
              ),
            ),
            SizedBox(width: isWidthSmall(context) ? 0 : 20, height: isWidthSmall(context) ? 20 : 0),
            Expanded(
              flex: isWidthSmall(context) ? 0 : 50,
              child: TextFormField(
                controller: tagsController,
                maxLength: 200,
                decoration: InputDecoration(labelText: 'Tags', helperText: 'Tags para categorizar os produtos e facilitar pesquisas'),
              ),
            ),
          ],
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
                controller: priceController,
                validator: isPriceValid,
                decoration: InputDecoration(labelText: 'Custo', helperText: 'O valor qur você investe para produzir esse produto', prefix: Text('R\$   ')),
              ),
            ),
            SizedBox(width: isWidthSmall(context) ? 0 : 20, height: isWidthSmall(context) ? 20 : 0),
            Expanded(
              flex: isWidthSmall(context) ? 0 : 33,
              child: TextFormField(
                controller: valueController,
                validator: isPriceValid,
                decoration: InputDecoration(labelText: 'Preço de venda', helperText: 'O preço que você venderá esses produtos', prefix: Text('R\$   ')),
              ),
            ),
            SizedBox(width: isWidthSmall(context) ? 0 : 20, height: isWidthSmall(context) ? 20 : 0),
            Expanded(
              flex: isWidthSmall(context) ? 0 : 33,
              child: TextFormField(
                controller: discountController,
                validator: isPriceValid,
                decoration: InputDecoration(labelText: 'Desconto máximo', helperText: 'O máximo de desconto que pode ser aplicado a esse produto', suffix: Text('%')),
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
          children: [firstRow, secondRow, thirdRow, fourthRow, formActions],
        ),
      ),
    );
  }
}
