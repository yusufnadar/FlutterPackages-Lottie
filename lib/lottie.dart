import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottiePage extends StatefulWidget {
  const LottiePage({Key? key}) : super(key: key);

  @override
  _LottiePageState createState() => _LottiePageState();
}

class _LottiePageState extends State<LottiePage>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
    controller!.addStatusListener((status) {
      if (status == AnimationStatus.reverse) {
        Future.delayed(const Duration(seconds: 2)).then((value) {
          Navigator.pop(context);
          controller!.reset();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lottie Package'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      content: Lottie.asset(
                        'assets/loading.json',
                        controller: controller,
                        onLoaded: (composition) {
                          controller!..duration = composition.duration
                            ..forward();
                        },
                      ),
                    ));
          },
          child: Lottie.network(
              'https://assets7.lottiefiles.com/packages/lf20_dyiqnus5.json',
              errorBuilder: (context, object, trace) {
            return Text(object.toString());
          }, repeat: true, reverse: true),
        ),
      ),
    );
  }
}
