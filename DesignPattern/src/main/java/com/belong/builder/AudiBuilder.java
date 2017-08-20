package com.belong.builder;
/**
 * @Description: <p></p>
 * @Author : belong
 * @Date : 2017年8月2日
 */
public class AudiBuilder extends CarBuilder {

	@Override
	public void buildLogo() {
		car.setLogo("AUDI-a6");
	}

	@Override
	public void buildVL() {
		car.setVL(1.6);
	}

	@Override
	public void buildColor() {
		car.setColor("black");
	}

}
