package com.belong.algorithms.sort.quicksort;

/**
 * Created by belong on 2017/4/9.
 */

import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

public class ThreadExecutor {
    // 创建线程池
    public static ExecutorService exec = Executors.newCachedThreadPool();
    private int[] array;

    public ThreadExecutor(int[] array) {
        this.array = array;
        createThread(0, array.length - 1);
    }

    public void createThread(int start, int end) {
        // 用于存放待处理信息类
        Future<Point> future = exec.submit((new ThreadQuickSort(start, end, array)));
        try {
            System.out.println("中间值是："+future.get().getMiddle());
            if (future.get().compareStartMiddle())
                // 相当于i--
                createThread(future.get().getStart(), future.get().getMiddle() - 1);
            if (future.get().compareMiddleEnd())
                // 相当于j++
                createThread(future.get().getMiddle() + 1, future.get().getEnd());
        } catch (InterruptedException e) {
            e.printStackTrace();
        } catch (ExecutionException e) {
            e.printStackTrace();
        }
    }

    /**
     * 输出函数
     */
    public void print() {
        System.out.println("输出排序后的结果：");
        for (int g : array)
            System.out.print(g + " ");
    }

    public static void main(String[] args) {
        int[] array = {10, 9, 8, 7, 5, 6, 4, 3, 2, 1};
        ThreadExecutor tx = new ThreadExecutor(array);
        tx.print();
        // 用完线程池一定要进行关闭
        exec.shutdown();
    }
}
