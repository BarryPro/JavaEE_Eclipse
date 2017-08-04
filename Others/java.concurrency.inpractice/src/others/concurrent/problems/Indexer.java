package others.concurrent.problems;

import java.io.File;
import java.io.FileFilter;
import java.util.Collection;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;

public class Indexer implements Runnable {
	private static final int N_CONSUMERS = 0;
	private static final Collection<? extends File> BOUND = null;
	private final BlockingQueue<File> queue;
	
	public Indexer(BlockingQueue<File> queue){
		this.queue = queue;
	}
	@Override
	public void run() {
		// TODO Auto-generated method stub
		try {
			while(true){
				indexFile(queue.take());
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	private void indexFile(File take) {
		// TODO Auto-generated method stub
		
	}
	public static void startIndexing(File[] roots){
		BlockingQueue<File> queue = new LinkedBlockingQueue<File>(BOUND);
		FileFilter filter = new FileFilter(){
			public boolean accept(File file){
				return true;
			}
		};
		
		for(File root:roots){
			new Thread (new FileCrawler(queue,filter,root)).start();
		}
		for(int i = 0;i<N_CONSUMERS;i++){
			new Thread(new Indexer(queue)).start();
		}
	}
	

}
