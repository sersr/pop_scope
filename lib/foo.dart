import 'package:flutter/material.dart';

class FooPage extends StatefulWidget {
  const FooPage({super.key});

  @override
  State<FooPage> createState() => _FooPageState();
}

class _FooPageState extends State<FooPage> {
  // 状态
  final popState = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final child = AnimatedBuilder(
      animation: popState,
      builder: (context, child) {
        return PopScope(
          canPop: popState.value,
          onPopInvoked: (didPop) {
            if (didPop) {
              return;
            }
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('更改状态才能退出,当前状态: ${popState.value}')));
          },
          child: ElevatedButton(
            child: Text('更改状态: ${popState.value}'),
            onPressed: () {
              popState.value = !popState.value;
              if (popState.value) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('按下返回按钮退出。')));
              }
            },
          ),
        );
      },
    );

    final mapPop = ElevatedButton(
      onPressed: () {
        Navigator.maybePop(context);
        if (!popState.value) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('更改状态才能退出,当前状态: ${popState.value}')));
        }
      },
      child: const Text('系统返回和mayPop一样'),
    );

    final pop = ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text('pop()直接返回'),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Foo page'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //...
            child,
            //...
            const SizedBox(height: 20),
            mapPop,
            const SizedBox(height: 20),
            pop,
          ],
        ),
      ),
    );
  }
}
