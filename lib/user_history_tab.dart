import 'package:flutter/material.dart';

class UserHistoryTab extends StatelessWidget {
  const UserHistoryTab({super.key});
  final bool _customIcon = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          ExpansionTile(
            title: const Text('24, August 2024'),
            trailing: Icon(
              _customIcon ? Icons.arrow_drop_down : Icons.arrow_drop_down,
            ),
            children: const <Widget>[
              Text("This is where you'll find history"),
              Text("This is where you'll find history"),
              Text("This is where you'll find history"),
              Text("This is where you'll find history"),
              Text("This is where you'll find history"),
            ],
          ),
          ExpansionTile(
            title: const Text('04, September 2024'),
            trailing: Icon(
              _customIcon ? Icons.arrow_drop_down : Icons.arrow_drop_down,
            ),
            children: const <Widget>[
              Text("This is where you'll find history"),
              Text("This is where you'll find history"),
              Text("This is where you'll find history"),
              Text("This is where you'll find history"),
              Text("This is where you'll find history"),
            ],
          ),
          ExpansionTile(
            title: const Text('05, September 2024'),
            trailing: Icon(
              _customIcon ? Icons.arrow_drop_down : Icons.arrow_drop_down,
            ),
            children: const <Widget>[
              Text("This is where you'll find history"),
              Text("This is where you'll find history"),
              Text("This is where you'll find history"),
              Text("This is where you'll find history"),
              Text("This is where you'll find history"),
            ],
          ),
          ExpansionTile(
            title: const Text('24, August 2024'),
            trailing: Icon(
              _customIcon ? Icons.arrow_drop_down : Icons.arrow_drop_down,
            ),
            children: const <Widget>[
              Text("This is where you'll find history"),
              Text("This is where you'll find history"),
              Text("This is where you'll find history"),
              Text("This is where you'll find history"),
              Text("This is where you'll find history"),
            ],
          ),
          ExpansionTile(
            title: const Text('04, September 2024'),
            trailing: Icon(
              _customIcon ? Icons.arrow_drop_down : Icons.arrow_drop_down,
            ),
            children: const <Widget>[
              Text("This is where you'll find history"),
              Text("This is where you'll find history"),
              Text("This is where you'll find history"),
              Text("This is where you'll find history"),
              Text("This is where you'll find history"),
            ],
          ),
          ExpansionTile(
            title: const Text('01, November 2024'),
            trailing: Icon(
              _customIcon ? Icons.arrow_drop_down : Icons.arrow_drop_down,
            ),
            children: const <Widget>[
              Text("This is where you'll find history"),
              Text("This is where you'll find history"),
              Text("This is where you'll find history"),
              Text("This is where you'll find history"),
              Text("This is where you'll find history"),
            ],
          ),
          ExpansionTile(
            title: const Text('25, December 2024'),
            trailing: Icon(
              _customIcon ? Icons.arrow_drop_down : Icons.arrow_drop_down,
            ),
            children: const <Widget>[
              Text("This is where you'll find history"),
              Text("This is where you'll find history"),
              Text("This is where you'll find history"),
              Text("This is where you'll find history"),
              Text("This is where you'll find history"),
            ],
          ),
        ],
      ),
    );
  }
}
