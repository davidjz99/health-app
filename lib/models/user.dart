class User {
  final int? userId;
  final String? name;
  final String? email;
  final String? password;
  final int? age;
  final double? height;
  final double? weight;

  // Constructor, con todos los parametros opcionales
  User({
    this.userId,
    this.name,
    this.email,
    this.password,
    this.age,
    this.height,
    this.weight,
  });

  //se usa para crear una nueva instancia con valores actualizados
  User copyWith({
    int? userId,
    String? name,
    String? email,
    String? password,
    int? age,
    double? height,
    double? weight,
  }) {
    return User(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
    );
  }

  // Método opcional: crea un usuario para el login
  User.forLogin({required this.email, required this.password})
    : userId = null,
      name = null,
      age = null,
      height = null,
      weight = null;

  // Constructor para crear un objeto User desde un mapa JSON (deserialización)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      age: json['age'],
      height: json['height'],
      weight: json['weight'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
