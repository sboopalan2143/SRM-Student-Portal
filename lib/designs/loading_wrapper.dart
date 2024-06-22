import 'package:sample/designs/_designs.dart';
import 'package:flutter/material.dart';

class LoadingWrapper extends StatelessWidget {
  const LoadingWrapper({
    required this.child,
    required this.isLoading,
    super.key,
  });

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading == true)
          Stack(
            children: [
              ModalBarrier(
                dismissible: false,
                color:
                    Theme.of(context).colorScheme.background.withOpacity(0.3),
              ),
              Center(
                child:
                    CircularProgressIndicators.primaryColorProgressIndication,
              ),
            ],
          ),
      ],
    );
  }
}
