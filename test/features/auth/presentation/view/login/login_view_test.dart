import 'package:age_care/core/failure/disable_account.dart';
import 'package:age_care/core/failure/failure.dart';
import 'package:age_care/core/failure/server_errro.dart';
import 'package:age_care/features/auth/domain/entity/auth_entity.dart';
import 'package:age_care/features/auth/domain/use_case/login_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_view_test.mocks.dart';

//============LOGIN UNIT TESTING================

@GenerateNiceMocks([
  MockSpec<LoginUseCase>(),
  MockSpec<BuildContext>(),
])
void main() {
  late MockLoginUseCase mockLoginUseCase;
  late AuthEntity mockAuthEntity;

  setUpAll(() async {
    mockLoginUseCase = MockLoginUseCase();
  });

  group('test login', () {
    setUpAll(() async {
      //Mocking the AuthEntity
      mockAuthEntity = AuthEntity(
        staffId: '1234',
        firstName: 'ishu',
        lastName: 'test',
        email: 'ishutest@mail.com',
        password: 'password',
        phone: '1234567890',
        username: 'ishutest',
        address: 'test address',
      );

      // Mocking the login use case
      when(
        mockLoginUseCase.loginStaff(
          'ishutest',
          'password',
        ),
      ).thenAnswer(
        (_) async => Future.value(
          Right(true),
        ),
      );
    });

    test('login correct user and pass', () async {
      // login with proper credential
      final result = await mockLoginUseCase.loginStaff(
        'ishutest',
        'password',
      );
      expect(result, Right(true));
    });

    //Login with server error
    test('login with server error', () async {
      final serverError = ServerError();
      when(mockLoginUseCase.loginStaff('ishutest', 'password'))
          .thenAnswer((_) async => Left(serverError));

      final result = await mockLoginUseCase.loginStaff('ishutest', 'password');
      expect(result, Left(serverError));
    });

    //Login with disabled account
    test('login with disabled account', () async {
      final disableAccount = AccountDisabledFailure();
      when(mockLoginUseCase.loginStaff('ishutest', 'password'))
          .thenAnswer((_) async => Left(disableAccount));

      final result = await mockLoginUseCase.loginStaff('ishutest', 'password');
      expect(result, Left(disableAccount));
    });

    //Login with invalid username
    test('test login with invalid username', () async {
      final mockErrorModel = Failure(
        error: 'user not found',
      );

      when(
        mockLoginUseCase.loginStaff(
          'ishu',
          'password',
        ),
      ).thenAnswer(
        (_) async => Left(mockErrorModel),
      );

      final result = await mockLoginUseCase.loginStaff(
        'ishu',
        'password',
      );

      expect(result, Left(mockErrorModel));
    });
  });
}
