namespace SimpleList {
    // All indexes always correct
    public class LazyCompactingList<T>: SimpleList<T> {

        public LazyCompactingList.from_array (T[] array)
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
}
