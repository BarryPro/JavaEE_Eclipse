package com.belong.builder;
/**
 * @Description: <p></p>
 * @Author : belong
 * @Date : 2017年8月2日
 */
public class BinLiBuilder extends CarBuilder {

	@Override
	public void buildLogo() {
		car.setLogo("BinLI-7");
	}

	@Override
	public void buildVL() {
		car.setVL(3.0);
	}

	@Override
	public void buildColor() {
		car.setColor("blue");
	}

}
