package com.belong.test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;

/**
 * 
 * @description <p>测试jdk中sort的排序是升序，还是降序
 * Arrays和Collections的sort</p>
 *
 * @author belong
 */
public class JDKSortFunTest {
	public static void main(String[] args){
		ArrayList< Integer> list = new ArrayList<>();
		list.add(34);
		list.add(4);
		list.add(84);
		list.add(30);
		list.add(784);
		int a [] = {5,46,3,67,75,7,587,457,4578,45};
		Arrays.sort(a);
		for(int i = 0;i<a.length;i++) {
			System.out.print((i != a.length-1)?a[i]+" ":" "+a[i]+"\n");
		}
		Collections.sort(list);
		System.out.println(list);
	}
}
