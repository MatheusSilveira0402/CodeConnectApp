// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'CodeConnect';

  @override
  String get navFeed => 'Feed';

  @override
  String get navPerfil => 'Profile';

  @override
  String get navDevsNearYou => 'Devs';

  @override
  String get navSobreNos => 'About us';

  @override
  String get navSair => 'Logout';

  @override
  String get btnPublicar => 'Publish';

  @override
  String get btnCancelar => 'Cancel';

  @override
  String get btnRetry => 'Try again';

  @override
  String get btnDelete => 'Delete';

  @override
  String get btnDiscard => 'Discard';

  @override
  String get btnUpdate => 'Update';

  @override
  String get logoutTitle => 'Logout';

  @override
  String get logoutMessage => 'Are you sure you want to log out?';

  @override
  String logoutError(String error) {
    return 'Error logging out: $error';
  }

  @override
  String get sobreNosWelcome => 'Welcome to\nCodeConnect!';

  @override
  String get sobreNosSubtitle => 'Where community\nand code come together!';

  @override
  String get sobreNosIntro =>
      'At the heart of the digital revolution is CodeConnect, born from the vision of creating a space where developers, enthusiasts and technology lovers can connect, learn and collaborate like never before! We are a global community passionate about code, committed to offering an inclusive and welcoming environment for all skill levels.';

  @override
  String get sobreNosMissionTitle => 'Our Mission';

  @override
  String get sobreNosMissionText =>
      'At CodeConnect, we believe collaboration is the essence of innovation. Our mission is to provide a platform where creative minds can come together, share knowledge, and build extraordinary projects. Whether you\'re a newcomer eager to learn or an experienced veteran, you\'ll find a home here for your tech ambitions.';

  @override
  String get sobreNosJoinTitle => 'Join Us!';

  @override
  String get sobreNosJoinText =>
      'We\'re excited to have you with us on this thrilling journey. Join our vibrant community and discover the power of collaboration in the world of code.';

  @override
  String get sobreNosFooter =>
      'Together, let\'s turn ideas into innovations and shape the digital future.';

  @override
  String get loginWelcome => 'Welcome! Log in to continue';

  @override
  String get fieldEmailOrUsernameLabel => 'Email or username';

  @override
  String get fieldEmailHint => 'Enter your email';

  @override
  String get fieldPasswordLabel => 'Password';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get forgotPassword => 'Forgot password';

  @override
  String get forgotPasswordSnack => 'Password recovery coming soon...';

  @override
  String get btnLogin => 'Login';

  @override
  String get orContinueWith => 'or continue with';

  @override
  String get githubLabel => 'GitHub';

  @override
  String get googleLabel => 'Google';

  @override
  String get noAccountYet => 'Don\'t have an account yet?';

  @override
  String get signUpNow => 'Sign up!';

  @override
  String get cadastroTitle => 'Sign up';

  @override
  String get cadastroSubtitle => 'Hello! Fill in your details';

  @override
  String get fieldNameLabel => 'Name';

  @override
  String get fieldNameHint => 'Full name';

  @override
  String get fieldEmailAddressLabel => 'Email address';

  @override
  String get fieldConfirmPasswordLabel => 'Confirm password';

  @override
  String get btnCadastrar => 'Sign up';

  @override
  String get orCreateAccountWith => 'or create an account with';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get loginNow => 'Log in!';

  @override
  String get defaultFieldName => 'Field';

  @override
  String get validatorEmailRequired => 'Email is required';

  @override
  String get validatorEmailInvalid => 'Invalid email';

  @override
  String get validatorPasswordRequired => 'Password is required';

  @override
  String validatorPasswordMinLength(int minLength) {
    return 'Password must be at least $minLength characters';
  }

  @override
  String get validatorConfirmPasswordRequired =>
      'Password confirmation is required';

  @override
  String get validatorPasswordsDontMatch => 'Passwords don\'t match';

  @override
  String get validatorNameRequired => 'Name is required';

  @override
  String get validatorFullNameRequired => 'Enter your full name';

  @override
  String get validatorNameTooShort => 'Name is too short';

  @override
  String validatorFieldRequired(String field) {
    return '$field is required';
  }

  @override
  String validatorMinLength(String field, int minLength) {
    return '$field must be at least $minLength characters';
  }

  @override
  String validatorMaxLength(String field, int maxLength) {
    return '$field must be at most $maxLength characters';
  }

  @override
  String get searchHint => 'Type what you\'re looking for';

  @override
  String get errorLoadingPosts => 'Error loading posts';

  @override
  String get noPostsFound => 'No posts found';

  @override
  String get beFirstToPublish => 'Be the first to publish!';

  @override
  String get errorLoadingProfile => 'Error loading profile';

  @override
  String get userNotFound => 'User not found';

  @override
  String get tabMyProjects => 'My projects';

  @override
  String get tabApproved => 'Approved';

  @override
  String get noProjectsYet => 'You don\'t have any projects yet';

  @override
  String get shareYourProjects => 'Share your projects!';

  @override
  String get noSharedProjects => 'No shared projects';

  @override
  String get offlineBanner => 'No connection — showing saved data';

  @override
  String get avatarUploadSoon => 'Avatar upload coming soon...';

  @override
  String get editPostTitle => 'Edit Post';

  @override
  String get newProjectTitle => 'New Project';

  @override
  String get selectCoverImage => 'Please select a cover image';

  @override
  String get postUpdatedSuccess => 'Post updated successfully!';

  @override
  String get postPublishedSuccess => 'Post published successfully!';

  @override
  String get errorPublishingPost => 'Error publishing post';

  @override
  String get confirmDeleteTitle => 'Confirm deletion';

  @override
  String get confirmDeletePostMessage =>
      'Are you sure you want to delete this post?';

  @override
  String get postDeletedSuccess => 'Post deleted successfully!';

  @override
  String get errorDeletingPost => 'Error deleting post';

  @override
  String get loadImage => 'Load image';

  @override
  String get projectNameLabel => 'Project name';

  @override
  String get projectNameHint => 'Easy-to-use React';

  @override
  String get fieldTitleRequired => 'Please enter the title';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get descriptionHint => 'Describe your project...';

  @override
  String get fieldDescriptionRequired => 'Please enter the description';

  @override
  String get tagsLabel => 'Tags';

  @override
  String get tagsHint => 'React';

  @override
  String get fieldTagsRequired => 'Please enter the tags';

  @override
  String get takePhoto => 'Take photo';

  @override
  String get chooseFromGallery => 'Choose from gallery';

  @override
  String get cameraPermissionDenied => 'Camera permission denied.';

  @override
  String get cameraPermissionPermanentlyDenied =>
      'Camera permission denied. Enable it in the app settings.';

  @override
  String get noCameraAvailable => 'No camera available on this device';

  @override
  String cameraInitError(String error) {
    return 'Error initializing camera: $error';
  }

  @override
  String cameraCaptureError(String error) {
    return 'Error capturing photo: $error';
  }

  @override
  String daysAgo(int count) {
    return '${count}d ago';
  }

  @override
  String hoursAgo(int count) {
    return '${count}h ago';
  }

  @override
  String minutesAgo(int count) {
    return '${count}min ago';
  }

  @override
  String get justNow => 'Just now';

  @override
  String get errorConnectionTimeout =>
      'Connection timed out. Check your internet.';

  @override
  String get errorReceiveTimeout => 'Response timed out. Try again.';

  @override
  String get errorConnection => 'Connection error. Check your internet.';

  @override
  String get errorInvalidData => 'Invalid data. Check the information.';

  @override
  String get errorWrongCredentials => 'Incorrect email or password.';

  @override
  String get errorAccessDenied => 'Access denied.';

  @override
  String get errorEmailAlreadyUsed => 'This email is already registered.';

  @override
  String get errorInvalidDataShort => 'Invalid data.';

  @override
  String get errorServer => 'Server error. Try again later.';

  @override
  String get errorGeneric => 'Error processing the request. Try again.';

  @override
  String get errorSessionExpired => 'Session expired. Log in again.';

  @override
  String get errorNoPermission =>
      'You don\'t have permission to perform this action.';

  @override
  String get errorPostNotFound => 'Post not found.';

  @override
  String get errorFileTooLarge => 'File too large. Choose a smaller image.';

  @override
  String get errorLogin => 'Error logging in. Try again.';

  @override
  String get errorRegister => 'Error creating account. Try again.';

  @override
  String get errorUpdateAvatar => 'Error updating avatar';

  @override
  String get errorOfflineNoCache => 'No connection and no locally saved data';

  @override
  String get errorFetchPosts => 'Error fetching posts';

  @override
  String errorLikePost(int id) {
    return 'Error liking post #$id';
  }

  @override
  String get errorCreatePost => 'Error creating post';

  @override
  String errorUpdatePost(int id) {
    return 'Error updating post #$id';
  }

  @override
  String errorDeletePost(int id) {
    return 'Error deleting post #$id';
  }

  @override
  String get devsNearYouTitle => 'Devs near you';

  @override
  String get shareLocationButton => 'Share my location';

  @override
  String get locationSharedSuccess => 'Location shared successfully!';

  @override
  String get errorSharingLocation => 'Error sharing location';

  @override
  String get locationPermissionDeniedMessage =>
      'Location permission denied. Can\'t show nearby devs.';

  @override
  String get locationServiceDisabledMessage =>
      'Enable the device\'s location service.';

  @override
  String get errorGettingLocation => 'Error getting your location';

  @override
  String get errorLoadingNearbyDevs => 'Error loading nearby devs';

  @override
  String get noDevsNearby => 'No devs found nearby';

  @override
  String kmAway(String km) {
    return '$km km away';
  }

  @override
  String get viewProfile => 'View profile';

  @override
  String memberSince(String date) {
    return 'Member since $date';
  }
}
