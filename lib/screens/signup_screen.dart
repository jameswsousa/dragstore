import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatelessWidget {
  final _namecontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _passcontroller = TextEditingController();
  final _adrresscontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {


  void _onSuccess() {
    _scaffoldkey.currentState.showSnackBar(SnackBar(
      content: Text(
        "Usuário criado com sucesso",
      ),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 3),
    ));
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
     _scaffoldkey.currentState.showSnackBar(SnackBar(
      content: Text(
        "Erro ao criar usuário",
      ),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 3),
    ));
  }

    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        if (model.isLoading)
          return Center(
            child: CircularProgressIndicator(),
          );
        return Form(
            key: _formkey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(hintText: "Nome Completo"),
                  controller: _namecontroller,
                  validator: (text) {
                    if (text.isEmpty)
                      return "Nome invalido";
                    else
                      return null;
                  },
                ),
                SizedBox(height: 16),
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
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(hintText: "Endereço"),
                  controller: _adrresscontroller,
                  validator: (text) {
                    if (text.isEmpty)
                      return "Endereço Inválido";
                    else
                      return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (_formkey.currentState.validate()) {
                        Map<String, dynamic> userData = {
                          'name': _namecontroller.text,
                          'email': _emailcontroller.text,
                          'adress': _adrresscontroller.text,
                        };

                        model.signUp(
                            userData: userData,
                            pass: _passcontroller.text,
                            onSuccess: _onSuccess,
                            onFail: _onFail,);
                      }
                    },
                    child: Text(
                      "Criar Conta",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                )
              ],
            ));
      }),
    );


    
  }

}
