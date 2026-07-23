import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In pt, this message translates to:
  /// **'CodeConnect'**
  String get appTitle;

  /// No description provided for @navFeed.
  ///
  /// In pt, this message translates to:
  /// **'Feed'**
  String get navFeed;

  /// No description provided for @navPerfil.
  ///
  /// In pt, this message translates to:
  /// **'Perfil'**
  String get navPerfil;

  /// No description provided for @navDevsNearYou.
  ///
  /// In pt, this message translates to:
  /// **'Devs'**
  String get navDevsNearYou;

  /// No description provided for @navSobreNos.
  ///
  /// In pt, this message translates to:
  /// **'Sobre nós'**
  String get navSobreNos;

  /// No description provided for @navSair.
  ///
  /// In pt, this message translates to:
  /// **'Sair'**
  String get navSair;

  /// No description provided for @btnPublicar.
  ///
  /// In pt, this message translates to:
  /// **'Publicar'**
  String get btnPublicar;

  /// No description provided for @btnCancelar.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get btnCancelar;

  /// No description provided for @btnRetry.
  ///
  /// In pt, this message translates to:
  /// **'Tentar novamente'**
  String get btnRetry;

  /// No description provided for @btnDelete.
  ///
  /// In pt, this message translates to:
  /// **'Excluir'**
  String get btnDelete;

  /// No description provided for @btnDiscard.
  ///
  /// In pt, this message translates to:
  /// **'Descartar'**
  String get btnDiscard;

  /// No description provided for @btnUpdate.
  ///
  /// In pt, this message translates to:
  /// **'Atualizar'**
  String get btnUpdate;

  /// No description provided for @logoutTitle.
  ///
  /// In pt, this message translates to:
  /// **'Sair'**
  String get logoutTitle;

  /// No description provided for @logoutMessage.
  ///
  /// In pt, this message translates to:
  /// **'Deseja realmente sair?'**
  String get logoutMessage;

  /// No description provided for @logoutError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao fazer logout: {error}'**
  String logoutError(String error);

  /// No description provided for @sobreNosWelcome.
  ///
  /// In pt, this message translates to:
  /// **'Bem-Vindo ao\nCodeConnect!'**
  String get sobreNosWelcome;

  /// No description provided for @sobreNosSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Onde a comunidade\ne o código se unem!'**
  String get sobreNosSubtitle;

  /// No description provided for @sobreNosIntro.
  ///
  /// In pt, this message translates to:
  /// **'No coração da revolução digital está o CodeConnect nasceu da visão de criar um espaço onde desenvolvedores e apaixonados e entusiastas da tecnologia podem se conectar, aprender e colaborar de maneira inigualável! Somos uma comunidade global apaixonada, por código e comprometidos em oferecer um ambiente inclusivo e acolhedor para todos os níveis de habilidade.'**
  String get sobreNosIntro;

  /// No description provided for @sobreNosMissionTitle.
  ///
  /// In pt, this message translates to:
  /// **'Nossa Missão'**
  String get sobreNosMissionTitle;

  /// No description provided for @sobreNosMissionText.
  ///
  /// In pt, this message translates to:
  /// **'Na CodeConnect, acreditamos que a colaboração é a essência da inovação. Nossa missão é fornecer uma plataforma onde as mentes criativas podem se unir, compartilhar conhecimento, e desenvolver projetos extraordinários. Quer você seja um novato ansioso para aprender ou um veterano experiente, você encontrará aqui um lar para suas aspirações tecnológicas.'**
  String get sobreNosMissionText;

  /// No description provided for @sobreNosJoinTitle.
  ///
  /// In pt, this message translates to:
  /// **'Junte-se a Nós!'**
  String get sobreNosJoinTitle;

  /// No description provided for @sobreNosJoinText.
  ///
  /// In pt, this message translates to:
  /// **'Estamos animados para ter você conosco nesta jornada empolgante. Junte-se à nossa comunidade vibrante e descubra o poder da colaboração no mundo do código'**
  String get sobreNosJoinText;

  /// No description provided for @sobreNosFooter.
  ///
  /// In pt, this message translates to:
  /// **'Juntos, vamos transformar ideias em inovações e moldar o futuro digital.'**
  String get sobreNosFooter;

  /// No description provided for @loginWelcome.
  ///
  /// In pt, this message translates to:
  /// **'Bem-vindo! Faça seu login'**
  String get loginWelcome;

  /// No description provided for @fieldEmailOrUsernameLabel.
  ///
  /// In pt, this message translates to:
  /// **'Email ou usuário'**
  String get fieldEmailOrUsernameLabel;

  /// No description provided for @fieldEmailHint.
  ///
  /// In pt, this message translates to:
  /// **'Digite seu email'**
  String get fieldEmailHint;

  /// No description provided for @fieldPasswordLabel.
  ///
  /// In pt, this message translates to:
  /// **'Senha'**
  String get fieldPasswordLabel;

  /// No description provided for @rememberMe.
  ///
  /// In pt, this message translates to:
  /// **'Lembrar-me'**
  String get rememberMe;

  /// No description provided for @forgotPassword.
  ///
  /// In pt, this message translates to:
  /// **'Esqueci a senha'**
  String get forgotPassword;

  /// No description provided for @forgotPasswordSnack.
  ///
  /// In pt, this message translates to:
  /// **'Recuperação de senha em breve...'**
  String get forgotPasswordSnack;

  /// No description provided for @btnLogin.
  ///
  /// In pt, this message translates to:
  /// **'Login'**
  String get btnLogin;

  /// No description provided for @orContinueWith.
  ///
  /// In pt, this message translates to:
  /// **'ou continue com'**
  String get orContinueWith;

  /// No description provided for @githubLabel.
  ///
  /// In pt, this message translates to:
  /// **'GitHub'**
  String get githubLabel;

  /// No description provided for @googleLabel.
  ///
  /// In pt, this message translates to:
  /// **'Google'**
  String get googleLabel;

  /// No description provided for @noAccountYet.
  ///
  /// In pt, this message translates to:
  /// **'Ainda não tem conta?'**
  String get noAccountYet;

  /// No description provided for @signUpNow.
  ///
  /// In pt, this message translates to:
  /// **'Cadastre-se!'**
  String get signUpNow;

  /// No description provided for @cadastroTitle.
  ///
  /// In pt, this message translates to:
  /// **'Cadastro'**
  String get cadastroTitle;

  /// No description provided for @cadastroSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Olá! Preencha seus dados'**
  String get cadastroSubtitle;

  /// No description provided for @fieldNameLabel.
  ///
  /// In pt, this message translates to:
  /// **'Nome'**
  String get fieldNameLabel;

  /// No description provided for @fieldNameHint.
  ///
  /// In pt, this message translates to:
  /// **'Nome completo'**
  String get fieldNameHint;

  /// No description provided for @fieldEmailAddressLabel.
  ///
  /// In pt, this message translates to:
  /// **'Endereço de email'**
  String get fieldEmailAddressLabel;

  /// No description provided for @fieldConfirmPasswordLabel.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar senha'**
  String get fieldConfirmPasswordLabel;

  /// No description provided for @btnCadastrar.
  ///
  /// In pt, this message translates to:
  /// **'Cadastrar'**
  String get btnCadastrar;

  /// No description provided for @orCreateAccountWith.
  ///
  /// In pt, this message translates to:
  /// **'ou crie conta com'**
  String get orCreateAccountWith;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In pt, this message translates to:
  /// **'Já tem conta?'**
  String get alreadyHaveAccount;

  /// No description provided for @loginNow.
  ///
  /// In pt, this message translates to:
  /// **'Faça seu login!'**
  String get loginNow;

  /// No description provided for @defaultFieldName.
  ///
  /// In pt, this message translates to:
  /// **'Campo'**
  String get defaultFieldName;

  /// No description provided for @validatorEmailRequired.
  ///
  /// In pt, this message translates to:
  /// **'Email é obrigatório'**
  String get validatorEmailRequired;

  /// No description provided for @validatorEmailInvalid.
  ///
  /// In pt, this message translates to:
  /// **'Email inválido'**
  String get validatorEmailInvalid;

  /// No description provided for @validatorPasswordRequired.
  ///
  /// In pt, this message translates to:
  /// **'Senha é obrigatória'**
  String get validatorPasswordRequired;

  /// No description provided for @validatorPasswordMinLength.
  ///
  /// In pt, this message translates to:
  /// **'Senha deve ter pelo menos {minLength} caracteres'**
  String validatorPasswordMinLength(int minLength);

  /// No description provided for @validatorConfirmPasswordRequired.
  ///
  /// In pt, this message translates to:
  /// **'Confirmação de senha é obrigatória'**
  String get validatorConfirmPasswordRequired;

  /// No description provided for @validatorPasswordsDontMatch.
  ///
  /// In pt, this message translates to:
  /// **'As senhas não coincidem'**
  String get validatorPasswordsDontMatch;

  /// No description provided for @validatorNameRequired.
  ///
  /// In pt, this message translates to:
  /// **'Nome é obrigatório'**
  String get validatorNameRequired;

  /// No description provided for @validatorFullNameRequired.
  ///
  /// In pt, this message translates to:
  /// **'Digite seu nome completo'**
  String get validatorFullNameRequired;

  /// No description provided for @validatorNameTooShort.
  ///
  /// In pt, this message translates to:
  /// **'Nome muito curto'**
  String get validatorNameTooShort;

  /// No description provided for @validatorFieldRequired.
  ///
  /// In pt, this message translates to:
  /// **'{field} é obrigatório'**
  String validatorFieldRequired(String field);

  /// No description provided for @validatorMinLength.
  ///
  /// In pt, this message translates to:
  /// **'{field} deve ter pelo menos {minLength} caracteres'**
  String validatorMinLength(String field, int minLength);

  /// No description provided for @validatorMaxLength.
  ///
  /// In pt, this message translates to:
  /// **'{field} deve ter no máximo {maxLength} caracteres'**
  String validatorMaxLength(String field, int maxLength);

  /// No description provided for @searchHint.
  ///
  /// In pt, this message translates to:
  /// **'Digite o que você procura'**
  String get searchHint;

  /// No description provided for @errorLoadingPosts.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao carregar posts'**
  String get errorLoadingPosts;

  /// No description provided for @noPostsFound.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum post encontrado'**
  String get noPostsFound;

  /// No description provided for @beFirstToPublish.
  ///
  /// In pt, this message translates to:
  /// **'Seja o primeiro a publicar!'**
  String get beFirstToPublish;

  /// No description provided for @errorLoadingProfile.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao carregar perfil'**
  String get errorLoadingProfile;

  /// No description provided for @userNotFound.
  ///
  /// In pt, this message translates to:
  /// **'Usuário não encontrado'**
  String get userNotFound;

  /// No description provided for @tabMyProjects.
  ///
  /// In pt, this message translates to:
  /// **'Meus projetos'**
  String get tabMyProjects;

  /// No description provided for @tabApproved.
  ///
  /// In pt, this message translates to:
  /// **'Aprovados'**
  String get tabApproved;

  /// No description provided for @noProjectsYet.
  ///
  /// In pt, this message translates to:
  /// **'Você ainda não tem projetos'**
  String get noProjectsYet;

  /// No description provided for @shareYourProjects.
  ///
  /// In pt, this message translates to:
  /// **'Compartilhe seus projetos!'**
  String get shareYourProjects;

  /// No description provided for @noSharedProjects.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum projeto compartilhado'**
  String get noSharedProjects;

  /// No description provided for @offlineBanner.
  ///
  /// In pt, this message translates to:
  /// **'Sem conexão — mostrando dados salvos'**
  String get offlineBanner;

  /// No description provided for @avatarUploadSoon.
  ///
  /// In pt, this message translates to:
  /// **'Upload de avatar em breve...'**
  String get avatarUploadSoon;

  /// No description provided for @editPostTitle.
  ///
  /// In pt, this message translates to:
  /// **'Editar Post'**
  String get editPostTitle;

  /// No description provided for @newProjectTitle.
  ///
  /// In pt, this message translates to:
  /// **'Novo Projeto'**
  String get newProjectTitle;

  /// No description provided for @selectCoverImage.
  ///
  /// In pt, this message translates to:
  /// **'Por favor, selecione uma imagem de capa'**
  String get selectCoverImage;

  /// No description provided for @postUpdatedSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Post atualizado com sucesso!'**
  String get postUpdatedSuccess;

  /// No description provided for @postPublishedSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Post publicado com sucesso!'**
  String get postPublishedSuccess;

  /// No description provided for @errorPublishingPost.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao publicar post'**
  String get errorPublishingPost;

  /// No description provided for @confirmDeleteTitle.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar exclusão'**
  String get confirmDeleteTitle;

  /// No description provided for @confirmDeletePostMessage.
  ///
  /// In pt, this message translates to:
  /// **'Tem certeza que deseja excluir este post?'**
  String get confirmDeletePostMessage;

  /// No description provided for @postDeletedSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Post excluído com sucesso!'**
  String get postDeletedSuccess;

  /// No description provided for @errorDeletingPost.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao excluir post'**
  String get errorDeletingPost;

  /// No description provided for @loadImage.
  ///
  /// In pt, this message translates to:
  /// **'Carregar imagem'**
  String get loadImage;

  /// No description provided for @projectNameLabel.
  ///
  /// In pt, this message translates to:
  /// **'Nome do projeto'**
  String get projectNameLabel;

  /// No description provided for @projectNameHint.
  ///
  /// In pt, this message translates to:
  /// **'React fácil de usar'**
  String get projectNameHint;

  /// No description provided for @fieldTitleRequired.
  ///
  /// In pt, this message translates to:
  /// **'Por favor, insira o título'**
  String get fieldTitleRequired;

  /// No description provided for @descriptionLabel.
  ///
  /// In pt, this message translates to:
  /// **'Descrição'**
  String get descriptionLabel;

  /// No description provided for @descriptionHint.
  ///
  /// In pt, this message translates to:
  /// **'Descreva seu projeto...'**
  String get descriptionHint;

  /// No description provided for @fieldDescriptionRequired.
  ///
  /// In pt, this message translates to:
  /// **'Por favor, insira a descrição'**
  String get fieldDescriptionRequired;

  /// No description provided for @tagsLabel.
  ///
  /// In pt, this message translates to:
  /// **'Tags'**
  String get tagsLabel;

  /// No description provided for @tagsHint.
  ///
  /// In pt, this message translates to:
  /// **'React'**
  String get tagsHint;

  /// No description provided for @fieldTagsRequired.
  ///
  /// In pt, this message translates to:
  /// **'Por favor, insira as tags'**
  String get fieldTagsRequired;

  /// No description provided for @takePhoto.
  ///
  /// In pt, this message translates to:
  /// **'Tirar foto'**
  String get takePhoto;

  /// No description provided for @chooseFromGallery.
  ///
  /// In pt, this message translates to:
  /// **'Escolher da galeria'**
  String get chooseFromGallery;

  /// No description provided for @cameraPermissionDenied.
  ///
  /// In pt, this message translates to:
  /// **'Permissão de câmera negada.'**
  String get cameraPermissionDenied;

  /// No description provided for @cameraPermissionPermanentlyDenied.
  ///
  /// In pt, this message translates to:
  /// **'Permissão de câmera negada. Habilite nas configurações do app.'**
  String get cameraPermissionPermanentlyDenied;

  /// No description provided for @noCameraAvailable.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma câmera disponível neste dispositivo'**
  String get noCameraAvailable;

  /// No description provided for @cameraInitError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao inicializar a câmera: {error}'**
  String cameraInitError(String error);

  /// No description provided for @cameraCaptureError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao capturar a foto: {error}'**
  String cameraCaptureError(String error);

  /// No description provided for @daysAgo.
  ///
  /// In pt, this message translates to:
  /// **'{count}d atrás'**
  String daysAgo(int count);

  /// No description provided for @hoursAgo.
  ///
  /// In pt, this message translates to:
  /// **'{count}h atrás'**
  String hoursAgo(int count);

  /// No description provided for @minutesAgo.
  ///
  /// In pt, this message translates to:
  /// **'{count}min atrás'**
  String minutesAgo(int count);

  /// No description provided for @justNow.
  ///
  /// In pt, this message translates to:
  /// **'Agora'**
  String get justNow;

  /// No description provided for @errorConnectionTimeout.
  ///
  /// In pt, this message translates to:
  /// **'Tempo de conexão esgotado. Verifique sua internet.'**
  String get errorConnectionTimeout;

  /// No description provided for @errorReceiveTimeout.
  ///
  /// In pt, this message translates to:
  /// **'Tempo de resposta esgotado. Tente novamente.'**
  String get errorReceiveTimeout;

  /// No description provided for @errorConnection.
  ///
  /// In pt, this message translates to:
  /// **'Erro de conexão. Verifique sua internet.'**
  String get errorConnection;

  /// No description provided for @errorInvalidData.
  ///
  /// In pt, this message translates to:
  /// **'Dados inválidos. Verifique as informações.'**
  String get errorInvalidData;

  /// No description provided for @errorWrongCredentials.
  ///
  /// In pt, this message translates to:
  /// **'Email ou senha incorretos.'**
  String get errorWrongCredentials;

  /// No description provided for @errorAccessDenied.
  ///
  /// In pt, this message translates to:
  /// **'Acesso negado.'**
  String get errorAccessDenied;

  /// No description provided for @errorEmailAlreadyUsed.
  ///
  /// In pt, this message translates to:
  /// **'Este email já está cadastrado.'**
  String get errorEmailAlreadyUsed;

  /// No description provided for @errorInvalidDataShort.
  ///
  /// In pt, this message translates to:
  /// **'Dados inválidos.'**
  String get errorInvalidDataShort;

  /// No description provided for @errorServer.
  ///
  /// In pt, this message translates to:
  /// **'Erro no servidor. Tente novamente mais tarde.'**
  String get errorServer;

  /// No description provided for @errorGeneric.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao processar a requisição. Tente novamente.'**
  String get errorGeneric;

  /// No description provided for @errorSessionExpired.
  ///
  /// In pt, this message translates to:
  /// **'Sessão expirada. Faça login novamente.'**
  String get errorSessionExpired;

  /// No description provided for @errorNoPermission.
  ///
  /// In pt, this message translates to:
  /// **'Você não tem permissão para realizar esta ação.'**
  String get errorNoPermission;

  /// No description provided for @errorPostNotFound.
  ///
  /// In pt, this message translates to:
  /// **'Post não encontrado.'**
  String get errorPostNotFound;

  /// No description provided for @errorFileTooLarge.
  ///
  /// In pt, this message translates to:
  /// **'Arquivo muito grande. Escolha uma imagem menor.'**
  String get errorFileTooLarge;

  /// No description provided for @errorLogin.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao fazer login. Tente novamente.'**
  String get errorLogin;

  /// No description provided for @errorRegister.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao criar conta. Tente novamente.'**
  String get errorRegister;

  /// No description provided for @errorUpdateAvatar.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao atualizar avatar'**
  String get errorUpdateAvatar;

  /// No description provided for @errorOfflineNoCache.
  ///
  /// In pt, this message translates to:
  /// **'Sem conexão e nenhum dado salvo localmente'**
  String get errorOfflineNoCache;

  /// No description provided for @errorFetchPosts.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao buscar posts'**
  String get errorFetchPosts;

  /// No description provided for @errorLikePost.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao curtir post #{id}'**
  String errorLikePost(int id);

  /// No description provided for @errorCreatePost.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao criar post'**
  String get errorCreatePost;

  /// No description provided for @errorUpdatePost.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao atualizar post #{id}'**
  String errorUpdatePost(int id);

  /// No description provided for @errorDeletePost.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao excluir post #{id}'**
  String errorDeletePost(int id);

  /// No description provided for @devsNearYouTitle.
  ///
  /// In pt, this message translates to:
  /// **'Devs por perto'**
  String get devsNearYouTitle;

  /// No description provided for @shareLocationButton.
  ///
  /// In pt, this message translates to:
  /// **'Compartilhar minha localização'**
  String get shareLocationButton;

  /// No description provided for @locationSharedSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Localização compartilhada com sucesso!'**
  String get locationSharedSuccess;

  /// No description provided for @errorSharingLocation.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao compartilhar localização'**
  String get errorSharingLocation;

  /// No description provided for @locationPermissionDeniedMessage.
  ///
  /// In pt, this message translates to:
  /// **'Permissão de localização negada. Não é possível mostrar devs próximos.'**
  String get locationPermissionDeniedMessage;

  /// No description provided for @locationServiceDisabledMessage.
  ///
  /// In pt, this message translates to:
  /// **'Ative o serviço de localização do dispositivo.'**
  String get locationServiceDisabledMessage;

  /// No description provided for @errorGettingLocation.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao obter sua localização'**
  String get errorGettingLocation;

  /// No description provided for @errorLoadingNearbyDevs.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao carregar devs próximos'**
  String get errorLoadingNearbyDevs;

  /// No description provided for @noDevsNearby.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum dev encontrado por perto'**
  String get noDevsNearby;

  /// No description provided for @kmAway.
  ///
  /// In pt, this message translates to:
  /// **'{km} km de você'**
  String kmAway(String km);

  /// No description provided for @viewProfile.
  ///
  /// In pt, this message translates to:
  /// **'Ver perfil'**
  String get viewProfile;

  /// No description provided for @memberSince.
  ///
  /// In pt, this message translates to:
  /// **'Membro desde {date}'**
  String memberSince(String date);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
