package com.belong.test;
/**
 * @Description: <p></p>
 * @Author : belong
 * @Date : 2017年8月20日
 */

import com.sun.media.jfxmedia.control.VideoDataBuffer;

public class VolatileTest {
	private volatile String string;
	public void fun() {
		string = new String("belong");
	}
}
