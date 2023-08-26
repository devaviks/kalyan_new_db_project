import 'package:flutter/material.dart';
import 'package:kalyan_new_project/show_data.dart';

import 'database_helper.dart';
import 'model_class.dart';


class UserListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: FutureBuilder<List<UserData>>(
        future: DatabaseHelper.instance.getAllUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.data?.isEmpty ?? true) {
            return Center(
              child: Text('No user data found.'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              UserData userData = snapshot.data![index];
              return ListTile(
                title: Text('${userData.firstName} ${userData.lastName}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowDataPage(userData: userData),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
