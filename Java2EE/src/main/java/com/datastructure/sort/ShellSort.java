package com.datastructure.sort;

import java.util.Arrays;

/**
 * The type Shell sort.
 */
/*
 * belong
 * h是先4组排序后每个排序(直接插入排序法)
 */
public class ShellSort {
    /**
     * The constant count.
     */
    public static int count = 0;
    private int[] data = {47, 55, 10, 40, 15, 94, 5, 70};

    /**
     * Shell sort.
     */
    public void shellSort() {
        System.out.println("原始数组：");
        System.out.println(Arrays.toString(data));
        System.out.println("-------------------");
        System.out.println("开始排序：");
        int arrayLength = data.length;
        //h变量保存可变增量
        int h = 1;
        //按h * 3 + 1得到增量序列的最大值
        while (h <= arrayLength / 3) {/// 计算间隔h最大值
            h = h * 3 + 1;
        }
        while (h > 0) {
            System.out.println("===h的值:" + h + "===");
            for (int i = h; i < arrayLength; i++) {
                //当整体后移时，保证data[i]的值不会丢失
                int tmp = data[i];
                //i索引处的值已经比前面所有值都大，表明已经有序，无需插入
                //（i-1索引之前的数据已经有序的，i-1索引处元素的值就是最大值）
                if (data[i] - data[i - h] < 0) {
                    int j = i - h;
                    //整体后移h格,
                    //当h不等于1的时候，进行大小值对调，也就是让数组成为基本有序
                    //在h等于1的时候：不仅和(h的可变增量的跨度的那个值)比，
                    //而且还要和跨度值的前一个元素比(直到j >= 0)，直到把最小的送入到没有比他更小的地方。
                    for (; j >= 0 && data[j] - tmp > 0; j = j - h) {//j=j-h 退几个格
                        data[j + h] = data[j];    //把元素调为，退格下一个h的坐标在进行比对
                    }
                    //最后将tmp的值，也就是做小的值，插入已经比对完毕之后的合适位置
                    data[j + h] = tmp;
                }
                System.out.println(Arrays.toString(data));
            }
            //h=4的最终结果是[15, 55, 5, 40, 47, 94, 10, 70]
            h = (h - 1) / 3;//反向计算h序列,
        }
    }

    /**
     * Main.
     *
     * @param args the args
     */
    public static void main(String[] args) {
        ShellSort s = new ShellSort();
        s.shellSort();
    }
}
