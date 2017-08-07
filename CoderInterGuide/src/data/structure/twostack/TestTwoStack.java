package data.structure.twostack;

public class TestTwoStack {
	public static void main(String[] args) {
		TwoStack queue = new TwoStack();
		queue.add(1);
		queue.add(2);
		queue.add(3);
		queue.add(4);
		queue.add(5);
		for(int i = 0; i < 5; i++){
			System.out.println(queue.poll());
		}
	}
}
