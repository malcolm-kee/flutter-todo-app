import 'package:flutter/material.dart';
import 'model/task.dart';
import 'task_form.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Malcolm Do',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      home: const TodoList());
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final _biggerFont = const TextStyle(fontSize: 18);
  final _doneFont =
      const TextStyle(fontSize: 18, decoration: TextDecoration.lineThrough);
  final _items = <Task>[
    const Task(title: 'Wake up'),
    const Task(title: 'Learn flutter'),
  ];

  void _pushNewTaskForm() {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Add Todo'),
        ),
        body: TaskForm((newTaskTitle) {
          setState(() {
            _items.add(Task(title: newTaskTitle));
          });
          Navigator.pop(context);
        }),
      );
    }));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Malcolm Do'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _pushNewTaskForm,
              tooltip: 'Add item',
            )
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: ListTile.divideTiles(
            context: context,
            tiles: _items
                .map((task) => ListTile(
                      title: Text(
                        task.title,
                        style: task.done ? _doneFont : _biggerFont,
                      ),
                      trailing: Icon(
                        task.done
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: task.done ? Colors.red : null,
                        semanticLabel:
                            task.done ? 'Mark as not done' : 'Mark as done',
                      ),
                      onTap: () {
                        setState(() {
                          _items[_items.indexOf(task)] =
                              task.copyWith(done: !task.done);
                        });
                      },
                    ))
                .toList(),
          ).toList(),
        ),
      );
}
