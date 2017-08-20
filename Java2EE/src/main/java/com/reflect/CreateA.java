package com.reflect;

import java.lang.reflect.Constructor;

/**
 * Description:
 * <br/>Copyright (C), 2008-2010, belong
 * <br/>This program is protected by copyright laws.
 * <br/>Program Name:
 * <br/>Date:
 * @author belong
 */
public class CreateA
{
	public static void main(String[] args)
		throws Exception
	{
		//获取JFrame对应的Class对象
		Class<?> jframeClazz = Class.forName("com.belong.A.A");//引入该目录下的jar包中的A类
		//获取JFrame中带一个字符串参数的构造器
		String name="belong";
		Constructor ctor = jframeClazz
			.getConstructor(String.class);
		//调用Constructor的newInstance方法创建对象
		Object obj = ctor.newInstance(name);
		//输出JFrame对象
		((A)obj).test();
	}
}
