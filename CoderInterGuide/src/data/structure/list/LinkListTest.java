package data.structure.list;


public class LinkListTest {
	public static void main(String[] args) {
		LinkList<Integer> list1 = new LinkList<Integer>();
		list1.add(1);
		list1.add(2);
		list1.add(3);
		list1.add(4);
		list1.add(5);
		//System.out.println(list1);
		LinkList<Integer> list2 = new LinkList<Integer>();		
		list2.add(2);
		list2.add(3);
		list2.add(4);
		list2.add(5);
		list2.add(6);
		//System.out.println(list2);
		new LinkList<Integer>().printCommonPart(list1, list2);
	}
	
	
}
