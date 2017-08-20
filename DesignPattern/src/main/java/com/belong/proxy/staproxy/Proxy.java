package com.belong.proxy.staproxy;

public class Proxy  implements Subject{
	public Subject helloWorld ;      
	public Proxy(Subject helloWorld){      
		this.helloWorld = helloWorld;      
	}      

	public void print(){      
		System.out.println("代理器：Welcome");      
		//相当于回调      
		helloWorld.print();      
	}      

	     
}
