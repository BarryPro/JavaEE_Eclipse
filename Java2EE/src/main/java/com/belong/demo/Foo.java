package com.belong.demo;

import java.io.Serializable;

/**
 * 验证序列transient关键字的作用
 * Created by belong on 2017/4/6.
 */
public class Foo implements Serializable{
    public static transient int w = 1;
    public static transient int x = 2;
    public int y = 3;
    public transient int z = 4;

}
