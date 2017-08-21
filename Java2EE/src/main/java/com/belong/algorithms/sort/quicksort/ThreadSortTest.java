package com.belong.algorithms.sort.quicksort;

import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.RecursiveAction;

/**
 * @Description: <p>多线程快排</p>
 * @Author: belong.
 * @Date: 2017/7/16.
 */
public class ThreadSortTest {
    public static void main(String[] args) throws InterruptedException {
        int[] a = {2, 3, 2, 5, 234, 532, 54, 53, 56, 2, 345, 563, 436, 42, 4, 2, 52, 45};
        int start = 0;
        int end = a.length - 1;
        SortTask sortTask = new SortTask(a,start,end);
        ForkJoinPool pool = new ForkJoinPool();
        //pool.awaitTermination(2, TimeUnit.SECONDS);
        pool.submit(sortTask);
        for(int i:sortTask.getA()){
            System.out.print(i+" ");
        }
        pool.shutdown();
    }
}

class SortTask extends RecursiveAction {

    private volatile int start;
    private volatile int end;
    private volatile int[] a;

    public int[] getA(){
        return a;
    }

    public SortTask(int[] a, int start, int end) {
        this.a = a;
        this.start = start;
        this.end = end;
    }

    @Override
    protected void compute() {
        boolean flag = false;
        int i = start;
        int j = end;
        if (i > j) {
            return;
        }
        while (i != j) {
            if (a[i] > a[j]) {
                int tmp = a[i];
                a[i] = a[j];
                a[j] = tmp;
                flag = !flag;
            }
            if (flag) {
                j--;
            } else {
                i++;
            }
        }
        i--;
        j++;
        //System.out.println(Thread.currentThread().getName()+"i: "+a[i]);
        SortTask task_start = new SortTask(a, start, i);
        SortTask task_end = new SortTask(a, j, end);
        task_start.fork();
        task_end.fork();
    }
}
