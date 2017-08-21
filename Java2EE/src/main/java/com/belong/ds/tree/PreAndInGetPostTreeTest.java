package com.belong.ds.tree;

/**
 * 根据先序和中序来求后序
 * Created by belong on 2017/4/3.
 */
public class PreAndInGetPostTreeTest {
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
     * 根据先序来得到根节点
     * @param preArray 先序数组
     * @return 返回根节点
     */
    public DataNode initRootNode(int[] preArray) {
        rootNode = new DataNode();
        //先序的第一个节点一定是根节点
        rootNode.data = preArray[0];
        return rootNode;
    }

    /**
     * 根据先序和后序数组来还原二叉树
     * @param preArray 先序数组
     * @param midArray 中序数组
     * @param rootNode 根节点
     */
    public void BuildTree(int[] preArray, int[] midArray, DataNode rootNode) {
        //得到根节点的索引位置
        int index_root = getIndex(midArray, rootNode.data);
        //得到右子树的节点个数（左子树的节点个数就是根节点的索引号 ）
        int lengthOfRightTree = preArray.length - index_root - 1;

        //临时存储先序的和中序的左右子树
        int[] preArray_left;
        int[] preArray_right;
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
                preArray_left = new int[index_root];
                midArray_left = new int[index_root];
                //把先序preArray数组中根节点后的（中序中左子树的节点个数）6个节点复制到preArray_left数组中
                System.arraycopy(preArray, 1, preArray_left, 0, index_root);
                //把先序midArray数组中根节点后的（中序中左子树的节点个数）6个节点复制到midArray_left数组中
                System.arraycopy(midArray, 0, midArray_left, 0, index_root);
                //先序子树中第一个仍然是跟根节点（子树的根节点）
                left_childDataNode.data = preArray_left[0];
                //就是根下的左子节点
                rootNode.leftChild = left_childDataNode;
                //递归建左子树
                BuildTree(preArray_left, midArray_left, left_childDataNode);
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
                preArray_right = new int[lengthOfRightTree];
                midArray_right = new int[lengthOfRightTree];
                System.arraycopy(preArray, index_root + 1, preArray_right, 0, lengthOfRightTree);
                System.arraycopy(midArray, index_root + 1, midArray_right, 0, lengthOfRightTree);
                right_childDataNode.data = preArray_right[0];
                rootNode.rightChild = right_childDataNode;
                //递归建右子树
                BuildTree(preArray_right, midArray_right, right_childDataNode);
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
     * 根据先序和中序构建出来的树来进行后序遍历
     * @param node
     */
    public void postOrderTraverse(DataNode node) {
        if (node == null) {
            return;
        }
        postOrderTraverse(node.leftChild);
        postOrderTraverse(node.rightChild);
        System.out.print(node.data+" ");
    }


    public static void main(String args[]) {
        //前序数组
        int[] preArray = {35,20,15,16,29,28,30,40,50,45,55};
        //中序数组
        int[] midArray = {15,16,20,28,29,30,35,40,45,50,55};
        PreAndInGetPostTreeTest tree = new PreAndInGetPostTreeTest();
        DataNode headNode = tree.initRootNode(preArray);
        tree.BuildTree(preArray, midArray, headNode);
        tree.postOrderTraverse(headNode);
    }


}
