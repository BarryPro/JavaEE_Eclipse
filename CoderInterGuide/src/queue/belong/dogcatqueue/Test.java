package queue.belong.dogcatqueue;

public class Test {
	public static void main(String[] args) {
		DogCatQueue dogcat = new DogCatQueue();
		
		dogcat.add(new Dog());
		dogcat.add(new Dog());
		dogcat.add(new Cat());
		dogcat.add(new Dog());
		dogcat.add(new Cat());
		for(int i = 0;i<5;i++){
			System.out.println(dogcat.pollAll().toString());
		}
	}
	
}
