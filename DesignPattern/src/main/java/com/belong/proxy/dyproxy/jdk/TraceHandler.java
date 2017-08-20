package com.belong.proxy.dyproxy.jdk;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;

/**
 * 定义的代理类
 * 重写调用（invoke）方法，这个invoke中的内容就是代理处理的事情
 */
public class TraceHandler implements InvocationHandler{
	private Object target;

	public TraceHandler(Object target) {   
		this.target = target;   
	}   

	@Override
	public Object invoke(Object proxy, Method method, Object[] args)
			throws Throwable {
		try {
			System.out.println("调用的方法名："+ method.getName());
			return method.invoke(target, args);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return null;
		} finally {
			System.out.println("hello world");
		}
	}
}
