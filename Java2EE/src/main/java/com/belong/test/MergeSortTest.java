package com.belong.test;

import java.util.Arrays;

/**
 * @Description: <p>归并排序</p>
 * @Author : belong
 * @Date : 2017年8月22日
 */
public class MergeSortTest {
	public static void main(String[] args) {
		int [] data = {4,6,5,4,6,7,567,6,87,564,6,45,645};
		mergesort(data);
		System.out.println(Arrays.toString(data));
	}
	
	public static void mergesort(int [] data) {
		int l = 0;
		int r = data.length-1;
		sort(data,l,r);
	}
    /**
     * 归并的归算法（拆分）
     * @param data 待排序的数组
     * @param l 数组的左下标
     * @param r 数组的右下标
     */
	private static void sort(int[] data, int l, int r) {
		if(l < r) { // 拆分条件，到不能拆为止
			int center = (l + r) / 2; // 计算中间的位置，用于作为左右两边的分界线
			sort(data, l, center); // 对center的左边进行拆分
			sort(data, center+1, r); // 对center的右边进行拆分
			merge(data,l,center,r); // 对拆分后的数据进行合并
		}		
	}

	/**
	 * 归并排序的并算法（合并）
	 * @param data 待排序的数组
     * @param l 数组的左下标
	 * @param center 数组中间下标，也就是左右两边的下标
     * @param r 数组的右下标
	 */
	private static void merge(int[] data, int l, int center, int r) {
		// 1、定义一个与data等大的临时数组用于装排好序的数据
		int [] tmpArr = new int[data.length];
		// 定义临时数组的索引下标(一定是左边的第一个的下标，因为是很多部分的左要加在一起，不可以是0，那样没回都是从头开始)
		int index = l; 
		// 2、定义左右两边的第一个索引的变量由于遍历数据
		int lF = l; //左边第一个元素的下标
		int rF = center + 1; // 右边第一个元素的下标
		// 3、开始比较左右两部分的数据按从小到大的顺序放入到新数组中
		while(lF <= center && rF <= r) { //循环条件：左右两部分的左右下标都是合法的
			if(data[lF] < data[rF]) { // 那个小就把那个数据放入临时数组中
				tmpArr[index++] = data[lF++];
			} else {
				tmpArr[index++] = data[rF++];
			}
		}
		// 4、把左右两部分中多的那部分直接放到临时数组的后面，因为剩下的是最大的，并且只能是多出一个元素来
		while(lF <= center) { // 剩余的是左部分的元素
			tmpArr[index++] = data[lF++];
		}
		while(rF <= r) { // 剩余的是右部分的元素
			tmpArr[index++] = data[rF++];
		}
		// 5、把临时数组重新赋值到data数组中
		while(l <= r) {
			data[l] = tmpArr[l++];
		}
	}	
}
