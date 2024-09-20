import 'dart:io';

import 'package:boostacademia/db/dao/dao.dart';
import 'package:boostacademia/model/users.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    
  }
  debugPrint((await findall()).toString());
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {
      'login': (context) => LoginPage(),
      'registro': (context) => RegistroPage(),
      'treinos': (context) => TreinosPage(userName: '',),
      'treino1': (context) => const Treino1(),
      'treino2': (context) => const Treino2(),
      'treino3': (context) => const Treino3(),
      'treino4': (context) => const Treino4(),
    },
  ));

}

class LoginPage extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0f0940),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/122.png', width: 150),
            const SizedBox(height: 50),
            TextField(
              controller: email,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: const TextStyle(color: Colors.white),
                filled: true,
                fillColor: const Color(0xFF1e1a54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: password,
              style: const TextStyle(color: Colors.white),
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Senha',
                hintStyle: const TextStyle(color: Colors.white),
                filled: true,
                fillColor: const Color(0xFF1e1a54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (email.text.isEmpty || password.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Por favor, preencha todos os campos.')),
                  );
                  return;
                }

                var userList = await findall(); // Presumindo que findall() retorna uma lista de dicionários
                var user = userList.firstWhere(
                  (user) => user['email'] == email.text && user['password'] == password.text,
                  orElse: () => {}, // Retorne um dicionário vazio se não encontrar
                );

                if (user.isNotEmpty) { // Verifica se o dicionário não está vazio
                  // Passar o nome do usuário ao navegar para a TreinosPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TreinosPage(userName: user['name']),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Usuário ou senha incorretos.')),
                  );
                }
              },

              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                backgroundColor: const Color(0xFFFFFFFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, 'registro');
              },
              child: const Text('Registrar-se', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}


class RegistroPage extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController pwd = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0f0940),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1e1a54),
        title: const Text('Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/122.png', width: 150),
            TextField(
              controller: name,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Nome',
                hintStyle: const TextStyle(color: Colors.white),
                filled: true,
                fillColor: const Color(0xFF1e1a54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: email,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: const TextStyle(color: Colors.white),
                filled: true,
                fillColor: const Color(0xFF1e1a54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: pwd,
              style: const TextStyle(color: Colors.white),
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Senha',
                hintStyle: const TextStyle(color: Colors.white),
                filled: true,
                fillColor: const Color(0xFF1e1a54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                insertUser(User(name: name.text, email: email.text, password: pwd.text));
                Navigator.pushNamed(context, 'treinos');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                backgroundColor: const Color(0xFFFFFFFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text('Registrar-se'),
            ),
          ],
        ),
      ),
    );
  }
}

class TreinosPage extends StatelessWidget {
  final String userName;

