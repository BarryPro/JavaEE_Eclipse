package com.belong.algorithms.array;

import java.util.Arrays;

/**
 * @Description: <p>倒置数组</p>
 * @Author : belong
 * @Date : 2017年8月26日
 */
public class InversionArray {
	public static void main(String[] args) {
		int[] a = { 1, 2, 3, 4, 5, 6, 7, 8 };
		inversionArray(a);
		System.out.println(Arrays.toString(a));
	}

	private static void inversionArray(int[] a) {
		for (int i = 0; i < a.length / 2; i++) {
			int tmp = a[i];
			a[i] = a[a.length-i-1];
			a[a.length-1-i] = tmp;
		}
	}
}
