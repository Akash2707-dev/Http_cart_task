import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/progress_provider.dart';
import '../widgets/custom_progress_indicator.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  void _startProgress(BuildContext context, WidgetRef ref) {
    ref.read(progressProvider.notifier).state = 0.0;

    Future.delayed(Duration.zero, () {
      final controller = ref.read(progressProvider.notifier);

      for (int i = 1; i <= 100; i++) {
        Future.delayed(Duration(milliseconds: 60 * i), () {
          controller.state = i / 100;
        });
      }
    });
  }

  void _showCompletionDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Completed"),
          content: const Text("The progress has reached 100%!"),
          actions: [
            TextButton(
              onPressed: () {
                ref.read(progressProvider.notifier).state = 0.0;
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Circular Progress Indicator")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomProgressIndicator(
              fillColor: Colors.blue,
              unfilledColor: Colors.grey,
              onComplete: () => _showCompletionDialog(context, ref),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _startProgress(context, ref);
              },
              child: const Text("Start"),
            ),
          ],
        ),
      ),
    );
  }
}
