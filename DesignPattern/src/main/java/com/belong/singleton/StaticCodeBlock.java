package com.belong.singleton;
/**
 * @Description: <p>静态代码块来实现单例模式</p>
 * @Author : belong
 * @Date : 2017年8月20日
 */
public class StaticCodeBlock {
	private static StaticCodeBlock singleton;  
	
    private StaticCodeBlock (){}  
    
    /**
     * 根据静态代码块的性质，只有在类加载的时候进行初始化一次
     */
    static {
    	singleton = new StaticCodeBlock();
    }

	public static StaticCodeBlock getInstance() {
		return singleton;
	}
}
