package com.belong.singleton;

import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

/**
 * @Description: <p>单例模式测试类
 * 采用多线程和反射技术来进行测试</p>
 * @Author : belong
 * @Date : 2017年8月19日
 */
public class SingleTonTest {
	// 必须使用并发容器来进行装实例对象
	private static final Set<Integer> set = new CopyOnWriteArraySet<>();
	private static final String[] methods = {"lazyBones","syncLazyBones","eager","staticCodeBlock","volatileDCL","staticInnerClass","enumSingleton"};
	public static void main(String[] args) {
		long start = System.currentTimeMillis();
		// 创建15个线程来进行实例化
		// 线程数
		int n = 10000;
		for (int i = 0; i < n; i++) {
			new Thread(new Runnable() {				
				@Override
				public void run() {					
					try {
						// 调用该对象的反射对象
						Object object = Class.forName("com.belong.singleton.SingleTonTest").newInstance();
						// 得到反射要用的运行是类
						Class<?> classType = Class.forName("com.belong.singleton.SingleTonTest");
						classType.getMethod(methods[3], null).invoke(object, null);
					} catch (Exception e) {
						e.printStackTrace();
					}					
				}
			}).start();;
		}
		long end = System.currentTimeMillis();
		System.out.println("实例化"+n+"个实例一共耗时"+(end-start)+"毫秒");
		System.out.println(set);
		System.out.println("一共产生了"+set.size()+"个实例");
	}
	
	/**
	 * 1、单例模式-懒汉模式-线程不安全
	 */
	public static void lazyBones() {	
		set.add(LazyBones.getInstance().hashCode());
	}
	
	/**
	 *2、单例模式-同步懒汉模式-线程安全的-性能低
	 */
	public static void syncLazyBones() {	
		set.add(SyncLazyBones.getInstance().hashCode());
	}
	
	/**
	 *3、单例模式-饿汉模式-线程安全的-浪费资源
	 */
	public static void eager() {	
		set.add(Eager.getInstance().hashCode());
	}
	
	/**
	 *4、单例模式-静态代码块-线程安全的
	 */
	public static void staticCodeBlock() {	
		set.add(StaticCodeBlock.getInstance().hashCode());
	}
	
	/**
	 *5、单例模式-volatile双检索模式-线程安全的
	 */
	public static void volatileDCL() {	
		set.add(VolatileDCL.getInstance().hashCode());
	}
	
	/**
	 *6、单例模式-静态内部类单例模式-线程安全的-懒加载节省资源
	 */
	public static void staticInnerClass() {	
		set.add(StaticInnerClass.getInstance().hashCode());
	}
	
	/**
	 *7、单例模式-枚举单例模式-线程安全的-懒加载节省资源-简单-自动支持序列化机制
	 */
	public static void enumSingleton() {	
		set.add(Enum.INSTANCE.getInstance().hashCode());
	}
	

}
