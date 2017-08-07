package com.belong.list;

public class Josephuskill1Test {
	public static void main(String[] args) {
		JosephusKill1 list = new JosephusKill1();
		list.add(1);
		list.add(2);
		list.add(3);
		list.add(4);
		list.add(5);
		System.out.println(list.josephusKill1(list.getHead(), 3).value);
	}
}
