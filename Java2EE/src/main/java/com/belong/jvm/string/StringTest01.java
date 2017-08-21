package com.belong.jvm.string;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/7/14.
 */
public class StringTest01 {
    public static void main(String[] args) {
        String baseStr = "baseStr";
        final String baseFinalStr = "baseStr";

        String str1 = "baseStr01";
        String str2 = "baseStr"+"01";
        String str3 = baseStr + "01";
        String str4 = baseFinalStr+"01";
        String str5 = new String("baseStr01").intern();

        System.out.println(str1 == str2);//#3
        System.out.println(str1 == str3);//#4
        System.out.println(str1 == str4);//#5
        System.out.println(str1 == str5);//#6
    }
}
