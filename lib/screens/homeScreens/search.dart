import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messagingapp/customWidget/appText.dart';
import 'package:messagingapp/customWidget/customFormTextBuilder.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       body: Container(
//         width: double.infinity,
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               CustomSearchTextField(),
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messagingapp/customWidget/customFormTextBuilder.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class SearchScreen extends StatefulWidget {
  final User? currentUser;
  const SearchScreen({super.key, this.currentUser});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> searchResults = [];

  Future<void> _searchUsers(String query) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("Users")
        .where("full name", isLessThanOrEqualTo: query)
        .get();

    setState(() {
      searchResults = querySnapshot.docs
          .where(
            (doc) =>
                doc.id != widget.currentUser?.uid &&
                (doc["full name"] as String).toLowerCase().contains(
                      query.toLowerCase(),
                    ),
          )
          .toList();
      ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomSearchTextField(
                  controller: _searchController,
                  onSubmitted: (query) {
                    _searchUsers(query);
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final userData =
                          searchResults[index].data() as Map<String, dynamic>;
                      return ListTile(
                        leading: const CircleAvatar(
                          backgroundImage: AssetImage(
                              "assets/images/anonymous-user-circle-icon-vector-18958255.jpg"),
                        ),

                        title: AppText(text: userData['full name'] ?? ""),
                        subtitle: AppText(text: userData["email"] ?? ""),
                        // Add more user information as needed
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
