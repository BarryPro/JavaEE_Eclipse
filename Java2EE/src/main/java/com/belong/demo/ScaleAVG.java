package com.belong.demo;

import java.util.Scanner;

/**
 * Created by belong on 2017/4/7.
 */
public class ScaleAVG {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        while (scanner.hasNext()) {
            int A = scanner.nextInt();
            int b[] = new int[A - 2];
            if (A <= 2) {
                System.out.println(A + "/" + (A - 1));
            } else {
                for (int i = 2; i < A ; i++) {
                    b[i - 2] = sum(A , i);
                }
                int s = 0;
                for (int j = 0; j < b.length; j++) {
                    s = s + b[j];
                }
                int c = gcd(s, b.length);
                System.out.println(s / c + "/" + b.length / c);
            }
        }
    }

    private static int sum(int n, int i) {
        int a[] = new int[100];
        int sum = 0;
        int position = 0;
        while (n != 0) {
            int r = n % i;
            n = n / i;
            a[position] = r;
            position++;
        }
        for (int j = 0; j < a.length; j++) {
            sum = sum + a[j];
        }
        return sum;
    }

    private static int gcd(int x, int y) {
        if (y == 0) {
            return x;
        } else {
            return gcd(y, x % y);
        }
    }
}
