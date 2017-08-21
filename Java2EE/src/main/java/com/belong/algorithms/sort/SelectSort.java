package com.belong.algorithms.sort;


import java.util.Arrays;

/**
 * belong
 * 2012-02-03
 */

public class SelectSort {
    private int[] data1 = {21, 30, 49, 39, 16, 9};

    public void selectSort() {

        System.out.println("开始排序");
        int arrayLength = data1.length;
        //依次进行n－1趟比较, 第i趟比较将第i大的值选出放在i位置上。
        for (int i = 0; i < arrayLength - 1; i++) {
            //第i个数据只需和它后面的数据比较
            for (int j = i + 1; j < arrayLength; j++) {
                //如果第i位置的数据 > j位置的数据, 交换它们
                if (data1[i] - (data1[j]) > 0) {
                    int tmp = data1[i];
                    data1[i] = data1[j];
                    data1[j] = tmp;
                }
            }
            System.out.println(Arrays.toString(data1));
        }
    }

    public static void main(String[] args) {
        SelectSort s = new SelectSort();

        System.out.println("排序之前：\n"
                + Arrays.toString(s.data1));
        s.selectSort();
        System.out.println("排序之后：\n"
                + Arrays.toString(s.data1));

    }
}
