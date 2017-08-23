package com.belong.algorithms.search;
import java.util.Arrays;
public class BinarySearch {
	public static void main(String[] args) {
		int []a={2,3,1,12,11,17,8};
		Arrays.sort(a);//排序
		System.out.println(rank(12,a));
	}
	public static int rank(int key,int[] a){
		//数组必须是有序的
		int lo=0;
		int hi=a.length-1;

		while(lo<=hi){
			//被查找的键要么不存在，要么必然存在于a[hi..lo]之中
			// 0 1 2 3 4 5 6 7  0+ 7-0/2   4+(7-4)/2
			int mid=lo+(hi-lo)/2;  //(lo+hi)/2   //  2 3 4 5 6 7 8 9 //算中间索引号的小算法，举例说明
			//lo起始位置改变了，必须把lo移动的位置给加回来

			if(key<a[mid]){
				hi=mid-1;////向中间值的左端移动
			}else if(key>a[mid]){
				lo=mid+1;			//向中间值的右端移动	
			}else{
				return mid;//不移动 就是中间值
			}
		}
		return -1;//没找到
	}
}
