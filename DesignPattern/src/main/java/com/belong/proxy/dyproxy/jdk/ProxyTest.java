package com.belong.proxy.dyproxy.jdk;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Proxy;
//JDK动态代理
public class ProxyTest {
	public static void main(String[] args) {

		final IAnimal animal = new Cat();

		InvocationHandler handler = new TraceHandler(animal);

		//代理类通过传进来的运行时类和实现的接口以及装载了被代理类的句柄来进行实例化代理对象
		//实际是通过反射来进行实例化
		Object proxyObj = Proxy.newProxyInstance(
				animal.getClass().getClassLoader(),//得到要进行代理类的类加载器
				animal.getClass().getInterfaces(),//得到类实现的接口
				handler //实现调用句柄类做句柄（实际的代理类）
				);

		if (proxyObj instanceof IAnimal) {
			System.out.println("the proxyObj is an animal!");
			IAnimal animalProxy = (IAnimal)proxyObj;
			animalProxy.go();
			animalProxy.info();
		} else {
			System.out.println("the proxyObj isn't an animal!");
		}
	}
}
