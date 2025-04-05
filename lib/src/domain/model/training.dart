// トレーニング記録のドメインモデル
class Training {
  /// トレーニングID
  int id = 0;

  /// ユーザーID
  String userId = '';

  /// タイトル
  String title = '';

  /// 詳細
  String detail = '';

  /// コンストラクタ
  Training({
    required this.id,
    required this.userId,
    required this.title,
    required this.detail,
  });
}
