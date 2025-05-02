import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text("User Profile")),
      body: FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection("users").doc(user?.uid).get(),
        builder: (context, snapshot) {
          if (user?.email == "ammareldesouki82@gmail.com") {
            return ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .restorablePushReplacementNamed("AdminPanel");
                },
                child: const Text("go to admin panel"));
          }
          // Handle loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Handle errors
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading profile"));
          }

          // Check if document exists and has data
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("User profile not found"));
          }

          // Safely retrieve user data
          var userData = snapshot.data!.data() as Map<String, dynamic>? ?? {};

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: userData['profileImage'] != null &&
                        userData['profileImage'] != ""
                    ? NetworkImage(userData['profileImage'])
                    : const AssetImage('assets/images/default_profile.png')
                        as ImageProvider,
              ),
              const SizedBox(height: 20),
              Text(
                '${userData['firstName'] ?? 'N/A'} ${userData['lastName'] ?? 'N/A'}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                userData['email'] ?? 'No email available',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          );
        },
      ),
    );
  }
}
