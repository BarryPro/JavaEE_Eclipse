package com.belong.demo;

import java.util.Scanner;
import java.util.Stack;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/4/26.
 */
public class Demo10 {
    public static void main(String[] args) {
        Scanner cin = new Scanner(System.in);
        while (cin.hasNext()){
            String string = cin.nextLine();
            System.out.println(nBL(string));
        }

    }

    /**
     * @param string 输入的字符
     * @return 返回是否匹配
     */
    public static int nBL(String string){
        // 数字栈
        Stack<String> num = new Stack<>();
        // 要处理的字符都在这里
        String [] strings = string.split("[^\\S]+");
        Pattern pattern = Pattern.compile("[0-9]+");
        Matcher matcher = null;
        // 分离数字和符号
        for(String i: strings){
            // 开始进行运算
            matcher = pattern.matcher(i);
            if(matcher.find()){
                num.push(i);
            } else {
                switch (i){
                    case "^":
                        if(num.size()<1){
                            return -1;
                        }
                        int count1 = Integer.parseInt(num.pop());
                        count1++;
                        if(num.size()<16){
                            num.push(count1+"");
                        } else {
                            return -2;
                        }
                        break;
                    case "*":
                        if(num.size()<2){
                            return -1;
                        }
                        int a = Integer.parseInt(num.pop());
                        int b = Integer.parseInt(num.pop());
                        int count = a*b;
                        if(num.size()<16){
                            num.push(count+"");
                        } else {
                            return -2;
                        }
                        break;
                    case "+":
                        if(num.size()<2){
                            return -1;
                        }
                        int a1 = Integer.parseInt(num.pop());
                        int b1 = Integer.parseInt(num.pop());
                        int count2 = a1+b1;
                        if(num.size()<16){
                            num.push(count2+"");
                        } else {
                            return -2;
                        }
                        break;
                }
            }
        }
        return Integer.parseInt(num.pop());
    }
}
