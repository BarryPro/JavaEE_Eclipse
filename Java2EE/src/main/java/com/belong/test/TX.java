package com.belong.test;
/**
 * @Title :
 * @Description : 
 * <p></p>
 * @Author : belong
 * @Date : 2017年9月12日
 */

interface IX{
	String isx = "isx";
	boolean execute(String sql);
}

abstract class AbsIX implements IX{
	static String isx = "absix";
	public AbsIX() {
		System.out.println(isx);
	}
}
class CX1 extends AbsIX{
	static {
		isx = "CX1";
	}

	@Override
	public boolean execute(String sql) {
		System.out.println(isx);
		return this.isx=="CX1";
	}
	
}

class CX2 extends AbsIX{
	CX2(){
		isx = "CX2";
	}
	@Override
	public boolean execute(String sql) {
		System.out.println(isx);
		return this.isx=="CX2";
	}
	
}

public class TX {
	public static void main(String[] args) {
		IX cx1 = new CX1();
		IX cx2 = new CX2();
		if(cx1.execute(null)) {
			System.out.println(cx2.isx);
		} else if (cx2.execute(null)){
			System.out.println(cx1.isx);
		}
		
	}
}