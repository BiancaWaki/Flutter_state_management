import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/todo_api.dart';
import 'package:todo/presenter/home_presenter.dart';
import 'package:todo/view/login.dart';
import 'package:todo/presenter/login_presenter.dart';

void main() {
  final api = TodoApi();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginPresenter(api: api)),
        ChangeNotifierProvider(create: (_) => HomePresenter(api: api)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Color(0xFFA901F7), // Cor de fundo da AppBar
          centerTitle: true, // Centraliza o título
          titleTextStyle: TextStyle(
            color: Colors.white, // Define a cor do título como branca
            fontSize: 20, // Define o tamanho da fonte do título
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // Cor dos ícones (inclusive o ícone de pop)
        ),

        // Definir um esquema de cores para o app
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFFA901F7), // Cor primária do app
          //secondary: const Color(0xFF3101B9), // Cor secundária/accen
          background: const Color(0xFFA901F7), // Cor de fundo padrão
          surface: const Color(0xFFA901F7), // Cor de fundo do Scaffold
        ),
        // Configurar cor para botões e seus textos.
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            backgroundColor: const Color(0xFF3101B9), // Cor dos botões
            foregroundColor: const Color(0xFFFFFFFF), // Cor do texto do botão
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Borda arredondada
            ),
            side: const BorderSide(
              color: Colors.white, // Cor da borda branca
              width: 1.5, // Espessura da borda
            ),
          ),
        ),

        // Configurar cor para TextField
        inputDecorationTheme: InputDecorationTheme(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          filled: true,
          fillColor: const Color(0xFFFFFFFF), // Cor de fundo do TextField
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
          labelStyle: const TextStyle(
              color: Color(0xFF3101B9)), // Cor do texto do rótulo
          hintStyle: const TextStyle(
              color: Color(0xFF3101B9)), // Cor do texto da dica (hint)
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Colors.white,
          ),
        ),
        dialogTheme: const DialogTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Color(0xFF3101B9),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          contentTextStyle: TextStyle(
            color: Color(0xFF3101B9),
            fontSize: 16,
          ),
        ),
      ),
      home: const Login(),
    );
  }
}
