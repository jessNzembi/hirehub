// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class Settings extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Settings',
//           style: TextStyle(color: Color.fromARGB(255, 78, 176, 221)),
//         ),
//         centerTitle: true,
//       ),
//       body: ListView(
//         padding: EdgeInsets.symmetric(vertical: 8),
//         children: [
//           _buildSectionHeader('General'),
//           Divider(),
//           ListTile(
//             title: Text('Update Profile'),
//             trailing: Icon(Icons.account_circle),
//             onTap: () {
//               // Navigate to the update profile page
//               Get.toNamed('/updateProfile');
//             },
//           ),
//           Divider(),
//           ListTile(
//             title: Text('Logout'),
//             trailing: Icon(Icons.exit_to_app),
//             onTap: () {
//               // Add logout functionality
//               // For example, call a method to log out the user
//             },
//           ),
//           Divider(),
//           ListTile(
//             title: Text('Delete Account'),
//             trailing: Icon(Icons.delete),
//             onTap: () {
//               // Add logic to delete the account
//               // For example: showDialog(), or Get.defaultDialog(), etc.
//             },
//           ),
//           Divider(),
//           SizedBox(height: 16),
//           _buildSectionHeader('Feedback'),
//           Divider(),
//           ListTile(
//             title: Text('Report a Bug'),
//             trailing: Icon(Icons.bug_report),
//             onTap: () {
//               // Add functionality to report a bug
//             },
//           ),
//           Divider(),
//           ListTile(
//             title: Text('Send Feedback'),
//             trailing: Icon(Icons.feedback),
//             onTap: () {
//               // Add functionality to send feedback
//             },
//           ),
//           Divider(),
//           ListTile(
//             title: Text('Contact Us'),
//             trailing: Icon(Icons.contact_support),
//             onTap: () {
//               // Add functionality to contact support
//             },
//           ),
//           Divider(),
//         ],
//       ),
//     );
//   }

//   Widget _buildSectionHeader(String title) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Center(
//         child: Text(
//           title,
//           style: TextStyle(
//             fontSize: 18,
//             //fontWeight: FontWeight.bold,
//             color: Color.fromARGB(255, 78, 176, 221),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirehub/utils/apis.dart';
import 'package:hirehub/widgets/tools.dart';

class Settings extends StatelessWidget {
  final ApiService apiService = ApiService(); // Initialize ApiService

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(color: Color.fromARGB(255, 78, 176, 221)),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8),
        children: [
          _buildSectionHeader('General'),
          Divider(),
          ListTile(
            title: Text('Update Profile'),
            trailing: Icon(Icons.account_circle),
            onTap: () {
              // Navigate to the update profile page
              Get.toNamed('/updateProfile');
            },
          ),
          // Other list tiles
          Divider(),
          ListTile(
            title: Text('Logout'),
            trailing: Icon(Icons.exit_to_app),
            onTap: () async {
              _showConfirmationDialog(
                context,
                'Logout',
                'Are you sure you want to log out?',
                () async {
                  bool confirmLogout = await apiService.logout();
                  if (confirmLogout) {
                    // Navigate to the login page after logout
                    Get.offAllNamed('/login');
                  }
                },
              );
            },
          ),
          // Other list tiles
          Divider(),
          ListTile(
            title: Text('Delete Account'),
            trailing: Icon(Icons.delete),
            onTap: () async {
              _showConfirmationDialog(
                context,
                'Delete Account',
                'Are you sure you want to delete your account?',
                () async {
                  bool confirmDelete = await apiService.deleteAccount();
                  if (confirmDelete) {
                    // Navigate to the login page after account deletion
                    Get.offAllNamed('/login');
                  }
                },
              );
            },
          ),
          Divider(),
          SizedBox(height: 16),
          _buildSectionHeader('Feedback'),
          Divider(),
          ListTile(
            title: Text('Report a Bug'),
            trailing: Icon(Icons.bug_report),
            onTap: () {
              showCustomSnackbar(
                "Missing Feature",
                "Report a Bug feature is yet to be implemented.",
                icon: Icons.error,
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text('Send Feedback'),
            trailing: Icon(Icons.feedback),
            onTap: () {
              showCustomSnackbar(
                "Missing Feature",
                "Feedback feature is yet to be implemented.",
                icon: Icons.error,
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text('Contact Us'),
            trailing: Icon(Icons.contact_support),
            onTap: () {
              showCustomSnackbar(
                "Missing Feature",
                "Contact feature is yet to be implemented.",
                icon: Icons.error,
              );
            },
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 78, 176, 221),
          ),
        ),
      ),
    );
  }

  Future<void> _showConfirmationDialog(BuildContext context, String title,
      String content, Function() onConfirmed) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                onConfirmed(); // Call the callback when confirmed
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
