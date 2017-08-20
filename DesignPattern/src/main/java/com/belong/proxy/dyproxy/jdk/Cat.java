package com.belong.proxy.dyproxy.jdk;

public class Cat implements IAnimal{
	@Override
     public void info() {
         System.out.println("This is a cat!");
     }

	@Override
	public void go() {
		System.out.println("GO GO GO GO");
	}
 
}
