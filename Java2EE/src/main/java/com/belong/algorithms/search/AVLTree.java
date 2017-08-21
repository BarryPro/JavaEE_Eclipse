package com.belong.algorithms.search;

/**
 * Java 语言: AVL树（平衡二叉树）
 *
 * @author belong
 * @date 2015/12/23
 */

public class AVLTree<T extends Comparable<T>> {
	private AVLTreeNode<T> mRoot;    // 根结点

	// AVL树的节点(内部类)
	class AVLTreeNode<T extends Comparable<T>> {
		T key;                // 关键字(键值)
		int height;         // 高度
		AVLTreeNode<T> left;    // 左孩子
		AVLTreeNode<T> right;    // 右孩子

		public AVLTreeNode(T key, AVLTreeNode<T> left, AVLTreeNode<T> right) {
			this.key = key;
			this.left = left;
			this.right = right;
			this.height = 0;
		}
	}

	// 构造函数
	public AVLTree() {
		mRoot = null;
	}

	/*
	 * 获取树的高度
	 */
	private int height(AVLTreeNode<T> tree) {
		if (tree != null){
			return tree.height;
		}

		return 0;
	}

	public int height() {
		return height(mRoot);
	}

	/*
	 * 比较两个值的大小
	 */
	private int max(int a, int b) {
		return a>b ? a : b;
	}

	/*
	 * 前序遍历"AVL树"
	 */
	private void preOrder(AVLTreeNode<T> tree) {
		if(tree != null) {
			System.out.print(tree.key+" ");
			preOrder(tree.left);
			preOrder(tree.right);
		}
	}

	public void preOrder() {
		preOrder(mRoot);
	}

	/*
	 * 中序遍历"AVL树"
	 */
	private void inOrder(AVLTreeNode<T> tree) {
		if(tree != null){
			inOrder(tree.left);
			System.out.print(tree.key+" ");
			inOrder(tree.right);
		}
	}

	public void inOrder() {
		inOrder(mRoot);
	}

	/*
	 * 后序遍历"AVL树"
	 */
	private void postOrder(AVLTreeNode<T> tree) {
		if(tree != null) {
			postOrder(tree.left);
			postOrder(tree.right);
			System.out.print(tree.key+" ");
		}
	}

	public void postOrder() {
		postOrder(mRoot);
	}

	
	/* 
	 * 查找最小结点：返回tree为根结点的AVL树的最小结点。
	 */
	private AVLTreeNode<T> minimum(AVLTreeNode<T> tree) {
		if (tree == null){
			return null;
		}

		while(tree.left != null){
			tree = tree.left;
		}
		return tree;
	}

	public T minimum() {
		AVLTreeNode<T> p = minimum(mRoot);
		if (p != null){
			return p.key;
		}

		return null;
	}

	/* 
	 * 查找最大结点：返回tree为根结点的AVL树的最大结点。
	 */
	private AVLTreeNode<T> maximum(AVLTreeNode<T> tree) {
		if (tree == null){
			return null;
		}

		while(tree.right != null){
			tree = tree.right;
		}
		return tree;
	}

	public T maximum() {
		AVLTreeNode<T> p = maximum(mRoot);
		if (p != null){
			return p.key;
		}

		return null;
	}

	/*
	 * LL：左左对应的情况(左单旋转)。
	 *        2
	 *     A                     B     
	 *    /  1                 /   \
	 *   B   -->>LL--->>      X     A
	 *  /  0
	 * X
	 * 返回值：旋转后的根节点
	 * (插入的节点是左子树的左边节点)
	 */
	private AVLTreeNode<T> leftLeftRotation(AVLTreeNode<T> k2) {
		AVLTreeNode<T> k1;

		k1 = k2.left;
		k2.left = k1.right;
		k1.right = k2;
		//关于高度，树的高度即为最大层次。
		//即空的二叉树的高度是0，非空树的高度从1计数，等于它的最大层次(根的层次为1，根的子节点为第2层，依次类推)。
		k2.height = max( height(k2.left), height(k2.right)) + 1;
		k1.height = max( height(k1.left), k2.height) + 1;//左右比较

		return k1;
	}

	/*
	 * RR：右右对应的情况(右单旋转)。
	 *
	 *      -2                              0
	 *     A                               B     
	 *      \ -1                         /0  \0
	 *       B         -->>RR--->>      A     X
	 *        \ 0
	 *         X
	 *
	 *(插入节点是右子树的右边节点)
	 * 返回值：旋转后的根节点
	 */
	private AVLTreeNode<T> rightRightRotation(AVLTreeNode<T> k1) {
		AVLTreeNode<T> k2;

		k2 = k1.right;
		k1.right = k2.left;
		k2.left = k1;

		k1.height = max( height(k1.left), height(k1.right)) + 1;
		k2.height = max( height(k2.right), k1.height) + 1;

		return k2;
	}

	/*
	 * LR：左右对应的情况(左双旋转)。--对应RR-LL
	 *(插入节点是左子树的右边节点)
	 * 返回值：旋转后的根节点
	 */
	private AVLTreeNode<T> leftRightRotation(AVLTreeNode<T> k3) {
		k3.left = rightRightRotation(k3.left);

		return leftLeftRotation(k3);
	}

