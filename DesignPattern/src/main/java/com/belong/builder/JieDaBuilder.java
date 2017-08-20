package com.belong.builder;
/**
 * @Description: <p></p>
 * @Author : belong
 * @Date : 2017年8月2日
 */
public class JieDaBuilder extends CarBuilder {

	@Override
	public void buildLogo() {
		car.setLogo("桑塔纳2000");
	}

	@Override
	public void buildVL() {
		car.setVL(2.0);
	}

	@Override
	public void buildColor() {
		car.setColor("red");
	}

}
