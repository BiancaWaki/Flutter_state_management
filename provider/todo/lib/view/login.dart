import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/presenter/login_presenter.dart';
import 'package:todo/view/home.dart';
import 'package:todo/view/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isObscured = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFA901F7),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<LoginPresenter>(
              builder: (context, presenter, child) {
                if (presenter.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 150),
                    const Text(
                      'Que bom que voltou!',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 30),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15), // Ajusta o padding
                        hintText: 'Número de telefone, email ou CPF',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      obscureText: isObscured,
                      controller: passwordController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        hintText: 'Senha',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscured = !isObscured;
                            });
                          },
                          icon: Icon(isObscured
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        Text(
                          ' Esqueceu seu login ou senha? ',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Clique aqui',
                          style: TextStyle(
                            color: Colors.yellow,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        login(presenter);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 25),
                      ),
                      child: const Text(
                        'Entrar',
                        style: TextStyle(
                          fontSize: 20, // Aumenta o tamanho da fonte
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.white,
              width: 1.0,
              style: BorderStyle.solid,
            ),
          ),
        ),
        child: BottomAppBar(
          color: const Color(0xFFA901F7),
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Não possui cadastro?',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register()),
                  );
                },
                child: const Text(
                  'Clique aqui',
                  style: TextStyle(
                    color: Colors.yellow,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login(LoginPresenter presenter) async {
    String email = emailController.text;
    String password = passwordController.text;
    final result = await presenter.login(email, password);
    if (result) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login inválido!')),
      );
    }
  }
}
