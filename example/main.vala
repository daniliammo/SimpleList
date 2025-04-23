using SimpleList;


public abstract class Program {

    private static LazyCompactingList<int?> list;


    public static int main() {
        list = new LazyCompactingList<int?> ();

        for (int i = 0; i < 5; i++) {
            list.add(2);
        }

        list.safe_set(0, 3); // Безопасная запись. Если вы не уверены в правильности индекса.

        print_list();
        return 0;
    }

    public static void print_list() {
        foreach (int item in list.items) {
            print(@"(foreach) item: $item\n");
        }

        for (int i = 0; i < list.items.length; i++) {
            var currentItem = list.items[i];
            print(@"(for) item $i: $currentItem\n");
        }

        print("safe get index 1: " + list.safe_get(1).to_string() + "\n"); // Безопасное получение. Если не уверены в правильности индекса.

        print("list size: " + list.size.to_string() + "\n");
    }
}
