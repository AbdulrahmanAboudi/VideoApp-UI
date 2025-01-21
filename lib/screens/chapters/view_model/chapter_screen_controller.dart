import 'package:get/get_state_manager/get_state_manager.dart';

class ChapterScreenController extends GetxController {
  Map<String, int>? selectedSection;

  void selectSection(int chapterIndex, int sectionIndex) {
    selectedSection = {
      'chapterIndex': chapterIndex,
      'sectionIndex': sectionIndex,
    };
    update();
  }
}
