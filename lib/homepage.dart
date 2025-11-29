import 'package:flutter/material.dart';
import 'FirestoreController.dart';
import 'AddUserPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FirestoreController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Modul 12 - Firebase PART I"),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddUserPage()),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: StreamBuilder(
        stream: controller.streamUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Terjadi kesalahan!"));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final user = data[index];

              return Card(
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(user["name"]),
                  subtitle: Text(user["description"]),

                  // TOMBOL EDIT & DELETE
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // EDIT
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddUserPage(
                                id: user.id,
                                name: user["name"],
                                description: user["description"],
                              ),
                            ),
                          );
                        },
                      ),

                      // DELETE
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          controller.deleteUsers(user.id);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
