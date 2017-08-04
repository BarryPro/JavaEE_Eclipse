package others.concurrent.problems;

import java.util.concurrent.CountDownLatch;

public class TestHarness {
	public static void main(String[] args) throws InterruptedException {
		System.out.println(new TestHarness().timeTasks(4, new Thread()));
	}
	public long timeTasks(int nThreads,final Runnable task)
			throws InterruptedException{
		final CountDownLatch startGate = new CountDownLatch(1);
		final CountDownLatch endGate = new CountDownLatch(nThreads);
		
		for(int i = 0;i<nThreads;i++){
			Thread t = new Thread(){
				public void run(){
					try{
						startGate.await();//相当于acquire（）+1
						try{
							task.run();
						}finally{
							endGate.countDown();//相当于release（）-1
						}
					}catch(InterruptedException ignored){
						
					}
				}
			};
			t.start();
		}
		
		long start = System.nanoTime();
		startGate.countDown();
		endGate.await();
		long end = System.nanoTime();
		return end-start;
		
	}
}
