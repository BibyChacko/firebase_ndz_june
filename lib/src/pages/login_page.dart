import 'package:flutter/material.dart';
import 'package:task_fb_june_ndz/src/cubit/authentication/authentication_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_fb_june_ndz/src/models/user_model.dart';
import 'package:task_fb_june_ndz/src/pages/signup_page.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailCOntroller = TextEditingController();
  TextEditingController _passwordCOntroller = TextEditingController();
  TextEditingController _addressCOntroller = TextEditingController();
  TextEditingController _nameCOntroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _emailCOntroller,
                decoration: InputDecoration(hintText: "Email"),
              ),
              TextFormField(
                controller: _passwordCOntroller,
                decoration: InputDecoration(hintText: "Password"),
              ),
              SizedBox(
                height: 24,
              ),
              BlocConsumer<AuthenticationCubit, AuthenticationState>(
                listener: (context, state) {
                  if (state is AuthenticationSuccess) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => HomePage()));
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                      onPressed: () {
                        context.read<AuthenticationCubit>().loginUser(
                            _emailCOntroller.text, _passwordCOntroller.text);
                      },
                      child: Text("Login"));
                },
              ),
              SizedBox(height: 24),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => SignUpPage()));
                  },
                  child: Text("Sign up"))
            ],
          ),
        ),
      ),
    );
  }
}
