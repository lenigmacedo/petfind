class Pets {
  String nomePet;
  String nomeDono;
  String desc;
  String raca;
  String sexo;
  String telefone;
  String tipo;

  Pets(this.nomePet, this.nomeDono, this.desc, this.raca, this.sexo,
      this.telefone, this.tipo);

  Pets.fromMap(Map<String, dynamic> map) {
    this.nomePet = map['nomePet'];
    this.nomeDono = map['nomeDono'];
    this.desc = map['descricao'];
    this.raca = map['raca'];
    this.sexo = map['sexo'];
    this.telefone = map['telefone'];
    this.tipo = map['tipo'];
  }
}
