// Path variable
const String INITIAL = '/';
const String HOME = 'home';
const String LOGIN = 'login';
const String SING_UP = 'sing-up';
const String NEW_PASSWORD = 'new-password';
const String PERSONAL = 'personal';
const String GUSTOS = 'gustos';
const String ADD_PAGE = 'add-page';
const String CHATS = 'chats';
const String CHAT_PERSONAL = 'chat-personal';
const String OTHER_USER = 'other-user';
const String SETTINGS = 'settings';
const String DETAILS = 'details';
const String PERMISOS = 'permisos';

// Call variable

const String URL_BASE = 'us-central1-sporth-c3c47.cloudfunctions.net';

/// PATH VARIABLE {
///  idUser,
///  idOtherUser
/// }
/// 
/// RETURN boolean
const String ANY_CHAT_USER = 'any_chat_user';

/// RETURN json
const String CHAT_ALL = 'chat_all';

/// PATH VARIABLE {
///   idEvent
/// }
/// 
/// RETURN json
const String CHAT_BY_EVENT = 'chat_by_event';

/// BODY {
///   chat
/// }
/// 
/// RETURN void
const String CHAT_SAVE = 'chat_save';

/// PATH VARIABLE {
///   idChat
/// }
/// 
/// BODY {
///   chat
/// }
/// 
/// RETURN void
const String CHAT_UPDATE = 'chat_update';

/// RETURN json
const String EVENT_ALL = 'event_all';

/// PATH VARIABLE {
///  idEvent,
///  idUser
/// }
/// 
/// RETURN void
const String EVENT_INSCRIBE = 'event_inscribe';

/// PATH VARIABLE {
///   idEvent
/// }
/// 
/// RETURN json
const String EVENT_ONE = 'event_one';

/// BODY {
///   event
/// }
/// 
/// RETURN void
const String EVENT_SAVE = 'event_save';

/// PATH VARIABLE {
///   idAnfitrion
/// }
/// 
/// RETURN json
const String EVENTS_BY_ANFITRION = 'events_by_anfitrion';

/// PATH VARIABLE {
///   idChat
/// }
/// 
/// RETURN json
const String MESSAGE_BY_CHAT = 'message_by_chat';

/// PATH VARIABLE {
///   idChat
/// }
/// 
/// BODY {
///   message
/// }
/// 
/// RETURN void
const String MESSAGE_SAVE = 'message_save';

/// PATH VARIABLE {
///   idFollower
/// }
/// 
/// BODY {
///   user
/// }
/// 
/// RETURN void
const String SEGUIDOR_DEGRADE = 'seguidor_degrade';

/// PATH VARIABLE {
///   idFollower
/// }
/// 
/// BODY {
///   user
/// }
/// 
/// RETURN void
const String SEGUIDOR_UPGRADE = 'seguidor_upgrade';

/// PATH VARIABLE {
///   idUser
/// }
/// 
/// RETURN json
const String USER_EXISTS = 'user_exists';

/// PATH VARIABLE {
///   idLogro
/// }
/// 
/// BODY {
///   user
/// }
/// 
/// RETURN void
const String USER_LOGRO = 'user_logro';

/// PATH VARIABLE {
///   idUser
/// }
/// 
/// RETURN json
const String USER_ONE = 'user_one';

/// BODY {
///   user
/// }
/// 
/// RETURN void
const String USER_SAVE = 'user_save';

/// BODY {
///   user
/// }
/// 
/// RETURN void
const String USER_UPDATE = 'user_update';

/// PATH VARIABLE {
///   username
/// }
/// 
/// RETURN json
const String USERNAME_EXISTS = 'username_exists';