import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/models/weight.dart';
import 'package:mobile_app/theme/colors.dart';

class WeightDialog extends StatefulWidget {
  final Weight? weight;
  final Function(String, String) onSave;

  const WeightDialog({Key? key, this.weight, required this.onSave})
      : super(key: key);

  @override
  State<WeightDialog> createState() => _WeightDialogState();
}

class _WeightDialogState extends State<WeightDialog> {
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
    if (widget.weight != null) {
      weightInputController.text = widget.weight!.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    String title = (widget.weight == null) ? 'Add' : 'Edit';
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 25,
        ),
      ),
      content: Form(
        key: _formKey,
        child: TextFormField(
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
            LengthLimitingTextInputFormatter(2),
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          decoration: const InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10.0, vertical: 13.0),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary),
              ),
              labelStyle: TextStyle(color: Colors.black),
              labelText: 'Your weight (kg)',
              border: OutlineInputBorder()),
        ),
      ),
      actions: <Widget>[
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
          onPressed: () {
            final bool isValid = _formKey.currentState!.validate();
            if (!isValid) {
              return;
            }
            widget.onSave(weightInputController.text, widget.weight!.id);
          },
        ),
      ],
    );
  }
}
