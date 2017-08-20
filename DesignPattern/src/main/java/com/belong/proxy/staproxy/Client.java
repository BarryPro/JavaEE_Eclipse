package com.belong.proxy.staproxy;

public class Client {
	public static void main(String[] args){      
		Subject helloWorld = new RealSubject();      
		Proxy staticProxy = new Proxy(helloWorld);      
		staticProxy.print();
	}    
}
