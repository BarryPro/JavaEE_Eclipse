package com.belong.proxy.dyproxy.cglib;

import net.sf.cglib.proxy.Enhancer;
import net.sf.cglib.proxy.MethodInterceptor;
import net.sf.cglib.proxy.MethodProxy;

import java.lang.reflect.Method;

/**
 * 使用cglib动态代理
 * 实现方法拦截器
 * @author belong
 *
 */
public class BookFacadeCglib implements MethodInterceptor {
    private Object target;

    /**
     * 创建代理对象
     *
     * @param target
     * @return
     */
    public Object getInstance(Object target) {
        this.target = target;
        // 用来实例化被代理的对象的增强子
        Enhancer enhancer = new Enhancer();
        enhancer.setSuperclass(this.target.getClass());
        // 回调方法
        // this指的是BookFacadeCglib类（也就是要代理类的子类）
        enhancer.setCallback(this);
        // 创建代理对象
        return enhancer.create();
    }

    @Override
    /**
     * 回调方法
     * 在被代理类调用自己的方法时会调用拦截器方法（eg：添加事务）
     */
    public Object intercept(Object obj, Method method, Object[] args,
                            MethodProxy proxy) throws Throwable {
        System.out.println("事物开始");
        proxy.invokeSuper(obj, args);
        System.out.println("事务结束");
        return null;


    }

}
