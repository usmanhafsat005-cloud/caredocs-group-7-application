import 'package:flutter/material.dart';

class pageone extends StatelessWidget {
  const pageone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BIODATA'), centerTitle: true),
      body: ListView(
        children: [
          Card(child: ListTile(title: Text('FULLNAME'))),
          SizedBox(height: 3),
          TextFormField(),
          SizedBox(height: 3),
          Card(child: ListTile(title: Text('SEX'))),
          SizedBox(height: 3),
          TextFormField(),
          SizedBox(height: 3),
          Card(child: ListTile(title: Text('AGE'))),
          SizedBox(height: 3),
          TextFormField(),
          SizedBox(height: 3),
          Card(child: ListTile(title: Text('ADDRESS'))),
          SizedBox(height: 3),
          TextFormField(),
          SizedBox(height: 3),
          Card(child: ListTile(title: Text('MARITAL STATUS'))),
          SizedBox(height: 3),
          TextFormField(),
          SizedBox(height: 3),
          ElevatedButton(onPressed: null, child: Text('ENTER')),
        ],
      ),
    );
  }
}
