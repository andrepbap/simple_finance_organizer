class BankAccountModel {
  final String name;
  final String description;

  BankAccountModel(this.name, this.description);

  static BankAccountModel fromMap(Map<String, dynamic> map) {
    var account = BankAccountModel(map["name"], map["description"]);
    return account;
  }

  Map<String, dynamic> toMap() {
    return {
      "description": description,
    };
  }
}
