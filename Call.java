public class Call {
    public long fn(int value) {
        if (value <= 1) {
            return value;
        } else {
            return fn(value - 1) * value;
        }
    }

    public static void main(String[] args) {
        Call call = new Call();
        System.out.println(call.fn(10));
    }
}
