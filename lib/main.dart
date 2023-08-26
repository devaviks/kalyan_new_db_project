import 'package:flutter/material.dart';
import 'package:kalyan_new_project/show_data.dart';

import 'database_helper.dart';
import 'model_class.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  String _firstName = "";
  String _lastName = "";
  String _gender = "Male";
  String _countryCode = "+1";
  String _phoneNumber = "";
  bool _isUser = false;
  bool _isSeller = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Form',
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
        backgroundColor: Colors.white,
        elevation: 2.0,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _firstName = value!;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _lastName = value!;
                },
              ),
              SizedBox(height: 12),
              SizedBox(
                width: 200,
                child: DropdownButtonFormField<String>(
                  value: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value!;
                    });
                  },
                  items: ['Male', 'Female']
                      .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                  decoration: InputDecoration(labelText: 'Gender'),
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  SizedBox(
                    width: 200,
                    child: DropdownButtonFormField<String>(
                      value: _countryCode,
                      onChanged: (value) {
                        setState(() {
                          _countryCode = value!;
                        });
                      },
                      items: ['+1', '+44', '+91', '+81']
                          .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                      decoration: InputDecoration(labelText: 'Country Code'),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Phone Number'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _phoneNumber = value!;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              CheckboxListTile(
                value: _isUser,
                onChanged: (value) {
                  setState(() {
                    _isUser = value!;
                  });
                },
                title: Text('User'),
              ),
              CheckboxListTile(
                value: _isSeller,
                onChanged: (value) {
                  setState(() {
                    _isSeller = value!;
                  });
                },
                title: Text('Seller'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _navigateToShowDataPage();
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToShowDataPage() async {
    UserData userData = UserData(
      id: 0, // Provide an appropriate initial value here
      firstName: _firstName,
      lastName: _lastName,
      gender: _gender,
      countryCode: _countryCode,
      phoneNumber: _phoneNumber,
      isUser: _isUser,
      isSeller: _isSeller,
    );

    int insertedId = await DatabaseHelper.instance.insert(userData);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShowDataPage(userData: userData.copyWith(id: insertedId)),
      ),
    );
  }

  List<UserData> userDataList = [];
}
