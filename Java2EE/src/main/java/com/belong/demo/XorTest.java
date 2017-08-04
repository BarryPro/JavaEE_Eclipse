package com.belong.demo;

import java.util.ArrayList;
import java.util.Scanner;
import java.util.Stack;

/**
 * 自定义异或
 * Created by belong on 2017/4/8.
 */
public class XorTest {
    public static void main(String[] args) {
        Scanner cin = new Scanner(System.in);
        while (cin.hasNext()) {
            //输入位二进制数
            int n = cin.nextInt();
            ArrayList<Integer> list_1 = new ArrayList<>();
            ArrayList<Integer> list_2 = new ArrayList<>();
            StringBuilder list = new StringBuilder();
            Stack<Integer> tmp = new Stack<>();
            int num_1 = 0;
            int num_2 = 0;
            //第一个二进制数
            num_1 = cin.nextInt();
            //第二个二进制数
            num_2 = cin.nextInt();
            //进行分离位数
            while (num_1 != 0) {
                tmp.push(num_1 % 10);
                num_1 /= 10;
            }
            if(tmp.size()<n){
                tmp.push(0);
            }
            while(!tmp.isEmpty()){
                list_1.add(tmp.pop());
            }
            //第二个数分离
            while (num_2 != 0) {
                tmp.push(num_2 % 10);
                num_2 /= 10;
            }
            if(tmp.size()<n){
                tmp.push(0);
            }
            while (!tmp.isEmpty()) {
                list_2.add(tmp.pop());
            }
            //开始进行判断
            for (int i = 0; i < list_1.size(); i++) {
                if (list_1.get(i) == list_2.get(i) && list_1.get(i) != 0 && list_2.get(i) != 0) {
                    list.append(0);
                } else if (list_1.get(i) != list_2.get(i)) {
                    list.append(1);
                } else {
                    list.append(0);
                }
            }
            System.out.println(Integer.parseInt(list.toString(), 2));
        }
    }
}
