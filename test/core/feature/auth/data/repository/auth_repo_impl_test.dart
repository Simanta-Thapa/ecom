import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failure.dart';
import 'package:ecommerce/features/auth/data/data/authremotedatasource.dart';
import 'package:ecommerce/features/auth/data/model/user_model.dart';
import 'package:ecommerce/features/auth/data/repository/auth_repository.dart';
import 'package:ecommerce/features/auth/domain/entites/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([AuthRemoteDataSource])
import 'auth_repo_impl_test.mocks.dart';

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;

  const tEmail = "test123@gmil.com";
  const tPwd = "123";
  const tName = "Test User";

  final tUserModel = UserModel('uid123', email: tEmail, name: tName);
  final tUserId = UserUid('uid123');

  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(mockAuthRemoteDataSource);
  });

  group("AuthRepository", () {
    group("Login", () {
      test("should return UserUid when successful", () async {
        // Arrange
        when(mockAuthRemoteDataSource.login(email: tEmail, pwd: tPwd))
            .thenAnswer((_) async => tUserModel);

        // Act
        final result = await repository.login(tEmail, tPwd);
        print("Result of test $result");
(
        // Assert
        expect(result, Right<Failure, UserUid>(tUserId))); // ✅ explicit generic
        verify(mockAuthRemoteDataSource.login(email: tEmail, pwd: tPwd)).called(1);
        verifyNoMoreInteractions(mockAuthRemoteDataSource);
      });
    });
  });





  group("Current user ",(){
   test("Should returns userUid if a user exists",() async{
   when(mockAuthRemoteDataSource.getCurrentUser()).thenAnswer((_) async =>tUserModel);

   final result = await repository.getCurrentUser();
   expect(result,Right(tUserId));
   verify(mockAuthRemoteDataSource.getCurrentUser()).called(1);
   verifyNoMoreInteractions(mockAuthRemoteDataSource);
   });
  });
}
