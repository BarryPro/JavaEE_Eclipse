package com.belong.test;

import java.util.Scanner;

/**
 * 笔试编程题
 */
public class ID2 {
    public static void main(String[] args) {
        new ID2().fun();
        //System.out.println(Math.max(1,2));
    }

    public void fun (){
        Scanner cin = new Scanner(System.in);
        int n = cin.nextInt();
        int a [] = new int[10001];
        if(n>=1 && n<=1000){
            for(int i = 0;i<n;i++){
                a[cin.nextInt()]++;
            }

            int max = -1;
            for(int i = 0;i<a.length;i++){
                max = Math.max(max,a[i]);
            }
            System.out.println(a[max]);
        }
    }
}
