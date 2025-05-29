class UserModel {
  final String id;
  final String nome;
  final String email;
  final String telefone;
  final String dataNascimento;
  final String cpf;
  final String endereco;

  UserModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.dataNascimento,
    required this.cpf,
    required this.endereco,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      nome: map['nome'] ?? '',
      email: map['email'] ?? '',
      telefone: map['telefone'] ?? '',
      dataNascimento: map['datanascimento'] ?? '',
      cpf: map['cpf'] ?? '',
      endereco: map['endereco'] ?? '',
    );
  }

  get imagemPerfil => null;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'datanascimento': dataNascimento,
      'cpf': cpf,
      'endereco': endereco,
    };
  }
}
