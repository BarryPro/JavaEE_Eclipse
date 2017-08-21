package com.belong.jvm.string;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/7/14.
 */
public class InternTest01 {
    public static void main(String[] args) {
        String str1 = "str01";
        String str2 = new String("str")+new String("01");
        String str3 = str2.intern();
        System.out.println(str2 == str1);//#8
        System.out.println(str3 == str1);//#9
    }
}
