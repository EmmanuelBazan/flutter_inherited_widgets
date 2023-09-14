import 'package:flutter/material.dart';
import 'package:flutter_inherited_widgets/stateManager/notifier.dart';

class Provider<T extends Notifier> extends StatefulWidget {
  final Widget child;
  //* an function like parameter to get only one instance of <T extends notifier>
  final T Function() create;

  const Provider({
    super.key,
    required this.child,
    required this.create,
  });

  @override
  State<Provider<T>> createState() => _ProviderState<T>();

  static T of<T extends Notifier>(BuildContext context) {
    final provider =
        context.findAncestorWidgetOfExactType<_InheritedWidget<T>>();

    assert(provider != null);

    return provider!.notifier;
  }
}

class _ProviderState<T extends Notifier> extends State<Provider<T>> {
  //* this variable is for use the same instance of the class that will extend from Notifier
  late final T _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = widget.create();
  }

  @override
  void dispose() {
    // ignore: invalid_use_of_protected_member
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedWidget(
      notifier: _notifier,
      child: widget.child,
    );
  }
}

//^ Inherited widget
class _InheritedWidget<T extends Notifier> extends InheritedWidget {
  final T notifier;

  const _InheritedWidget({
    Key? key,
    required Widget child,
    required this.notifier,
  }) : super(
          child: child,
          key: key,
        );

  @override
  bool updateShouldNotify(_) {
    return false;
  }
}
