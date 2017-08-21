package com.belong.algorithms.search;

public class OrderSearch1 {
	public static int orderSearch(int searchKey,int [] a,int n){
		int i;
		a[0]= searchKey;/*设置a[0]为关键字值，我们称之为哨兵*/
		i=n;//循环从数组尾部开始
		while(a[i]!=searchKey){
			i--;
		}
		return i;//返回0则说明查找失败
	}
	public static void main(String[] args) {
		int[] test=new int[]{1,2,29,3,95,3,5,6,7,9,12};//升序序列
		int index=OrderSearch1.orderSearch(95, test,test.length-1);
		System.out.println("查找到的位置 :"+ index);  
	}
}
