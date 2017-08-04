package com.belong.test;

import java.util.Scanner;

/**
 * Created by belong on 2016/12/15.
 */
public class MaxRect {
    public static void main(String[] args) {
        Scanner cin = new Scanner(System.in);
        int n = cin.nextInt();
        int reault = 0;
        if (n >= 1 && n <= 1000) {
            int a[] = new int[n];
            for (int i = 0; i <= n; i++) {
                int num = cin.nextInt();
                if (num >= 1 && num <= 10000) {
                    a[i] = num;
                }
            }
            for(int i = 0;i<a.length;i++){
                int width = 1;//定义矩形宽度
                for(int j = i-1; j>0; j--){
                    if(a[i]<a[j]){
                        break;
                    }
                    width++;
                }
                for(int j = i+1;j<a.length;j++){
                    if(a[i]<a[j]){
                        break;
                    }
                    width++;
                }
                int area = width*a[i];
                reault = Math.max(reault,area);
            }
            System.out.println(reault);
        }
    }
}

