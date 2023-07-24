import 'package:image_picker/image_picker.dart';

class FolderControl {
  final picker = ImagePicker();
  List<String> video = <String>[];

  Future<List<String>> getVideoPath() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final ImagePicker _picker = ImagePicker();

    try {
      final XFile? videoFile =
          await _picker.pickVideo(source: ImageSource.gallery);
      if (videoFile != null) {
        video.add(videoFile.path);
        video.add(videoFile.name);
        return video;
      } else {
        // ignore: avoid_print
        print('No video selected');
        return [];
      }
    } catch (e) {
      // ignore: avoid_print
      print('e:${e.toString()}');
      return [];
    }
  }
}
