package com.test.quick;

import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.RecursiveAction;

/**
 * @Description: <p>还是没有成功应该是fork函数的调用问题</p>
 * @Author: belong.
 * @Date: 2017/7/16.
 */
public class QuickSortClassParamTest {
    public static void main(String[] args) {
        Integer [] a = {3,5,35,456,4,6,4,53,46,34,634,7,3456,43};
        QuickSort sortTask = new QuickSort(a);
        //sortTask.quickSort();
        //sortTask.compute();
        ForkJoinPool pool = new ForkJoinPool();
        pool.submit(sortTask);
        for(Integer i:a){
            System.out.print(i+" ");
        }
    }
}

// 快排类
class QuickSort extends RecursiveAction {
    final Integer[] a;
    final Integer start;
    final Integer end;

    // 初始时传参
    public QuickSort(Integer[] a) {
        this.a = a;
        this.start = 0;
        this.end = a.length - 1;
    }

    // 过程中传参
    public QuickSort(Integer[] a,Integer start,Integer end) {
        this.a = a;
        this.start = start;
        this.end = end;
    }

    public void quickSort(){
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
        new QuickSort(a,start,i).quickSort();
        new QuickSort(a,j,end).quickSort();
    }

    @Override
    protected void compute() {
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
        new QuickSort(a, start, i).fork();
        new QuickSort(a, j, end).fork();
        //new QuickSort(a, start, i).compute();
        //new QuickSort(a, j, end).compute();
    }
}
