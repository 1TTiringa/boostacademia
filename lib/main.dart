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
    return Scaffold(
      backgroundColor: const Color(0xFF0f0940), // Cor de fundo
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 35, top: 130),
            child: const Text(
              'Boost Academia',
              style: TextStyle(
                color: Colors.white, // Texto branco para contraste
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
                    style: const TextStyle(color: Colors.white), // Texto branco
                    decoration: const InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.white), // Label branco
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), // Borda branca
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: senha,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white), // Texto branco
                    decoration: const InputDecoration(
                      hintText: "Senha",
                      hintStyle: TextStyle(color: Colors.white), // Hint branco
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), // Borda branca
                      ),
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
                        backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        child: IconButton(
                          onPressed: () {
                            if (usuario.text != "scania" || senha.text != "jeferson") {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('Usuário ou senha inválida'),
                                backgroundColor: Colors.red,
                              ));
                            }
                          },
                          icon: const Icon(Icons.arrow_forward, color: Color.fromARGB(255, 0, 0, 0)),
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
                      style: TextStyle(color: Colors.white), // Texto branco
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
  TextEditingController nomeCompleto = TextEditingController();
  TextEditingController usuario = TextEditingController();
  TextEditingController senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0f0940), // Cor de fundo
      appBar: AppBar(
        title: const Text('Registro'),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nomeCompleto,
              style: const TextStyle(color: Colors.white), // Texto branco
              decoration: const InputDecoration(
                labelText: 'Nome Completo',
                labelStyle: TextStyle(color: Colors.white), // Label branco
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Borda branca
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: usuario,
              style: const TextStyle(color: Colors.white), // Texto branco
              decoration: const InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white), // Label branco
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Borda branca
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: senha,
              obscureText: true,
              style: const TextStyle(color: Colors.white), // Texto branco
              decoration: const InputDecoration(
                labelText: 'Senha',
                labelStyle: TextStyle(color: Colors.white), // Label branco
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Borda branca
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aqui você pode adicionar a lógica para registrar o usuário
                debugPrint('Nome Completo: ${nomeCompleto.text}');
                debugPrint('Usuário: ${usuario.text}');
                debugPrint('Senha: ${senha.text}');
                Navigator.pop(context); // Volta para a página de login
              },
              child: const Text('Registrar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
