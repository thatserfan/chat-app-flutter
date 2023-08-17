import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: false,
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No messages'),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('Somthing went wrong...'),
          );
        }

        final loadedMessages = snapshot.data!.docs;

        return ListView.builder(
          itemCount: loadedMessages.length,
          itemBuilder: (context, index) => Text(
            loadedMessages[index].data()['text'],
          ),
        );
      },
    );
  }
}
