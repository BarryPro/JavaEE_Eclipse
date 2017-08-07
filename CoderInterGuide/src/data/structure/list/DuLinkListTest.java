package data.structure.list;

public class DuLinkListTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		DuLinkList<Integer> dlist = new DuLinkList<Integer>();
		dlist.add(2);
		dlist.add(3);
		dlist.add(4);
		dlist.add(5);
		dlist.add(6);
		System.out.println(dlist);
		System.out.println(dlist.reverseToString());
		System.out.println(dlist.delete(3));
		System.out.println(dlist);
		
	}

}
