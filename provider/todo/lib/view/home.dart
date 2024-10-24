import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/presenter/home_presenter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late AnimationController _controller;

  @override
  void initState() {
    final presenter = Provider.of<HomePresenter>(context, listen: false);
    Future.delayed(Duration.zero).then((value) {
      presenter.getTodos();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> deleteTodo(HomePresenter presenter, int todoId) async {
    await presenter.deleteTodo(todoId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () async {
            await context.read<HomePresenter>().logout();
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/login',
              (route) => false,
            );
          },
        ),
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
          child: Consumer<HomePresenter>(
            builder: (context, presenter, child) {
              if (presenter.loadingHome) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [
                  // Campo de busca
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        suffixIcon:
                            Icon(Icons.search, color: Color(0xFF3101B9)),
                        hintText: 'Busque palavras-chave',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  // Lista de todos
                  Expanded(
                    child: ListView.builder(
                      itemCount: presenter.todos.length,
                      itemBuilder: (context, index) {
                        final todo = presenter.todos[index];
                        final title =
                            todo['attributes']['title'] ?? 'Sem título';
                        final description = todo['attributes']['description'] ??
                            'Sem descrição';
                        final color = todo['attributes']['color'] ?? '#FFFFFF';
                        final todoId = todo['id'];

                        return Card(
                          color:
                              Color(int.parse(color.replaceFirst('#', '0xff'))),
                          child: ListTile(
                            contentPadding:
                                const EdgeInsets.only(left: 15, bottom: 20),
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
                              onPressed: () => _confirmDelete(
                                presenter: presenter,
                                context: context,
                                todoId: todoId,
                                title: title,
                              ), // Confirmação de deleção
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      final result =
                          await Navigator.pushNamed(context, '/todo');
                      if (result == true) {
                        presenter.getTodos();
                      }
                    },
                    tooltip: 'Adicionar TODO',
                    iconSize: 100,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // Função para exibir um diálogo de confirmação antes de deletar
  void _confirmDelete({
    required HomePresenter presenter,
    required BuildContext context,
    required int todoId,
    required String title,
  }) {
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
                deleteTodo(presenter, todoId); // Executa a exclusão
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

  // Função para criar um novo Todo
  Future<void> createTodo({
    required HomePresenter presenter,
    required String title,
    required String description,
    required String color,
  }) async {
    await presenter.createTodo(
      title: title,
      description: description,
      color: color,
    );
  }
}
