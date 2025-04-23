/* SimpleList.vala
 *
 * Copyright 2025 Daniliammo
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

namespace SimpleList {

    protected class SimpleList<T> {
        public T?[] items;

        public int size {
            public get { return items.length; }
            protected set { items.resize (value); }
        }

        public T last { public get { return items[this.size - 1]; } }


        protected SimpleList.from_array (T?[] array)
        {
            this.items = array;
        }

        public T ? safe_get (int index) {
            assert_if_invalid_index (index);
            return items[index];
        }

        public void safe_set (int index, T item) {
            assert_if_invalid_index (index);
            items[index] = item;
        }

        public void add (T value) {
            size += 1;
            items[size - 1] = value;
        }

        protected void assert_if_invalid_index (int index) {
            assert (index >= 0 && index < items.length);
        }

        public void remove_at (int index) {
            assert_if_invalid_index (index);
            items[index] = null; // Помечаем элемент как null
            compact (); // Немедленно уплотняем массив
        }

        public virtual void compact () {}
    }

    // All indexes always correct
    public class LazyCompactingList<T>: SimpleList<T?> {

        public LazyCompactingList.from_array (T?[] array)
        {
            base.from_array (array);
        }

        public override void compact () {
            int nullVariablesCount = 0;

            for (int i = items.length - 1; i >= 0; i--) {
                if (items[i] == null) {
                    nullVariablesCount++;
                }
                if (items[i] != null) {
                    break;
                }
            }
            size -= nullVariablesCount;
        }
    }

    public class AutoCompactingList<T>: SimpleList<T?> {

        public AutoCompactingList.from_array (T?[] array)
        {
            base.from_array (array);
        }

        public override void compact () {
            int first_null_at = -1; // Позиция первого null в массиве
            int non_null_count = 0; // Количество не-null элементов

            // Находим первый null и считаем не-null элементы
            for (int i = 0; i < items.length; i++) {
                if (items[i] == null) {
                    if (first_null_at == -1) {
                        first_null_at = i;
                    }
                } else {
                    non_null_count++;
                }
            }

            // Если null только в конце, просто ресайзим массив
            if (first_null_at == non_null_count) {
                size = non_null_count;
                return;
            }

            // Если null внутри массива, пересобираем его
            if (first_null_at != -1 && first_null_at < non_null_count) {
                var new_items = new T[non_null_count];
                int new_index = 0;

                for (int i = 0; i < items.length; i++) {
                    if (items[i] != null) {
                        new_items[new_index++] = items[i];
                    }
                }

                items = new_items;
            }
        }
    }
}
