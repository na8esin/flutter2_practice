import 'dart:math';

class Pagination {
  // 一度に画面に表示できる最大のページ数
  static const max = 10;

  static int maxHalf() => (max / 2).floor();
  static int centerLeftDiff() => maxHalf() - 1;

  static List<int> pagination(int selectedPage, int pageMax) {
    if (pageMax < selectedPage) {
      throw Exception('selectedPage must be less than or equal to pageMax');
    }

    // 右の最大ページが決まれば1に到達するか10個までカウントする
    List<int> pagination = [];
    for (var i = rightMaxNumber(selectedPage, pageMax); i > 0; i--) {
      if (pagination.length == max) {
        break;
      }
      pagination.add(i);
    }

    // for文の条件を反転させればreverseしなくてもいいと思うが
    // そうなると最小値を求めないといけなくなる
    return pagination.reversed.toList();
  }

  static int rightMaxNumber(int selectedPage, int pageMax) {
    int rightMaxNumber = 0;

    // 今回の例で言うと6ページを境に動作が変わる
    if (selectedPage <= maxHalf() + 1) {
      rightMaxNumber = min(pageMax, max);
    } else {
      rightMaxNumber = min(selectedPage + maxHalf() - 1, pageMax);
    }

    return rightMaxNumber;
  }
}
