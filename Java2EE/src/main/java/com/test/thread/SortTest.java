package com.test.thread;

/**
 * @Description: <p>单线程版</p>
 * @Author: belong.
 * @Date: 2017/7/16.
 */
public class SortTest {
    private static int start;
    private static int end;

    public static void main(String[] args) {
        int [] a = {2,3,2,5,234,532,54,53,56,2,345,563,436,42,4,2,52,45};
        start = 0;
        end = a.length-1;
        quickSort(a,start,end);
        for(int i:a){
            System.out.print(i+" ");
        }
    }

    public static void quickSort(int[] a,int start,int end){
        boolean flag = false;
        int i = start;
        int j = end;
        if(i>j){
            return ;
        }
        while(i!=j){
            if(a[i]>a[j]){
                int tmp = a[i];
                a[i] = a[j];
                a[j] = tmp;
                flag = !flag;
            }
            if(flag){
                j--;
            } else {
                i++;
            }
        }
        i--;
        j++;
        quickSort(a,start,i);
        quickSort(a,j,end);
    }
}
