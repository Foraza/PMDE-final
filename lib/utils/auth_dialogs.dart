import 'package:flutter/material.dart';

class AuthDialogs {
  static Future<void> emptyFieldDialog(BuildContext context, int fields) async {
    return showDialog<void>(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Há campos vazios!',
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            height: 50,
            child: Column(
              children: [
                Text(
                  'Há $fields campos vazios!',
                  textAlign: TextAlign.left,
                ),
                const Text(
                  'Preencha-os e tente novamente.',
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> fieldErrorDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Credenciais Invalidas',
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            height: 50,
            child: Column(
              children: const [
                Text(
                  'Confira seu e-mail e senha, depois tente novamente.',
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> fieldValidateDialog(BuildContext context, String field) async {
    return showDialog<void>(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Campo Invalido',
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            height: 50,
            child: Column(
              children: [
                Text(
                  'Confira o campo de $field, depois tente novamente.',
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> connectionErrorDialog(BuildContext context, String error) async {
    return showDialog<void>(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Problemas com Login',
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            height: 140,
            child: Column(
              children: [
                const Text(
                  'Ocorreu algum erro, aguarde um pouco e depois tente novamente.',
                  textAlign: TextAlign.left,
                ),
                Text(
                  '\nErro - $error',
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> comparePasswordDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Senha Diferentes!',
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            height: 50,
            child: Column(
              children: const [
                Text(
                  'Preencha novamente os campos de senha e tente novamente.',
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> existingUserDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Usuario da Existe!',
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            height: 50,
            child: Column(
              children: const [
                Text(
                  'Confira seus dados, o usuario informado já está cadastrado.',
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
