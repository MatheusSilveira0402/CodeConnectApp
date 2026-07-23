// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'CodeConnect';

  @override
  String get navFeed => 'Feed';

  @override
  String get navPerfil => 'Perfil';

  @override
  String get navDevsNearYou => 'Devs';

  @override
  String get navSobreNos => 'Sobre nós';

  @override
  String get navSair => 'Sair';

  @override
  String get btnPublicar => 'Publicar';

  @override
  String get btnCancelar => 'Cancelar';

  @override
  String get btnRetry => 'Tentar novamente';

  @override
  String get btnDelete => 'Excluir';

  @override
  String get btnDiscard => 'Descartar';

  @override
  String get btnUpdate => 'Atualizar';

  @override
  String get logoutTitle => 'Sair';

  @override
  String get logoutMessage => 'Deseja realmente sair?';

  @override
  String logoutError(String error) {
    return 'Erro ao fazer logout: $error';
  }

  @override
  String get sobreNosWelcome => 'Bem-Vindo ao\nCodeConnect!';

  @override
  String get sobreNosSubtitle => 'Onde a comunidade\ne o código se unem!';

  @override
  String get sobreNosIntro =>
      'No coração da revolução digital está o CodeConnect nasceu da visão de criar um espaço onde desenvolvedores e apaixonados e entusiastas da tecnologia podem se conectar, aprender e colaborar de maneira inigualável! Somos uma comunidade global apaixonada, por código e comprometidos em oferecer um ambiente inclusivo e acolhedor para todos os níveis de habilidade.';

  @override
  String get sobreNosMissionTitle => 'Nossa Missão';

  @override
  String get sobreNosMissionText =>
      'Na CodeConnect, acreditamos que a colaboração é a essência da inovação. Nossa missão é fornecer uma plataforma onde as mentes criativas podem se unir, compartilhar conhecimento, e desenvolver projetos extraordinários. Quer você seja um novato ansioso para aprender ou um veterano experiente, você encontrará aqui um lar para suas aspirações tecnológicas.';

  @override
  String get sobreNosJoinTitle => 'Junte-se a Nós!';

  @override
  String get sobreNosJoinText =>
      'Estamos animados para ter você conosco nesta jornada empolgante. Junte-se à nossa comunidade vibrante e descubra o poder da colaboração no mundo do código';

  @override
  String get sobreNosFooter =>
      'Juntos, vamos transformar ideias em inovações e moldar o futuro digital.';

  @override
  String get loginWelcome => 'Bem-vindo! Faça seu login';

  @override
  String get fieldEmailOrUsernameLabel => 'Email ou usuário';

  @override
  String get fieldEmailHint => 'Digite seu email';

  @override
  String get fieldPasswordLabel => 'Senha';

  @override
  String get rememberMe => 'Lembrar-me';

  @override
  String get forgotPassword => 'Esqueci a senha';

  @override
  String get forgotPasswordSnack => 'Recuperação de senha em breve...';

  @override
  String get btnLogin => 'Login';

  @override
  String get orContinueWith => 'ou continue com';

  @override
  String get githubLabel => 'GitHub';

  @override
  String get googleLabel => 'Google';

  @override
  String get noAccountYet => 'Ainda não tem conta?';

  @override
  String get signUpNow => 'Cadastre-se!';

  @override
  String get cadastroTitle => 'Cadastro';

  @override
  String get cadastroSubtitle => 'Olá! Preencha seus dados';

  @override
  String get fieldNameLabel => 'Nome';

  @override
  String get fieldNameHint => 'Nome completo';

  @override
  String get fieldEmailAddressLabel => 'Endereço de email';

  @override
  String get fieldConfirmPasswordLabel => 'Confirmar senha';

  @override
  String get btnCadastrar => 'Cadastrar';

  @override
  String get orCreateAccountWith => 'ou crie conta com';

  @override
  String get alreadyHaveAccount => 'Já tem conta?';

  @override
  String get loginNow => 'Faça seu login!';

  @override
  String get defaultFieldName => 'Campo';

  @override
  String get validatorEmailRequired => 'Email é obrigatório';

  @override
  String get validatorEmailInvalid => 'Email inválido';

  @override
  String get validatorPasswordRequired => 'Senha é obrigatória';

  @override
  String validatorPasswordMinLength(int minLength) {
    return 'Senha deve ter pelo menos $minLength caracteres';
  }

  @override
  String get validatorConfirmPasswordRequired =>
      'Confirmação de senha é obrigatória';

  @override
  String get validatorPasswordsDontMatch => 'As senhas não coincidem';

  @override
  String get validatorNameRequired => 'Nome é obrigatório';

  @override
  String get validatorFullNameRequired => 'Digite seu nome completo';

  @override
  String get validatorNameTooShort => 'Nome muito curto';

  @override
  String validatorFieldRequired(String field) {
    return '$field é obrigatório';
  }

  @override
  String validatorMinLength(String field, int minLength) {
    return '$field deve ter pelo menos $minLength caracteres';
  }

  @override
  String validatorMaxLength(String field, int maxLength) {
    return '$field deve ter no máximo $maxLength caracteres';
  }

  @override
  String get searchHint => 'Digite o que você procura';

  @override
  String get errorLoadingPosts => 'Erro ao carregar posts';

  @override
  String get noPostsFound => 'Nenhum post encontrado';

  @override
  String get beFirstToPublish => 'Seja o primeiro a publicar!';

  @override
  String get errorLoadingProfile => 'Erro ao carregar perfil';

  @override
  String get userNotFound => 'Usuário não encontrado';

  @override
  String get tabMyProjects => 'Meus projetos';

  @override
  String get tabApproved => 'Aprovados';

  @override
  String get noProjectsYet => 'Você ainda não tem projetos';

  @override
  String get shareYourProjects => 'Compartilhe seus projetos!';

  @override
  String get noSharedProjects => 'Nenhum projeto compartilhado';

  @override
  String get offlineBanner => 'Sem conexão — mostrando dados salvos';

  @override
  String get avatarUploadSoon => 'Upload de avatar em breve...';

  @override
  String get editPostTitle => 'Editar Post';

  @override
  String get newProjectTitle => 'Novo Projeto';

  @override
  String get selectCoverImage => 'Por favor, selecione uma imagem de capa';

  @override
  String get postUpdatedSuccess => 'Post atualizado com sucesso!';

  @override
  String get postPublishedSuccess => 'Post publicado com sucesso!';

  @override
  String get errorPublishingPost => 'Erro ao publicar post';

  @override
  String get confirmDeleteTitle => 'Confirmar exclusão';

  @override
  String get confirmDeletePostMessage =>
      'Tem certeza que deseja excluir este post?';

  @override
  String get postDeletedSuccess => 'Post excluído com sucesso!';

  @override
  String get errorDeletingPost => 'Erro ao excluir post';

  @override
  String get loadImage => 'Carregar imagem';

  @override
  String get projectNameLabel => 'Nome do projeto';

  @override
  String get projectNameHint => 'React fácil de usar';

  @override
  String get fieldTitleRequired => 'Por favor, insira o título';

  @override
  String get descriptionLabel => 'Descrição';

  @override
  String get descriptionHint => 'Descreva seu projeto...';

  @override
  String get fieldDescriptionRequired => 'Por favor, insira a descrição';

  @override
  String get tagsLabel => 'Tags';

  @override
  String get tagsHint => 'React';

  @override
  String get fieldTagsRequired => 'Por favor, insira as tags';

  @override
  String get takePhoto => 'Tirar foto';

  @override
  String get chooseFromGallery => 'Escolher da galeria';

  @override
  String get cameraPermissionDenied => 'Permissão de câmera negada.';

  @override
  String get cameraPermissionPermanentlyDenied =>
      'Permissão de câmera negada. Habilite nas configurações do app.';

  @override
  String get noCameraAvailable => 'Nenhuma câmera disponível neste dispositivo';

  @override
  String cameraInitError(String error) {
    return 'Erro ao inicializar a câmera: $error';
  }

  @override
  String cameraCaptureError(String error) {
    return 'Erro ao capturar a foto: $error';
  }

  @override
  String daysAgo(int count) {
    return '${count}d atrás';
  }

  @override
  String hoursAgo(int count) {
    return '${count}h atrás';
  }

  @override
  String minutesAgo(int count) {
    return '${count}min atrás';
  }

  @override
  String get justNow => 'Agora';

  @override
  String get errorConnectionTimeout =>
      'Tempo de conexão esgotado. Verifique sua internet.';

  @override
  String get errorReceiveTimeout =>
      'Tempo de resposta esgotado. Tente novamente.';

  @override
  String get errorConnection => 'Erro de conexão. Verifique sua internet.';

  @override
  String get errorInvalidData => 'Dados inválidos. Verifique as informações.';

  @override
  String get errorWrongCredentials => 'Email ou senha incorretos.';

  @override
  String get errorAccessDenied => 'Acesso negado.';

  @override
  String get errorEmailAlreadyUsed => 'Este email já está cadastrado.';

  @override
  String get errorInvalidDataShort => 'Dados inválidos.';

  @override
  String get errorServer => 'Erro no servidor. Tente novamente mais tarde.';

  @override
  String get errorGeneric => 'Erro ao processar a requisição. Tente novamente.';

  @override
  String get errorSessionExpired => 'Sessão expirada. Faça login novamente.';

  @override
  String get errorNoPermission =>
      'Você não tem permissão para realizar esta ação.';

  @override
  String get errorPostNotFound => 'Post não encontrado.';

  @override
  String get errorFileTooLarge =>
      'Arquivo muito grande. Escolha uma imagem menor.';

  @override
  String get errorLogin => 'Erro ao fazer login. Tente novamente.';

  @override
  String get errorRegister => 'Erro ao criar conta. Tente novamente.';

  @override
  String get errorUpdateAvatar => 'Erro ao atualizar avatar';

  @override
  String get errorOfflineNoCache =>
      'Sem conexão e nenhum dado salvo localmente';

  @override
  String get errorFetchPosts => 'Erro ao buscar posts';

  @override
  String errorLikePost(int id) {
    return 'Erro ao curtir post #$id';
  }

  @override
  String get errorCreatePost => 'Erro ao criar post';

  @override
  String errorUpdatePost(int id) {
    return 'Erro ao atualizar post #$id';
  }

  @override
  String errorDeletePost(int id) {
    return 'Erro ao excluir post #$id';
  }

  @override
  String get devsNearYouTitle => 'Devs por perto';

  @override
  String get shareLocationButton => 'Compartilhar minha localização';

  @override
  String get locationSharedSuccess => 'Localização compartilhada com sucesso!';

  @override
  String get errorSharingLocation => 'Erro ao compartilhar localização';

  @override
  String get locationPermissionDeniedMessage =>
      'Permissão de localização negada. Não é possível mostrar devs próximos.';

  @override
  String get locationServiceDisabledMessage =>
      'Ative o serviço de localização do dispositivo.';

  @override
  String get errorGettingLocation => 'Erro ao obter sua localização';

  @override
  String get errorLoadingNearbyDevs => 'Erro ao carregar devs próximos';

  @override
  String get noDevsNearby => 'Nenhum dev encontrado por perto';

  @override
  String kmAway(String km) {
    return '$km km de você';
  }

  @override
  String get viewProfile => 'Ver perfil';

  @override
  String memberSince(String date) {
    return 'Membro desde $date';
  }
}
