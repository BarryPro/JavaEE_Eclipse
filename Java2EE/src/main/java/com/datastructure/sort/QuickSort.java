package com.datastructure.sort;

public class QuickSort {
    /**
     * 主方法
     */
    public static void main(String[] args) {
        //声明数组
        int[] nums = {49, 38, 65, 97, 76, 13, 27};
        //应用快速排序方法 I
        quickSort(nums, 0, nums.length - 1);
        //显示排序后的数组
        for (int i = 0; i < nums.length; ++i) {
            System.out.print((i < nums.length - 1) ? nums[i] + "," : nums[i] + "\n");
        }
    }

    /**
     * 快速排序方法
     */
    /* data：要排序的数组
     * start:选取的是第一个数，这里是索引号，这里是49，始终拿这个数和其他数比较，
	 * 		  因此，位置也就串这个数所在的索引，
	 * end；最后一个元素，这里是索引号，这里是27
	 */
    public static void quickSort(int[] data, int start, int end) {
        int i = start; //相当于i，左  索引
        int j = end; //相当于j,  右  索引
        if (i >= j) { // 判断是否到中间了 ，到中间返回
            return; //返回
        }
        //确定指针方向的逻辑变量，也就是从左搜索还是向右搜索
        boolean flag = true; //false:左->右  true：右->左
        while (i != j) { //如果i==j证明第一趟结束，每趟的标准值仅是一个，例如第一趟被比较值为49，
            if (data[i] > data[j]) {
                //交换数字 ：所有比它小的数据元素一律放到左边，所有比他大的数据元素一律放到右边，
                int temp = data[i];
                data[i] = data[j];
                data[j] = temp;
                //只有经过数的交换后，才能把游标的移动位置改变，移动书序是交替改变
                //决定下标移动，还是上标移动 ，游标更改 走下一个数据
                flag = flag != true;
                //	flag=!flag;
            }
            //将指针向前或者向后移动 ,第一次从左-》右，第二次从右-》左
            if (flag) {//true，右---》左
                j--;
            } else {//false 左---》右
                i++;
            }
        } //1 2
        //到此，数组的数据排列位置为：
        //第一次到该位置，data的值是：[27, 38, 13, 49, 76, 97, 65]
        //将数组分开两半，确定每个数字的正确位置
        //i=3,j=3
        i--; //
        j++;
        //i=2 j=4 start=0 end=6
        quickSort(data, start, i); //也就是 27 38 13在快速排序
        quickSort(data, j, end); // 也就是 76, 97, 65在快速排序
    }
}
