import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/features/Store/data/datasource/shop_local_data_source.dart';
import 'package:ecommerce/features/Store/data/datasource/shop_local_data_source_impl.dart';
import 'package:ecommerce/features/Store/data/datasource/shop_remote_data_source.dart';
import 'package:ecommerce/features/Store/data/datasource/shop_remote_data_source_impl.dart';
import 'package:ecommerce/features/Store/data/repository/shop_repository_impl.dart';
import 'package:ecommerce/features/Store/domain/respositories/shop_repository.dart';
import 'package:ecommerce/features/Store/domain/usecases/add_product_use_case.dart';
import 'package:ecommerce/features/Store/domain/usecases/get_products_use_case.dart';
import 'package:ecommerce/features/Store/domain/usecases/selected_image_use_case.dart';
import 'package:ecommerce/features/Store/presentation/bloc/shop_bloc.dart';
import 'package:ecommerce/features/auth/bloc/auth_bloc.dart';
import 'package:ecommerce/features/auth/bloc/auth_event.dart';
import 'package:ecommerce/features/auth/data/data/auth_remote_data_source_impl.dart';
import 'package:ecommerce/features/auth/data/data/authremotedatasource.dart';
import 'package:ecommerce/features/auth/data/repository/auth_repository.dart';
import 'package:ecommerce/features/auth/domain/repository/auth_repo.dart';
import 'package:ecommerce/features/auth/domain/usecase/login_use_case.dart';
import 'package:ecommerce/features/auth/domain/usecase/register_use_case.dart';
import 'package:ecommerce/features/auth/helpers/data_source_helper.dart';

import 'package:ecommerce/features/cart/data/datasource/cart_remote_datasource.dart';
import 'package:ecommerce/features/cart/data/datasource/cart_remote_datasource_impl.dart';
import 'package:ecommerce/features/cart/data/repository/cart_respository_impl.dart';
import 'package:ecommerce/features/cart/domain/respositories/cart_repository.dart';

import 'package:ecommerce/features/cart/domain/usecases/add_to_cart_use_case.dart';

import 'package:ecommerce/features/cart/domain/usecases/clear_cart_use_case.dart';

