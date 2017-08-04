package com.belong.demo;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Scanner;

/**
 * Created by belong on 2017/4/7.
 */
public class SetTest {
    public static void main(String[] args) {
        Scanner cin = new Scanner(System.in);
        while (cin.hasNext()) {
            int n = cin.nextInt();
            int m = cin.nextInt();
            HashSet<Integer> set = new HashSet();
            for (int i = 0; i < n; i++) {
                set.add(cin.nextInt());
            }
            for(int i = 0;i<m;i++){
                set.add(cin.nextInt());
            }
            //集合转换成对象数组，在进行排序
            Object[] list = set.toArray();
            //排序对象数组
            Arrays.sort(list);
            for(Object i : list){
                System.out.print(i+" ");
            }
        }
    }
}
