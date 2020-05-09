(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)

{%dependencies.inc}

{---put your views-related dependencies registration here---}
container.add('fileReader', TStringFileReaderFactory.create());
container.add('tplParser', TTemplateParserFactory.create());
container.add('homeView', THomeViewFactory.create());
container.add('sendmailView', TSendMailViewFactory.create());
