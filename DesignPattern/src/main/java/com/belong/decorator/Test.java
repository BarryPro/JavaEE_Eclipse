package com.belong.decorator;

public class Test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		

			//��ͨ����Ů��

			Girl g1 = new AmericanGirl();

			System.out.println(g1.getDescription());//
//			//ϲ����ѧ��
//
			Science g2 = new Science(g1);

			System.out.println(g2.getDescription());
//
//
//			//ϲ��������
//
			Art g3 = new Art(g2);

			System.out.println(g3.getDescription());		

	}

}
