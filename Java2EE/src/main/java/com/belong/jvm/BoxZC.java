package com.belong.jvm;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/7/9.
 */
public class BoxZC {
    public static void main(String[] args) {
        Integer a = 1;
        Integer b = 2;
        Integer c = 3;
        Integer d = 3;
        Integer e = 321;
        Integer f = 321;
        Long g = 3L;
        System.out.println("c == d is :"+(c == d));
        System.out.println("e == f is :"+(e == f));
        System.out.println("c == (a+b) is :"+(c == (a+b)));
        System.out.println("c.equals(a+b) is :"+(c.equals(a+b)));
        System.out.println("g == (a+b) is :"+(g == (a+b)));
        System.out.println("g.equals(a+b) is :"+(g.equals(a+b)));
    }
}
