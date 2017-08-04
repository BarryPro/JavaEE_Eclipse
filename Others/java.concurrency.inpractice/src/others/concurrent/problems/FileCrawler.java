package others.concurrent.problems;

import java.io.File;
import java.io.FileFilter;
import java.util.concurrent.BlockingQueue;

public class FileCrawler implements Runnable {
	private final BlockingQueue<File> fileQueue;
	private final FileFilter fileFilter;
	private final File root;
	
	public FileCrawler(BlockingQueue<File> queue, FileFilter filter, File root2) {
		// TODO Auto-generated constructor stub
		this.fileQueue = queue;
		this.fileFilter = filter;
		this.root = root2;
	}

	@Override
	public void run() {
		// TODO Auto-generated method stub
		try {
			crawl(root);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private void crawl(File root) throws InterruptedException{
		File[] entries = root.listFiles(fileFilter);
		if(entries != null){
			for(File entry:entries){
				if(entry.isDirectory()){
					crawl(entry);
				}else if(!alreadyIndexed(entry)){
					fileQueue.put(entry);
				}
			}
		}
	}

	private boolean alreadyIndexed(File entry) {
		// TODO Auto-generated method stub
		return false;
	}
}
