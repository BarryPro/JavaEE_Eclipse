package com.belong.demo;

import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/4/27.
 */
public class Demo11 {
    public static void main(String[] args) {
        Scanner cin = new Scanner(System.in);
        while (cin.hasNext()){
            String regex = cin.next();
            String string = cin.next();
            System.out.println(filter(string,regex));
        }
    }

    /**
     *
     * @param string 字符串部分
     * @param regex pattern部分
     * @return 返回是否匹配
     */
    public static int filter(String string,String regex){
        String tmp_str = regex.replaceAll("\\*","(.*)");
        String str = tmp_str.replaceAll("\\?","(.)");
        Pattern pattern = Pattern.compile(str);
        Matcher matcher = pattern.matcher(string);
        if(matcher.find()){
            return 1;
        }
        return 0;
    }
}
