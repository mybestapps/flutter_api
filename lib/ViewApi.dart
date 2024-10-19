import 'dart:convert';
import 'package:emp/ScreenAdd.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
class ViewApi extends StatefulWidget {
  const ViewApi({super.key});
  @override
  State<ViewApi> createState() => _ScreenHomeState();
}
class _ScreenHomeState extends State<ViewApi> {
  bool isloading = true;
  List items = [];
  @override
  void initState() {
    fetch();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              NavigateAdd();
            },
            label: Text("Add TODO")),
        appBar: AppBar(
          title: Text('Todo List'),
        ),
        body: Visibility(
          visible: isloading,
          child: Center(
            child: CircularProgressIndicator(),
          ),
          replacement: RefreshIndicator(
            onRefresh: fetch,
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index] as Map;
                final id = item["_id"] as String;

                return ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text(item["title"]),
                  subtitle: Text(item['description']),
                  trailing: PopupMenuButton(
                    onSelected: (value) {
                      if (value == "delete") {
                        deleteItem(id);
                      } else {
                        NavigateEdit(item);
                      }
                    },
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          child: Text("Delete"),
                          value: "delete",
                        ),
                        PopupMenuItem(
                          child: Text("Edit"),
                          value: "edit",
                        ),
                      ];
                    },
                  ),
                );
              },
            ),
          ),
        ));
  }
// fetch data function
  Future<void> fetch() async {
    setState(() {
      isloading = true;
    });
    final url = "http://api.nstack.in/v1/todos?page=1&limit=10";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      setState(() {
        items = result;
      });
    } else {
      print("error");
    }
    setState(() {
      isloading = false;
    });
  }
  // delete data
  Future deleteItem(String id) async {
    //delete
    final url = "http://api.nstack.in/v1/todos/$id";
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      //item removed
      final filtered = items.where((element) => element["_id"] != id).toList();
      setState(() {
        items = filtered;
      });
      showSucess(context, "Item Deleted", Colors.red);
    } else {
      //item not removed succesfully
      showSucess(context, "Deletion failed", Colors.black);
    }
  }
  NavigateAdd() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScreenAdd(),
        ));
  }
  NavigateEdit(Map item) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScreenAdd(todo: item),
        ));
  }

  void showSucess(context, String text, Color col) {
    final snackbar = SnackBar(
        backgroundColor: col,
        content: Text(
          text,
          style: TextStyle(color: Colors.white),
        ));
  }
}