package com.belong.sort;

public class QuickSortTest {
	public static void main(String[] args) {
//		��������
		int []a = {4,6,3,677,3,56,6,7,85758,45,8678,465};
//		���÷���
		int start = 0;
		int end = a.length-1; //����Ҫ�ȳ�����һ����0��ʼ��
		fun(a,start,end);	
		for(int i:a){
			System.out.println(i);
		}
	}
	
	public static void fun(int[] a,int start ,int end){
		boolean flag = false; //false�������� true��������
		int i = start; //������
		int j = end; //������
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
