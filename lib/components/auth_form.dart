import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/auth_exception.dart';

import '../models/auth.dart';

enum AuthMode { signup, login }

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _isLoading = false;

  AuthMode _authMode = AuthMode.login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  bool _isLogin() => _authMode == AuthMode.login;
  bool _isSignup() => _authMode == AuthMode.signup;

  void _switchAutMode() {
    setState(() {
      _authMode = _isLogin() ? AuthMode.signup : AuthMode.login;
    });
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ocorreu um erro'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final isValid = _formkey.currentState?.validate() ?? false;

    if (!isValid) return;

    setState(() => _isLoading = true);

    _formkey.currentState?.save();
    Auth auth = Provider.of(context, listen: false);
    try {
      if (_isLogin()) {
        await auth.login(
          _authData['email']!,
          _authData['password']!,
        );
      } else {
        await auth.signup(
          _authData['email']!,
          _authData['password']!,
        );
      }
    } on AuthException catch (e) {
      _showErrorDialog(e.toString());
    } catch (e) {
      _showErrorDialog('Ocorreu um erro inesperado');
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: _isLogin() ? 320 : 400,
        width: deviceSize.width * 0.75,
        child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) => _authData['email'] = value ?? '',
                  validator: (value) {
                    final email = value ?? '';
                    return email.trim().isEmpty || !email.contains('@')
                        ? 'Informe email válido'
                        : null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                  controller: _passwordController,
                  onSaved: (value) => _authData['password'] = value ?? '',
                  validator: (value) {
                    final password = value ?? '';
                    return password.isEmpty || password.length < 5
                        ? 'Informe uma senha válida'
                        : null;
                  },
                ),
                if (_isSignup())
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Confirmar Senha'),
                    obscureText: true,
                    validator: _isLogin()
                        ? null
                        : (value) {
                            return (value ?? '') != _passwordController.text
                                ? 'Senha não confere'
                                : null;
                          },
                  ),
                const SizedBox(height: 20),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 8,
                            )),
                        child: Text(_isLogin() ? 'ENTRAR' : 'REGISTRAR'),
                      ),
                const Spacer(),
                TextButton(
                  onPressed: _switchAutMode,
                  child: Text(
                      _isLogin() ? 'DESEJA REGISTRAR?' : 'JÁ POSSUI CONTA?'),
                ),
              ],
            )),
      ),
    );
  }
}
