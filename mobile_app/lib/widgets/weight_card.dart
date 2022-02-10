import 'package:flutter/material.dart';
import 'package:mobile_app/models/weight/weight.dart';
import 'package:mobile_app/theme/colors.dart';
import 'package:mobile_app/widgets/weight_dialog.dart';

class WeightCard extends StatelessWidget {
  final Function(Weight) onDeleted;

  final Weight weight;
  const WeightCard({
    Key? key,
    required this.weight,
    required this.onDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) {
            return WeightDialog(
              id: weight.id,
              value: weight.value,
            );
          },
        );
      },
      child: Dismissible(
        onDismissed: (direction) {
          onDeleted(weight);
        },
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
                        color: AppColors.lightGrey,
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
