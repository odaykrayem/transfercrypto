import 'package:flutter/material.dart';
import '../models/navbar_item_model.dart';
import '../routes/sub_routes.dart';

List<NavBarItemModel> navigationItemsList = [
  NavBarItemModel(
    title: 'home',
    navigationPath: SubRoutes.home,
    iconData: Icons.home_work_rounded,
    index: 0,
  ),
  NavBarItemModel(
    title: 'transactions',
    navigationPath: SubRoutes.transactions,
    iconData: Icons.list_alt_rounded,
    index: 1,
  ),
  NavBarItemModel(
    title: 'aboutUs',
    navigationPath: SubRoutes.about,
    iconData: Icons.info_outline_rounded,
    index: 2,
  ),
  NavBarItemModel(
    title: 'transferNow',
    navigationPath: SubRoutes.guide,
    iconData: Icons.menu_book_rounded,
    index: 3,
  ),
];
