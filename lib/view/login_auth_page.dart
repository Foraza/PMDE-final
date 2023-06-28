// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ifsp_aluno/components/ifsp_login_button.dart';
import 'package:ifsp_aluno/components/ifsp_modal.dart';
import 'package:ifsp_aluno/components/ifsp_scaffold.dart';
import 'package:ifsp_aluno/model/campus.dart';

class LoginAuthPage extends StatelessWidget {
  final String? title;

  const LoginAuthPage({this.title, super.key});

  @override
  Widget build(BuildContext context) {
    List<Campus> testList = [];
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

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    ifspLogo,
                    scale: 4,
                  ),
                  const Text(
                    'Aluno',
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 40, letterSpacing: 3),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const IFSPScaffold(selectedKey: 0),
                      ),
                    ),
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(
                          MediaQuery.of(context).size.width * 0.8,
                          MediaQuery.of(context).size.height * 0.1,
                        )),
                        backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary)),
                    child: const Text(
                      'Entrar',
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                  ),
                ],
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
    );
  }
}
