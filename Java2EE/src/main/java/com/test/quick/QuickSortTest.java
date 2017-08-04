package com.test.quick;

import java.util.ArrayList;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/7/16.
 */
public class QuickSortTest {
    public static void main(String[] args) {
        ArrayList<Integer> list = new ReadSample().readNum();
        long start = System.currentTimeMillis();
        quickSort(list,0,list.size()-1);
        long end = System.currentTimeMillis();

        //for(Integer i:list){
        //    System.out.println(i);
        //}
        System.out.println("一共用时："+(end-start));
    }
    public static void quickSort(ArrayList<Integer> a,int start,int end){
        boolean flag = false;
        int i = start;
        int j = end;
        if(i>j){
            return ;
        }
        while(i!=j){
            if(a.get(i)>a.get(j)){
                int tmp = a.get(i);
                a.set(i,a.get(j));
                a.set(j,tmp);
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
