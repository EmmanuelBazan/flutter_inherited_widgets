import 'package:flutter/material.dart';
import 'package:flutter_inherited_widgets/stateManager/notifier.dart';
import 'package:flutter_inherited_widgets/stateManager/provider.dart';

class Consumer<T extends Notifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T notifier) builder;

  const Consumer({
    super.key,
    required this.builder,
  });

  @override
  State<Consumer<T>> createState() => _ConsumerState<T>();
}

class _ConsumerState<T extends Notifier> extends State<Consumer<T>> {
  late final T _notifier;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
  }

  //* didChangeDependencies could be execute more than only one time, so we need to handle this case
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _notifier = Provider.of(context);
      _notifier.addListener(_listener);
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _notifier.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _notifier);
  }
}
