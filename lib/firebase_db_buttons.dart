import 'package:caredocs_apps/database_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FirebaseDBButtons extends StatefulWidget {
  const FirebaseDBButtons({super.key});

  @override
  State<FirebaseDBButtons> createState() => _FirebaseDBButtonsState();
}

class _FirebaseDBButtonsState extends State<FirebaseDBButtons> {
  final DatabaseService db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await db.create(path: 'data1', data: 'Flutter pro');
              },
              child: const Text('Create'),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () async {
                DataSnapshot? event = await db.read(path: 'data1');
                if (kDebugMode) {
                  print(event?.snapshot.value);
                }
              },
              child: const Text('Read'),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () async {
                await db.update(
                  path: 'data1',
                  data: {'text': 'Flutter updated'},
                );
              },
              child: const Text('Update'),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () async {
                await db.delete(path: 'data1');
              },
              child: const Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}

extension on DataSnapshot? {
  get snapshot => null;
}
