package com.belong.basic;

/**
 * Created by belong on 2016/12/5.
 */
public class FloatTest {
    public static void main(String[] args) {
        int a[] = {4, 5, 73, 4, 2, 78};
        System.out.println(new FloatTest().search(a));
        //byte a = 120;
        //char ch = (char)a;
        //short b = 120;
        //char ch2 = (char)65537;
        //int ch3 = 120;
        //ch3 = b;
        //ch3 = ch;
        //ch3 = a;
        //b = a;
        //ch3 = ch;
        //char aa = 56;
        //byte ab = 56;
        //short ac = 32767;
        //char ad = 65535;
        //
        //System.out.println(0b11);
    }

    public void graph() {
        for (int i = 1; i <= 5; i++) {
            for (int j = 1; j < i; j++) {
                System.out.print((char) (j + 96));
            }
            for (int j = i; j > 0; j--) {
                System.out.print((char) (j + 96));
            }
            System.out.println();
        }
    }

    public int search(int[] a) {
        int max = 0;
        int index = 0;
        do {
            if (max < a[index]) {
                max = a[index];
            }
            index++;
        } while (index < a.length);
        return max;
    }

    public void floatFun() {
        System.out.println(1.1 / 0);
        System.out.println(1.1 / -0);
        System.out.println(-1.1 / 0);
        System.out.println(-1.1 / -0);
    }

    public void modFun() {
        System.out.println(1.1 % 0);
        System.out.println(1.1 % -0);
        System.out.println(-1.1 % 0);
        System.out.println(-1.1 % -0);
    }

    public void charFun() {
        System.out.println("abcd\ref");
        System.out.println("abcd\bef");
        System.out.println("abcd\nef");
        System.out.println("abcd\tef");
    }

    public void ascII() {
        for (int i = 0; i < 65535; i++) {
            if (i % 10 == 0) {
                System.out.println();
            }
            System.out.print((char) i + " ");
        }
    }
}
