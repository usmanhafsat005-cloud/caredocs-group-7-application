import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  final String title;

  const NotePage({super.key, required this.title});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final TextEditingController controller = TextEditingController();

  List<String> notes = [];

  void addNote() {
    if (controller.text.trim().isEmpty) return;

    setState(() {
      notes.add(controller.text.trim());
      controller.clear();
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Note added successfully")));
  }

  void openAddNoteSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),

      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Add ${widget.title} Note",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: controller,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Write your note here...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  onPressed: () {
                    Navigator.pop(context);
                    addNote();
                  },
                  child: const Text("SAVE NOTE"),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
        onPressed: openAddNoteSheet,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: notes.isEmpty
            ? const Center(
                child: Text(
                  "No notes yet. Tap + to add a note.",
                  style: TextStyle(fontSize: 16),
                ),
              )
            : ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    child: ListTile(
                      leading: const Icon(Icons.note, color: Colors.teal),
                      title: Text(notes[index]),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
