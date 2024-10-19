import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class UserRegistration extends StatefulWidget {
  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final DatabaseReference _database = FirebaseDatabase.instance.ref();



  void _saveData() {
    if (_formKey.currentState!.validate()) {
      _database.child("employee").push().set({
        'name': nameController.text,
        'email': emailController.text,
        'address': addressController.text,
        'phone': phoneController.text,
        'password': passwordController.text,
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data saved successfully!')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save data: $error')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Employee Register"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.blueAccent.shade200,
              Colors.pinkAccent.shade200,
            ],
            center: Alignment.center,
            radius: 1.0,
            focal: Alignment.center,
            focalRadius: 0.1,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Register Employee',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildInputField(
                    controller: nameController,
                    label: 'Name',
                    icon: Icons.person,
                  ),
                  SizedBox(height: 20),
                  _buildInputField(
                    controller: addressController,
                    label: 'Address',
                    icon: Icons.account_balance_wallet,
                  ),
                  SizedBox(height: 20),
                  _buildInputField(
                    controller: emailController,
                    label: 'Email',
                    icon: Icons.email,
                  ),
                  SizedBox(height: 20),
                  _buildInputField(
                    controller: phoneController,
                    label: 'Phone',
                    icon: Icons.phone,
                  ),
                  SizedBox(height: 20),
                  _buildInputField(
                    controller: passwordController,
                    label: 'Password',
                    icon: Icons.lock,
                    isPassword: true,
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _saveData,
                      child: Text('Submit'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        minimumSize: Size(100, 50),
                        textStyle: TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          // Handle navigation to login
                        },
                        child: Text('Login'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.red),
          border: InputBorder.none,
          prefixIcon: Icon(icon),
        ),
        keyboardType:
        isPassword ? TextInputType.visiblePassword : TextInputType.text,
        obscureText: isPassword,
      ),
    );
  }
}
