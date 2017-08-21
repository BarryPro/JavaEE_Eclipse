package com.belong.algorithms.sort;

import java.util.Arrays;

/*
1. 首先新建一个空列表，用于保存已排序的有序数列（我们称之为“有序列表”）。 
2.从原数列中取出一个成员，将其与有序列表中的成员逐个进行比较，找到第一个大于它的成员，将自身插入该较大成员之前。
 跳出循环，进行下一轮比对。
3.如果没有大于它的成员，将其插入有序数列的最后。 
4.重复步骤2，3直到所有原数列中的数据都处理完毕。
在下面的代码中，我们以以对整数进行排序为例子。
 */
public class InsertSort {
    public static void main(String[] args) {
        int[] nums = {49, 38, 10, 97, 76, 13, 27};
        System.out.println(Arrays.toString(new InsertSort().insertSort(nums)));

    }

    public int[] insertSort(int[] source) {
        for (int i = 0; i < source.length; i++) {
            int index = -1;
            //将第i个与前i-1个逐个比较，找到第一个比它大的
            for (int j = 0; j < i; j++) {
                if (source[j] > source[i]) {
                    index = j;
                    break;
                }
            }
            //将第i个插入合适的位置。如果前面没有被第i个大的，不需要做任何事情。
            if (index != -1) {
                int temp = source[i];
                moveBackward(index, i - 1, source);
                source[index] = temp; //插入相应的位置
            }
        }

        return source;
    }

    /*
     * 将给定数组中指定范围内的所有元素在数组中向后移一个位置。
     */
    private void moveBackward(int from, int to, int[] values) {
        for (int i = to + 1; i > from; i--) {
            values[i] = values[i - 1];
        }
    }


}
