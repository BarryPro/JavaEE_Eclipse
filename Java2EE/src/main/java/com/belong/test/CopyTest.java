package com.belong.test;

import java.util.Arrays;

/**
 * @Description: <p>system下的copy测试</p>
 * @Author : belong
 * @Date : 2017年8月22日
 */
public class CopyTest {
	public static void main(String[] args) {
		int [] a = {4,6,45,4,56,46,54,4,436,34,6,346,534,5,43};
		int [] b = Arrays.copyOf(a, a.length);
		int [] c = new int[b.length];
		System.arraycopy(a, 0, c, 2, b.length-2);
		System.out.println("b:"+Arrays.toString(b));
		System.out.println("c:"+Arrays.toString(c));
	}
}
