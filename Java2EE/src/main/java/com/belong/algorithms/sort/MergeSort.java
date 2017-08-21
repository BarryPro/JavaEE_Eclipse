package com.belong.algorithms.sort;

public class MergeSort {
	//利用归并排序算法对数组data进行排序 
	private int[] data={50,10,90,30,70,40,80,60,20};
	public  void mergeSort(){
		//归并排序 
		sort(data , 0 , data.length - 1);
	}
	/** 
	 * 将索引从left到right范围的数组元素进行归并排序 
	 * @param data 待排序的数组
	 * @param left 待排序的数组的第一个元素索引 
	 * @param right 待排序的数组的最后一个元素的索引 
	 * 先把所有数据通过递归，分割好数据，本题是分割成两两一组
	 */ 
	private  void sort(int[] data, int left, int right) { 
		if (left < right){
			//找出中间索引，不停地分割数组，使其成为不能再分割的部分
			int center = (left + right) / 2;/*cent值分别是:4 2 1 0   */
			//对左边数组进行递归
			System.out.println(left < center?"sort-left---L:"+left+";C:"+center:"");
			////对左边数组进行分割
			sort(data, left, center); //递归时先调用的后返回，后调用的先返回，因此形参的值也跟随，根据栈的原则			
			//对右边数组进行递归
			System.out.println(center + 1 < right?"sort-right---C:"+(center + 1)+";R:"+right:"");
			//对右边数组进行分割
			sort(data, center + 1, right); /*当center是0的时候，left=right,因此sort不再执行，继续走合并*/
			
			//合并
			merge(data, left, center, right); 
		} 
	} 
	/** 合并
	 * 将两个数组进行归并，归并前两个数组已经有序，归并后依然有序。 
	 * @param data 数组对象 
	 * @param left 左数组的第一个元素的索引 
	 * @param center 左数组的最后一个元素的索引，center+1是右数组第一个元素的索引
	 * @param right 右数组的最后一个元素的索引 
	 */ 
	private  void merge(int[] data, int left, int center, int right) {
		//定义一个与待排序序列长度相同的临时数组 
		int[] tmpArr = new int[data.length];
		int mid = center + 1;
		//third记录中间数组的索引
		int third = left; 
		int tmp = left; 
		while (left <= center && mid <= right){ 
			//从左右两个数组中取出小的放入中间数组， 
			if (data[left]-data[mid]<= 0){ 
				tmpArr[third++] = data[left++]; 
			} else{
				tmpArr[third++] = data[mid++]; 
			}
		} 
		//比较后剩余的其他数字部分依次放入中间数组 
 		while (mid <= right) { 
			tmpArr[third++] = data[mid++]; 
		} 
        while (left <= center) { 
			tmpArr[third++] = data[left++]; 
		} 
		//将中间数组中的内容复制拷回原数组
		//(原left～right范围的内容复制回原数组) 
		while (tmp <= right){//已经排序好的数组
		
			data[tmp] = tmpArr[tmp++]; 
		}
		System.out.println("merge");
	} 
	public static void main(String[] args) {
		MergeSort m=new MergeSort();

		System.out.println("排序之前：\n"
				+ java.util.Arrays.toString(m.data));
		m.mergeSort();
		System.out.println("排序之后：\n" 
				+ java.util.Arrays.toString(m.data));
	}
}
