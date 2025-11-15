import 'package:ecommerce/features/profile/domain/usecases/profile_select_image_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/fetch_user_profile.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FetchUserProfile fetchUserProfileUseCase;
  final ProfileSelectImageUseCase profileSelectImageUseCase;

  ProfileBloc({
    required this.fetchUserProfileUseCase,
    required this.profileSelectImageUseCase,
  }) : super(const ProfileState()) {
    on<FetchProfile>(_onFetchProfile);
    on<SelectedTab>(_onSelectTab);
    on<OnSelectImage>(_onSelectImage);
  }

  Future<void> _onFetchProfile(
    FetchProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final profile = await fetchUserProfileUseCase(uid: event.uid);

      emit(state.copyWith(isLoading: false, profile: profile));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _onSelectImage(
    OnSelectImage event,
    Emitter<ProfileState> emit,
  ) async {
    final result = await profileSelectImageUseCase.call(event.source);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.msg)),
      (image) => emit(state.copyWith(image: image)),
    );
  }

  void _onSelectTab(SelectedTab event, Emitter<ProfileState> emit) {
    emit(state.copyWith(selectedTab: event.tab));
  }
}
