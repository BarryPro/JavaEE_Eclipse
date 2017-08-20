package com.belong.builder;
/**
 * @Description: <p>Car车类：符合产品（Product）</p>
 * @Author : belong
 * @Date : 2017年8月2日
 */
public class Car {
	private String logo;
	private Double VL;
	private String color;
	
	public String getLogo() {
		return logo;
	}
	public void setLogo(String logo) {
		this.logo = logo;
	}
	public Double getVL() {
		return VL;
	}
	public void setVL(Double vL) {
		VL = vL;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	
}

