import 'package:flutter/material.dart';
import 'package:pill_pilot/models/intake_slot_model.dart';
import 'package:pill_pilot/widgets/my_card.dart';
import 'package:pill_pilot/models/day_part.dart';
import 'package:provider/provider.dart';

class IntakeSlotCard extends StatelessWidget {
  final DayPart dayPart;

  const IntakeSlotCard({super.key, required this.dayPart});

  @override
  Widget build(BuildContext context) {
    return Consumer<IntakeSlotModel>(
      builder: (context, intakeSlotModel, child) => MyCard(
        border: Border.all(width: 1),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getDayPartLabel(dayPart),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  getDefaultTime(dayPart),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Divider(),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 155, 233, 209),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 24, 227, 166),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: GestureDetector(
                          onTap: () => intakeSlotModel.addOne(dayPart),
                          child: Row(
                            children: [
                              Image.asset(
                                "lib/images/pill_one.png",
                                height: 40,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                "+1",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => intakeSlotModel.addHalf(dayPart),
                        child: Row(
                          children: [
                            const SizedBox(width: 6),
                            Image.asset(
                              "lib/images/pill_half_1.png",
                              height: 48,
                            ),
                            Text(
                              "+½",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "${intakeSlotModel.getAmount(dayPart)}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),

                GestureDetector(
                  onTap: () => intakeSlotModel.clear(dayPart),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.delete_outline, size: 30),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
