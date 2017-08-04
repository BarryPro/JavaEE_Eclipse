package com.datastructure.practice;


import javafx.scene.transform.Rotate;

import java.util.LinkedList;
import java.util.Queue;
import java.util.Stack;

/**
 * Created by belong on 2017/4/2.
 */
public class BinaryTreeTraverseTest<E extends Comparable<E>> {
    public class Node<E> {
        private E value;
        private Node<E> left;
        private Node<E> right;

        public Node(E value){
            this.value = value;
            this.left = null;
            this.right = null;
        }
    }

    //定义根节点
    private Node<E> root;

    /**
     * 返回根节点
     * @return
     */
    public Node<E> getRoot(){
        return root;
    }

    /**
     * 采用二叉排序树的方式左小又大的方式进行插入节点
     * @param value
     */
    public void insertNode(E value){
        if(root == null){
            root = new Node(value);
            //如果不结束函数的话还会在把根节点插入左指数中（因为程序还会往下走）
            return;
        }
        //定义临时节点用于循环插入节点
        Node<E> currentNode = root;
        while (true) {
            //添加右子树
            if(value.compareTo(currentNode.value) > 0){
                //循环找右子树
                if(currentNode.right == null){
                    currentNode.right = new Node(value);
                    break;
                }
                currentNode = currentNode.right;
            } else {
                //循环找左子树
                if(currentNode.left == null){
                    currentNode.left = new Node(value);
                    break;
                }
                currentNode = currentNode.left;
            }
        }
    }

    /**
     * 采用数组的方式进行构建二叉树
     * @param list
     */
    public void createTree(E [] list){
        for(E value:list){
            insertNode(value);
        }
    }

    /**
     * 采用递归的方式先序进行遍历
     * @param node
     */
    public void preOrderTraverse(Node<E> node){
        System.out.print(node.value+" ");
        if(node.left != null){
            preOrderTraverse(node.left);
        }
        if(node.right != null){
            preOrderTraverse(node.right);
        }
    }

    /**
     * 采用递归的方式中序进行遍历
     * @param node
     */
    public void inOrderTraverse(Node<E> node){
        if(node.left != null){
            inOrderTraverse(node.left);
        }
        System.out.print(node.value+" ");
        if(node.right != null){
            inOrderTraverse(node.right);
        }
    }

    /**
     * 采用递归的方式后序进行遍历
     * @param node
     */
    public void postOrderTraverse(Node<E> node){
        if(node.left != null){
            postOrderTraverse(node.left);
        }
        if(node.right != null){
            postOrderTraverse(node.right);
        }
        System.out.print(node.value+" ");
    }

    /**
     * 先序遍历
     * 非递归深度遍历树都是从根节点进行遍历
     * 都是采用栈来进行存储的
     * @param root
     */
    public void preOrderTraverseNoRecursion(Node<E> root){
        //先进后出
        Stack<Node<E>> stack = new Stack();
        stack.push(root);
        while (!stack.isEmpty()) {
            Node<E> currentNode = stack.pop();
            System.out.print(currentNode.value + " ");
            if(currentNode.right != null){
                stack.push(currentNode.right);
            }
            if(currentNode.left != null){
                stack.push(currentNode.left);
            }
        }
    }

    /**
     * 中序遍历（非递归）
     * 左中右
     * @param root
     */
    public void inOrderTraverseNoRecursion(Node<E> root){
        //先进后出
        Stack<Node<E>> stack = new Stack();
        Node<E> currentNode = root;
        while (!stack.isEmpty() || currentNode != null) {
            //从最左端开始
            while (currentNode != null){
                //先把根节点压入栈
                stack.push(currentNode);
                currentNode = currentNode.left;
            }
            currentNode = stack.pop();
            System.out.print(currentNode.value + " ");
            currentNode = currentNode.right;
        }
    }

    /**
     * 后序遍历（非递归）
     * 左右中
     * @param root
     */
    public void postOrderTraverseNoRecursion(Node<E> root){
        Stack<Node<E>> stack = new Stack();
        //从跟节点开始遍历
        Node<E> currentNode = root;
        Node<E> rightNode = null;
        while(!stack.isEmpty() || currentNode != null){
            //找到最左端的节点
            while(currentNode != null){
                stack.push(currentNode);
                currentNode = currentNode.left;
            }
            //弹出最左端的节点（进行判断）
            currentNode = stack.pop();
            //最左端的节点没有右节点或者是当前节点的右节点是上一个输出的节点
            while(currentNode.right == null || currentNode.right == rightNode){
                //输出当前节点的值
                System.out.print(currentNode.value+" ");
                rightNode = currentNode;
                if(stack.isEmpty()){
                    //说明根节点也输出出去了
                    return ;
                }
                //弹出下一个节点
                currentNode = stack.pop();
            }
            //还有右节点没有进行遍历
            stack.push(currentNode);
            currentNode = currentNode.right;
        }
    }

    /**
     * 采用广度优先遍历树（队列）
     * @param root
     */
    public void breadthFirstTraverse(Node<E> root){
        //用于存放树的节点（先进先出）
        Queue<Node<E>> queue = new LinkedList();
        queue.offer(root);
        while(!queue.isEmpty()){
            //按先进先出释放节点
            Node<E> currentNode = queue.poll();
            System.out.print(currentNode.value+" ");
            //左右节点挨个走（就是按层遍历）
            if(currentNode.left != null){
                queue.offer(currentNode.left);
            }
            if(currentNode.right != null){
                queue.offer(currentNode.right);
            }
        }
    }

    public static void main(String[] args) {
        BinaryTreeTraverseTest treeTraverseTest = new BinaryTreeTraverseTest();
        Integer [] arrays = {35,20,15,16,29,28,30,40,50,45,55};
        treeTraverseTest.createTree(arrays);

        System.out.print("先序遍历（递归）：");
        treeTraverseTest.preOrderTraverse(treeTraverseTest.getRoot());
        System.out.println();
        System.out.print("中序遍历（递归）：");
        treeTraverseTest.inOrderTraverse(treeTraverseTest.getRoot());
        System.out.println();
        System.out.print("后序遍历（递归）：");
        treeTraverseTest.postOrderTraverse(treeTraverseTest.getRoot());
        System.out.println();

        System.out.print("先序遍历（非递归）：");
        treeTraverseTest.preOrderTraverseNoRecursion(treeTraverseTest.getRoot());
        System.out.println();
        System.out.print("中序遍历（非递归）：");
        treeTraverseTest.inOrderTraverseNoRecursion(treeTraverseTest.getRoot());
        System.out.println();
        System.out.print("后序遍历（非递归）：");
        treeTraverseTest.postOrderTraverseNoRecursion(treeTraverseTest.getRoot());
        System.out.println();

        System.out.print("广度优先遍历：");
        treeTraverseTest.breadthFirstTraverse(treeTraverseTest.getRoot());
    }
}
