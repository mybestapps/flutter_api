import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ViewApi.dart';
class ScreenAdd extends StatefulWidget {
  ScreenAdd({Key? key, this.todo}) : super(key: key);
  final todo;
  @override
  State<ScreenAdd> createState() => _ScreenAddState();
}
class _ScreenAddState extends State<ScreenAdd> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final title = todo["title"];
      final descrip = todo["description"];
      titlecontroller.text = title;
      descriptioncontroller.text = descrip;
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Edit Data" : "Add Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: titlecontroller,
              decoration: InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    width: 3,
                  ),

                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: descriptioncontroller,
              maxLines: 8,
              minLines: 5,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                isEdit ? update() : SubmitData();
              },
              child: Text(isEdit ? "Update" : "Submit"),
            )
          ],
        ),
      ),
    );
  }

  update() async {
    final todo = widget.todo;
    final id = todo["_id"];
    final title = titlecontroller.text;
    final description = descriptioncontroller.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false
    };
    final url = "http://api.nstack.in/v1/todos/$id";
    final uri = Uri.parse(url);
    try {
      final response = await http.put(
        uri,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewApi(),
            ));
        showSucess(context, "Sucessfully Updated", Colors.green);
      } else {
        showSucess(context, "Updation Failed", Color.fromARGB(255, 154, 0, 0));
      }
    } catch (e) {
      showSucess(context, "Updation Failed $e", Color.fromARGB(255, 123, 2, 2));
    }
  }

  void SubmitData() async {
    // taking text from textfiled
    final title = titlecontroller.text;
    final description = descriptioncontroller.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false
    };
    //submit data
    final url = "http://api.nstack.in/v1/todos";
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 201) {
      titlecontroller.text = "";
      descriptioncontroller.text = "";
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewApi(),
          ));
      showSucess(
          context, "Sucessfully Created", Color.fromARGB(255, 3, 159, 83));
    } else {
      showSucess(context, "Creation Failed", Colors.red);
    }
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