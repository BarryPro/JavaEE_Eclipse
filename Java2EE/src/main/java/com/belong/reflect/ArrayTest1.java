package com.belong.reflect;

import java.lang.reflect.Array;

/**
 * Created by belong on 2016/12/11.
 */
public class ArrayTest1
{
    public static void main(String args[])
    {
        try
        {
            Object arr = Array.newInstance(String.class, 10);
            Array.set(arr, 5, "Flex");
            Array.set(arr, 6, "belong");
            Object book1 = Array.get(arr , 5);
            Object book2 = Array.get(arr , 6);
            System.out.println(book1);
            System.out.println(book2);
            System.out.println(Array.get(arr,9));
            Object a = Array.newInstance(String.class,3);
            Array.set(a,1,"belong");
            Array.set(a,2,"amlke");
            System.out.println(Array.get(a,1));
            System.out.println(Array.get(a,2));
        }
        catch (Throwable e)
        {
            System.err.println(e);
        }
    }
}
