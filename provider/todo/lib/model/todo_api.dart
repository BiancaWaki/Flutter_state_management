import 'dart:convert';
import 'package:http/http.dart' as http;

class TodoApi {
  final String baseUrl = 'https://todo.rafaelbarbosatec.com/api';
  String? _jwtToken;

  // Login do Usuário
  Future<bool> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/local');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'identifier': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      _jwtToken = responseData['jwt'];
      print('Login bem-sucedido! Token: $_jwtToken');
      return true;
    }
    return false;
  }

  // Cadastro de Usuário
  Future<bool> register(String username, String email, String password) async {
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
      return true;
    }
    return false;
  }

  // Listar TODOs
  Future<List<dynamic>> getTodos() async {
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
  Future<void> createTodo(
      String title, String description, String color) async {
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
  Future<void> deleteTodo(int todoId) async {
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
