import 'package:flutter/material.dart';

class DefaultSpace extends StatelessWidget {
  const DefaultSpace({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}
