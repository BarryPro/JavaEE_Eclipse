package com.belong.reflect;

import com.belong.basic.DeepClone;

import java.lang.reflect.Constructor;

/**
 * Created by belong on 2016/12/11.
 */
public class CreateFun
{
    public static void main(String[] args)
            throws Exception
    {
        //获取JFrame对应的Class对象
        Class<?> jframeClazz = Class.forName("com.belong.basic.DeepClone");//引入该目录下的jar包中的A类
        //获取JFrame中带一个字符串参数的构造器
        String name="belong";
        Constructor ctor = jframeClazz.getConstructor(String.class);
        //调用Constructor的newInstance方法创建对象
        Object obj = ctor.newInstance(name);
        //输出JFrame对象
        ((DeepClone)obj).fun();
    }
}
