package com.belong.demo;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/5/14.
 */
public class Demo15 {
    public static void main(String[] args) {
        String path = Demo15.class.getClassLoader().getResource("file/abbr.txt").getPath();
        System.out.println(path);
    }
}
