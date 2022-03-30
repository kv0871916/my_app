// ignore_for_file: cast_nullable_to_non_nullable

import 'package:flutter/material.dart';
import 'package:my_app/main_home/views/body/home_body.dart';
import 'package:my_app/main_home/views/bottombar/home_bottom_bar.dart';

final mytabs = <String, Map<String, Widget>>{
  'home': <String, Widget>{
    'header': const Tab(
      text: 'Home',
    ),
    'body': const CustomBody(
      text: 'Home',
      url: 'https://krishworks.com',
    ),
    'commanbottom': const CustomBottom(),
  },
  'aboutus': <String, Widget>{
    'header': const Tab(
      text: 'About us',
    ),
    'body': const CustomBody(
      text: 'About us',
      url: 'https://krishworks.com/about/',
    ),
    'commanbottom': const CustomBottom(),
  },
  'updates': <String, Widget>{
    'header': const Tab(
      text: 'Updates',
    ),
    'body': const CustomBody(
      text: 'Updates',
      url: 'https://krishworks.com/updates/',
    ),
    'commanbottom': const CustomBottom(),
  },
};
final myTabsHeader = <Widget>[
  mytabs['home']?['header'] as Tab,
  mytabs['aboutus']?['header'] as Tab,
  mytabs['updates']?['header'] as Tab,
];
final myTabsBody = <Widget>[
  mytabs['home']?['body'] as Widget,
  mytabs['aboutus']?['body'] as Widget,
  mytabs['updates']?['body'] as Widget,
];
final myTabsBottomNavigationBar = <Widget>[
  mytabs['home']?['commanbottom'] as Widget,
  mytabs['aboutus']?['commanbottom'] as Widget,
  mytabs['updates']?['commanbottom'] as Widget,
];

final mysettingtabs = <String, Map<String, Widget>>{
  'gallery': <String, Widget>{
    'header': const Tab(
      text: 'Gallery',
    ),
    'body': const CustomBody(
      text: 'Gallery',
      url: 'https://krishworks.com/gallery/',
    ),
    'commanbottom': const CustomBottom(),
  },
  'contactus': <String, Widget>{
    'header': const Tab(
      text: 'Contact us',
    ),
    'body': const CustomBody(
      text: 'Contact us',
      url: 'https://krishworks.com/contact/',
    ),
    'commanbottom': const CustomBottom(),
  },
};
final mysettingtabsHeader = <Widget>[
  mysettingtabs['gallery']?['header'] as Tab,
  mysettingtabs['contactus']?['header'] as Tab,
];
final mysettingtabsBody = <Widget>[
  mysettingtabs['gallery']?['body'] as Widget,
  mysettingtabs['contactus']?['body'] as Widget,
];
final mysettingtabsSidebar = <Widget>[
  mysettingtabs['gallery']?['commanbottom'] as Widget,
  mysettingtabs['contactus']?['commanbottom'] as Widget,
];
