import 'package:f_authentication_template/domain/controllers/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _signUpPageState createState() => _signUpPageState();
}

class _signUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  AuthenticationController controller = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('signupScaffold'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      "Signup with email",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      key: Key('signupEmail'),
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter email";
                        } else if (!value.contains('@')) {
                          return "Enter valid email address";
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      key: Key('signupPassword'),
                      controller: this._passwordController,
                      decoration: InputDecoration(labelText: "Password"),
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter password";
                        } else if (value.length < 6) {
                          return "Password should have at least 6 characters";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      key: Key("signupSubmit"),
                      onPressed: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        final form = _formKey.currentState;
                        form!.save();
                        if (form.validate()) {
                          var value = await controller.signup(
                              _emailController.text, _passwordController.text);
                          if (value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('User ok')));
                            Get.back();
                          }
                        } else {
                          final snackBar = SnackBar(
                            content: Text('Validation nok'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: Text("Submit"),
                    )
                  ],
                ),
              ),
            ),
            TextButton(
                key: Key('signupBackToLogin'),
                onPressed: () {
                  Get.back();
                },
                child: Text("Login")),
          ],
        ),
      ),
    );
  }
}
