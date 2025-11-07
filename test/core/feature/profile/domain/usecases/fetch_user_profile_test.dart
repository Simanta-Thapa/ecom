// import 'package:ecommerce/features/profile/domain/respositories/profile_respositories.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:dartz/dartz.dart';

// import 'package:ecommerce/features/profile/domain/entities/profile.dart';

// import 'package:ecommerce/features/profile/domain/usecases/fetch_user_profile.dart';
// import 'fetch_user_profile_test.mocks.dart'; // generated mock import

// // ✅ Generate mocks for ProfileRepository
// @GenerateMocks([ProfileRepository])
// void main() {
//   late FetchUserProfile usecase;
//   late MockProfileRepository mockProfileRepository;

//   setUp(() {
//     mockProfileRepository = MockProfileRepository();
//     usecase = FetchUserProfile(repository:mockProfileRepository);
//   });

//   const tProfileUser = Profile(uid: '123', name: 'simanta',);

//   test('should return user from the repository', () async {
//     // Arrange
//     when(mockProfileRepository.fetchUserProfile('123'))
//         .thenAnswer((_) async => Right(tProfileUser));

//     // Act
//     final result = await usecase.execute(uid: '123');

//     // Assert
//     expect(result, Right(tProfileUser));
//     verify(mockProfileRepository.fetchUserProfile('123'));
//     verifyNoMoreInteractions(mockProfileRepository);
//   });
// }
