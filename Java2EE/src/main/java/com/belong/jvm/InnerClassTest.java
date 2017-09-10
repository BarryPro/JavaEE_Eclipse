package com.belong.jvm;
/**
 * @Title : 匿名内部类的字节码研究
 * @Description : 
 * <p></p>
 * @Author : belong
 * @Date : 2017年9月4日
 */

/**
 * 
 * @description
 *              <p>
 * 				InnerClassTest类是外部类
 *              </p>
 *
 * @author belong
 */
public class InnerClassTest {
	private Inner inner = null;

	public InnerClassTest() {

	}

	public Inner getInnerInstance() {
		if (inner == null)
			inner = new Inner();
		return inner;
	}

	protected class Inner {
		public Inner() {

		}
	}
	
	static class StaticClass{
		public StaticClass() {
			
		}
	}
}
