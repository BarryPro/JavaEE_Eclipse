package com.belong.test;

import java.util.Scanner;

/**
 * @Description: <p></p>
 * @Author : belong
 * @Date : 2017年8月25日
 */
public class AliLoadBox {
	private static Model[] items;
	private static int CUSTOMS_LIMIT_MONEY_PER_BOX = 2000;
	private static int boxMinNum = -1;

	private static int process() {
		// 1.按箱子长宽高最小的一个排序
		String min = "";
		if (boxTemplate.length > boxTemplate.width) {
			if (boxTemplate.width > boxTemplate.height) {
				min = "height";
			} else {
				min = "width";
			}

		} else {
			if (boxTemplate.length > boxTemplate.height) {
				min = "height";
			} else {
				min = "length";
			}
		}
		int tmp = 0;
		switch (min) {
		case "length":			
			for (int i = 0; i < items.length; i++) {
				if (boxTemplate.price <= CUSTOMS_LIMIT_MONEY_PER_BOX && tmp <= boxTemplate.length) {
					boxTemplate.price += items[i].price;
					tmp += items[i].length;
				} else {
					boxMinNum++;
					tmp = 0;
				}
			}
			break;
		case "height":
			for (int i = 0; i < items.length; i++) {
				if (boxTemplate.price <= CUSTOMS_LIMIT_MONEY_PER_BOX && tmp <= boxTemplate.length) {
					boxTemplate.price += items[i].price;
					tmp += items[i].height;
				} else {
					boxMinNum++;
					tmp = 0;
				}
			}
			break;
		default:
			for (int i = 0; i < items.length; i++) {
				if (boxTemplate.price <= CUSTOMS_LIMIT_MONEY_PER_BOX && tmp <= boxTemplate.length) {
					boxTemplate.price += items[i].price;
					tmp += items[i].width;
				} else {
					boxMinNum++;
					tmp = 0;
				}
			}
			break;
		}
		return boxMinNum == -1? boxMinNum:++boxMinNum;
	}

	public static void main(String args[]) {
		Scanner scanner = new Scanner(System.in);
		boxTemplate.price = CUSTOMS_LIMIT_MONEY_PER_BOX;

		while (scanner.hasNext()) {
			boxTemplate.length = scanner.nextInt();
			boxTemplate.width = scanner.nextInt();
			boxTemplate.height = scanner.nextInt();

			int itemNum = scanner.nextInt();
			items = new Model[itemNum];
			for (int i = 0; i < itemNum; i++) {
				Model item = new Model();
				item.price = scanner.nextInt();
				item.length = scanner.nextInt();
				item.width = scanner.nextInt();
				item.height = scanner.nextInt();
				items[i] = item;
			}
			long startTime = System.currentTimeMillis();
			System.out.println(process());
		}
	}

}

class Model {
	public int price;
	public int length;
	public int width;
	public int height;
}

class boxTemplate {
	public static int price;
	public static int length;
	public static int width;
	public static int height;
}
