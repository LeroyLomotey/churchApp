import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.all(15),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.pin_drop),
                const SizedBox(width: 10),
                Text('438 Valley Street, Orange, NJ 07050',
                    style: Theme.of(context).textTheme.titleMedium)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.call),
                const SizedBox(width: 10),
                Text('+1 (973) 674-7711 | (908) 906-2476',
                    style: Theme.of(context).textTheme.titleMedium)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.mail),
                const SizedBox(width: 10),
                Text('Icgclibertytemplenj@gmail.com',
                    style: Theme.of(context).textTheme.titleMedium)
              ],
            ),
          ]),
    );
  }
}
