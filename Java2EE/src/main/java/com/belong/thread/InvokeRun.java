package com.belong.thread;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/7/10.
 */
public class InvokeRun extends Thread {
    private int i;

    @Override
    public void run() {
        for (; i < 100; i++) {
            System.out.println(Thread.currentThread().getName() + " " + i + " isLive:" + Thread.currentThread().isAlive());
        }
    }

    public static void main(String[] args) {
        for (int i = 0; i < 100; i++) {
            System.out.println(Thread.currentThread().getName() + " " + i + " isLive:" + Thread.currentThread().isAlive());
            InvokeRun invokeRun = new InvokeRun();
            if (i == 20) {
                InvokeRun invokeRun_1 = new InvokeRun();
                InvokeRun invokeRun_2 = new InvokeRun();
                // 一个线程调用完run方法后就不在是新建状态了
                //invokeRun_1.run();
                //invokeRun_2.run();
                //invokeRun_1.start();
                //invokeRun_2.start();
                invokeRun.start();
                invokeRun.start();
            }
            //if(i>20&&!invokeRun.isAlive()){
            //    invokeRun.start();
            //}
            //try {
            //    Thread.sleep(1);
            //} catch (InterruptedException e) {
            //    e.printStackTrace();
            //}
        }
    }
}
