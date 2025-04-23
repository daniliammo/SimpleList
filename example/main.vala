using SimpleList;


public abstract class Program {

    private static LazyCompactingList<int?> list;


    public static int main() {
        list = new LazyCompactingList<int?> ();

        for (int i = 0; i < 18; i++) {
            list.add(52);
        }

        list.safe_set(0, 42);

        print_list();
        return 0;
    }

    public static void print_list() {
        foreach (int item in list.items) {
            print(@"item: $item\n");
        }

        for (int i = 0; i < list.items.length; i++) {
            print(@"item $i: " + list.items[i].to_string() + "\n");
        }

        print("size: " + list.size.to_string() + "\n");
    }
}
