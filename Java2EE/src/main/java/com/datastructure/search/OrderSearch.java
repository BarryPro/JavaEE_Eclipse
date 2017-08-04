package com.datastructure.search;



public class OrderSearch {
	/**顺序查找平均时间复杂度 O（n）
	 * @param searchKey 要查找的值
	 * @param array 数组（从这个数组中查找）
	 * @return  查找结果（数组的下标位置）
	 */
	public static int orderSearch(int searchKey,int... array){
		for(int i=0;i<array.length;i++){
			if(array[i]==searchKey){
				return i;
			}
		}
		return -1;
		
	}
	/**测试查找结果
	 * @param args
	 */
	public static void main(String[] args) {
		  int[] test=new int[]{1,2,29,3,95,3,5,6,7,9,12};//升序序列
		  int index=OrderSearch.orderSearch(95, test);
		  System.out.println("查找到的位置 :"+ index);  
	}
}
