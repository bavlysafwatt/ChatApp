import 'package:chat_app/components/user_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey.shade400,
          centerTitle: true,
          title: const Text(
            'Chats',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.logout_outlined),
            )
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: users.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<String> usersList = [];
              for (int i = 0; i < snapshot.data!.docs.length; i++) {
                if (email != snapshot.data!.docs[i]['email']) {
                  usersList.add(snapshot.data!.docs[i]['email']);
                }
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListView.builder(
                  itemCount: usersList.length,
                  itemBuilder: (context, index) {
                    return UserTile(
                      text: usersList[index],
                      onTap: () {
                        Navigator.pushNamed(context, 'chatPage',
                            arguments: [email, usersList[index]]);
                      },
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'There was an error, please try again later!',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.grey.shade600,
                  backgroundColor: Colors.grey.shade500,
                ),
              );
            }
          },
        ));
  }
}
