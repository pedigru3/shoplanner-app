import 'package:result_dart/result_dart.dart';
import 'package:shoplanner/layers/domain/entities/validation/validation.dart';

class NameValidation extends Validation {
  @override
  String? call(String? input, [String? message]) {
    if (input == null || input.isEmpty) {
      return message ?? 'Campo obrigatório';
    } else {
      if (input.length < 10) {
        return message ?? 'Nome inválido';
      } else {
        return null;
      }
    }
  }
}
