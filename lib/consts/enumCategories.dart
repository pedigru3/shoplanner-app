enum Category { Alimentos, Higiene, Limpeza, Utilidades, Feira, Carnes }

Category categoryFromString(String str) {
  return Category.values.firstWhere(
    (categoria) => categoria.toString().split('.').last == str,
    orElse: () => throw Exception('Categoria não encontrada'),
  );
}

extension CategoryExtension on Category {
  String toStringValue() {
    return toString().split('.').last;
  }
}
