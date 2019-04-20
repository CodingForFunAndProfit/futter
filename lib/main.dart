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
        home: DefaultTabController(
          length: 2,
          child: TodoList(),
        ));
  }
}

class Todo {
  String task;
  bool bDone = false;
  Todo(this.task);
  void done() {
    this.bDone = true;
  }

  void undone() {
    this.bDone = false;
  }

  bool isDone() {
    return this.bDone;
  }
}

class TodoList extends StatefulWidget {
  @override
  createState() => new TodoListState();
}

class TodoListState extends State<TodoList> {
  //List<String> _todoItems = [];
  //List<String> _doneItems = [];
  List<Todo> _todos = [];
  //Set<String> _todoDone = Set<String>();

  void _addTodoItem(String task) {
    if (task.length > 0) {
      //setState(() => _todoItems.add(task));
      setState(() {
        _todos.add(new Todo(task));
      });
    }
  }

  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if (index < _todos.length) {
          if (!_todos[index].isDone()) return _buildTodoItem(_todos[index]);
        }
        /*
        if (index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index]);
        }
        */
      },
    );
  }

  Widget _buildTodoListDone() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if (index < _todos.length) {
          if (_todos[index].isDone()) return _buildTodoItem(_todos[index]);
        }
      },
    );
  }

  Widget _buildTodoItem(Todo todo) {
    return new Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Row(
        children: [
          IconButton(
              icon: Icon(todo.isDone()
                  ? Icons.check_box
                  : Icons.check_box_outline_blank),
              color: Colors.black,
              onPressed: () {
                setState(() {
                  if (todo.isDone()) {
                    todo.undone();
                  } else {
                    todo.done();
                  }
                });
              }),
          Expanded(
            child: Text(todo.task),
          ),
          IconButton(
              icon: Icon(Icons.delete),
              color: Colors.grey,
              onPressed: () {
                _deleteTodo(todo);
              }),
        ],
      ),
    );
  }

  void _deleteTodo(Todo todo) {
    if (todo != null) {
      setState(() => _todos.remove(todo));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        bottom: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.directions_car)),
            Tab(icon: Icon(Icons.directions_transit)),
          ],
        ),
        title: new Text('Todo List'),
      ),
      body: TabBarView(
        children: [
          _buildTodoList(),
          _buildTodoListDone(),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
          onPressed: _pushAddTodoScreen,
          tooltip: 'Add task',
          child: new Icon(Icons.add)),
      /*
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
          onPressed: _pushAddTodoScreen,
          tooltip: 'Add task',
          child: new Icon(Icons.add)),
          */
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
