package com.belong.factory.abstractfactory;

/**
 * 客户来进行选择厂家来进行生产产品
 */
public class Client {

	public static void main(String[] args) {
		//选择厂家1来进行生产产品
		ConcreteFactory1 f1= new ConcreteFactory1();  
        ProductA a =f1.createProductA();
        System.out.println(a.toString());
          
        //选择厂家2来进行生产产品
        ConcreateFactory2 f2= new ConcreateFactory2();
        ProductB b =f1.createProductB();
        System.out.println(b.toString());
	}

}
