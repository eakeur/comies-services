import 'package:comies/components.dart';
import 'package:comies/controllers.dart';
import 'package:comies/core.dart';
import 'package:datacontext/datacontext.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  Authentication createState() => Authentication();
}

class Authentication extends State<AuthenticationScreen> {
  final nickname = TextEditingController();
  final password = TextEditingController();
  late AuthenticationController controller;
  final formKey = GlobalKey<FormState>();
  bool showPassword = false;
  bool keepConnected = true;

  @override
  void initState() {
    controller = AuthenticationController(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text("Bom te ver!", textAlign: TextAlign.center, style: getPageTitle()),
                  SizedBox(height: 10),
                  Text("Insira seu nome de usuário e senha para acessar sua conta", textAlign: TextAlign.center),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: nickname,
                    validator: (value) => value!.length > 7 && value.contains('@') ? null : 'Por favor, insira seu apelido e o @ de sua empresa',
                    autofocus: true,
                    keyboardType: TextInputType.name,
                    maxLines: 1,
                    decoration: InputDecoration(labelText: "Usuário", suffixIcon: Icon(Icons.person)),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: password,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !showPassword,
                    validator: (value) => value!.length >= 8 ? null : 'Ops, sua senha não parece com uma das que combinamos',
                    decoration: InputDecoration(
                      labelText: "Senha",
                      suffixIcon: IconButton(
                        icon: Icon(showPassword ? Icons.visibility_rounded : Icons.visibility_off_rounded),
                        onPressed: () => setState(() => showPassword = !showPassword),
                      ),
                    ),
                    maxLines: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CheckboxListTile(value: keepConnected, onChanged: (boo) => setState(() => keepConnected = boo ?? false), title: Text('Me mantenha conectado'), activeColor: PrimaryColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 40,
                          child: DefaultButton(
                              label: 'Registrar',
                              disabled: true,
                              onTap: () {
                                if (formKey.currentState!.validate()) controller.authenticate(nickname: nickname.text, password: password.text);
                              }),
                        ),
                        SizedBox(width: 30),
                        ValueListenableBuilder<LoadStatus>(
                          valueListenable: controller.loadStatus,
                          builder: (context, status, child) => Expanded(
                            flex: 60,
                            child: MainButton(
                                label: 'Entrar',
                                isLoading: status == LoadStatus.LOADING,
                                loadingLabel: 'Entrando...',
                                onTap: () {
                                  if (formKey.currentState!.validate()) controller.authenticate(nickname: nickname.text, password: password.text, remember: keepConnected);
                                }),
                          ),
                        )
                      ],
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
