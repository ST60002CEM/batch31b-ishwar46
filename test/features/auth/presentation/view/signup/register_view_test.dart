import 'package:age_care/core/failure/failure.dart';
import 'package:age_care/features/auth/domain/entity/auth_entity.dart';
import 'package:age_care/features/auth/domain/use_case/register_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'register_view_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<RegisterUseCase>(),
  MockSpec<BuildContext>(),
])
void main() {
  late MockRegisterUseCase mockRegisterUseCase;

  setUpAll(() async {
    mockRegisterUseCase = MockRegisterUseCase();
  });

  group('test register', () {
    setUpAll(() {
      when(
        mockRegisterUseCase.registerStaff(AuthEntity(
          firstName: 'Test',
          lastName: 'Bahadur',
          email: 'bahadur@test.com',
          password: 'password',
          phone: '1234567890',
          username: 'testuser',
          address: 'test address',
        )),
      ).thenAnswer(
        (_) async => const Right(true),
      );
    });
    test('Sign up with all fields', () async {
      // Call the register method
      final result = await mockRegisterUseCase.registerStaff(AuthEntity(
        firstName: 'Test',
        lastName: 'Bahadur',
        email: 'bahadur@test.com',
        password: 'password',
        phone: '1234567890',
        username: 'testuser',
        address: 'test address',
      ));

      // Verify the expected result
      expect(result, const Right(true));
    });

    test('Sign up with duplicate username', () async {
      // Mock a response indicating the username is already taken
      final duplicateUsernameFailure =
          Failure(error: 'Username already exists');
      when(mockRegisterUseCase.registerStaff(AuthEntity(
        firstName: 'Test',
        lastName: 'Bahadur',
        email: 'bahadur@test.com',
        password: 'password',
        phone: '1234567890',
        username: 'testuser',
        address: 'test address',
      ))).thenAnswer((_) async => Left(duplicateUsernameFailure));

      // Call the register method with duplicate username
      final result = await mockRegisterUseCase.registerStaff(AuthEntity(
        firstName: 'Test',
        lastName: 'Bahadur',
        email: 'bahadur@test.com',
        password: 'password',
        phone: '1234567890',
        username: 'testuser',
        address: 'test address',
      ));

      // Verify the expected result
      expect(result, Left(duplicateUsernameFailure));
    });

    test('Sign up with incomplete information', () async {
      // Mock a response indicating incomplete information provided
      final incompleteInformationFailure =
          Failure(error: 'Incomplete information');
      when(mockRegisterUseCase.registerStaff(AuthEntity(
        firstName: 'Test',
        lastName: '',
        email: 'bahadur@test.com',
        password: 'password',
        phone: '1234567890',
        username: '',
        address: 'test address',
      ))).thenAnswer((_) async => Left(incompleteInformationFailure));

      // Call the register method with incomplete information
      final result = await mockRegisterUseCase.registerStaff(AuthEntity(
        firstName: 'Test',
        lastName: '',
        email: 'bahadur@test.com',
        password: 'password',
        phone: '',
        username: 'testuser',
        address: 'test address',
      ));

      // Verify the expected result
      expect(result, Left(incompleteInformationFailure));
    });

    test('Sign up with invalid email', () async {
      // Mock a response indicating the email is invalid
      final invalidEmailFailure = Failure(error: 'Invalid email address');
      when(mockRegisterUseCase.registerStaff(AuthEntity(
        firstName: 'Test',
        lastName: 'Bahadur',
        email: 'bahadur@test.com',
        password: 'password',
        phone: '1234567890',
        username: 'testuser',
        address: 'test address',
      ))).thenAnswer((_) async => Right(true));

      // Call the register method with invalid email
      final result = await mockRegisterUseCase.registerStaff(AuthEntity(
        firstName: 'Test',
        lastName: 'Bahadur',
        email: 'bahadur@test.com',
        password: 'password',
        phone: '1234567890',
        username: 'testuser',
        address: 'test address',
      ));

      // Verify the expected result
      expect(result, Left(true));
    });
  });
}
