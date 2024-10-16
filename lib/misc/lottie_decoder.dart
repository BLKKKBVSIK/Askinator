import 'package:lottie/lottie.dart';

Future<LottieComposition?> customDecoder(List<int> bytes) => LottieComposition.decodeZip(
      bytes,
      filePicker: (files) => files.firstWhere(
        (f) => f.name.startsWith('animations/') && f.name.endsWith('.json'),
      ),
    );
