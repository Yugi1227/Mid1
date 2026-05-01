public class TestCalculator {
    public static void main(String[] args) {
        Calculator calc = new Calculator();

        if (calc.add(5, 5) != 10) {
            throw new AssertionError("Addition test failed");
        }

        if (calc.subtract(5, 2) != 3) {
            throw new AssertionError("Subtraction test failed");
        }

        System.out.println("All calculator tests passed");
    }
}
