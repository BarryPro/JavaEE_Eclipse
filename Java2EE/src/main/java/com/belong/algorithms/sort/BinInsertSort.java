package com.belong.algorithms.sort;

import java.util.Arrays;

/*
 * 折半直接插入排序
 */
public class BinInsertSort {
    public static int count = 0;

    public static void main(String[] args) {
        int[] data = new int[]{49, 38, 10, 97, 76, 13, 27};
        System.out.println("原始数据：" + Arrays.toString(data));
        //binaryInsertSort(data);
        binaryInsertSort(data);
        System.out.println("排序后数据：" + Arrays.toString(data));
    }

    /*
     * 二分查找法：折半查找的算法思想是将数列按有序化(递增或递减)排列，查找过程中采用跳跃式方式查找，即先以有序数列的
     * 中点位置为比较对象，
     * 如果要找的元素值小于该中点元素，则将待查序列缩小为左半部分，否则为右半部分。通过一次比较，将查找区间缩小一半。
     * 折半查找是一种高效的查找方法。它可以明显减少比较次数，提高查找效率。但是，折半查找的先决条件是查找表中的数据元素
     * 必须有序。

       step1. 首先确定整个查找区间的中间位置 　　mid = （ left + right ）/ 2 　　
       step2. 用待查关键字值与中间位置的关键字值进行比较； 　　
               若相等，则查找成功 　　
               若大于，则在后（右）半个区域继续进行折半查找 　　
               若小于，则在前（左）半个区域继续进行折半查找 　　
       Step3. 对确定的缩小区域再按折半公式，重复上述步骤。
               最后，得到结果：要么查找成功， 要么查找失败。 　　
               折半查找的存储结构采用一维数组存放。
     */
    //它的折半数据是 之前已经排序好的数据
    public static void binaryInsertSort(int[] data) {
        for (int i = 0; i < data.length - 1; i++) {
            if (data[i + 1] < data[i]) {  //后面的数小于前面的数,想升序排列，因此可以进行折半排序
                // 缓存i处的元素值
                int tmp = data[i + 1];
                // 记录搜索范围的左边界
                int low = 0;
                // 记录搜索范围的右边界
                int high = i;
                //二分查找法
                while (low <= high) {  // 一次对折 两次对折 比较，
                    //核心是使使搜索范围变小 ，找到后就把他们进行位置排序 直到low<high,找到该放置的位置
                    // 记录中间位置
                    int mid = (low + high) / 2;
                    // 比较中间位置数据和i处数据大小，以缩小搜索范围
                    if (data[mid] < tmp) {  //看看在哪个数值的范围，挨个比较其值
                        low = mid + 1;
                    } else {
                        high = mid - 1;
                    }
                }
                //将low~i处数据整体向后移动1位
                for (int j = i; j >= low; j--) {
                    data[j + 1] = data[j];
                }
                data[low] = tmp;
                System.out.println("第" + i + "次排序数据：" + Arrays.toString(data));
            }
        }
    }
}
