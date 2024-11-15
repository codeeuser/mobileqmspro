// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `MobileQMS Pro`
  String get title {
    return Intl.message(
      'MobileQMS Pro',
      name: 'title',
      desc: 'The application title',
      args: [],
    );
  }

  /// `Text`
  String get text {
    return Intl.message(
      'Text',
      name: 'text',
      desc: '',
      args: [],
    );
  }

  /// `Board Setting`
  String get boardSetting {
    return Intl.message(
      'Board Setting',
      name: 'boardSetting',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get selectLanguage {
    return Intl.message(
      'Select Language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Background Color`
  String get backgroundColor {
    return Intl.message(
      'Background Color',
      name: 'backgroundColor',
      desc: '',
      args: [],
    );
  }

  /// `Text Color`
  String get textColor {
    return Intl.message(
      'Text Color',
      name: 'textColor',
      desc: '',
      args: [],
    );
  }

  /// `Number Of Token Box`
  String get numberOfTokenBox {
    return Intl.message(
      'Number Of Token Box',
      name: 'numberOfTokenBox',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Token Number`
  String get tokenNumber {
    return Intl.message(
      'Token Number',
      name: 'tokenNumber',
      desc: '',
      args: [],
    );
  }

  /// `Print Token`
  String get printToken {
    return Intl.message(
      'Print Token',
      name: 'printToken',
      desc: '',
      args: [],
    );
  }

  /// `Proceed to Counter`
  String get proceedToCounter {
    return Intl.message(
      'Proceed to Counter',
      name: 'proceedToCounter',
      desc: '',
      args: [],
    );
  }

  /// `Please Wait`
  String get pleaseWait {
    return Intl.message(
      'Please Wait',
      name: 'pleaseWait',
      desc: '',
      args: [],
    );
  }

  /// `Counter`
  String get counter {
    return Intl.message(
      'Counter',
      name: 'counter',
      desc: '',
      args: [],
    );
  }

  /// `Created`
  String get createdDate {
    return Intl.message(
      'Created',
      name: 'createdDate',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get statusQueue {
    return Intl.message(
      'Status',
      name: 'statusQueue',
      desc: '',
      args: [],
    );
  }

  /// `Current Token`
  String get currentToken {
    return Intl.message(
      'Current Token',
      name: 'currentToken',
      desc: '',
      args: [],
    );
  }

  /// `My Queue`
  String get myQueue {
    return Intl.message(
      'My Queue',
      name: 'myQueue',
      desc: '',
      args: [],
    );
  }

  /// `Mark Complete`
  String get markComplete {
    return Intl.message(
      'Mark Complete',
      name: 'markComplete',
      desc: '',
      args: [],
    );
  }

  /// `Mark as Completed`
  String get markAsCompleted {
    return Intl.message(
      'Mark as Completed',
      name: 'markAsCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Re-Call`
  String get recall {
    return Intl.message(
      'Re-Call',
      name: 'recall',
      desc: '',
      args: [],
    );
  }

  /// `Call Token`
  String get callToken {
    return Intl.message(
      'Call Token',
      name: 'callToken',
      desc: '',
      args: [],
    );
  }

  /// `Issue Token`
  String get issueToken {
    return Intl.message(
      'Issue Token',
      name: 'issueToken',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message(
      'More',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `More Options`
  String get moreOptions {
    return Intl.message(
      'More Options',
      name: 'moreOptions',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Print QR Code`
  String get printQRCode {
    return Intl.message(
      'Print QR Code',
      name: 'printQRCode',
      desc: '',
      args: [],
    );
  }

  /// `Pair Code`
  String get pairCode {
    return Intl.message(
      'Pair Code',
      name: 'pairCode',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Feedback`
  String get feedback {
    return Intl.message(
      'Feedback',
      name: 'feedback',
      desc: '',
      args: [],
    );
  }

  /// `MobileQMS Board Pad App`
  String get mobileqmsBoardPadApp {
    return Intl.message(
      'MobileQMS Board Pad App',
      name: 'mobileqmsBoardPadApp',
      desc: '',
      args: [],
    );
  }

  /// `Server Started`
  String get serverStarted {
    return Intl.message(
      'Server Started',
      name: 'serverStarted',
      desc: '',
      args: [],
    );
  }

  /// `Server Stopped`
  String get serverStopped {
    return Intl.message(
      'Server Stopped',
      name: 'serverStopped',
      desc: '',
      args: [],
    );
  }

  /// `Setup Language`
  String get setupLanguage {
    return Intl.message(
      'Setup Language',
      name: 'setupLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Setup the Stall`
  String get setupTheStall {
    return Intl.message(
      'Setup the Stall',
      name: 'setupTheStall',
      desc: '',
      args: [],
    );
  }

  /// `Setup Printer`
  String get setupPrinter {
    return Intl.message(
      'Setup Printer',
      name: 'setupPrinter',
      desc: '',
      args: [],
    );
  }

  /// `Completed Token`
  String get completedTokens {
    return Intl.message(
      'Completed Token',
      name: 'completedTokens',
      desc: '',
      args: [],
    );
  }

  /// `Reset Token Number`
  String get resetTokenNumber {
    return Intl.message(
      'Reset Token Number',
      name: 'resetTokenNumber',
      desc: '',
      args: [],
    );
  }

  /// `Visit us at`
  String get visitUsAt {
    return Intl.message(
      'Visit us at',
      name: 'visitUsAt',
      desc: '',
      args: [],
    );
  }

  /// `Terms of use`
  String get termsOfUse {
    return Intl.message(
      'Terms of use',
      name: 'termsOfUse',
      desc: '',
      args: [],
    );
  }

  /// `Privacy`
  String get privacy {
    return Intl.message(
      'Privacy',
      name: 'privacy',
      desc: '',
      args: [],
    );
  }

  /// `Current Window Name`
  String get currentWindowName {
    return Intl.message(
      'Current Window Name',
      name: 'currentWindowName',
      desc: '',
      args: [],
    );
  }

  /// `App Name`
  String get appName {
    return Intl.message(
      'App Name',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Package Name`
  String get packageName {
    return Intl.message(
      'Package Name',
      name: 'packageName',
      desc: '',
      args: [],
    );
  }

  /// `Build Number`
  String get buildNumber {
    return Intl.message(
      'Build Number',
      name: 'buildNumber',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Display the Running Queue Number`
  String get displayTheRunningQueueNumber {
    return Intl.message(
      'Display the Running Queue Number',
      name: 'displayTheRunningQueueNumber',
      desc: '',
      args: [],
    );
  }

  /// `You should Setup the Printer before use`
  String get youShouldSetupPrinter {
    return Intl.message(
      'You should Setup the Printer before use',
      name: 'youShouldSetupPrinter',
      desc: '',
      args: [],
    );
  }

  /// `Device`
  String get device {
    return Intl.message(
      'Device',
      name: 'device',
      desc: '',
      args: [],
    );
  }

  /// `Connect`
  String get connect {
    return Intl.message(
      'Connect',
      name: 'connect',
      desc: '',
      args: [],
    );
  }

  /// `Disconnect`
  String get disconnect {
    return Intl.message(
      'Disconnect',
      name: 'disconnect',
      desc: '',
      args: [],
    );
  }

  /// `Test Print`
  String get testPrint {
    return Intl.message(
      'Test Print',
      name: 'testPrint',
      desc: '',
      args: [],
    );
  }

  /// `Font Scale`
  String get fontScale {
    return Intl.message(
      'Font Scale',
      name: 'fontScale',
      desc: '',
      args: [],
    );
  }

  /// `Page Size`
  String get pageSize {
    return Intl.message(
      'Page Size',
      name: 'pageSize',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Setup Window`
  String get setupWindow {
    return Intl.message(
      'Setup Window',
      name: 'setupWindow',
      desc: '',
      args: [],
    );
  }

  /// `Enable Window`
  String get enableWindow {
    return Intl.message(
      'Enable Window',
      name: 'enableWindow',
      desc: '',
      args: [],
    );
  }

  /// `Edit Window`
  String get editWindow {
    return Intl.message(
      'Edit Window',
      name: 'editWindow',
      desc: '',
      args: [],
    );
  }

  /// `Open Service List`
  String get openServiceList {
    return Intl.message(
      'Open Service List',
      name: 'openServiceList',
      desc: '',
      args: [],
    );
  }

  /// `Move Up`
  String get moveUp {
    return Intl.message(
      'Move Up',
      name: 'moveUp',
      desc: '',
      args: [],
    );
  }

  /// `Move Down`
  String get moveDown {
    return Intl.message(
      'Move Down',
      name: 'moveDown',
      desc: '',
      args: [],
    );
  }

  /// `Edit Service`
  String get editService {
    return Intl.message(
      'Edit Service',
      name: 'editService',
      desc: '',
      args: [],
    );
  }

  /// `Service List`
  String get serviceList {
    return Intl.message(
      'Service List',
      name: 'serviceList',
      desc: '',
      args: [],
    );
  }

  /// `Service Form`
  String get serviceForm {
    return Intl.message(
      'Service Form',
      name: 'serviceForm',
      desc: '',
      args: [],
    );
  }

  /// `Service Name`
  String get serviceName {
    return Intl.message(
      'Service Name',
      name: 'serviceName',
      desc: '',
      args: [],
    );
  }

  /// `Service Letter`
  String get serviceLetter {
    return Intl.message(
      'Service Letter',
      name: 'serviceLetter',
      desc: '',
      args: [],
    );
  }

  /// `Start Number`
  String get startNumber {
    return Intl.message(
      'Start Number',
      name: 'startNumber',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Window Form`
  String get windowForm {
    return Intl.message(
      'Window Form',
      name: 'windowForm',
      desc: '',
      args: [],
    );
  }

  /// `Window Name`
  String get windowName {
    return Intl.message(
      'Window Name',
      name: 'windowName',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Window Wizard`
  String get windowWizard {
    return Intl.message(
      'Window Wizard',
      name: 'windowWizard',
      desc: '',
      args: [],
    );
  }

  /// `Service Wizard`
  String get serviceWizard {
    return Intl.message(
      'Service Wizard',
      name: 'serviceWizard',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Window`
  String get window {
    return Intl.message(
      'Window',
      name: 'window',
      desc: '',
      args: [],
    );
  }

  /// `Service`
  String get service {
    return Intl.message(
      'Service',
      name: 'service',
      desc: '',
      args: [],
    );
  }

  /// `Add Logo`
  String get addLogo {
    return Intl.message(
      'Add Logo',
      name: 'addLogo',
      desc: '',
      args: [],
    );
  }

  /// `Remove Logo`
  String get removeLogo {
    return Intl.message(
      'Remove Logo',
      name: 'removeLogo',
      desc: '',
      args: [],
    );
  }

  /// `Open Image Galerry`
  String get openImageGalerry {
    return Intl.message(
      'Open Image Galerry',
      name: 'openImageGalerry',
      desc: '',
      args: [],
    );
  }

  /// `Open Camera`
  String get openCamera {
    return Intl.message(
      'Open Camera',
      name: 'openCamera',
      desc: '',
      args: [],
    );
  }

  /// `Add Printer`
  String get addPrinter {
    return Intl.message(
      'Add Printer',
      name: 'addPrinter',
      desc: '',
      args: [],
    );
  }

  /// `Do You Accept`
  String get doYouAccept {
    return Intl.message(
      'Do You Accept',
      name: 'doYouAccept',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Add Service`
  String get addService {
    return Intl.message(
      'Add Service',
      name: 'addService',
      desc: '',
      args: [],
    );
  }

  /// `Add Window`
  String get addWindow {
    return Intl.message(
      'Add Window',
      name: 'addWindow',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message(
      'Dashboard',
      name: 'dashboard',
      desc: '',
      args: [],
    );
  }

  /// `Windows`
  String get windows {
    return Intl.message(
      'Windows',
      name: 'windows',
      desc: '',
      args: [],
    );
  }

  /// `App Info`
  String get appInfo {
    return Intl.message(
      'App Info',
      name: 'appInfo',
      desc: '',
      args: [],
    );
  }

  /// `Token List`
  String get tokenList {
    return Intl.message(
      'Token List',
      name: 'tokenList',
      desc: '',
      args: [],
    );
  }

  /// `Server`
  String get server {
    return Intl.message(
      'Server',
      name: 'server',
      desc: '',
      args: [],
    );
  }

  /// `Share Token Info`
  String get shareTokenInfo {
    return Intl.message(
      'Share Token Info',
      name: 'shareTokenInfo',
      desc: '',
      args: [],
    );
  }

  /// `Appearance dark mode`
  String get appearance {
    return Intl.message(
      'Appearance dark mode',
      name: 'appearance',
      desc: '',
      args: [],
    );
  }

  /// `Mark All As Completed`
  String get markAllAsCompleted {
    return Intl.message(
      'Mark All As Completed',
      name: 'markAllAsCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Permission`
  String get permission {
    return Intl.message(
      'Permission',
      name: 'permission',
      desc: '',
      args: [],
    );
  }

  /// `Send SMS`
  String get sendSms {
    return Intl.message(
      'Send SMS',
      name: 'sendSms',
      desc: '',
      args: [],
    );
  }

  /// `In App Purchase`
  String get inAppPurchase {
    return Intl.message(
      'In App Purchase',
      name: 'inAppPurchase',
      desc: '',
      args: [],
    );
  }

  /// `Already Purchased`
  String get alreadyPurchased {
    return Intl.message(
      'Already Purchased',
      name: 'alreadyPurchased',
      desc: '',
      args: [],
    );
  }

  /// `Purchased Record`
  String get purchasedRecord {
    return Intl.message(
      'Purchased Record',
      name: 'purchasedRecord',
      desc: '',
      args: [],
    );
  }

  /// `Mark All As Timeout`
  String get markAllAsTimeout {
    return Intl.message(
      'Mark All As Timeout',
      name: 'markAllAsTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Token Action`
  String get tokenAction {
    return Intl.message(
      'Token Action',
      name: 'tokenAction',
      desc: '',
      args: [],
    );
  }

  /// `Recall Token`
  String get recallToken {
    return Intl.message(
      'Recall Token',
      name: 'recallToken',
      desc: '',
      args: [],
    );
  }

  /// `Timeout`
  String get timeout {
    return Intl.message(
      'Timeout',
      name: 'timeout',
      desc: '',
      args: [],
    );
  }

  /// `Timeout Token`
  String get timeoutToken {
    return Intl.message(
      'Timeout Token',
      name: 'timeoutToken',
      desc: '',
      args: [],
    );
  }

  /// `Wizard Project`
  String get wizardProject {
    return Intl.message(
      'Wizard Project',
      name: 'wizardProject',
      desc: '',
      args: [],
    );
  }

  /// `Drop Database`
  String get dropDatabase {
    return Intl.message(
      'Drop Database',
      name: 'dropDatabase',
      desc: '',
      args: [],
    );
  }

  /// `No Action`
  String get noAction {
    return Intl.message(
      'No Action',
      name: 'noAction',
      desc: '',
      args: [],
    );
  }

  /// `Exit Application`
  String get exitApplication {
    return Intl.message(
      'Exit Application',
      name: 'exitApplication',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Create a Demo Project`
  String get createDemoProject {
    return Intl.message(
      'Create a Demo Project',
      name: 'createDemoProject',
      desc: '',
      args: [],
    );
  }

  /// `Proceed`
  String get proceed {
    return Intl.message(
      'Proceed',
      name: 'proceed',
      desc: '',
      args: [],
    );
  }

  /// `Running Tokens`
  String get runningTokens {
    return Intl.message(
      'Running Tokens',
      name: 'runningTokens',
      desc: '',
      args: [],
    );
  }

  /// `Loading`
  String get loading {
    return Intl.message(
      'Loading',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Passcode`
  String get passcode {
    return Intl.message(
      'Passcode',
      name: 'passcode',
      desc: '',
      args: [],
    );
  }

  /// `Invalid`
  String get invalid {
    return Intl.message(
      'Invalid',
      name: 'invalid',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'messages'),
      Locale.fromSubtags(languageCode: 'ms'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
