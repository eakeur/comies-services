import 'package:comies/core.dart';
import 'package:datacontext/datacontext.dart';
import 'package:flutter/material.dart';
import 'package:comies/components.dart';

class CategoryForm extends StatefulWidget {
  final Category? category;

  final LoadStatus submitStatus;

  final Function() onSubmit;

  final bool isNew;

  const CategoryForm({Key? key, required this.category, required this.onSubmit, required this.submitStatus, this.isNew = true}) : super(key: key);

  @override
  _CategoryFormState createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  late TextEditingController codeController;
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late GlobalKey<FormState> formState;

  late DataSet<CategoryView> categories;

  void setFields() {
    codeController = TextEditingController(text: getTextView(widget.category?.code))..addListener(() => widget.category?.code = getTextValue(codeController.text));
    nameController = TextEditingController(text: getTextView(widget.category?.name))..addListener(() => widget.category?.name = getTextValue(nameController.text));
    descriptionController = TextEditingController(text: getTextView(widget.category?.description))..addListener(() => widget.category?.description = getTextValue(descriptionController.text));
  }

  @override
  void initState() {
    super.initState();
    formState = GlobalKey<FormState>();
    categories = getProvider(context).categoryViews;
    setFields();
  }

  @override
  void didUpdateWidget(CategoryForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    setFields();
  }

  String? isCodeValid(String? code) => code != null
      ? code.length >= 3 && code.length <= 6
          ? null
          : 'Ops! O código precisa ter de 3 a 6 caracteres'
      : 'Ops! Precisamos de um código para essa categoria.';

  String? isNameValid(String? name) => name != null
      ? name.length >= 3 && name.length <= 150
          ? null
          : 'Ops! O nome precisa ter de 3 a 150 caracteres'
      : 'Ops! Precisamos de um nome para essa categoria.';

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
                decoration: InputDecoration(labelText: 'Código', helperText: 'Código da categoria'),
              ),
            ),
            SizedBox(width: isWidthSmall(context) ? 0 : 20, height: isWidthSmall(context) ? 20 : 0),
            Expanded(
              flex: isWidthSmall(context) ? 0 : 70,
              child: TextFormField(
                controller: nameController,
                validator: isNameValid,
                maxLength: 150,
                decoration: InputDecoration(labelText: 'Nome', helperText: 'Nome da categoria'),
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
          decoration: InputDecoration(labelText: 'Descrição', helperText: 'Descrição da categoria. Pode ser algo relacionado à sua composição ou a história dela no restaurante'),
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
          children: [firstRow, secondRow, formActions],
        ),
      ),
    );
  }
}
