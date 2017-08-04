package com.thread;

import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.FutureTask;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/7/11.
 */
public class FutureTest {
    public static void main(String[] args) {
        Callable callable = () -> {
            for (int i = 0; i < 100; i++) {
                System.out.println(Thread.currentThread().getName()+" "+i);
            }
            return "belong";
        };

        Callable callable1 = () -> {
            for (int i = 0; i < 100; i++) {
                System.out.println(Thread.currentThread().getName()+" "+i);
            }
            return "belong1";
        };
        FutureTask future = new FutureTask(callable);
        FutureTask future1 = new FutureTask(callable1);
        new Thread(future).start();
        new Thread(future1).start();
        try {
            System.out.println(future.get());
            System.out.println(future1.get());
        } catch (InterruptedException e) {
            e.printStackTrace();
        } catch (ExecutionException e) {
            e.printStackTrace();
        }
    }
}


