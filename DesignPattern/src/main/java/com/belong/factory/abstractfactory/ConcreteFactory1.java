package com.belong.factory.abstractfactory;

//具体工厂来生产产品族的具体产品（不同的厂家）
public class ConcreteFactory1 implements AbstractFactory{
	public ProductA createProductA(){
		return new ProductA();
	}
	
	public ProductB createProductB(){
		return new ProductB();
	}
	
}