  TreinosPage({required this.userName}); // Construtor para receber o nome

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0f0940),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF1e1a54),
        title: Text( // Usar o nome do usuário aqui
          'Bom dia, $userName!',
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Treinos:',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Pesquisar treinos',
                      hintStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: const Color(0xFF1e1a54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Treinos realizados:',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: GridView.count(
                mainAxisSpacing: 1,
                crossAxisCount: 1,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'treino1');
                    },
                    child: Column(
                      children: [
                        Image.asset("images/1.png", width: 300),
                        const SizedBox(height: 2),
                        const Text(
                          'Treino de Definição',
                          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'treino2');
                    },
                    child: Column(
                      children: [
                        Image.asset("images/resistencia.jpg", width: 300),
                        const SizedBox(height: 2),
                        const Text(
                          'Treino de Resistência',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'treino3');
                    },
                    child: Column(
                      children: [
                        Image.asset("images/forca.jpg", width: 300),
                        const SizedBox(height: 2),
                        const Text(
                          'Treino de Força',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'treino4');
                    },
                    child: Column(
                      children: [
                        Image.asset("images/cardio.jpg", width: 300),
                        const SizedBox(height: 2),
                        const Text(
                          'Treino de Cardio',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Página de Detalhes para o Treino 1
class Treino1 extends StatelessWidget {
  const Treino1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExerciseDetailPage(
      treinoNome: 'Treino de Definição',
      exercicios: [
        ExerciciosData('Prancha', 'Tempo do exercício: 2 minutos', 'Médio'),
        ExerciciosData('Abdominal', 'Repetições: 20', 'Médio'),
        ExerciciosData('Flexão', 'Repetições: 20', 'Médio'),
        ExerciciosData('Agachamento', 'Repetições: 20', 'Médio'),
        ExerciciosData('Polichinelos', 'Tempo: 2 minutos', 'Fácil'),
      ],
    );
  }
}

// Página de Detalhes para o Treino 2
class Treino2 extends StatelessWidget {
  const Treino2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExerciseDetailPage(
      treinoNome: 'Treino de Resistência',
      exercicios: [
        ExerciciosData('Corrida', 'Tempo do exercício: 30 minutos', 'Difícil'),
        ExerciciosData('Pular Corda', 'Tempo: 15 minutos', 'Médio'),
        ExerciciosData('Burpee', 'Repetições: 20', 'Difícil'),
        ExerciciosData('Escalador', 'Tempo: 5 minutos', 'Difícil'),
        ExerciciosData('Prancha Lateral', 'Tempo: 1 minuto', 'Médio'),
      ],
    );
  }
}

// Página de Detalhes para o Treino 3
class Treino3 extends StatelessWidget {
  const Treino3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExerciseDetailPage(
      treinoNome: 'Treino de Força',
      exercicios: [
        ExerciciosData('Levantamento de Peso', 'Repetições: 10', 'Difícil'),
        ExerciciosData('Supino', 'Repetições: 10', 'Médio'),
        ExerciciosData('Remada', 'Repetições: 12', 'Médio'),
        ExerciciosData('Agachamento com Peso', 'Repetições: 10', 'Difícil'),
        ExerciciosData('Deadlift', 'Repetições: 8', 'Difícil'),
        ExerciciosData('Desenvolvimento de Ombros', 'Repetições: 10', 'Médio'),
        ExerciciosData('Tríceps Testa', 'Repetições: 12', 'Médio'),
      ],
    );
  }
}

// Página de Detalhes para o Treino 4
class Treino4 extends StatelessWidget {
  const Treino4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExerciseDetailPage(
      treinoNome: 'Treino de Cardio',
      exercicios: [
        ExerciciosData('Ciclismo', 'Tempo: 30 minutos', 'Médio'),
        ExerciciosData('Corrida Intervalada', 'Tempo: 20 minutos', 'Difícil'),
        ExerciciosData('Dança', 'Tempo: 45 minutos', 'Fácil'),
        ExerciciosData('Natação', 'Tempo: 30 minutos', 'Médio'),
        ExerciciosData('Escada', 'Tempo: 15 minutos', 'Fácil'),
        ExerciciosData('Jumping Jacks', 'Tempo: 10 minutos', 'Fácil'),
        ExerciciosData('Zumba', 'Tempo: 30 minutos', 'Médio'),
      ],
    );
  }
}

class ExerciseDetailPage extends StatelessWidget {
  final String treinoNome;
  final List<ExerciciosData> exercicios;

  const ExerciseDetailPage({Key? key, required this.treinoNome, required this.exercicios}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0f0940),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1e1a54),
        title: Text(treinoNome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              treinoNome,
              style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: exercicios.length,
                itemBuilder: (context, index) {
                  final exercicio = exercicios[index];
                  return Card(
                    color: const Color(0xFF1e1a54),
                    child: ListTile(
                      leading: const Icon(Icons.fitness_center, color: Colors.white),
                      title: Text(exercicio.nome, style: const TextStyle(color: Colors.white)),
                      subtitle: Text(
                        '${exercicio.detalhes}\nDificuldade: ${exercicio.dificuldade}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TutorialPage(
                                exercicioNome: exercicio.nome,
                                tutorial: 'Tutorial de como realizar ${exercicio.nome}:\n\n'
                                    '1. Mantenha a posição correta.\n'
                                    '2. Execute o movimento lentamente.\n'
                                    '3. Respire de forma controlada.\n'
                                    '4. Mantenha a forma durante todo o exercício.',
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text('Começar treino!'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Classe para armazenar dados dos exercícios
class ExerciciosData {
  final String nome;
  final String detalhes;
  final String dificuldade;

  ExerciciosData(this.nome, this.detalhes, this.dificuldade);
}

// Página de Tutorial
class TutorialPage extends StatelessWidget {
  final String exercicioNome;
  final String tutorial;

  const TutorialPage({Key? key, required this.exercicioNome, required this.tutorial}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0f0940),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1e1a54),
        title: Text(exercicioNome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                exercicioNome,
                style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                tutorial,
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ), 
              ElevatedButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExerciseDetailPage(treinoNome: "",exercicios: [],)));},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text('FINALIZAR'),
                      ),
            ],
          ),
        ),
      ),
    );
  }
}