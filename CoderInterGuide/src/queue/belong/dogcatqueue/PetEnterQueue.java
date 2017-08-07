package queue.belong.dogcatqueue;

public class PetEnterQueue {
	private Pet pet;//多态
	private long count;//时间戳
	
	public PetEnterQueue(Pet pet,long count){
		this.pet = pet;
		this.count = count;
	}
	
	public Pet getPet(){ //返回宠物
		return this.pet;
	}
	
	public long getCount(){ //返回时间戳
		return this.count;
	}
	
	public String getEnterPerType(){//调用父类返回宠物类型
		return this.pet.getType();
	}
}
