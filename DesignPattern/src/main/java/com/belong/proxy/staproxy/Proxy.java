package com.belong.proxy.staproxy;

public class Proxy  implements Subject{
	public Subject helloWorld ;      
	public Proxy(Subject helloWorld){      
		this.helloWorld = helloWorld;      
	}      

	public void print(){      
		System.out.println("��������Welcome");      
		//�൱�ڻص�      
		helloWorld.print();      
	}      

	     
}
