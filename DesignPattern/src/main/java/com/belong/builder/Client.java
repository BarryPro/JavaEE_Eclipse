package com.belong.builder;
/**
 * @Description: <p>用户测试类</p>
 * @Author : belong
 * @Date : 2017年8月2日
 */
public class Client {
	public static void main(String[] args) {
		DirectorCar director = new DirectorCar();
		AudiBuilder audiBuilder = new AudiBuilder();
		Car car = director.construct(audiBuilder);
		System.out.println("车型："+car.getLogo());
		System.out.println("排气量："+car.getVL());
		System.out.println("颜色："+car.getColor());
	}

}
