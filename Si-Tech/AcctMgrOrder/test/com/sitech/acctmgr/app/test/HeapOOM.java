package com.sitech.acctmgr.app.test;

import java.util.ArrayList;
import java.util.List;

import org.springframework.context.support.StaticApplicationContext;

public class HeapOOM {
	static class OOMObject {
		
	}
	
	public static void main (String[] args) {
		
		String s1 = new StringBuilder("computer").append("software").toString();
		System.out.println(s1.intern() == s1+s1.intern());
		String s2 = new StringBuilder("ja").append("va").toString();
		System.out.println(s2.intern() == s2+s2.intern());
		
		//OOMtest
//		List<OOMObject> list = new ArrayList<HeapOOM.OOMObject>();
//		while (true) {
//			list.add(new OOMObject());
//		}
	}

}
