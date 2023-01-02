import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/create'),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('students').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.docs.map((document) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(document['image']),
                  ),
                  title: Text(
                    document['name'],
                    style: const TextStyle(color: Colors.black),
                  ),
                  subtitle: Text(document['semester']),
                  trailing: Wrap(
                    spacing: 12,
                    children: const [
                      Icon(Icons.edit, color: Colors.black),
                      Icon(Icons.delete, color: Colors.red),
                    ],
                  ),
                );
              }).toList(),
            );
          }
          return const Text("Data not found");
        },
      ),
    );
  }
}
