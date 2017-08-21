package com.belong.algorithms.sort.quicksort;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.RecursiveAction;

import com.belong.io.ReadSample;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/7/16.
 */
public class FastSortByForkAndJoin {
    public static void main(String[] args) {
        ArrayList<Integer> arrayList = new ReadSample().readNum();
        long longArray[] = new long[arrayList.size()];
        for (int i = 0; i < arrayList.size(); i++) {
            longArray[i] = Long.parseLong(arrayList.get(i).toString());
        }

        ForkJoinPool pool = new ForkJoinPool();
        FastSort fastSort = new FastSort(longArray);
        long startTime = System.currentTimeMillis();
        pool.execute(fastSort);
        while (!fastSort.isDone()) {
        }
        long endTime = System.currentTimeMillis();

        System.out.println("排序所花时间:" + (endTime - startTime) + "ms");
    }
}

class FastSort extends RecursiveAction {

    final long[] array;
    final int lo;
    final int hi;
    private int THRESHOLD = 30;

    public FastSort(long[] array) {
        this.array = array;
        this.lo = 0;
        this.hi = array.length - 1;
    }

    public FastSort(long[] array, int lo, int hi) {
        this.array = array;
        this.lo = lo;
        this.hi = hi;
    }

    @Override
    protected void compute() {
        if (hi - lo < THRESHOLD)
            sequentiallySort(array, lo, hi);
        else {
            int pivot = partition(array, lo, hi);
            FastSort left = new FastSort(array, lo, pivot - 1);
            FastSort right = new FastSort(array, pivot + 1, hi);

            invokeAll(left, right);
        }
    }

    private int partition(long[] array, int lo, int hi) {
        long x = array[hi];
        int i = lo - 1;
        for (int j = lo; j < hi; j++) {
            if (array[j] <= x) {
                i++;
                swap(array, i, j);
            }
        }
        swap(array, i + 1, hi);
        return i + 1;
    }

    private void swap(long[] array, int i, int j) {
        if (i != j) {
            long temp = array[i];
            array[i] = array[j];
            array[j] = temp;
        }
    }

    private void sequentiallySort(long[] array, int lo, int hi) {
        Arrays.sort(array, lo, hi + 1);
    }
}
