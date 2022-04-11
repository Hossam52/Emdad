import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:flutter_test/flutter_test.dart';
void main() {
  test('non empty string', () {
    final validator = SharedMethods.defaultValidation('test');
    expect(validator, null);
  });
}