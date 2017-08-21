package com.belong.ds.list;

/**
 * Created by Administrator on 2016/8/24.
 */
public class Palindrome1Test {
    public static void main(String[] args) {
        Palindrome1 list = new Palindrome1();
        list.add(1);
        list.add(2);
        list.add(3);
        list.add(2);
        list.add(1);
        System.out.println(list.isPalindrome1(list.getHead()));
    }
}