import 'package:ecommerce/features/cart/domain/usecases/get_cart_items_use_case.dart';
import 'package:ecommerce/features/cart/domain/usecases/remove_cart_item_use_case.dart';
import 'package:ecommerce/features/cart/domain/usecases/update_cart_item_qty_use_case.dart';
import 'package:ecommerce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce/features/checkout/data/datasource/checkout_remote_data_source.dart';
import 'package:ecommerce/features/checkout/data/datasource/checkout_remote_data_source_impl.dart';
import 'package:ecommerce/features/checkout/data/repository/checkout_repository_imp.dart';
import 'package:ecommerce/features/checkout/domain/respositories/checkout_repository.dart';
import 'package:ecommerce/features/checkout/domain/usecases/get_user_addresses_use_case.dart';
import 'package:ecommerce/features/checkout/domain/usecases/start_checkout_use_case.dart';
import 'package:ecommerce/features/checkout/presentation/bloc/checkout_bloc.dart';
import 'package:ecommerce/features/details/bloc/detail_bloc.dart';
import 'package:ecommerce/features/details/data/datasource/detail_remote_data_source_impl.dart';
import 'package:ecommerce/features/details/data/datasource/details_remote_data_source.dart';
import 'package:ecommerce/features/details/data/repository/detail_repository.dart';
import 'package:ecommerce/features/details/domain/repository/details_repository.dart';
import 'package:ecommerce/features/details/domain/usecase/get_product_details_use_case.dart';
import 'package:ecommerce/features/favorite/data/datasource/favorite_remote_data_source.dart';
import 'package:ecommerce/features/favorite/data/datasource/favorite_remote_data_source_imp.dart';
import 'package:ecommerce/features/favorite/data/repository/favorite_respository_impl.dart';
import 'package:ecommerce/features/favorite/domain/respositories/feature_repository.dart';
import 'package:ecommerce/features/favorite/domain/usecases/fetch_user_favorite_list.dart';
import 'package:ecommerce/features/favorite/domain/usecases/toggle_user_favorite.dart';
import 'package:ecommerce/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:ecommerce/features/profile/data/datasource/profile_local_data_source.dart';
import 'package:ecommerce/features/profile/data/datasource/profile_remote_data_source.dart';
import 'package:ecommerce/features/profile/data/respository/profile_respository_impl.dart';
import 'package:ecommerce/features/profile/domain/respositories/profile_respositories.dart';
import 'package:ecommerce/features/profile/domain/usecases/fetch_user_profile.dart';
import 'package:ecommerce/features/profile/domain/usecases/profile_select_image_use_case.dart';
import 'package:ecommerce/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../features/auth/domain/usecase/get_current_user_use_case.dart';
import '../features/auth/domain/usecase/logout_use_case.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core Layer / Externial

  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => RemoteDataSourceHelper(sl()));

  /// Data layer  and respository layer

  sl.registerLazySingleton<ProfileLocalDataSource>(()=>ProfileLocalDataSourceImpl());

  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRespositoryImpl(profileRemoteDataSource: sl(), profileLocalDataSource: sl()),
  );

  sl.registerLazySingleton<CartRemoteDatasource>(
    () => CartRemoteDatasourceImpl(sl()),
  );


  sl.registerLazySingleton<DetailRemoteDataSource>(()=>DetailRemoteDataSourceImpl(sl()));


  sl.registerLazySingleton<CheckoutRemoteDataSource>(()=>CheckoutRemoteDataSourceImpl(sl()));

  /// favorite

  sl.registerLazySingleton<FavoriteRemoteDataSource>(
    () => FavoriteRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<FavoriteRepository>(
    () => FavoriteRespositoryImpl(favoriteRemoteDataSource: sl()),
  );

  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(sl()));

  /// Auth

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(auth: sl(), firestore: sl(), helper: sl()),
  );

  sl.registerLazySingleton<AuthRepo>(() => AuthRepositoryImpl(sl()));

  sl.registerLazySingleton<ShopLocalDataSource>(
    () => ShopLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<ShopRemoteDataSource>(
    () => ShopRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<ShopRepository>(
    () => ShopRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );

  sl.registerLazySingleton<DetailRepository>(()=>DetailRepositoryImpl(sl()));

  sl.registerLazySingleton<CheckoutRepository>(()=>CheckoutRepositoryImpl(sl()));

  // Domain layer and usecase


   // Profile

  sl.registerLazySingleton(() => FetchUserProfile(repository: sl()));
  sl.registerLazySingleton(()=>ProfileSelectImageUseCase(sl()));

  /// favorite
  sl.registerLazySingleton(
    () => FetchUserFavoriteList(favoriteRepository: sl()),
  );

  sl.registerLazySingleton(() => ToggleUserFavorite(favoriteRepository: sl()));

  /// Cart

  sl.registerLazySingleton(() => GetCartItemsUseCase(sl()));
  sl.registerLazySingleton(() => AddToCartUseCase(sl()));
  sl.registerLazySingleton(() => RemoveCartItemUseCase(sl()));
  sl.registerLazySingleton(() => ClearCartUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCartItemQtyUseCase(sl()));

  /// Cart

  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));

  ///Shop

  sl.registerLazySingleton(() => GetProductUseCase(sl()));
  sl.registerLazySingleton(() => SelectedImage(sl()));
  sl.registerLazySingleton(()=>AddProductUseCase(sl()));

  /// Details

  sl.registerLazySingleton(()=>GetProductDetailsUseCase(sl()));




  sl.registerLazySingleton(()=>GetUserAddressesUserCase(sl()));
  sl.registerLazySingleton(()=>StartCheckoutUseCase(checkoutRepository: sl()));

  /// bloc

  sl.registerFactory(() => ProfileBloc(fetchUserProfileUseCase: sl(), profileSelectImageUseCase: sl(),));

  sl.registerFactory(
    () => FavoriteBloc(fetchUserFavoriteList: sl(), toggleUserFavorite: sl()),
  );

  sl.registerFactory(
    () => CartBloc(
      getCartItemsUseCase: sl(),
      addToCartUseCase: sl(),
      removeCartItemUseCase: sl(),
      clearCartUseCase: sl(),
      updateCartItemQtyUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      registerUseCase: sl(),
      logoutUseCase: sl(),
      getCurrentUserUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => ShopBloc(
        getProductUseCase: sl(),
        selectedImage: sl(),
      addProductUseCase:sl(),

    ),
  );


  sl.registerFactory(()=>DetailBloc(getProductDetailsUseCase: sl()));

  sl.registerFactory(()=>CheckoutBloc(getUserAddressesUserCase:sl(), startCheckoutUseCase:sl(),));
}
