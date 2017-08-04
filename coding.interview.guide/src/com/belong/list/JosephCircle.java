package com.belong.list;

public class JosephCircle {
	public static void main(String [] args){
		int n = 5;
		show(n);
	}
	public static void show(int n){
		int sign[] = new int [n];
		int out[] = new int [n-1];
		int i = 0;
		int k = 0;
		int count = 0;
		while(true){
			i = i % n;
			
			if(sign[i] == 0){
				k++;
				if(k % 3 == 0){
					sign[i] = 1;
					out[count] = i;
					count++;
				}
				
			}
			if(count == n-1){
				break;
			}
			i++;
		}
		for(int p:out){
			System.out.printf("%-4d",p);
		}
		System.out.println();
		for(int l = 0;l<sign.length;l++){
			if(sign[l]==0){
				System.out.println(l);
			
			}
		}
	}
}
