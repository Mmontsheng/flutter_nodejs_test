import 'package:flutter/material.dart';
import 'package:mobile_app/models/weight.dart';
import 'package:mobile_app/theme/colors.dart';
import 'package:mobile_app/widgets/weight_dialog.dart';

class WeightCard extends StatelessWidget {
  final DismissDirectionCallback? onDismissed;

  final Weight weight;
  const WeightCard({
    Key? key,
    required this.weight,
    this.onDismissed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) {
            return WeightDialog(
                weight: weight,
                onSave: (value, id) {
                  Navigator.pop(context);
                });
          },
        );
      },
      child: Dismissible(
        onDismissed: onDismissed,
        key: Key(weight.id),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Container(
            height: 100,
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      weight.value,
                      style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5, top: 8),
                      child: Text('kg',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.grey,
                          )),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(weight.date,
                    style: const TextStyle(
                        color: AppColors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
