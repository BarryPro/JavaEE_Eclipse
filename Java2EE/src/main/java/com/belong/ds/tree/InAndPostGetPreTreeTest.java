package com.belong.ds.tree;

/**
 * 根据中序和后序来求先序
 * Created by belong on 2017/4/3.
 */
public class InAndPostGetPreTreeTest {
    //定义数据节点
    class DataNode {
        int data;
        DataNode leftChild = null;
        DataNode rightChild = null;
    }

    //定义根节点
    DataNode rootNode;
    //左右孩子节点
    DataNode left_childDataNode;
    DataNode right_childDataNode;

    /**
     * 根据后序序来得到根节点
     * @param postArray 先序数组
     * @return 返回根节点
     */
    public DataNode initRootNode(int[] postArray) {
        rootNode = new DataNode();
        //后序的最后一个节点一定是根节点
        rootNode.data = postArray[postArray.length-1];
        return rootNode;
    }

    /**
     * 根据先序和后序数组来还原二叉树
     * @param postArray 先序数组
     * @param midArray 中序数组
     * @param rootNode 根节点
     */
    public void BuildTree(int[] postArray, int[] midArray, DataNode rootNode) {
        //得到根节点的索引位置
        int index_root = getIndex(midArray, rootNode.data);
        //得到右子树的节点个数（左子树的节点个数就是根节点的索引号 ）
        int lengthOfRightTree = postArray.length - index_root - 1;

        //临时存储先序的和中序的左右子树
        int[] postArray_left;
        int[] postArray_right;
        int[] midArray_left;
        int[] midArray_right;

        //如果存在这样的根节点（就是找到根节点的索引）
        if (index_root > 0) {
            left_childDataNode = new DataNode();
            if (index_root == 1) {
                left_childDataNode.data = midArray[0];
                rootNode.leftChild = left_childDataNode;
            } else {
                //根节点的索引下标正好是左子树的节点个数
                postArray_left = new int[index_root];
                midArray_left = new int[index_root];
                //把后序postArray数组中根节点后的（中序中左子树的节点个数）6个节点复制到postArray_left数组中
                System.arraycopy(postArray, 0, postArray_left, 0, index_root);
                //把后序midArray数组中根节点后的（中序中左子树的节点个数）6个节点复制到midArray_left数组中
                System.arraycopy(midArray, 0, midArray_left, 0, index_root);
                //为左子节点赋值
                left_childDataNode.data = postArray_left[index_root-1];
                //根节点与左子树相连
                rootNode.leftChild = left_childDataNode;
                //递归建左子树
                BuildTree(postArray_left, midArray_left, left_childDataNode);
            }
        }

        //注释和左子树一样
        if (lengthOfRightTree > 0) {
            right_childDataNode = new DataNode();
            //如果右子树的长度等于1那这个右子树直接就是根节点的右子节点了
            if (lengthOfRightTree == 1) {
                right_childDataNode.data = midArray[index_root + 1];
                rootNode.rightChild = right_childDataNode;
                //结束函数
                return;
            } else {
                postArray_right = new int[lengthOfRightTree];
                midArray_right = new int[lengthOfRightTree];
                //计算出右子树的在后序中从哪开始复制到哪结束
                System.arraycopy(postArray, postArray.length - 1 - lengthOfRightTree, postArray_right, 0, lengthOfRightTree);
                System.arraycopy(midArray, index_root + 1, midArray_right, 0, lengthOfRightTree);
                //为右子节点赋值
                right_childDataNode.data = postArray_right[lengthOfRightTree-1];
                //根节点与右子树相连
                rootNode.rightChild = right_childDataNode;
                //递归建右子树
                BuildTree(postArray_right, midArray_right, right_childDataNode);
            }
        }
    }

    /**
     * 求temp的值在数组中的索引位置
     * @param array
     * @param temp
     * @return 成功返回下标索引
     *         失败返回-1
     */
    public int getIndex(int[] array, int temp) {
        //如果没有找到返回-1
        int index = -1;
        for (int i = 0; i < array.length; i++) {
            if (array[i] == temp) {
                index = i;
                return index;
            }
        }
        return index;
    }

    /**
     * 先序遍历二叉树（递归）
     * @param node
     */
    public void preOrderTraverse(DataNode node) {
        if (node == null) {
            return;
        }
        System.out.print(node.data+" ");
        preOrderTraverse(node.leftChild);
        preOrderTraverse(node.rightChild);

    }

    public static void main(String[] args) {
        //前序数组
        int[] postArray = {16,15,28,30,29,20,45,55,50,40,35};
        //中序数组
        int[] midArray = {15,16,20,28,29,30,35,40,45,50,55};
        InAndPostGetPreTreeTest tree = new InAndPostGetPreTreeTest();
        DataNode headNode = tree.initRootNode(postArray);
        tree.BuildTree(postArray, midArray, headNode);
        tree.preOrderTraverse(headNode);
    }
}
