import 'package:flutter/material.dart';

void main() {
  runApp(ViewEmployee());
}

class ViewEmployee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'More Contents',
            style: TextStyle(
              color: Colors.white, // Change to any color you like
              fontSize: 20, // Adjust font size
            ),
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: BeautifulListView(),
      ),
    );
  }
}

class BeautifulListView extends StatelessWidget {
  // Sample data for the list
  final List<Map<String, String>> items = [
    {'title': 'Mountain View', 'subtitle': 'Nature at its best', 'image': 'https://picsum.photos/200/300'},
    {'title': 'Sunny Beach', 'subtitle': 'Relax at the beach', 'image': 'https://picsum.photos/200/301'},
    {'title': 'City Lights', 'subtitle': 'Explore the nightlife', 'image': 'https://picsum.photos/200/302'},
    {'title': 'Forest Trail', 'subtitle': 'A walk in the woods', 'image': 'https://picsum.photos/200/303'},
    {'title': 'Sea World', 'subtitle': 'A walk in the sea', 'image': 'https://picsum.photos/200/304'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length, // Number of items in the list
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(15.0),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  items[index]['image']!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                items[index]['title']!,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple[800],
                ),
              ),
              subtitle: Text(
                items[index]['subtitle']!,
                style: TextStyle(color: Colors.grey[600]),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
              tileColor: Colors.deepPurple[50], // Light background color
              onTap: () {
                print('Tapped on: ${items[index]['title']}');
              },
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        // Build the separator between items
        return Divider(); // A simple divider between items
      },
    );
  }
}
