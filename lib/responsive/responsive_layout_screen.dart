import 'package:flutter/material.dart';
import 'package:instagram_by_ary/providers/user_provider.dart';
import 'package:instagram_by_ary/utils/global_variables.dart';
import 'package:provider/provider.dart';

class ResponsiveLatout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLatout(
      {Key? key,
      required this.webScreenLayout,
      required this.mobileScreenLayout})
      : super(key: key);

  @override
  State<ResponsiveLatout> createState() => _ResponsiveLatoutState();
}

class _ResponsiveLatoutState extends State<ResponsiveLatout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          return widget.webScreenLayout;
        } else {
          return widget.mobileScreenLayout;
        }
      },
    );
  }
}
