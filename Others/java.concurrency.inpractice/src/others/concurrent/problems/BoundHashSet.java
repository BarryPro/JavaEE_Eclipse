package others.concurrent.problems;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.Semaphore;

public class BoundHashSet<T> {
	private final Set<T> set;
	private final Semaphore sem;
	//构造器初始化final 常量
	public BoundHashSet(int bound){
		this.set = Collections.synchronizedSet(new HashSet<T>());
		sem = new Semaphore(bound);
	}
	
	public boolean add(T o) throws InterruptedException {
		sem.acquire();//获得许可
		boolean wasAdded = false;
		try{
			wasAdded = set.add(o);
			return wasAdded;
		} finally{
			if(!wasAdded){
				sem.release();//释放许可
			}
		}
	}
	
	public boolean remove (Object o){
		boolean wasRemoved = set.remove(o);
		if(wasRemoved){
			sem.release();
		}
		return wasRemoved;
	}
}
