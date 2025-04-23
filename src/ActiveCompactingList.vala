namespace SimpleList {

    public class AutoCompactingList<T>: SimpleList<T> {

        public AutoCompactingList.from_array (T[] array) {
            base.from_array (array);
        }

        public override void compact () {
            // Находим первый null с конца массива
            int last_non_null_index = items.length - 1;
            while (last_non_null_index >= 0 && items[last_non_null_index] == null) {
                last_non_null_index--;
            }

            // Все элементы null
            if (last_non_null_index < 0) {
                size = 0;
                return;
            }

            // Проверяем, есть ли null в середине массива
            bool has_null_in_middle = false;
            for (int i = 0; i <= last_non_null_index; i++) {
                if (items[i] == null) {
                    has_null_in_middle = true;
                    break;
                }
            }

            if (!has_null_in_middle) {
                // Null только в конце - просто уменьшаем размер
                size = last_non_null_index + 1;
            } else {
                // Null есть в середине - перестраиваем массив
                var new_items = new T[last_non_null_index + 1];
                int new_index = 0;

                for (int i = 0; i <= last_non_null_index; i++) {
                    if (items[i] != null) {
                        new_items[new_index++] = items[i];
                    }
                }

                // Корректируем размер на случай, если пропустили какие-то null
                if (new_index < new_items.length) {
                    new_items.resize (new_index);
                }

                items = new_items;
                size = items.length;
            }
        }
    }
}
