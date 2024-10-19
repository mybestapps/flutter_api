import 'package:emp/UpdateEmployee.dart';
import 'package:emp/UserRegistration.dart';
import 'package:emp/ViewApi.dart';
import 'package:emp/ViewEmployee.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DrawerExampleOne(title: 'Home Page'),
    );
  }
}

class DrawerExampleOne extends StatelessWidget {
  final String title;

  const DrawerExampleOne({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee App'),
      ),
      body: Center(
        child: Text('Home Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // User Account Drawer Header
            UserAccountsDrawerHeader(
              accountName: Text('Sam'),
              accountEmail: Text('sam@emp.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  'JD',
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            // Drawer ListTiles (Menu Items)
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Handle the Home tap
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Register'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserRegistration(),));

              },
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text('Update Profile'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateEmployee(),));

              },
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text('View Employee'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewEmployee(),));
              },
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text('View Api Data'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewApi(),));

              },
            ),

            Divider(), // A horizontal line divider
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Handle the Logout tap
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
    );
  }
}

