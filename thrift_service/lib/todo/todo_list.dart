import 'package:flutter/material.dart';

import 'todo.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;

  const TodoList(this.todos);

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return Center(
        child: Text('Noting to do... Great!'),
      );
    } else {
      return ListView.builder(
        itemCount: todos.length,
        itemBuilder: (BuildContext context, int index) {
          var todo = todos[index];
          return _buildTodo(todo);
        },
      );
    }
  }

  Widget _buildTodo(Todo todo) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      //shadowColor: Colors.blueGrey,
      //elevation: 15.0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  todo.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: todo.done ? TextDecoration.lineThrough : null,
                  ),
                ),
                Text(
                  '${todo.created.day}/${todo.created.month} ['
                  '${todo.created.hour}:${todo.created.minute}:'
                  '${todo.created.second}]',
                  style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                ),
              ],
            ),
            Spacer(),
            IconButton(
              iconSize: 30,
              icon: Icon(todo.done ? Icons.clear : Icons.check),
              onPressed: () {
                todo.done = !todo.done;
                todo.save();
              },
            ),
            IconButton(
              iconSize: 30,
              icon: Icon(
                Icons.delete,
                color: Colors.red[400],
              ),
              onPressed: () {
                todo.delete();
              },
            ),
          ],
        ),
      ),
    );
  }
}
