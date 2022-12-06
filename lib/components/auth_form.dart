import 'package:flutter/material.dart';

enum AuthMode { Signup, Login }

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _isLoading = false;

  AuthMode _authMode = AuthMode.Login;
  final Map<String, String> _authData = {
    'email': '',
    'passwaord': '',
  };

  bool _isLogin() => _authMode == AuthMode.Login;
  bool _isSignup() => _authMode == AuthMode.Signup;

  void _switchAutMode() {
    setState(() {
      _authMode = _isLogin() ? AuthMode.Signup : AuthMode.Login;
    });
  }

  void _submit() {
    final isValid = _formkey.currentState?.validate() ?? false;

    if (!isValid) return;

    setState(() => _isLoading = true);

    _formkey.currentState?.save();
    if(_isLogin()){

    } else {

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
                    email.trim().isEmpty || !email.contains('@')
                        ? 'Informe email válido'
                        : null;
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                  controller: _passwordController,
                  onSaved: (value) => _authData['password'] = value ?? '',
                  validator: (value) {
                    final password = value ?? '';
                    password.isEmpty || password.length < 5
                        ? 'Informe uma senha válida'
                        : null;
                    return null;
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
                            (value ?? '') != _passwordController.text
                                ? 'Senha não confere'
                                : null;
                            return null;
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
