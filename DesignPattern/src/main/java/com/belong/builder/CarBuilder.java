package com.belong.builder;
/**
 * @Description: <p>汽车组合器：抽象建造者（Builder）</p>
 * @Author : belong
 * @Date : 2017年8月2日
 */

import com.sun.org.apache.xml.internal.resolver.helpers.PublicId;

public abstract class CarBuilder {
	protected Car car = new Car();
	
	public abstract void buildLogo();
	public abstract void buildVL();
	public abstract void buildColor();
	
    // 返回创建好的产品
	public Car createCar() {
		return car;
	}
}
