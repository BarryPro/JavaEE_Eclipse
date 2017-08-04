package com.belong.sort;

public class QuickSortTest {
	public static void main(String[] args) {
//		测试数据
		int []a = {4,6,3,677,3,56,6,7,85758,45,8678,465};
//		调用方法
		int start = 0;
		int end = a.length-1; //索引要比长度少一，从0开始的
		fun(a,start,end);	
		for(int i:a){
			System.out.println(i);
		}
	}
	
	public static void fun(int[] a,int start ,int end){
		boolean flag = false; //false从右往左， true从左往右
		int i = start; //左索引
		int j = end; //又索引
		if(i>=j){
			return ;
		}
		while(i!=j){
			if(a[i]>a[j]){
				int tmp = a[i];
				a[i] = a[j];
				a[j] = tmp;
				flag = !flag;
			}
			if(flag){
				j--;
			} else {
				i++;
			}
		}
		i--;
		j++;
		fun(a, start, i);
		fun(a, j, end);
	}

}
