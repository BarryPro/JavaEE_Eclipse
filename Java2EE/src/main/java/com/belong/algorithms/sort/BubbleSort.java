package com.belong.algorithms.sort; /**
 * @author belong
 * @date
 * @author belong
 * @date
 */


/**
 * @author belong
 * @date
 *
 */

import java.util.Arrays;

//定义一个数据包装类

public class BubbleSort {
    private int[] data = {9, 16, 27, 23, 30, 49, 21, 35};

    public void bubbleSort() {
        System.out.println("开始排序");
        int arrayLength = data.length;
        for (int i = 0; i < arrayLength - 1; i++) // -1的原因是最大的数再不用排了
        {
            boolean flag = false;
            for (int j = 0; j < arrayLength - 1 - i; j++) // -1-i的原因是没走一次i，
            // 相当于把最大的数已经放到最后了，因此在没有循环的必要了
            {
                // 如果j索引处的元素大于j+1索引处的元素
                if (data[j] - (data[j + 1]) > 0) {
                    //交换它们
                    int tmp = data[j + 1];
                    data[j + 1] = data[j];
                    data[j] = tmp;
                    flag = true;
                }
            }
            System.out.println(Arrays.toString(data));
            // 如果某趟没有发生交换，则表明已处于有序状态
            if (!flag) {
                break;
            }
        }
    }

    public static void main(String[] args) {
        BubbleSort b = new BubbleSort();

        System.out.println("排序之前：\n"
                + Arrays.toString(b.data));
        b.bubbleSort();
        System.out.println("排序之后：\n"
                + Arrays.toString(b.data));
    }
}
