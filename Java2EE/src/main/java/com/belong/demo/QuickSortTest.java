package com.belong.demo;

/**
 * Created by belong on 2017/4/9.
 */
public class QuickSortTest {
    private int start;
    private int end;
    public static void main(String[] args) {
        int [] a = {34,5456,24,534,34,2,35,643,234,4,1,34};
        int start = 0;
        int end = a.length-1;
        new QuickSortTest().quickSort(a,start,end);
        for (int i : a) {
            System.out.print(i+" ");
        }
    }

    public void quickSort(int [] a ,int start,int end){
        boolean flag = false;
        int i = start;
        int j = end;
        if(i >= j){
            return;
        }
        //开始进入循环排序
        while(i != j){
            if(a[i] > a[j]){
                int tmp = a[i];
                a[i] = a[j];
                a[j] = tmp;
                //只要交换了就改变方向
                flag = !flag;
            }
            if(!flag){
                j--;
            } else {
                i++;
            }
        }
        //i和j没有从参数中传过来
        i--;
        j++;
        //new Thread(()-> quickSort(a,start,i)).start();
        //new Thread(()-> quickSort(a,j,end)).start();
        quickSort(a,start,i);
        quickSort(a,j,end);
    }

}
