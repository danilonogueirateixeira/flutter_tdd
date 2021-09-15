import 'package:flutter/material.dart';
import 'package:flutter_arch/ui/components/error_message.dart';
import 'package:flutter_arch/ui/components/headline1.dart';
import 'package:flutter_arch/ui/components/login_header.dart';
import 'package:flutter_arch/ui/components/spinner_dialog.dart';
import 'package:flutter_arch/ui/pages/login/components/email_input.dart';
import 'package:flutter_arch/ui/pages/login/components/login_button.dart';
import 'package:flutter_arch/ui/pages/login/components/password_input.dart';
import 'package:flutter_arch/ui/pages/login/login_presenter.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;

  const LoginPage(this.presenter);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    widget.presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          widget.presenter.isLoadingStream.listen((isLoading) {
            if (isLoading) {
              showLoading(context);
            } else {
              hideLoading(context);
            }
          });

          widget.presenter.mainErrorStream.listen((error) {
            showErrorMessage(context, error);
          });

          return SingleChildScrollView(
            child: Column(
              children: [
                LoginHeader(),
                Headline1(text: "Login"),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Provider(
                    create: (_) => widget.presenter,
                    child: Form(
                      child: Column(
                        children: [
                          EmailInput(),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 32),
                            child: PasswordInput(),
                          ),
                          LoginButton(),
                          TextButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.person),
                            label: Text('Criar Conta'),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
