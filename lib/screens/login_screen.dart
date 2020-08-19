import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/signup_screen.dart';
import 'package:loja_virtual/widgets/loading_animation.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailcontroller = TextEditingController();

  final _passcontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  final _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    void _onSuccess() {
      Navigator.of(context).pop();
    }

    void _onFail() {
      _scaffoldkey.currentState.showSnackBar(SnackBar(
        content: Text(
          "Erro ao fazer Login",
        ),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 3),
      ));
    }

    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return SignUpScreen();
                }));
              },
              child: Text(
                "Criar Conta".toUpperCase(),
                style: TextStyle(fontSize: 15, color: Colors.white),
              ))
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading) {
            return Center(
              child: CustomLoadingWidget(),
            );
          }
          return Form(
              key: _formkey,
              child: ListView(
                padding: EdgeInsets.all(16),
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(hintText: "E-mail"),
                    controller: _emailcontroller,
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text.isEmpty || !text.contains("@"))
                        return "Email invalido";
                      else
                        return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Senha"),
                    controller: _passcontroller,
                    obscureText: true,
                    validator: (text) {
                      if (text.isEmpty || text.length < 6)
                        return "Senha Inválida";
                      else
                        return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          if (_emailcontroller.text.isEmpty) {
                            _scaffoldkey.currentState.showSnackBar(SnackBar(
                              content: Text(
                                "Insira seu e-mail para recuperar a senha",
                              ),
                              backgroundColor: Colors.redAccent,
                              duration: Duration(seconds: 3),
                            ));
                          } else {
                            model.recoverPass(_emailcontroller.text);
                            _scaffoldkey.currentState.showSnackBar(SnackBar(
                              content: Text(
                                "Confira seu E-mail",
                              ),
                              backgroundColor: Theme.of(context).primaryColor,
                              duration: Duration(seconds: 3),
                            ));
                          }
                        },
                        child: Text(
                          "Esqueci minha senha",
                          textAlign: TextAlign.right,
                        )),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 44,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        if (_formkey.currentState.validate()) {}
                        model.signIn(
                            email: _emailcontroller.text,
                            onFail: _onFail,
                            onSuccess: _onSuccess,
                            pass: _passcontroller.text);
                      },
                      child: Text(
                        "Entrar",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ));
        },
      ),
    );
  }
}
