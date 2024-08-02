import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {
      'login': (context) => const Login(),
      'registro': (context) => const Registro(),
    },
  ));
}

// ignore: must_be_immutable
class ItemValor extends StatelessWidget {
  String titulo;
  String texto;
  late VoidCallback ondelete;

  ItemValor({
    required this.titulo,
    required this.texto,
    required this.ondelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(
          Icons.note,
          color: Color.fromARGB(255, 161, 191, 236),
        ),
        title: Text(titulo),
        subtitle: Text(texto),
        trailing:
            IconButton(onPressed: ondelete, icon: const Icon(Icons.delete)),
      ),
    );
  }
}

class Formulario extends StatefulWidget {
  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  TextEditingController controllerTitulo = TextEditingController();
  TextEditingController controllerTexto = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(('Formulário de Cadastro')),
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 121, 137, 224),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextField(
              controller: controllerTitulo,
              decoration: const InputDecoration(hintText: 'Insira o Texto'),
              inputFormatters: [],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextField(
              controller: controllerTexto,
              decoration: const InputDecoration(hintText: 'Insira o Texto'),
              inputFormatters: const [],
            ),
          ),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ElevatedButton(
                  onPressed: () {
                    debugPrint('Valor do Titulo: ${controllerTitulo.text}');
                    debugPrint('Valor do TextField: ${controllerTexto.text}');

                    ItemValor conteudo = ItemValor(
                        titulo: controllerTitulo.text,
                        texto: controllerTexto.text,
                        ondelete: () {});
                    Navigator.pop(context, conteudo);
                  },
                  child: const Text('Salvar')))
        ],
      ),
    );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginPage();
}

class _LoginPage extends State<Login> {
  TextEditingController usuario = TextEditingController();
  TextEditingController senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 130),
              child: const Text(
                'Faça login',
                style: TextStyle(
                  color: Color.fromARGB(255, 121, 137, 224),
                  fontSize: 45,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.4,
                    right: 35,
                    left: 35),
                child: Column(
                  children: [
                    TextFormField(
                      controller: usuario,
                      decoration: const InputDecoration(
                        labelText: "Usuário",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: senha,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Senha",
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Color.fromARGB(255, 121, 137, 224),
                          child: IconButton(
                            onPressed: () {
                              if (usuario.text != "scania" || senha.text != "jeferson") {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text('Usuário ou senha inválida'),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            },
                            icon: const Icon(Icons.arrow_forward, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'registro');
                      },
                      child: const Text(
                        'Não tem uma conta? Registre-se',
                        style: TextStyle(color: Color.fromARGB(255, 121, 137, 224)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Registro extends StatefulWidget {
  const Registro({Key? key}) : super(key: key);

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  TextEditingController usuario = TextEditingController();
  TextEditingController senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
        backgroundColor: Color.fromARGB(255, 121, 137, 224),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usuario,
              decoration: const InputDecoration(
                labelText: 'Usuário',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: senha,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Senha',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aqui você pode adicionar a lógica para registrar o usuário
                debugPrint('Usuário: ${usuario.text}');
                debugPrint('Senha: ${senha.text}');
              },
              child: const Text('Registrar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 121, 137, 224),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
