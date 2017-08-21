package com.belong.reflect;


import java.lang.reflect.*;
/**
 * Description:
 * <br/>Copyright (C), 2008-2010, belong
 * <br/>This program is protected by copyright laws.
 * <br/>Program Name:
 * <br/>Date:
 * @author  belong
 * @version  1.0
 */

public class ArrayTest1 
{
	public static void main(String args[])
	{
		try
		{
			
			Object arr = Array.newInstance(String.class, 10);
		
			Array.set(arr, 5, "Flex������ȫ");
			Array.set(arr, 6, "����ʦ");
		
			Object book1 = Array.get(arr , 5);
			Object book2 = Array.get(arr , 6);
			
			System.out.println(book1);
			System.out.println(book2);
		}
		catch (Throwable e)
		{
			System.err.println(e);
		}
	}
}