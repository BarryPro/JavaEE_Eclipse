package com.belong.demo;

import java.util.ArrayList;
import java.util.Scanner;

public class Demo2 {
    public static void main(String[] args) {
        Scanner cin = new Scanner(System.in);
        while (cin.hasNext()) {
            //输入n道题
            ArrayList<Double> list = new ArrayList<>();
            int n = cin.nextInt();
            for (int i = 0; i < n; i++) {
                int tmp = cin.nextInt();
                double tmp2 = tmp/100;
                list.add(tmp2);
            }
            //要及格需要的次数
            int k = (int) Math.round(Math.ceil(n * 0.6));
            double sum;
            double tmp_a = 0.0;
            double tmp_b = 0.0;
            //计算总概率
            for (int i = k; i <= n; i++) {
                //临时概率
                tmp_a += fun(jc_Fun(n), jc_Fun(i));
                System.out.println(tmp_a);
            }
            for (double i : list) {
                tmp_b *= i / 100;
                System.out.println(tmp_b);
            }
            sum = tmp_a * tmp_b;
            System.out.printf("%.5f", sum);
        }

    }

    /**
     * 求数的阶乘
     *
     * @return
     */
    public static int jc_Fun(int n) {
        if (n <= 1) {
            return 1;
        } else {
            return n * jc_Fun(n - 1);
        }
    }

    /**
     * 求概率
     *
     * @param a 分子
     * @param b 分母
     * @return 返回概率运算
     */
    public static double fun(int a, int b) {
        return a / b;
    }
}
