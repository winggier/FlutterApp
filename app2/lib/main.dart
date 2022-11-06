import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:email_validator/email_validator.dart';

// object that store user info
class Customer {
  String name;
  String id;
  String pass;
  String email;
  Customer(this.name, this.id, this.pass, this.email);
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Form1',
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<FirstScreen> {
  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();
  TextEditingController c3 = TextEditingController();
  TextEditingController c4 = TextEditingController();
  var newc = Customer("", "", "", "");
  bool _isValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: c1,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User Name',
              ),
              onChanged: (text) {
                newc.name = text;
                // ignore: avoid_print
                print('1st text field: $text');
              },
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: c2,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User ID',
              ),
              onChanged: (text) {
                newc.id = text;
              },
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: c4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              onChanged: (text) {
                newc.pass = text;
              },
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: c3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User email',
              ),
              onChanged: (text) {
                newc.email = text;
                setState(() {
                  _isValid = EmailValidator.validate(text);
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_isValid ? '' : 'Email is not valid.',
                  style: const TextStyle(
                    color: Colors.red,
                  )),
            ),
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
              onPressed: () {
                if (_isValid) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SecondScreen(
                        customer: newc,
                      ),
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        content: Text("Please input valid email"),
                      );
                    },
                  );
                }
              },
              child: const Text('Submit!'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  final Customer customer;

  const SecondScreen({
    super.key,
    required this.customer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Info'),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 30),
        children: [
          _tile('User Name', customer.name, Icons.person),
          _tile('User ID', customer.id, Icons.numbers),
          _tile('Password', customer.pass, Icons.password),
          _tile('Email', customer.email, Icons.email),
        ],
      ),
    );
  }
}

ListTile _tile(String title, String subtitle, IconData icon) {
  return ListTile(
    title: Text(title,
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 16,
        )),
    leading: Icon(
      icon,
      color: Colors.blue[500],
    ),
    subtitle: Text(subtitle,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 24,
        )),
  );
}
