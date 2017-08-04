package com.datastructure.list;

/**
 * Created by belong on 2016/8/24.
 */
public class Palindrome3Test {
    public static void main(String[] args) {
        Palindrome3 list = new Palindrome3();
        list.add(1);
        list.add(2);
        list.add(3);
        list.add(2);
        list.add(1);
        System.out.println(list.isPalindrome3(list.getHead()));
    }
}
