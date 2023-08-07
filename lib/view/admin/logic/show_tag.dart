import 'package:navi_station/view/user/tag_show_logic.dart';

class tagFunction {
  // 出発地点の名前を取得
  static Future<void> fetchStartNames(Tag tags, List<String> startName, List<String> tmpStartName) async {
    List<String> names = await tags.StartNameTitle();
    startName.clear(); // リストをクリアしてから新しい要素を追加(必須)(必須)
    startName.addAll(names); // 新しい要素を追加
    tmpStartName.clear(); // リストをクリアしてから新しい要素を追加(必須)
    tmpStartName.addAll(startName); // tmpStartNameにstartNameの内容をコピー
  }

  // 出発地点の詳細を取得
  static Future<void> fetchStartInfo(Tag tags, Map<String, dynamic> startNames) async {
    Map<String, dynamic> names = await tags.StartNameInfo();
    startNames.clear(); // リストをクリアしてから新しい要素を追加(必須)
    startNames.addAll(names); // 新しい要素を追加
  }

  // 到着地点の名前を取得
  static Future<void> fetchGoalNames(Tag tags, List<String> goalName, List<String> tmpGoalName) async {
    List<String> names = await tags.GoalNames();
    goalName.clear(); // リストをクリアしてから新しい要素を追加(必須)
    goalName.addAll(names); // 新しい要素を追加
    tmpGoalName.clear(); // リストをクリアしてから新しい要素を追加(必須)
    tmpGoalName.addAll(goalName); // tmpGoalNameにgoalNameの内容をコピー
  }

  // 到着地点の詳細を取得
  static Future<void> fetchGoalInfo(Tag tags, Map<String, dynamic> goalNames) async {
    Map<String, dynamic> names = await tags.GoalNamesInfo();
    goalNames.clear(); // リストをクリアしてから新しい要素を追加(必須)
    goalNames.addAll(names); // 新しい要素を追加
  }

  // 手段の詳細を取得
  static Future<void> fetchMethodNames(Tag tags, List<String> methodNames) async {
    List<String> names = await tags.methodName();
    methodNames.clear(); // リストをクリアしてから新しい要素を追加(必須)
    methodNames.addAll(names);  // 新しい要素を追加
  }

  // アイコンの画像パスを取得
  static Future<void> fetchTagIcon(Tag tags, Map<String, dynamic> tagIcon) async {
    Map<String, dynamic> names = await tags.TagIcon();
    tagIcon.clear(); // リストをクリアしてから新しい要素を追加(必須)
    tagIcon.addAll(names);  // 新しい要素を追加
  }
}