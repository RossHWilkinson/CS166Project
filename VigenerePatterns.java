import java.io.*;
import java.lang.reflect.Array;
import java.util.Arrays;
import java.util.Scanner;
public class VigenerePatterns {

	public static void main(String args[])
	{
		int len = 0;
		char [] input = new char [10000];
		
		File file = new File("input.txt");
		Scanner scanner = null;
		try {
			scanner = new Scanner(file);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		String content = null;
		try {
			content = new Scanner(new File("input.txt")).useDelimiter("\\Z").next();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		input = content.toCharArray();
		
		len = content.length();
		char [] check = new char [10];
		for(int point = 0; point < len - 2; point++)
		{
			check[0] = input[point];
			check[1] = input[point + 1];
			check[2] = input[point + 2];
			int similar = 0;

			for(int inputPoint = 0; inputPoint < len - 2; inputPoint++)
			{
				

				if( (check[0]== input[inputPoint]) && (check[1] == input[inputPoint + 1]) && (check[2] == input[inputPoint + 2]) )
				{
					similar++;
					if(similar > 1)
					{
						System.out.println(String.valueOf(input[inputPoint]) + String.valueOf(input[inputPoint + 1]) + String.valueOf(input[inputPoint + 2]));
					}
				}
			}
		}
	}

	private static int readInArray(char[] input) throws FileNotFoundException 
	{
		File file = new File("input.txt");
		Scanner scanner = null;
		try {
			scanner = new Scanner(file);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		String content = new Scanner(new File("input.txt")).useDelimiter("\\Z").next();
		System.out.println(content);
		input = content.toCharArray();
		return content.length();
	}
}



