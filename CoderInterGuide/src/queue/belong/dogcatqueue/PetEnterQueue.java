package queue.belong.dogcatqueue;

public class PetEnterQueue {
	private Pet pet;//��̬
	private long count;//ʱ���
	
	public PetEnterQueue(Pet pet,long count){
		this.pet = pet;
		this.count = count;
	}
	
	public Pet getPet(){ //���س���
		return this.pet;
	}
	
	public long getCount(){ //����ʱ���
		return this.count;
	}
	
	public String getEnterPerType(){//���ø��෵�س�������
		return this.pet.getType();
	}
}
