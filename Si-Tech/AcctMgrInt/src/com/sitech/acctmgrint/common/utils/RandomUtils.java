package com.sitech.acctmgrint.common.utils;

public class RandomUtils {
	public static int getRandom() {
		java.util.Random r = new java.util.Random();
		int ran = r.nextInt(9999);
		int ran1 = r.nextInt(10) * 1000;
		if ((ran + "").length() < 4) {
			ran = ran + ran1;
		}
		int key = 99999;
		int realKey = ran ^ key;
		return realKey;
	}
}
