import 'package:comies/components.dart';
import 'package:comies/core.dart';
import 'package:datacontext/datacontext.dart';
import 'package:flutter/material.dart';

class CustomerForm extends StatefulWidget {
  final Customer? customer;

  final LoadStatus submitStatus;

  final Function() onSubmit;

  final bool isNew;

  const CustomerForm({Key? key, required this.customer, required this.onSubmit, required this.submitStatus, this.isNew = true}) : super(key: key);

  @override
  _CustomerFormState createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  late TextEditingController nameController;
  late TextEditingController documentController;
  late GlobalKey<FormState> formState;

  void setFields() {
    nameController = TextEditingController(text: getTextView(widget.customer?.name))..addListener(() => widget.customer?.name = getTextValue(nameController.text));
    documentController = TextEditingController(text: getTextView(widget.customer?.document))..addListener(() => widget.customer?.document = getTextValue(documentController.text));
  }

  @override
  void initState() {
    super.initState();
    formState = GlobalKey<FormState>();
    setFields();
  }

  @override
  void didUpdateWidget(CustomerForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    setFields();
  }

  String? isNameValid(String? name) => name != null
      ? name.length >= 3 && name.length <= 150
          ? null
          : 'Ops! O nome precisa ter de 3 a 150 caracteres'
      : 'Ops! Precisamos de um nome para esse produto.';

  Widget get firstRow => Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: TextFormField(
          controller: nameController,
          validator: isNameValid,
          maxLength: 150,
          decoration: InputDecoration(labelText: 'Nome', helperText: 'Nome do cliente'),
        ),
      );

  Widget get secondRow => Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: TextFormField(
          controller: documentController,
          maxLength: 14,
          decoration: InputDecoration(labelText: 'Documento', helperText: 'Documento do cliente'),
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
