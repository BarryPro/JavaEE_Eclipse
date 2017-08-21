package com.belong.ds.list;

/**实现空间复杂度是O(1) 时间O(n)
 * Created by belong on 2016/8/24.
 */
public class Palindrome3 {
    public class Node{
        public int value;
        public Node next;
        public Node(int value,Node next){
            this.value = value;
            this.next = next;
        }
    }
    private Node head;
    private Node tail;
    private int size;

    public Node getHead() {
        return head;
    }

    public void add(int data){
        if(head == null){
            head = new Node(data,null);
            tail = head;
        } else {
            Node node = new Node(data,null);
            tail.next = node;
            tail = node;
        }
        size++;
    }

    //利用链表的逆序
    public boolean isPalindrome3(Node head){
        if(head == null || head.next == null){
            return true;
        }
        //先找到中间的节点
        Node n1 = head;
        Node n2 = head;
        while(n2.next != null && n2.next.next != null){
            //n1用于存放中间的节点
            n1 = n1.next;
            //n2决定遍历的次数（相当于除以2）
            n2 = n2.next.next;
        }
        //n2指向右变的第一个节点
        n2 = n1.next;
        //下面就是把右面的节点进行逆序
        //让n1的下一节点为空(也就是右边的第二个节点)
        //让中间的节点与后面的节点断开（当做pre节点）
        n1.next = null;
        Node n3 = null;
        //此时的n2相当于head
        //n3相当于next
        //n1相当于pre
        while(n2 != null){
            n3 = n2.next;
            n2.next = n1;
            n1 = n2;
            n2 = n3;
        }
        //现在逆序之后的头是n1(也就是原链表的最后一个节点)
        //此时的n2和n3都已经没有用了(可以继续使用)
        //保存原链表的最一个节点（用于回复链表）
        n3 = n1;
        n2 = head;
        //用于存放显示的结果
        boolean res = true;
        //左右两个头节点都不为空
        //判断回文序列
        while (n1 != null && n2 != null) {
            if (n1.value != n2.value) {
                res = false;
                break;
            }
            //向后进行遍历
            n1 = n1.next;
            n2 = n2.next;
        }
        //判断完之后要进行链表的恢复（把右边的逆序部分进行恢复）
        //此时的n1(就是逆序的head节点)
        //n2都已经没有用了可以进行使用了（相当于next）
        //因为原链表的最后一个节点的后面是空（所以要进行把最后的节点的next要置null）
        //把逆序的第二个节点当做要恢复链表的头节点
        n1 = n3.next;
        //（把n3的next截断因为之前还链接倒数第二个节点）
        //现在的n3就相当于pre
        n3.next = null;
        //此时的n3相当于pre
        while(n1 != null){
            n2 = n1.next;
            n1.next = n3;
            n3 = n1;
            n1 = n2;
        }
        return res;
    }
}
