import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',
      theme: ThemeData(
        primaryColor: Colors.deepOrangeAccent,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class GlobalState {

  late List<String> notes = ["новый год"];
  late List<String> notesData = ["нахрюкаться в щщи"];
  late List<String> notesDay = ['31.12.2023'];


}

class MyHomePage extends StatefulWidget{
  const MyHomePage({Key? key}) : super(key: key);


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  GlobalState globalState = GlobalState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Заметки'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: ListView.builder(
        itemCount: globalState.notes.length,
        padding: EdgeInsets.all(3),
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ListTile(
                title: Text(globalState.notes[index]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => notesDetailsScreen(notesPage: globalState.notes[index], notesInfo: globalState.notesData[index], notesDate: globalState.notesDay[index]),
                    ),
                  );
                },
              ),
              FloatingActionButton(
                  backgroundColor: Colors.deepOrange,
                  autofocus: true,
                  child: Icon(Icons.remove),
                  onPressed: () {
                setState(() {
                  globalState.notes.removeAt(index);
                  globalState.notesData.removeAt(index);
                  globalState.notesDay.removeAt(index);
                });
              }),
              Divider(color: Colors.black),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepOrangeAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Addnotescreen(),
            ),
          ).then((newContact) {
            setState(() {
              globalState.notes.add(newContact[0]);
              globalState.notesData.add(newContact[1]);
              globalState.notesDay.add(newContact[2]);
            });
          });
        },
      ),
    );
  }
}

class notesDetailsScreen extends StatelessWidget {
  final String notesPage;
  final String notesInfo;
  final String notesDate;

  notesDetailsScreen({required this.notesPage, required this.notesInfo, required this.notesDate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(notesPage),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Center(
        child: Container(
          child: Row(
            children: [
              Column(
                children: [
                  Text('$notesInfo', textScaleFactor: 2,),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
              Padding(padding: EdgeInsets.all(25)),
              Column(
                children: [
                  Text('$notesDate', textScaleFactor: 2,)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Addnotescreen extends StatefulWidget {
  @override
  _AddnotescreenState createState() => _AddnotescreenState();
}

class _AddnotescreenState extends State<Addnotescreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _nameController2 = TextEditingController();
  TextEditingController _nameController3 = TextEditingController();
  GlobalState globalState = GlobalState();
  late List<String> notesList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить заметку'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Название'),
            ),
            TextField(
              controller: _nameController2,
              decoration: InputDecoration(labelText: 'Описание'),
            ),
            TextField(
              controller: _nameController3,
              decoration: InputDecoration(labelText: 'Дата'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Добавить'),
              onPressed: () {
                notesList.add(_nameController.text);
                notesList.add(_nameController2.text);
                notesList.add(_nameController3.text);
                Navigator.pop(context, notesList);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrangeAccent),
            ),
          ],
        ),
      ),
    );
  }
}