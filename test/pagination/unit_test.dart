import 'package:flutter_test/flutter_test.dart';

import 'package:flutter2_practice/src/pagination/pagination.dart';

void main() {
  group('Pagination', () {
    test('rightMaxNumber', () {
      expect(Pagination.rightMaxNumber(1, 1), 1);
      expect(Pagination.rightMaxNumber(1, 10), 10);
      expect(Pagination.rightMaxNumber(1, 11), 10);
      expect(Pagination.rightMaxNumber(6, 6), 6);
      expect(Pagination.rightMaxNumber(6, 7), 7);
      expect(Pagination.rightMaxNumber(6, 10), 10);
      expect(Pagination.rightMaxNumber(6, 11), 10);

      expect(Pagination.rightMaxNumber(7, 7), 7);
      expect(Pagination.rightMaxNumber(7, 8), 8);
      expect(Pagination.rightMaxNumber(7, 10), 10);
      expect(Pagination.rightMaxNumber(7, 11), 11);
      expect(Pagination.rightMaxNumber(7, 100), 11);
    });

    test('pagination', () {
      expect(Pagination.pagination(1, 1), [1]);
      expect(Pagination.pagination(1, 3), [1, 2, 3]);
      expect(Pagination.pagination(1, 10), [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
      expect(Pagination.pagination(1, 11), [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);

      expect(Pagination.pagination(6, 6), [1, 2, 3, 4, 5, 6]);
      expect(Pagination.pagination(6, 7), [1, 2, 3, 4, 5, 6, 7]);
      expect(Pagination.pagination(6, 10), [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
      expect(Pagination.pagination(6, 11), [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);

      expect(Pagination.pagination(7, 7), [1, 2, 3, 4, 5, 6, 7]);
      expect(Pagination.pagination(7, 8), [1, 2, 3, 4, 5, 6, 7, 8]);
      expect(Pagination.pagination(7, 10), [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
      expect(Pagination.pagination(7, 11), [2, 3, 4, 5, 6, 7, 8, 9, 10, 11]);
      expect(Pagination.pagination(7, 12), [2, 3, 4, 5, 6, 7, 8, 9, 10, 11]);
      expect(Pagination.pagination(7, 100), [2, 3, 4, 5, 6, 7, 8, 9, 10, 11]);

      expect(Pagination.pagination(14, 20),
          [9, 10, 11, 12, 13, 14, 15, 16, 17, 18]);
    });
  });
}
