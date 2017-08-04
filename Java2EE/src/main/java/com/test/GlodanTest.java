package com.test;

import java.util.ArrayList;

/**
 * @Description:
 *               <p>
 *               </p>
 * @Author : belong
 * @Date : 2017年8月3日
 */
public class GlodanTest {
	int sum = 0;

	public static void main(String[] args) {
		int[] a = { 6, 8, 7, 9 };
		ArrayList<Integer> list = new ArrayList<>();
		for (int i : a) {
			list.add(i);
		}
		GlodanTest gTest = new GlodanTest();
		gTest.fun(list);
		 System.out.println(gTest.sum);
	}

	public void fun(ArrayList<Integer> list) {
		java.util.Collections.sort(list);
		if (list.size() < 2) {
			return;
		}
		ArrayList<Integer> list_sum_tmp = new ArrayList<>();
		for (int i = 0; i < list.size(); i += 2) {
			if (i < list.size() - 1) {
				list_sum_tmp.add(list.get(i) + list.get(i + 1));
			}
		}
		for (Integer i : list_sum_tmp) {
			sum += i;
		}
		System.out.println(list_sum_tmp);
		fun(list_sum_tmp);
	}

}
