import 'package:comies/components/buttons/main-button.dart';
import 'package:comies/core.dart';
import 'package:flutter/material.dart';

class ProductForm extends StatefulWidget {
  final Product? product;

  final LoadStatus submitStatus;

  final Function(Product) onSubmit;

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
  late GlobalKey<FormState> formState;

  @override
  void initState() {
    super.initState();
    formState = GlobalKey<FormState>();
    codeController = TextEditingController(text: widget.product?.code);
    nameController = TextEditingController(text: widget.product?.name);
    descriptionController = TextEditingController(text: widget.product?.description);
    displayController = TextEditingController(text: widget.product?.display);
    tagsController = TextEditingController(text: widget.product?.tags);
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

  Widget get firstRow => Padding(
        padding: EdgeInsets.only(bottom: 10),
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
            SizedBox(width: isWidthSmall(context) ? 0 : 10, height: isWidthSmall(context) ? 10 : 0),
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
        padding: const EdgeInsets.only(bottom: 10.0),
        child: TextFormField(
          controller: descriptionController,
          maxLines: 3,
          maxLength: 500,
          decoration: InputDecoration(labelText: 'Descrição', helperText: 'Descrição do produto. Pode ser algo relacionado à sua composição ou a história dele no restaurante'),
        ),
      );

  Widget get thirdRow => Padding(
        padding: const EdgeInsets.only(bottom: 10),
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
            SizedBox(width: isWidthSmall(context) ? 0 : 10, height: isWidthSmall(context) ? 10 : 0),
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

  Widget get formActions => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MainButton(
            label: 'Salvar',
            loadingLabel: 'Salvando...',
            isLoading: widget.submitStatus == LoadStatus.LOADING,
            onTap: () {
              formState.currentState!.validate();
            },
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: formState,
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [firstRow, secondRow, thirdRow, formActions],
          ),
        ),
      ),
    );
  }
}
