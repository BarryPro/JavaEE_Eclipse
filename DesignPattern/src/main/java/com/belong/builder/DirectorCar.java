package com.belong.builder;
/**
 * @Description: <p>Directory类 用于控制这个汽车的组装过程
 * 使用与同样的过程参数不同会有不同的结果</p>
 * @Author : belong
 * @Date : 2017年8月2日
 */
public class DirectorCar {
	public Car construct(CarBuilder carBuilder) {
		Car car;
		carBuilder.buildLogo();
		carBuilder.buildVL();
		carBuilder.buildColor();
		car = carBuilder.createCar();
		return car;
	}
}
