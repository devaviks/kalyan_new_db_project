import 'package:flutter/material.dart';
import 'package:kalyan_new_project/user_list.dart';

import 'model_class.dart';

class ShowDataPage extends StatelessWidget {
  final UserData userData;

  ShowDataPage({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              _showDetailsDialog(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Name: ${userData.firstName} ${userData.lastName}',
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserListPage(),
                ),
              );
            },
            child: Text('Name: ${userData.firstName}'),

          ),
        ],
      ),
    );
  }

  void _showDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('User Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('First Name: ${userData.firstName}'),
              Text('Last Name: ${userData.lastName}'),
              Text('Gender: ${userData.gender}'),
              Text('Country Code: ${userData.countryCode}'),
              Text('Phone Number: ${userData.phoneNumber}'),
              Text('User: ${userData.isUser}'),
              Text('Seller: ${userData.isSeller}'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}