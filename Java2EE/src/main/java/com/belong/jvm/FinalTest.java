package com.belong.jvm;
/**
 * @Title : 测试final关键字
 * @Description : 类的private方法会隐式地被指定为final方法
 * <p></p>
 * @Author : belong
 * @Date : 2017年9月4日
 */
public class FinalTest {
	final void fun() {
		fun2();
	}
	private void fun2() {
		// TODO Auto-generated method stub
		
	}
}
