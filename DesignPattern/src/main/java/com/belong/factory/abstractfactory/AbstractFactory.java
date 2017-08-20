package com.belong.factory.abstractfactory;


/**
 * 抽象工厂接口
 * 产品族有A和B
 */

public interface AbstractFactory{
	AbstractProductA createProductA();
	
	AbstractProductB createProductB();
}
