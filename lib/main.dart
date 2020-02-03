import 'package:flutter/material.dart';
import 'package:flutter_app1111/views/checkbox_group.dart';
import 'package:flutter_app1111/views/dynamic_widget.dart';

void main() => runApp(
  MaterialApp(
    home: CheckboxGroup(),
  ),
);

class TimeTrackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Time Tracker',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new TimeTrackHome(title: 'Task List'),
    );
  }
}

class TimeTrackHome extends StatefulWidget {
  TimeTrackHome({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TimeTrackHomeState createState() => new _TimeTrackHomeState();
}

class _TimeTrackHomeState extends State<TimeTrackHome> {
  TextEditingController _textController;
  List<TaskItem> _taskList = new List<TaskItem>();

  void _addTaskDialog() async {
    _textController = TextEditingController();

    await showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text("Add A New Task"),
          content: new TextField(
            controller: _textController,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Enter the task name'),
          ),
          actions: <Widget>[
            new FlatButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("CANCEL")),
            new FlatButton(
                onPressed: (() {
                  Navigator.pop(context);
                  _addTask(_textController.text);
                }),
                child: const Text("ADD"))
          ],
        ));
  }

  void _addTask(String title) {
    setState(() {
      // add the new task
      _taskList.add(TaskItem(
        name: title,
      ));
    });
  }

  @override
  void initState() {
    _taskList = List<TaskItem>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Align(
        alignment: Alignment.topCenter,
        child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20),
            itemExtent: 60.0,
            itemCount: _taskList.length,
            itemBuilder: (BuildContext context, int index) {
              if (index < _taskList.length) {
                return Dismissible(
                  key: ObjectKey(_taskList[index]),
                  onDismissed: (direction) {
                    if(this.mounted) {
                      setState(() {
                        _taskList.removeAt(index);
                      });
                    }
                  },
                  child: _taskList[index],
                );
              }else{
                return null;
              }
            }),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _addTaskDialog,
        tooltip: 'Click to add a new task',
        child: new Icon(Icons.add),
      ),
    );
  }
}

class TaskItem extends StatefulWidget {
  final String name;

  TaskItem({Key key, this.name}) : super(key: key);
  TaskItem.from(TaskItem other) : name = other.name;

  @override
  State<StatefulWidget> createState() => new _TaskState();
}

class _TaskState extends State<TaskItem> {
  static final _taskFont =
  const TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold);
  Color _color = Colors.transparent;

  void _highlightTask() {
    setState(() {
      if(_color == Colors.transparent) {
        _color = Colors.greenAccent;
      }
      else {
        _color = Colors.transparent;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Material(
        color: _color,
        child: ListTile(
          title: Text(
            widget.name,
            style: _taskFont,
            textAlign: TextAlign.center,
          ),
          onTap: () {
            _highlightTask();
          },
        ),
      ),
      Divider(
        height: 0.0,
        color: Colors.red,
      ),
    ]);
  }
}