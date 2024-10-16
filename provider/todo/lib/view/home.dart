import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/presenter/home_presenter.dart';
import 'package:todo/view/todo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Future<List<dynamic>> _todosFuture;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    // Carrega os TODOs no início
    final presenter = Provider.of<HomePresenter>(context, listen: false);
    _todosFuture = presenter.api.getTodos();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _deleteTodo(int todoId) async {
    try {
      final presenter = Provider.of<HomePresenter>(context, listen: false);
      await presenter.api.deleteTodo(todoId);
      setState(() {
        _todosFuture =
            presenter.api.getTodos(); // Recarrega a lista após deletar
      });
    } catch (e) {
      print('Erro ao excluir TODO: $e');
    }
  }

  Future<void> _createTodo(
      String title, String description, String color) async {
    try {
      final presenter = Provider.of<HomePresenter>(context, listen: false);
      await presenter.api.createTodo(title, description, color);
      setState(() {
        _todosFuture =
            presenter.api.getTodos(); // Recarrega a lista após adicionar
      });
    } catch (e) {
      print('Erro ao adicionar TODO: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Suas listagens',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        toolbarHeight: 100,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(0.0),
                child: TextField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search, color: Color(0xFF3101B9)),
                    hintText: 'Busque palavras-chave',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder<List<dynamic>>(
                  future: _todosFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Erro ao carregar TODOs: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final todos = snapshot.data!;
                      if (todos.isEmpty) {
                        return const Text('Nenhum TODO encontrado.');
                      }
                      return ListView.builder(
                        itemCount: todos.length,
                        itemBuilder: (context, index) {
                          final todo = todos[index];
                          final title =
                              todo['attributes']['title'] ?? 'Sem título';
                          final description = todo['attributes']
                                  ['description'] ??
                              'Sem descrição';
                          final color =
                              todo['attributes']['color'] ?? '#FFFFFF';
                          final todoId = todo['id'];

                          return Card(
                            color: Color(
                                int.parse(color.replaceFirst('#', '0xff'))),
                            child: ListTile(
                              contentPadding:
                                  EdgeInsets.only(left: 15, bottom: 20),
                              title: Text(
                                title,
                                style: const TextStyle(
                                  color: Color(0xFF3101B9),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                description,
                                style: const TextStyle(
                                  color: Color(0xFF3101B9),
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete_outline_sharp,
                                  color: Color(0xFF3101B9),
                                ),
                                onPressed: () => _confirmDelete(context, todoId,
                                    title), // Confirmação de deleção
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Text('Nenhum TODO disponível.');
                    }
                  },
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  // _showAddTodoDialog(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Todo(
                        createTodo: _createTodo,
                      ),
                    ),
                  );
                },
                tooltip: 'Adicionar TODO',
                iconSize: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Função para exibir um diálogo de confirmação antes de deletar
  void _confirmDelete(BuildContext context, int todoId, String title) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Deseja deletar este item?'),
          content: Text('"$title" será movido para a lixeira.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
                _deleteTodo(todoId); // Executa a exclusão
              },
              child: const Text(
                'Confirmar',
                style: TextStyle(
                  color: Color(0xFF3101B9),
                ),
              ),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(), // Cancela a exclusão
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}
