// Flutter imports:
import 'dart:convert';
import 'dart:developer';

// Project imports:
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ifsp_aluno/utils/auth_dialogs.dart';

class RegisterPage extends StatefulWidget {
  final String? title;

  const RegisterPage({this.title, super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _mailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _registerController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final List<TextEditingController> _listControllers;
  bool _isLoading = false;

  @override
  void initState() {
    _listControllers = [];
    _listControllers.add(_nameController = TextEditingController());
    _listControllers.add(_mailController = TextEditingController());
    _listControllers.add(_phoneController = TextEditingController());
    _listControllers.add(_registerController = TextEditingController());
    _listControllers.add(_passwordController = TextEditingController());
    _listControllers.add(_confirmPasswordController = TextEditingController());
    super.initState();
  }

  @override
  void dispose() {
    _listControllers.clear();
    _nameController.dispose();
    _mailController.dispose();
    _phoneController.dispose();
    _registerController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _validatePassword() {
    if (_passwordController.text.length < 8) {
      return false;
    }

    if (!_passwordController.text.contains(RegExp(r'[A-Z]'))) {
      return false;
    }

    if (!_passwordController.text.contains(RegExp(r'[a-z]'))) {
      return false;
    }

    if (!_passwordController.text.contains(RegExp(r'[0-9]'))) {
      return false;
    }

    if (!_passwordController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return false;
    }

    return true;
  }

  bool _confirmPassword() {
    return _passwordController.text == _confirmPasswordController.text;
  }

  bool _validateFields() {
    RegExp regex = RegExp(r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$');
    if (!regex.hasMatch(_mailController.text)) {
      AuthDialogs.fieldValidateDialog(context, "Email");
      return false;
    }

    if (!(_phoneController.text.replaceAll(RegExp(r'\D'), '').length == 11)) {
      AuthDialogs.fieldValidateDialog(context, "Telefone");
      return false;
    }

    if (!_validatePassword()) {
      AuthDialogs.fieldValidateDialog(context, "Senha");
      return false;
    }

    return true;
  }

  Future<bool> _register(BuildContext context) async {
    if (_listControllers.any((element) => element.text == "")) {
      int fields = 0;
      for (var e in _listControllers) {
        if (e.text == "") {
          fields++;
        }
      }

      AuthDialogs.emptyFieldDialog(context, fields);
      return false;
    }

    if (!_confirmPassword()) {
      AuthDialogs.comparePasswordDialog(context);
      return false;
    }

    if (!_validateFields()) {
      return false;
    }

    try {
      final dio = Dio();
      final response = await dio.post('https://fake-ifspaluno.cyclic.app/users/${_registerController.text}',
          data: json.encode({
            "email": _mailController.text,
            "registration": _registerController.text,
            "name": _nameController.text,
            "phone": _phoneController.text,
          }));

      if (response.data.toString() == "Usuário já cadastrado!") {
        AuthDialogs.existingUserDialog(context);
        setState(() {
          _isLoading = false;
        });
        return false;
      }

      if (response.data.toString() == "ok") {
        final authResponse = await dio.post('https://fake-ifspaluno.cyclic.app/auth/${_registerController.text}',
            data: json.encode({"password": _passwordController.text}));

        if (authResponse.data.toString() == "ok") {
          setState(() {
            _isLoading = false;
          });
          return true;
        }
      }

      return false;
    } on Exception catch (e) {
      AuthDialogs.fieldErrorDialog(context);
      log(e.toString());
      setState(() {
        _isLoading = false;
      });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(
                './assets/img/marca_ifsp.png',
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText: 'Nome',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: _mailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: _phoneController,
                            decoration: const InputDecoration(
                              labelText: 'Telefone',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: _registerController,
                            decoration: const InputDecoration(
                              labelText: 'Matricula',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              labelText: 'Senha',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: _confirmPasswordController,
                            decoration: const InputDecoration(
                              labelText: 'Confirmar Senha',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              bool register = await _register(context);
                              if (register) {
                                Navigator.of(context).pushReplacementNamed('/login');
                              }
                            },
                            // onPressed: () => _register(context),
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         const IFSPScaffold(selectedKey: 0),
                            //   ),
                            // ),
                            style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(Size(
                                  MediaQuery.of(context).size.width * 0.8,
                                  MediaQuery.of(context).size.height * 0.1,
                                )),
                                backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary)),
                            child: const Text(
                              'Cadastrar',
                              style: TextStyle(fontSize: 32, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: _isLoading,
              child: Positioned(
                child: Stack(children: [
                  Container(
                    color: Colors.black.withAlpha(140),
                  ),
                  const Center(child: CircularProgressIndicator())
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
