// Flutter imports:
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:ifsp_aluno/components/ifsp_login_button.dart';
import 'package:ifsp_aluno/components/ifsp_modal.dart';
import 'package:ifsp_aluno/model/campus.dart';
import 'package:ifsp_aluno/repositories/general_repo.dart';
import 'package:ifsp_aluno/utils/auth_dialogs.dart';

class LoginPage extends StatefulWidget {
  final String? title;

  const LoginPage({this.title, super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _loginController;
  late final TextEditingController _passwordController;
  late final List<TextEditingController> _listControllers;
  bool _isLoading = false;

  @override
  void initState() {
    _listControllers = [];
    _listControllers.add(_loginController = TextEditingController());
    _listControllers.add(_passwordController = TextEditingController());
    super.initState();
  }

  @override
  void dispose() {
    _listControllers.clear();
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<bool> _login(BuildContext context) async {
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

    setState(() {
      _isLoading = true;
    });

    try {
      final dio = Dio();
      final response = await dio.get('https://fake-ifspaluno.cyclic.app/auth/${_loginController.text}',
          data: json.encode({"password": _passwordController.text}));

      log(response.data.toString());

      setState(() {
        _isLoading = false;
      });

      if (!response.data['authenticated']) {
        AuthDialogs.fieldErrorDialog(context);
      }

      return response.data['authenticated'];
    } on Exception catch (e) {
      log(e.toString());
      if (e.toString().contains('500')) {
        AuthDialogs.fieldErrorDialog(context);
        setState(() {
          _isLoading = false;
        });
        return false;
      } else {
        AuthDialogs.fieldErrorDialog(context);
        setState(() {
          _isLoading = false;
        });
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Campus> testList = [];
    testList.add(Campus(
      sigla: "BTV",
      nome: "Boituva",
      avaUrl: "https://sistemas.btv.ifsp.edu.br/moodle/login/index.php",
      siteUrl: "",
    ));
    testList.add(Campus(
      sigla: "SLT",
      nome: "Salto",
      avaUrl: "https://moodle.slt.ifsp.edu.br/",
      siteUrl: "",
    ));
    testList.add(Campus(
      sigla: "SOR",
      nome: "Sorocaba",
      avaUrl: "https://moodle.sor.ifsp.edu.br/login/index.php",
      siteUrl: "",
    ));
    //Teste do modal

    String ifspLogo = Theme.of(context).colorScheme.brightness == Brightness.light
        ? 'assets/img/logo_ifsp_vertical_nobg.png'
        : 'assets/img/logo_ifsp_vertical_nobg_dark.png';

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // const Spacer(),
                          const SizedBox(
                            height: 60,
                          ),
                          Image.asset(
                            ifspLogo,
                            scale: 5,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          TextField(
                            controller: _loginController,
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
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Senha',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Ainda não tem conta? ',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context, rootNavigator: true).pushNamed('/register');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'Registrar.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              bool auth = await _login(context);
                              if (auth) {
                                GeneralRepo.matricula = _loginController.text;
                                Navigator.of(context).pushReplacementNamed('/home');
                              }
                            },
                            style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(Size(
                                  MediaQuery.of(context).size.width * 0.8,
                                  MediaQuery.of(context).size.height * 0.1,
                                )),
                                backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary)),
                            child: const Text(
                              'Login',
                              style: TextStyle(fontSize: 32, color: Colors.white),
                            ),
                          ),
                          // const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LoginBaseButton(
                        title: "IFSP",
                        func: () => {},
                        width: 0.3,
                        height: 0.06,
                        lightIcon: Image.asset("assets/img/if_min_logo.png"),
                        darkIcon: Image.asset("assets/img/if_min_logo_dark.png"),
                        transparency: true,
                        elevation: true,
                      ),
                      LoginBaseButton(
                        title: "Moodle",
                        func: (() {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => IFSPModal(
                              title: 'Selecione o campus',
                              campusList: testList,
                              funcOK: () => Navigator.pop(context, 'OK'),
                              //funcCancel: () {  },
                            ),
                          );
                        }),
                        width: 0.3,
                        height: 0.06,
                        lightIcon: Image.asset("assets/img/moodle_min_logo.png"),
                        darkIcon: Image.asset("assets/img/moodle_min_logo_dark.png"),
                        transparency: true,
                        elevation: true,
                      )
                    ],
                  ),
                )
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
