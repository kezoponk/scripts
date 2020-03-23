import java.util.Arrays;
import java.util.Scanner;

public class bytesorter {

    static int index = 0;
    static int lang = 0;
    static byte Bytes[] = new byte[200];
    static byte unsortedBytes[] = new byte[200];
    static String unsortedStrings[] = new String[200];
    static String sortedBytes[] = new String[100];

    static int realLength(String[] arr) {
        int count = 0;
        for (String out : arr) {
            try {
                if (out.isBlank()) return count;
            } catch (NullPointerException e) {
                return count;
            }
            count++;
        }
        return count;
    }

    static String javaSplitter(String line) {
        String splittedLine[] = line.split(" 0b");
        String trimmed = "";

        for (String character : splittedLine[1].split("")) {
            if(character.equals(")") || character.equals(" ")) break;
            trimmed += character;
        }
        if (trimmed.split("").length < 2) {
            System.out.println("Invalid byte selection");
            System.exit(1);
        }
        return trimmed;
    }

    static void getBytes(String line) {

        switch (lang) {
            case 1:
                Bytes[index] = (byte) (-1*Byte.parseByte(javaSplitter(line), 2));
                break;
            case 2: break;
        }

        unsortedStrings[index] = line;
        unsortedBytes[index] = Bytes[index];
        index++;
    }

    static void sortBytes() {
        int index = 0, lineIndex = 0;
        Arrays.sort(Bytes);

        while(index<realLength(unsortedStrings)) {
            System.out.println(index);
            lineIndex = 0;

            for (int unsortedByte: unsortedBytes) {
                if((byte) Bytes[index] == unsortedByte) {
                    sortedBytes[index] = unsortedStrings[lineIndex];
                    break;
                }
                lineIndex++;
            }
            index++;
        }

        for (String line: sortedBytes) {
            if(line == null) break;
            System.out.println(line);
        }
    }

    public static void main(String[] args) {
        System.out.println("Available Options:\n(1)Java\n");
        System.out.print("Language: ");

        Scanner scanner = new Scanner(System.in);
        try {
            lang = Integer.parseInt(scanner.nextLine());
        } catch (NumberFormatException e) {
            System.out.println("Invalid option");
        }

        System.out.println("Paste if selection with bytes to sort, press space -> enter when finished");
        scanner.useDelimiter("\n");
        try {
            scanner.forEachRemaining(line -> getBytes(line));
        } catch (ArrayIndexOutOfBoundsException e) {
            System.out.println("\nResult: \n");
        }

        sortBytes();
    }
}