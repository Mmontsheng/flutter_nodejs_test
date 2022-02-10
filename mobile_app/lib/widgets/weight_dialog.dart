import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/services/bearer_token.dart';
import 'package:mobile_app/state/weight.dart';
import 'package:mobile_app/theme/colors.dart';
import 'package:provider/provider.dart';

class WeightDialog extends StatefulWidget {
  final String? id;
  final String? value;

  const WeightDialog({Key? key, this.id, this.value}) : super(key: key);

  @override
  State<WeightDialog> createState() => _WeightDialogState();
}

class _WeightDialogState extends State<WeightDialog> {
  late BearerTokenService bearerTokenService;

  final GlobalKey<FormState> _formKey = GlobalKey();
  final weightInputController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    weightInputController.dispose();
  }

  @override
  void initState() {
    super.initState();
    weightInputController.text = widget.value ?? "";
  }

  @override
  Widget build(BuildContext context) {
    String id = widget.id ?? "";
    final provider = Provider.of<WeightProvider>(context);
    return AlertDialog(
      title: Text(
        id.isEmpty ? 'Add ${provider.isCreateUpdate}' : 'Edit',
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 25,
        ),
      ),
      content: SizedBox(
        height: 80,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                enableSuggestions: false,
                autocorrect: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide weight';
                  }
                  return null;
                },
                controller: weightInputController,
                keyboardType: TextInputType.phone,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(3),
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                decoration: InputDecoration(
                    suffixIcon: provider.isCreateUpdate ? loading() : null,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 13.0),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary),
                    ),
                    labelStyle: const TextStyle(color: Colors.black),
                    labelText: 'Your weight (kg)',
                    border: const OutlineInputBorder()),
              ),
              if (provider.createUpdateMessage.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(provider.createUpdateMessage,
                      style: const TextStyle(color: AppColors.danger)),
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: AppColors.primary,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text('Save',
              style: TextStyle(
                color: AppColors.primary,
              )),
          onPressed: () async {
            final bool isValid = _formKey.currentState!.validate();
            if (!isValid || provider.isCreateUpdate) {
              return;
            }
            if (id.isEmpty) {
              provider.add(weightInputController.text);
            } else {
              provider.update(id, weightInputController.text);
            }
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

Widget loading() {
  return const SizedBox(
    height: 5,
    width: 5,
    child: CupertinoActivityIndicator(),
  );
}
