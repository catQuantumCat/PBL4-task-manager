import 'package:flutter/widgets.dart';

class LazyIndexedStack extends StatefulWidget {
  const LazyIndexedStack(
      {super.key, required this.index, this.children = const []});

  final int index;
  final List<Widget> children;

  @override
  State<LazyIndexedStack> createState() => _LazyIndexedStackState();
}

class _LazyIndexedStackState extends State<LazyIndexedStack> {
  late final List<bool> _activatedWidget;

  @override
  void initState() {
    super.initState();

    _activatedWidget =
        List.generate(widget.children.length, (i) => i == widget.index);
  }

  @override
  void didUpdateWidget(covariant LazyIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.index != widget.index && !_activatedWidget[widget.index]) {
      _activatedWidget[widget.index] = true;
    }
  }

  List<Widget> get children {
    return List.generate(
        widget.children.length,
        (i) => _activatedWidget[i] == true
            ? widget.children[i]
            : const SizedBox.shrink());
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: widget.index,
      children: children,
    );
  }
}
