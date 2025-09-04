import 'package:flutter/material.dart';
import 'package:health_app/models/user.dart';

//crear el StatefulWidget (este es dinamico)
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

//crear la clase de estado
class _LoginScreenState extends State<LoginScreen> {
  //controladores alamcenar el texto tecleado en los inputs de email y password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //declaramos las variables necesarias
  String _message = '';

  //se ejecuta al hacer clic en el boton, para realizar la accion del login
  void _login() {
    print('entra login');
    final String email = _emailController.text;
    final String password = _passwordController.text;

    // Creamos una nueva instancia de la clase User
    final User userLogin = User.forLogin(email: email, password: password);

    print(userLogin.email);
    print(userLogin.password);

    // Llamamos a la funcion que se encarga de mostrar el texto
    _showMessage();
  }

  //libera recursos cuando una pantalla ya no se utiliza, cuando el widget se destruye
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //logica de una funcion
  void _showMessage() {
    setState(() {
      if (_message != '') {
        _message = '';
        return;
      }

      _message = 'Sesión iniciada';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Inicio de Sesión'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Aquí agregamos el título como un widget de texto.
            const Text(
              'Inicio de Sesión',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 68.0,
            ), // Espacio entre el título y el primer input.
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                _login();
              }, //se ejecuta la funcion login al hacer clic en el boton
              child: const Text('Iniciar Sesión'),
            ),
            const SizedBox(height: 16.0),
            Text(
              //texto de "sesion iniciada"
              _message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
