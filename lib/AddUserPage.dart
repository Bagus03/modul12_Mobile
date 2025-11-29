import 'package:flutter/material.dart';
import 'FirestoreController.dart';

class AddUserPage extends StatefulWidget {
  final String? id; // jika null → create

  final String? name;
  final String? description;

  AddUserPage({this.id, this.name, this.description});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final controller = FirestoreController();

  late TextEditingController nameController;
  late TextEditingController descController;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.name ?? "");
    descController = TextEditingController(text: widget.description ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.id != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? "Edit User" : "Tambah User")),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Nama"),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: "Deskripsi"),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isEmpty ||
                    descController.text.isEmpty) return;

                if (isEdit) {
                  // UPDATE
                  await controller.updateUsers(
                    widget.id!,
                    nameController.text,
                    descController.text,
                  );
                } else {
                  // CREATE
                  await controller.createUsers(
                    nameController.text,
                    descController.text,
                  );
                }

                Navigator.pop(context);
              },
              child: Text(isEdit ? "Update" : "Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
