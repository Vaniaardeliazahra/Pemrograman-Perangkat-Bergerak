import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

List<Map<String, dynamic>> todos = [];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "To-Do App",
      theme: ThemeData(primarySwatch: Colors.teal),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [TodoListPage(), AddTodoPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  BottomNavigationBar buildNavBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Tasks'),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Task'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: buildNavBar(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  void _toggleStatus(int index) {
    setState(() {
      todos[index]['done'] = !todos[index]['done'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To-Do List"), centerTitle: true),
      body: todos.isEmpty
          ? Center(child: Text("No tasks yet. Add one from 'Add Task'."))
          : ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];

                String warningText = "";
                Color warningColor = Colors.transparent;

                try {
                  DateTime today = DateTime.now();
                  DateTime now = DateTime(today.year, today.month, today.day);
                  DateTime deadlineDate = DateFormat(
                    "yyyy-MM-dd",
                  ).parse(todo['deadline']);
                  int diff = deadlineDate.difference(now).inDays;

                  if (diff == 1) {
                    warningText = "⚠ Deadline besok!";
                    warningColor = Colors.orange;
                  } else if (diff == 0) {
                    warningText = "⚠ Deadline hari ini!";
                    warningColor = Colors.red;
                  } else if (diff < 0) {
                    warningText = "❌ Deadline lewat!";
                    warningColor = Colors.red;
                  }
                } catch (e) {
                  warningText = "";
                }

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                  elevation: 2,
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    leading: Icon(
                      todo['done']
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: todo['done'] ? Colors.green : Colors.grey,
                      size: 32,
                    ),
                    title: Text(
                      todo['task'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: todo['done']
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(todo['desc'], style: TextStyle(fontSize: 14)),
                        SizedBox(height: 4),
                        Text(
                          "Deadline: ${todo['deadline']}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        if (warningText.isNotEmpty)
                          Text(
                            warningText,
                            style: TextStyle(
                              fontSize: 12,
                              color: warningColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.check, color: Colors.teal),
                      onPressed: () => _toggleStatus(index),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class AddTodoPage extends StatefulWidget {
  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final _formKey = GlobalKey<FormState>();
  final _taskCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _deadlineCtrl = TextEditingController();

  void _saveTodo() {
    if (_formKey.currentState!.validate()) {
      String deadlineText = _deadlineCtrl.text.isEmpty
          ? _getDefaultDeadline()
          : _deadlineCtrl.text;

      setState(() {
        todos.add({
          "task": _taskCtrl.text,
          "desc": _descCtrl.text,
          "deadline": deadlineText,
          "done": false,
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Task added!"), backgroundColor: Colors.teal),
      );

      _taskCtrl.clear();
      _descCtrl.clear();
      _deadlineCtrl.clear();
    }
  }

  String _getDefaultDeadline() {
    DateTime tomorrow = DateTime.now().add(Duration(days: 1));
    return DateFormat("yyyy-MM-dd").format(tomorrow);
  }

  Future<void> _pickDate() async {
    DateTime today = DateTime.now();
    DateTime initial = DateTime(today.year, today.month, today.day);

    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: initial,
      lastDate: DateTime(2100),
      initialDate: initial,
    );

    if (picked != null) {
      _deadlineCtrl.text = DateFormat("yyyy-MM-dd").format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Task"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _taskCtrl,
                decoration: InputDecoration(
                  labelText: "Task Title",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Title cannot be empty";
                  } else if (value.length < 3) {
                    return "Title must be at least 3 characters";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descCtrl,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Description cannot be empty";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _deadlineCtrl,
                readOnly: true,
                onTap: _pickDate,
                decoration: InputDecoration(
                  labelText: "Deadline",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.date_range),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _saveTodo,
                icon: Icon(Icons.save),
                label: Text("Save Task"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
