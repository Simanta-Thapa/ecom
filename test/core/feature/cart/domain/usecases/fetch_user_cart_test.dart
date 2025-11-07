// import 'package:dartz/dartz.dart';
// import 'package:ecommerce/features/cart/domain/entities/cart.dart';
// import 'package:ecommerce/features/cart/domain/respositories/cart_repository.dart';
// import 'package:ecommerce/features/cart/domain/usecases/fetch_user_cart.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'fetch_user_cart_test.mocks.dart'; //

// @GenerateMocks([CartRepository])



// void main(){
//   late FetchUserCart usecase;
//   late MockCartRepository mockCartRepository;


// setUp((){
//  mockCartRepository = MockCartRepository();
//  usecase = FetchUserCart(mockCartRepository);
// });


// const String id = '123';


// const tCart = Cart(
//   id:id, 
//   name:'Pants', 
//   image: 'Pant', 
//   size:"S", 
//   color:"Red", 
//   price:232, 
//   qty:5
//   );


//   test('should return cart from repository',() async{

//     // Arrange 
//      when(mockCartRepository.fetchUserCart(id)).thenAnswer((_) async => Right(tCart));


//      // Act 

//      final result = await usecase(uid: id);


//      //Assert
//      expect(result, Right(tCart));
//      verify(mockCartRepository.fetchUserCart(id));
//      verifyNoMoreInteractions(mockCartRepository);

//   });



// }