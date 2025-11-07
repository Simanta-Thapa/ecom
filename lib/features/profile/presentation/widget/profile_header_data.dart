class ProfileHeaderData{
  final String name;
  final String email;
  final bool isLoading;
  final String? errorMessage;


  const ProfileHeaderData({
    required this.name,
    required this.email,

    this.isLoading = false,
    this.errorMessage,
  });

}