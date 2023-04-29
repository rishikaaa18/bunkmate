import 'package:bunkmate/repository/database.dart';
import 'package:bunkmate/screens/selected_item.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../constants_methods.dart';

class Item extends StatelessWidget {
  final MapEntry entry;
  const Item({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final double percentage =
        Database.percentage(entry.value['total'], entry.value['attended']);
    var message = '';
    message = getMessage(percentage);
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Card(
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SelectedItem(title: entry.key)));
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.key,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text('Overall attendance is ${(percentage * 100).round()}%'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Center(
                    child: LinearPercentIndicator(
                      animation: true,
                      percent: percentage,
                      progressColor: percentage >= .75
                          ? Colors.green.shade300
                          : Colors.red.shade300,
                      barRadius: const Radius.circular(4),
                    ),
                  ),
                ),
                Text(
                  message,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () async {},
                        style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.green.shade300,
                            side: BorderSide(color: Colors.green.shade300)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [Icon(Icons.done), Text('Attanded')],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red.shade300,
                            side: BorderSide(color: Colors.red.shade300)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [Icon(Icons.close), Text('Missed')],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
