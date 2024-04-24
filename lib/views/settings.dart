import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirehub/utils/apis.dart';
import 'package:hirehub/widgets/tools.dart';

class Settings extends StatelessWidget {
  final ApiService apiService = ApiService();

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
              Get.toNamed('/updateProfile');
            },
          ),
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
                    Get.offAllNamed('/login');
                  }
                },
              );
            },
          ),
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
                    Get.offAllNamed('/');
                  } else {
                    print('failed');
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
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirmed();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
