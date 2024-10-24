import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TodoApi {
  final String baseUrl = 'https://todo.rafaelbarbosatec.com/api';
  String? _jwtToken;

  // Getter para o token
  String? get jwtToken => _jwtToken;

  // Recuperar o token do dispositivo
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt');
  }

  // Salvar o token no dispositivo
  void saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt', token);
    _jwtToken = token;
  }

  // Deletar o token do dispositivo
  Future<void> deleteToken() async {
    _jwtToken = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
  }

  // Login do Usuário
  Future<String?> login({
    required String identifier,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/auth/local');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'identifier': identifier,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      _jwtToken = responseData['jwt'];
      print('Login bem-sucedido! Token: $_jwtToken');
      saveToken(_jwtToken!);
      return _jwtToken;
    }
    return null;
  }

  // Cadastro de Usuário
  Future<String?> register({
    required String username,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/auth/local/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      _jwtToken = responseData['jwt'];
      print('Cadastro bem-sucedido! Token: $_jwtToken');
      saveToken(_jwtToken!);
      return _jwtToken;
    }
    return null;
  }

  // Listar TODOs
  Future<List<dynamic>> getTodos() async {
    _jwtToken = await getToken();
    if (_jwtToken == null) {
      throw Exception('Usuário não autenticado.');
    }

    final url = Uri.parse('$baseUrl/todos');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_jwtToken',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData['data'];
    } else {
      throw Exception('Falha ao listar TODOs: ${response.body}');
    }
  }

  // Cadastrar TODO
  Future<void> createTodo({
    required String title,
    required String description,
    required String color,
  }) async {
    if (_jwtToken == null) {
      throw Exception('Usuário não autenticado.');
    }

    final url = Uri.parse('$baseUrl/todos');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_jwtToken',
      },
      body: jsonEncode({
        'data': {
          'title': title,
          'description': description,
          'color': color,
        },
      }),
    );

    if (response.statusCode == 200) {
      print('TODO criado com sucesso!');
    } else {
      throw Exception('Falha ao criar TODO: ${response.body}');
    }
  }

  // Excluir TODO
  Future<void> deleteTodo({
    required int todoId,
  }) async {
    if (_jwtToken == null) {
      throw Exception('Usuário não autenticado.');
    }

    final url = Uri.parse('$baseUrl/todos/$todoId');
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_jwtToken',
      },
    );

    if (response.statusCode == 200) {
      print('TODO excluído com sucesso!');
    } else {
      throw Exception('Falha ao excluir TODO: ${response.body}');
    }
  }
}
