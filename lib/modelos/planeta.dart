class Planeta {
  int? id;
  double tamanho;
  double distancia;
  String nome;
  String? apelido;

  // Construtor da classe Planeta
  Planeta({
    this.id,
    required this.tamanho,
    required this.distancia,
    required this.nome,
    this.apelido,
  });

  // Construtor alternativo
  Planeta.vazio() : nome = '', tamanho = 0.0, distancia = 0.0, apelido = '';

  factory Planeta.fromMap(Map<String, dynamic> map) {
    return Planeta(
      id: map['id'],
      nome: map['nome'],
      tamanho: map['tamanho'],
      distancia: map['distancia'],
      apelido: map['apelido'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'tamanho': tamanho,
      'distancia': distancia,
      'apelido': apelido,
    };
  }
}
