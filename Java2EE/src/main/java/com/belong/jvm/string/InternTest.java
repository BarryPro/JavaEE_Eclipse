package com.belong.jvm.string;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/7/14.
 */
public class InternTest {
    public static void main(String[] args) {

        String str2 = new String("str")+new String("01");
        str2.intern();
        String str1 = "str01";
        System.out.println(str2==str1);//#7
    }
}
