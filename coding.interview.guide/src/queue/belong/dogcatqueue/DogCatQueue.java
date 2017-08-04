package queue.belong.dogcatqueue;

import java.util.LinkedList;
import java.util.Queue;
/**
 * 猫狗队列
 * @author Belong
 *
 */

public class DogCatQueue {
	private Queue<PetEnterQueue> dogQ;
	private Queue<PetEnterQueue> catQ;
	private long count;//负责记录当前的时间戳
	
	public DogCatQueue(){
		this.dogQ = new LinkedList<PetEnterQueue>();
		this.catQ = new LinkedList<PetEnterQueue>();
		this.count = 0;
	}
	
	public void add(Pet pet){
		if(pet.getType().equals("dog")){
			this.dogQ.add(new PetEnterQueue(pet,this.count++));
		} else if(pet.getType().equals("cat")){
			this.catQ.add(new PetEnterQueue(pet,this.count++));
		} else {
			throw new RuntimeException("error,not dog or cat");
		}
	}
	
	public Pet pollAll(){
		if(!this.catQ.isEmpty()&&!this.dogQ.isEmpty()){
			if(this.dogQ.peek().getCount()<this.catQ.peek().getCount()){//猫狗同时存在按谁的时间戳小谁先出队列
				return this.dogQ.poll().getPet();
			} else {
				return this.catQ.poll().getPet();
			}
		} else if(!this.dogQ.isEmpty()){
			return this.dogQ.poll().getPet();
		} else if(!this.catQ.isEmpty()){
			return this.catQ.poll().getPet();
		} else {
			throw new RuntimeException("error,not cat or dog");
		}
	}
	
	public Dog pollDog(){
		if(!this.dogQ.isEmpty()){
			return (Dog)this.dogQ.poll().getPet();
		} else {
			throw new RuntimeException("Dog queue is empty");
		}
	}
	
	public Cat pollCat(){
		if(!this.dogQ.isEmpty()){
			return (Cat)this.catQ.poll().getPet();
		} else {
			throw new RuntimeException("cat queue is empty");
		}
	}
	
	public boolean isEmpty(){//两个队列同时为空才为空
		return this.dogQ.isEmpty()&&this.catQ.isEmpty();
	}
	
	public boolean isDogQueueEmpty(){
		return this.dogQ.isEmpty();
	}
	
	public boolean isCatQueueEmpty(){
		return this.catQ.isEmpty();
	}
}
