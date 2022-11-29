import 'package:flutter/material.dart';
import 'package:task_fb_june_ndz/src/cubit/authentication/authentication_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_fb_june_ndz/src/models/user_model.dart';
import 'package:task_fb_june_ndz/src/pages/login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
          title: Text("Sign Up"),
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
              TextFormField(
                controller: _nameCOntroller,
                decoration: InputDecoration(hintText: "Name"),
              ),
              TextFormField(
                controller: _addressCOntroller,
                decoration: InputDecoration(hintText: "Address"),
              ),
              SizedBox(
                height: 24,
              ),
              BlocConsumer<AuthenticationCubit, AuthenticationState>(
                listener: (context, state) {
                 if(state is AuthenticationSuccess){
                   Navigator.of(context).push(MaterialPageRoute(builder: (_)=>LoginPage()));
                 }else if(state is AuthenticationFailure){
                   // Show the dialog
                 }
                },
                builder: (context, state) {
                  if(state is AuthenticationLoading){
                    return CircularProgressIndicator();
                  }
                  return ElevatedButton(
                      onPressed: () {
                        UserModel userModel = UserModel(
                            email: _emailCOntroller.text,
                            address: _addressCOntroller.text,
                            password: _passwordCOntroller.text,
                            mobileNo: "908797898");
                        context.read<AuthenticationCubit>().createUser(
                            userModel);
                      },
                      child: Text("SignUp"));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
