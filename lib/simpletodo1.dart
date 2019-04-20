import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Futter App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Todos(),
    );
  }
}

class Todos extends StatefulWidget {
  @override
  createState() => new TodosState();
}

class TodosState extends State<Todos> {
  List<String> _todoItems = [];
  Set<String> _todoDone = Set<String>();

  void _addTodoItem(String task) {
    if (task.length > 0) {
      setState(() => _todoItems.add(task));
    }
  }

  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if (index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index]);
        }
      },
    );
  }

  Widget _buildTodoItem(String todoText) {
    final _alreadDone = _todoDone.contains(todoText);
    return new Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Row(
        children: [
          IconButton(
              icon: Icon(_alreadDone
                  ? Icons.check_box
                  : Icons.check_box_outline_blank),
              color: Colors.black,
              onPressed: () {
                setState(() {
                  _alreadDone
                      ? _todoDone.remove(todoText)
                      : _todoDone.add(todoText);
                });
              }),
          Expanded(
            child: Text(todoText),
          ),
          IconButton(
              icon: Icon(Icons.delete),
              color: Colors.grey,
              onPressed: () {
                _deleteTodo(todoText);
              }),
        ],
      ),
    );
  }

  void _deleteTodo(String todo) {
    if (todo.length > 0) {
      setState(() => _todoItems.remove(todo));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Todo List'),
      ),
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
          onPressed: _pushAddTodoScreen,
          tooltip: 'Add task',
          child: new Icon(Icons.add)),
    );
  }

  void _pushAddTodoScreen() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Scaffold(
          appBar: new AppBar(title: new Text('Add a new task')),
          body: new TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addTodoItem(val);
              Navigator.pop(context); // Close the add todo screen
            },
            decoration: new InputDecoration(
                hintText: 'Enter something to do...',
                contentPadding: const EdgeInsets.all(16.0)),
          ));
    }));
  }
}
