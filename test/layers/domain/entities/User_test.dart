import 'package:shoplanner/layers/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Id não deve ser nulo', () {
    final user = UserEntity(name: 'Felipe');
    expect(user.id != null, true);
    expect(user.name, 'Felipe');
  });
}
