import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tg/componentes/decoracao_campo_aut.dart';
import 'package:tg/model/credenciais_model.dart';
import 'package:tg/pages/my_screen_page.dart';
import 'package:tg/validations/credentials_validator.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final validacao = CredenciaisModel();
  final validacaoForm = CredentialsValidator();
  final formKey = GlobalKey<FormState>();
  String user = '';

  bool isValid() {
    final result = validacaoForm.validate(validacao);

    return result.isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.106,
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset('assets/images/logosemfundo.png'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Center(child: Text('Insira a URL do servidor')),
                      content: TextField(
                        decoration: getAuthenticationInputDecoration(
                          'http://127.0.0.1',
                        ),
                      ),
                      actions: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "OK",
                              style: TextStyle(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(
                Icons.settings,
                size: 35,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
        ],
        leadingWidth: 160,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.90,
          height: MediaQuery.of(context).size.height * 0.50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 45),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: validacao.setUsuario,
                    validator: validacaoForm.byField(validacao, 'usuario'),
                    decoration: getAuthenticationInputDecoration('Usuário'),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: validacao.setSenha,
                    validator: validacaoForm.byField(validacao, 'senha'),
                    decoration: getAuthenticationInputDecoration('Senha'),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: ListenableBuilder(
                      listenable: validacao,
                      builder: (context, child) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed:
                              isValid()
                                  ? () {
                                    if (validacao.senha == 'hvr2015' &&
                                            validacao.usuario == 'gestor' ||
                                        validacao.senha == '00000' &&
                                            validacao.usuario == 'painel' ||
                                        validacao.senha == 'rossa2025' &&
                                            validacao.usuario ==
                                                'nutricionista') {
                                      if (validacao.senha == 'rossa2025' &&
                                          validacao.usuario ==
                                              'nutricionista') {
                                        user = validacao.usuario!;
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => HomeScreen(
                                                  usuario: user,
                                                  indice: 1,
                                                ),
                                          ),
                                        );
                                      }
                                      user = validacao.usuario!;
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => HomeScreen(
                                                usuario: user,
                                                indice: 0,
                                              ),
                                        ),
                                      );
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Center(
                                              child: Lottie.asset(
                                                'assets/lotties/erro.json',
                                              ),
                                            ),
                                            content: Text(
                                              'Usuário ou senha inválidos',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: const Color.fromARGB(
                                                  255,
                                                  0,
                                                  0,
                                                  0,
                                                ),
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            actions: [
                                              Container(
                                                width:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.width *
                                                    0.9,
                                                height:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.height *
                                                    0.04,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(0),
                                                ),
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                          218,
                                                          235,
                                                          65,
                                                          65,
                                                        ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    "OK",
                                                    style: TextStyle(
                                                      color:
                                                          const Color.fromARGB(
                                                            255,
                                                            248,
                                                            250,
                                                            252,
                                                          ),
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  }
                                  : null,
                          child: Text(
                            "ENTRAR",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
