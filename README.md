# Suggest a feature

<p align="center">
  <a href="https://pub.dartlang.org/packages/suggest_a_feature">
    <img alt="Pub" src="https://img.shields.io/pub/v/suggest_a_feature" />
  </a>
  <a href="https://github.com/What-the-Flutter/Suggest-a-Feature/actions/workflows/build.yml?query=workflow%3ABuild">
    <img alt="Build Status" src="https://github.com/What-the-Flutter/Suggest-a-Feature/actions/workflows/build.yml/badge.svg?event=push"/>
  </a>
  <a href="https://www.codefactor.io/repository/github/what-the-flutter/suggest-a-feature">
    <img alt="CodeFactor" src="https://www.codefactor.io/repository/github/what-the-flutter/suggest-a-feature/badge"/>
  </a>
</p>

This Flutter package is a ready-made module which allows other developers to implement additional
menu in their own mobile app where users can share their suggestions about the application in real
time, discuss them with others, and vote for each other's suggestions.

You can check interactive example [here](https://what-the-flutter.github.io/Suggest-a-Feature/#/).

A small demo:

![gif](https://raw.githubusercontent.com/What-the-Flutter/Suggest-a-Feature/master/example/assets/suggest_a_feature.gif)

## Usage

At first, you need to implement `SuggestionsDataSource`. This is an interface which we use to handle
all the data-layer logic. There you can add the connection to your DB.

If you use [firestore](https://firebase.google.cn/docs/firestore?hl=en) as a data source, you can
use our ready-made implementation [Suggest a feature Firestore](https://pub.dev/packages/suggest_a_feature_firestore).

Then you need to move the `SuggestionsPage`. For example:

``` dart
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => SuggestionsPage(
      userId: '1',
      suggestionsDataSource: MyDataSource(
        userId: '1',
      ),
      theme: SuggestionsTheme.initial(),
      onUploadMultiplePhotos: null,
      onSaveToGallery: null,
      onGetUserById: () {},
    ),
  ),
);
```

If you want to give a user the ability to attach photos to suggestions and save them to the gallery,
you just need to implement the `onUploadMultiplePhotos` and `onSaveToGallery` methods.

You can also either use our standard theme or create your own:

``` dart
theme: SuggestionsTheme().copyWith(...),
```

## Admin functionality

Admin functionality allows you to edit any suggestion (e.g change its' status) and to leave comments from the 'Admin'.

A small demo:

![gif](https://raw.githubusercontent.com/What-the-Flutter/Suggest-a-Feature/master/example/assets/suggest_a_feature_admin.gif)

In order to enable admin functionality, you should specify the `adminSettings` and set `isAdmin` to `true`:

``` dart
SuggestionsPage(
  isAdmin: true,
  adminSettings: const AdminSettings(
    id: '3',
    username: 'Admin',
  ),
);
```

## Localization

At the moment the package supports 3 languages: English, Russian and Ukrainian.

``` dart
MaterialApp(
  home: SuggestionsPage(),
  localizationsDelegates: [
    SuggestionsLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
  ],
);
```

- `SuggestionsLocalizations` - strings localization
- `GlobalMaterialLocalizations`- date format localization

You also have to invoke [initializeDateFormatting()](https://api.flutter.dev/flutter/date_symbol_data_local/initializeDateFormatting.html) before `MaterialApp()` widget creation in order to support date formatting.

``` dart
initializeDateFormatting();
return MaterialApp(
  home: SuggestionsPage(),
);
```

## Essential checks

For each suggestion and comment manipulation (updating or deleting) we recommend to check whether
user has author rights to commit those actions. Author rights concept is as follows: the user who
has created a suggestion/comment is the only one who can delete or update it. If it somehow happens
that a user without author rights tries to delete/update a suggestion, an Exception will be thrown.
`onGetUserById()` function in `SuggestionsPage` constructor will help you with this.