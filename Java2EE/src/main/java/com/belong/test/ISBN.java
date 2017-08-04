package com.belong.test;

import java.util.Scanner;

/**
 * Created by belong on 2016/12/15.
 */
public class ISBN {
    public static void main(String[] args) {
        //0-670-82162-4
        //语言-出版社-编号-识别码
        Scanner cin = new Scanner(System.in);
        while(cin.hasNext()){
            String str = cin.next();
            String ISBN[] = str.split("-");
            StringBuffer fullNum = new StringBuffer();
            for(String s:ISBN){
                fullNum.append(s);
            }
            int sum = 0;
            char ch[] = fullNum.toString().toCharArray();
            String [] num = new String [ch.length];
            for(int i = 0;i<ch.length-1;i++){
                num[i] = ch[i]+"";
                sum+=Integer.parseInt(num[i])*(i+1);
            }
            int mykey = sum%11;
            String key = "";//重算识别码
            if(mykey == 10){
                key = "X";
            }
            if(mykey == Integer.parseInt(ISBN[3])){
                System.out.println("Right");
            } else {
                StringBuffer MyISBN = new StringBuffer();
                for(int i = 0;i<num.length-1;i++){
                    if(i==1||i==4){
                        MyISBN.append("-");
                        MyISBN.append(num[i]);
                    } else {
                        MyISBN.append(num[i]);
                    }
                }
                MyISBN.append("-"+mykey);
                System.out.println(MyISBN);
            }
        }
    }
}
