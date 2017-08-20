package com.belong.factory.factorymethod;

/**
 * @Description: <p>工厂接口
 * 定义一个用于创建对象的接口，让子类决定将哪一个类实例化。工厂方法模式使一个类的实例化延迟到其子类</p>
 * @Author: belong.
 * @Date: 2017/7/13.
 */
public interface Factory {
    Product factoryMethod();
}