	/*
	 * RL：右左对应的情况(右双旋转)。对应 LL-RR
	 *(插入节点是右子树的左边节点)
	 * 返回值：旋转后的根节点
	 */
	private AVLTreeNode<T> rightLeftRotation(AVLTreeNode<T> k1) {
		k1.right = leftLeftRotation(k1.right);

		return rightRightRotation(k1);
	}
	
	/* 
	 * 将结点插入到AVL树中，并返回根节点
	 *
	 * 参数说明：
	 *     tree AVL树的根结点
	 *     key 插入的结点的键值
	 * 返回值：
	 *     根节点
	 */
	private AVLTreeNode<T> insert(AVLTreeNode<T> tree, T key) {
		if (tree == null) {
			// 新建节点
			tree = new AVLTreeNode<T>(key, null, null);
			
		} else {
			int cmp = key.compareTo(tree.key);//新增加的键值距离他最近的平衡因子绝对值超过1的3进行比较

			if (cmp < 0) {    // 应该将key插入到"tree的左子树"的情况
				tree.left = insert(tree.left, key);
				// 插入节点后，若AVL树失去平衡，则进行相应的调节。
				//因为BF为正，因此我们将整个树进行右旋(顺时针旋转),
				if (height(tree.left) - height(tree.right) == 2) {//打破平衡
					if (key.compareTo(tree.left.key) < 0){//新插入的值和将要插在某个节点下面的值进行比较  ，
						//插入的值小于当前节点的左子节点，  插入的节点是左子树的左边节点,
						//进行比对 LL型，左左型，
						tree = leftLeftRotation(tree);
					}else{//LR左右型  插入的节点是左子树的右边节点,
						tree = leftRightRotation(tree);
					}
				}
			} else if (cmp > 0) {    // 应该将key插入到"tree的右子树"的情况
				tree.right = insert(tree.right, key);
				// 插入节点后，若AVL树失去平衡，则进行相应的调节。
				//因为BF为负，因此我们将整个树进行左旋(逆时针旋转),
				if (height(tree.right) - height(tree.left) == 2) {//打破平衡
					if (key.compareTo(tree.right.key) > 0){//插入的值大于当前节点的右子节点，  插入的节点是右子树的右边节点,
						tree = rightRightRotation(tree);//RR型，右右型
					}else{//新插入的值比右节点小 RL //插入的值小于当前节点的右子节点，  插入的节点是右子树的左边节点,
						tree = rightLeftRotation(tree);//RL型 右左型
					}
				}
			} else {    // cmp==0
				System.out.println("添加失败：不允许添加相同的节点！");
			}
		}

		tree.height = max( height(tree.left), height(tree.right)) + 1;//从0开始算高度

		return tree;
	}

	public void insert(T key) {
		mRoot = insert(mRoot, key);
	}


	/* 
	 * 销毁AVL树
	 */
	private void destroy(AVLTreeNode<T> tree) {
		if (tree==null)
			return ;

		if (tree.left != null)
			destroy(tree.left);
		if (tree.right != null)
			destroy(tree.right);

		tree = null;
	}

	public void destroy() {
		destroy(mRoot);
	}

	/*
	 * 打印"二叉查找树"
	 *
	 * key        -- 节点的键值 
	 * direction  --  0，表示该节点是根节点;
	 *               -1，表示该节点是它的父结点的左孩子;
	 *                1，表示该节点是它的父结点的右孩子。
	 */
	private void print(AVLTreeNode<T> tree, T key, int direction) {
		if(tree != null) {
			if(direction==0)    // tree是根节点
				System.out.printf("%2d is root\n", tree.key, key);
			else                // tree是分支节点
				System.out.printf("%2d is %2d's %6s child\n", tree.key, key, direction==1?"right" : "left");

			print(tree.left, tree.key, -1);
			print(tree.right,tree.key,  1);
		}
	}

	public void print() {
		if (mRoot != null)
			print(mRoot, mRoot.key, 0);
	}

	private static int arr[]= {3,2,1,4,5,6,7,10,9,8};

	public static void main(String[] args) {
		int i;
		AVLTree<Integer> tree = new AVLTree<Integer>();

		System.out.printf("== 依次添加: ");
		for(i=0; i<arr.length; i++) {
			
			tree.insert(arr[i]);
			System.out.printf("%d ", arr[i]);
		}

		System.out.printf("\n== 前序遍历: ");
		tree.preOrder();

		System.out.printf("\n== 中序遍历: ");
		tree.inOrder();

		System.out.printf("\n== 后序遍历: ");
		tree.postOrder();
		System.out.printf("\n");

		System.out.printf("== 高度: %d\n", tree.height());
		System.out.printf("== 最小值: %d\n", tree.minimum());
		System.out.printf("== 最大值: %d\n", tree.maximum());
		System.out.printf("== 树的详细信息: \n");
		tree.print();


		// 销毁二叉树
		tree.destroy();
	}

}
