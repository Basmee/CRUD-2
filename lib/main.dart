import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';
import 'package:flutter_application_19/screen/read.dart';
import 'package:flutter_application_19/screen/config.dart';
import 'package:flutter_application_19/screen/users.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Patient Records App',
      theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 3, 116, 157)),
          useMaterial3: true),
      initialRoute: '/',
      routes: {
        '/login': (context) => const HomePage(),
      },
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  static const routeName = "/login";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  Users user = Users();

  Future<void> login(Users users) async {
    var params = {"email": user.email, "password": user.password};

    var url = Uri.http(Configure.server, "Users", params);
    var resp = await http.get(url);
    print(resp.body);
    List<Users> loginResult = usersFromJson(resp.body);
    print(loginResult.length);

    if (loginResult.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Username or password invalid"),
        ),
      );
    } else {
      Configure.login = loginResult[0];
      Navigator.pushNamed(context, ReadPatientPage.routeName);
    }
    return;
  }

  Future<bool> checkCredentials(Users user) async {
    var params = {"email": user.email, "password": user.password};

    var url = Uri.http(Configure.server, "Users", params);
    var resp = await http.get(url);
    print(resp.body);
    List<Users> loginResult = usersFromJson(resp.body);
    print(loginResult.length);

    return loginResult.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 164, 189),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            child: Center(
              child: Text(
                'RespiCare',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    'https://cdn-icons-png.flaticon.com/256/9821/9821795.png',
                    width: 200.0,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "Welcome",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  emailInputField(),
                  SizedBox(height: 15.0),
                  passwordInputField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      submitButton(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget emailInputField() {
    return TextFormField(
      initialValue: "Basmee.k@doc.com",
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: "  Username",
        labelStyle: TextStyle(color: Colors.white),
        hintText: "Input your email",
        icon: Icon(
          Icons.email,
          color: Colors.white,
        ),
        filled: true,
        fillColor: Colors.transparent,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(100.0),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required!";
        }

        if (!EmailValidator.validate(value)) {
          return "Invalid email format";
        }
        return null;
      },
      onSaved: (newValue) => user.email = newValue!,
    );
  }

  Widget passwordInputField() {
    return TextFormField(
      initialValue: "B123",
      style: TextStyle(color: Colors.white),
      obscureText: true,
      decoration: InputDecoration(
        labelText: "  Password:",
        labelStyle: TextStyle(color: Colors.white),
        hintText: "Input your password",
        icon: Icon(
          Icons.lock,
          color: Colors.white,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white), // สีขอบของกล่อง input
          borderRadius:
              BorderRadius.circular(100.0), // ลักษณะขอบมนของกล่อง input
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required!";
        }
        return null;
      },
      onSaved: (newValue) => user.password = newValue!,
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          print(user.toJson().toString());

          if (await checkCredentials(user)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Connecting to server")),
            );

            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ReadPatientPage(),
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Invalid email or password"),
              ),
            );
          }
        }
      },
      child: Text("Login"),
    );
  }
}
