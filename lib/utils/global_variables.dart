import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_by_ary/screens/add_post_screen.dart';
import 'package:instagram_by_ary/screens/feed_screen.dart';
import 'package:instagram_by_ary/screens/notifications_screen.dart';
import 'package:instagram_by_ary/screens/profile_screen.dart';
import 'package:instagram_by_ary/screens/searh_screen.dart';

const webScreenSize = 600;

final List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const NotificationsScreen(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
