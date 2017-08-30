package com.belong.algorithms.others;
/**
 * @Description: <p>最大子串求和</p>
 * @Author : belong
 * @Date : 2017年8月26日
 */
public class MaxSubSum {
	 /* 
      * 基于的性质:   
      * 1.对于全负的元素,找到最大值即可 
      * 2.对于最大子串和大于0的,可证明最大子串中任意前缀串大于0 
      *  
      * 算法:依次计算累加和,当累加和大于原累加和时记录最大值相关信息,当累加和小于零时,由下一元素重新累加 
      */  
	static int getMaxSub(int[] a) throws Exception {
		if (null == a || a.length <= 0) {
			throw new Exception();
		}	
		int maxhead = 0, maxend = 0, max = Integer.MIN_VALUE;
		int head = 0, sum = 0;
		for (int i = 0; i < a.length; i++) {
			sum += a[i];
			if (sum > max) {
				max = sum;
				maxhead = head;
				maxend = i;
			}
			if (sum < 0) {
				head = i + 1;
				sum = 0;
			}
		}
		System.out.printf("\nmaxsub is %d to %d sum=%d\n", maxhead, maxend, max);
		return max;
	}

	public static void main(String[] argvs) throws Exception {
		int[] a = { -23, 17, -7, 11, -2, 1, -34 };
		getMaxSub(a);
	}
}  