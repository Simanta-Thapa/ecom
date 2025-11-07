import 'package:ecommerce/features/profile/presentation/bloc/profile_event.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/profile.dart';


class ProfileState extends Equatable {
  final Profile? profile;
  final bool isLoading;
  final String? errorMessage;
  final ProfileTab selectedTab;

  const ProfileState({
    this.profile,
    this.isLoading = false,
    this.errorMessage,
    this.selectedTab = ProfileTab.favorite,
  });

  ProfileState copyWith({
    Profile? profile,
    bool? isLoading,
    String? errorMessage,
    ProfileTab? selectedTab,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }

  @override
  List<Object?> get props => [profile, isLoading, errorMessage, selectedTab];
}
