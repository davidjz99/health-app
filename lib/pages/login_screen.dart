import 'package:flutter/material.dart';
import 'package:health_app/models/user.dart';
import 'package:health_app/services/auth_service.dart';

//crear el StatefulWidget (este es dinamico)
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

//crear la clase de estado
class _LoginScreenState extends State<LoginScreen> {
  //controladores que almacenan el texto tecleado en los inputs de email y password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService(); // instancia del servicio

  // Variables de estado para las validaciones
  bool _isEmailValid = false;
  bool _isPasswordValid = false;

  //declaramos las variables necesarias
  String _message = '';

  // Se usa para saber si el campo del email tiene un formato valido
  final RegExp emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    caseSensitive: false,
    multiLine: false,
  );

  @override
  void initState() {
    super.initState();
    // Se agregan listeners a los controladores, para escuchar sus cambios y validar al momento
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  // Esta función se encarga de validar ambos campos
  void _validateForm() {
    // Usamos setState para que los cambios en las variables se reflejen
    setState(() {
      _isEmailValid = emailRegExp.hasMatch(
        _emailController.text,
      ); //si el email es valido
      _isPasswordValid =
          _passwordController.text.length >=
          8; //y si el password tiene 8 caracteres o mas
    });
  }

  //se ejecuta al hacer clic en el boton, para realizar la accion del login
  void _login() async {
    // Creamos una nueva instancia de la clase User
    final User userLogin = User.forLogin(
      email: _emailController.text,
      password: _passwordController.text,
    );

    // El servicio ahora retorna el token (String) o null
    final String? token = await _authService.login(userLogin);

    // Verificamos la respuesta de la API
    setState(() {
      if (token != null) {
        // El login fue exitoso, el objeto loggedInUser contiene los datos del usuario
        _message = '¡Login exitoso! Token guardado para futuras peticiones.';
        print('Token recibido y guardado: $token');
      } else {
        // El login falló
        _message = 'Error: Credenciales incorrectas';
      }
    });
  }

  //libera recursos cuando una pantalla ya no se utiliza, cuando el widget se destruye
  @override
  void dispose() {
    _emailController.removeListener(_validateForm);
    _passwordController.removeListener(_validateForm);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool _isButtonEnabled = _isEmailValid && _isPasswordValid;

    return Scaffold(
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
              onPressed: _isButtonEnabled
                  ? _login
                  : null, //se ejecuta la funcion login al hacer clic en el boton, siempre y cuando este habilitado el boton
              child: const Text('Iniciar Sesión'),
            ),
            const SizedBox(height: 16.0),
            //texto que redirecciona a la pagina para crear una cuenta
            const Text(
              '¿No tienes una cuenta? ¡Crea una!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 255),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
