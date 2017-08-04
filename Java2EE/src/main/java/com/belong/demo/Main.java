package com.belong.demo;

import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner cin = new Scanner(System.in);
        while (cin.hasNext()) {
            int num = cin.nextInt();
            int[] arrs = new int[num];
            for (int i = 0; i < num; i++) {
                arrs[i] = cin.nextInt();
            }
            int count = 0;
            int arrays[] = arrs;
            boolean flag = false;
            int index = 0;
            for (int i = index; i < arrs.length; ) {
                for (int j = index+1; j < arrs.length; j++) {
                    if (arrays[i] > arrs[j]) {
                        arrs = getCopy(arrs, i,flag);
                        count++;
                        arrays = arrs;
                        flag = false;
                        break;
                    } else {
                        i++;
                        flag = true;
                        index = i;
                    }
                }
                if (i == num-1) {
                    System.out.println(count);
                    break;
                }
            }

        }
    }

    /**
     * 用于交换数组
     *
     * @param index 是不动的点
     * @param array
     * @return
     */
    public static int[] getCopy(int[] array, int index,boolean flag) {
        int[] new_Arrs = new int[array.length];
        int first = 0;
        if(flag){
            first = array[index-1];
        }
        int tmp = array[index];
        for (int i = index + 1; i < array.length; i++) {
            new_Arrs[i-1] = array[i];
        }
        new_Arrs[array.length - 1] = tmp;
        if(flag){
            new_Arrs[index-1] = first;
        }
        return new_Arrs;
    }
}
