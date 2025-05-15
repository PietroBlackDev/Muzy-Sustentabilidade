import 'package:flutter/material.dart';

class CredenciaisModel extends ChangeNotifier {
  String? usuario;
  String? senha;

  CredenciaisModel({this.usuario = '', this.senha = ''});

  void setUsuario(String usuario) {
    this.usuario = usuario;
    notifyListeners();
  }

  void setSenha(String senha) {
    this.senha = senha;
    notifyListeners();
  }

  @override
  String toString() {
    return 'CredenciaisModel{usuario: $usuario, senha: $senha}';
  }
}
