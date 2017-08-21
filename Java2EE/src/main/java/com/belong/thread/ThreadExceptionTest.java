package com.belong.thread;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/7/13.
 */
public class ThreadExceptionTest implements Thread.UncaughtExceptionHandler{

    public static void main(String[] args) {
        try {
            Thread.currentThread().setUncaughtExceptionHandler(new ThreadExceptionTest());
            int a = 5/0;
            new Thread(new ThreadTest()).start();
            System.out.println("程序正常结束");
        } catch (Exception e) {
            System.out.println("异常捕获");
        }
    }

    @Override
    public void uncaughtException(Thread t, Throwable e) {
        System.out.println(t+" 线程出现了异常："+e);
    }
}

class ThreadTest implements Runnable{

    @Override
    public void run() {
        try {
            int b = 4/0;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
