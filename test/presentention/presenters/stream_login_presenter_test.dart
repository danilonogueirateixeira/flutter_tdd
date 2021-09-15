import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter_arch/presentetion/presenters/stream_login_presenter.dart';
import 'package:flutter_arch/presentetion/protocols/validation.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'stream_login_presenter_test.mocks.dart';

@GenerateMocks([Validation])
main() {
  late StreamLoginPresenter sut;
  late MockValidation validation;
  late String email;

  PostExpectation mockValidationCall(String? field) => when(validation.validate(
        field: field == null ? anyNamed('field') : field,
        value: anyNamed('value'),
      ));

  mockValidation({String? field, String? value}) {
    mockValidationCall(field).thenReturn(value);
  }

  setUp(() {
    validation = MockValidation();
    email = faker.internet.email();
    sut = StreamLoginPresenter(validation: validation);
    mockValidation();
  });

  test('Should call Validation with correct email', () {
    sut.validateEmail(email);

    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit email error if validation fails', () {
    mockValidation(value: 'error');
    expectLater(sut.emailErrorStream, emits('error'));

    sut.validateEmail(email);
  });
}
