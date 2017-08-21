package com.belong.ds.tree;
/*
 * Java实现二叉搜索树
 * 1.若他的左子树不空，则左子树上所有节点的值均小于它的根节点的值；
   2.若他的右子树不空，则右子树上所有节点的值均大于它的根节点的值。
   3.它的左、右子树也分别为排序二叉树。
 */
public class BSTree <T extends Comparable<T>>{
	private BSTNode<T> mRoot;//根节点

	public class BSTNode<T extends Comparable<T>>{
		T key;//关键字(键值)
		BSTNode<T> left;//左孩子
		BSTNode<T> right;//右孩子
		BSTNode<T> parent;//父节点		
		public BSTNode(T key,BSTNode<T> parent,BSTNode<T> left,BSTNode<T> right){
			this.key=key;
			this.parent=parent;
			this.left=left;
			this.right=right;			
		}		
	}
	//前序遍历
	private void preOrder(BSTNode<T> tree){
		if(tree!=null){
			System.out.print(tree.key+" ");
			preOrder(tree.left);
			preOrder(tree.right);
		}		
	}
	public void preOrder(){
		preOrder(mRoot);
	}
	//中序遍历
	private void inOrder(BSTNode<T> tree){
		if(tree!=null){
			inOrder(tree.left);
			System.out.print(tree.key+" ");
			inOrder(tree.right);
		}
	}
	public void inOrder(){
		this.inOrder(mRoot);
	}
	//后序遍历
	private void postOrder(BSTNode<T> tree){
		if(tree!=null){
			postOrder(tree.left);
			postOrder(tree.right);
			System.out.print(tree.key+" ");
		}
	}
	public void postOrder(){
		postOrder(mRoot);
	}

	/*递归实现，查找二叉树x中键值为key的节点
	 * 
	 */
	private BSTNode<T> search(BSTNode<T> x,T key){
		if(x==null){
			return x;
		}
		int cmp=key.compareTo(x.key);
		if(cmp<0){//小于当前节点的值，将在左树中查
			return search(x.left,key);
		}else if(cmp>0){//大于当前节点的值，将在右树中查
			return search(x.right,key);
		}else{
			return x;
		}		
	}
	/*
	 * 非递归实现，查找二叉树中键值为key的节点
	 */
	private BSTNode<T> iterativeSearch(BSTNode<T> x,T key){
		while(x!=null){
			int cmp=key.compareTo(x.key);
			if(cmp<0){
				x=x.left;
			}else if(cmp>0){
				x=x.right;
			}else{
				return x;
			}
		}
		return x;
	}
	public BSTNode<T> iterativeSearch(T key){
		return iterativeSearch(mRoot,key);
	}
	/*
	 * 查找最大结点，返回tree为根节点的二叉树的最大节点，在右侧找
	 */	
	private BSTNode<T> maximum(BSTNode<T> tree){
		if(tree==null){
			return null;
		}
		while(tree.right!=null){
			tree=tree.right;
		}
		return tree;
	}
	public T maximum(){
		BSTNode<T> p=maximum(mRoot);
		if(p!=null){
			return p.key;
		}
		return null;
	}
	/*
	 * 查找最小结点，返回tree为根节点的二叉树的最小结点，在左侧找
	 */	
	private BSTNode<T> minimum(BSTNode<T> tree){
		if(tree==null){
			return null;
		}
		while(tree.left!=null){
			tree=tree.left;
		}
		return tree;
	}
	public T minimum(){
		BSTNode<T> p=minimum(mRoot);
		if(p!=null){
			return p.key;
		}
		return null;
	}

	/*
	 * //查找该节点(x)的前驱节点，即查找二叉树中数据值小于该节点的最大节点
	 */
	public BSTNode<T> predecessor(BSTNode<T> x){
		//如果x存在左孩子，则x的前驱节点为-以其左孩子为根的子树的最大节点
		if(x.left!=null){
			return maximum(x.left);
		}//如果x没有左孩子，则x有以下两种可能：
		//1.x是一个右孩子，则x的前驱节点为它的父节点
		//2.x是一个左孩子，则查找x的最低的父节点，并且该节点要具有右孩子(因为都比他大)，
		//找到的这个最低的父节点就是x的前驱节点
		//其实就是，该节点左子树为空, 则其前驱为：其祖先节点(递归), 且该祖先节点的右孩子也是其祖先节点
        //  通俗的说，一直往上找找到最后出现左拐那次后的祖先节点;
		BSTNode<T> y=x.parent;//把父亲取出来，如果不是左孩子，就是右孩子(y就是其前驱)，
		//根据以下性质
		/*1.若他的左子树不空，则左子树上所有节点的值均小于它的根节点的值；
		   2.若他的右子树不空，则右子树上所有节点的值均大于它的根节点的值。
		   3.它的左、右子树也分别为排序二叉树。*/
		while((y!=null)&&(x==y.left)){//x是左孩子
			x=y;
			y=y.parent;					
		}
		return y;
		
		 
		
	}
	/*后继节点
	 * 找结点x的后继节点，即，查找二叉树中数据值大于该节点的最小节点
	 */
	public BSTNode<T> successor(BSTNode<T> x){

		if(x.right!=null){////如果x存在右孩子，则x的后继节点为：以其右孩子为根的子树的最小节点
			return minimum(x.right);
		}//如果没有右孩子，则x有以下两种可能
		//1.x是一个左孩子，则x的后继节点为它的父节点
		//2.x是一个右孩子，则查找x的最低父节点，并且该父节点要具有左孩子，找到的这个最低的父节点就是x的后继节点
		//
		//就是说一直往上找其祖先节点，直到出现最后出现右拐后的那个祖先节点：
		BSTNode<T> y=x.parent;
		while((y!=null)&&(x==y.right)){
			x=y;
			y=y.parent;
		}
		return y;		
	}
	/* 将节点插入到二叉树中
	 * tree：二叉树
	 * z：插入的节点 */	
	private void insert(BSTree<T> bst,BSTNode<T> z){
		int cmp;
		BSTNode<T> y=null;
		BSTNode<T> x=bst.mRoot;		
		while(x!=null){//查找z将要的插入位置
			y=x;
			cmp=z.key.compareTo(x.key);
			if(cmp<0){
				x=x.left;
			}else if(cmp>0){
				x=x.right;
			}else{
				return;//插入的树不允许和树中的相同
			}
		}//x==null之后，就是将要插入y的位置，现在在y中
		z.parent=y;
		if(y==null){
			bst.mRoot=z;//若b是空树，则直接将插入的结点作为根节点插入
		}else{
			cmp=z.key.compareTo(y.key);//z和y比
			if(cmp<0){
				y.left=z;//小于是左树
			}else if(cmp>0){
				y.right=z;//大于是右树
			}else{
				return ;//插入的树不允许和树中的相同
			}
		}
	}

	public void insert(T key){
		BSTNode<T> z=new BSTNode<T>(key,null,null,null);
		//如果新建节点失败，则返回
		if(z!=null){
			insert(this,z);
		}
	}
	/*
	 * 删除节点z，并返回被删除的节点
	 * bst：二叉树
	 * z删除的节点
	 * 1.没有儿子，即为叶结点。直接把父结点的对应儿子指针设为NULL，就OK了。
	   2.只有一个儿子。那么把父结点的相应儿子指针指向儿子的独生子，删除儿子结点也OK了。
	   3.有两个儿子。这是最麻烦的情况，因为你删除节点之后，还要保证满足搜索二叉树的结构。其实也比较容易，
	   我们可以选择左儿子中的最大元素或者右儿子中的最小元素放到待删除节点的位置，就可以保证结构的不变。
	   当然，你要记得调整子树，毕竟又出现了节点删除。习惯上大家选择左儿子中的最大元素，其实选择右儿子的最小元素也一样，
	   没有任何差别，只是人们习惯从左向右。这里咱们也选择左儿子的最大元素，将它放到待删结点的位置。
	   左儿子的最大元素其实很好找，只要顺着左儿子不断的去搜索右子树就可以了，直到找到一个没有右子树的结点。那就是最大的了。
	 */
	private BSTNode<T> remove(BSTree<T> bst,BSTNode<T> z){
		BSTNode<T> x=null;
		BSTNode<T> y=null;
		if((z.left==null)||(z.right==null)){//或者有左子节点，或者有右子节点
			y=z;
		}else{
			y=successor(z);//要删除的节点既有左子节点，又有右子节点  
			//查找删除节点的后继节点：数据值大于该节点的最小节点
		}
		if(y.left!=null){//y有左节点
			x=y.left;//付给临时变量x
		}else{//y有右节点
			x=y.right;//付给临时变量x
		}
		if(x!=null){
			x.parent=y.parent;//无论是否是后继节点，都把y的父节点给x做为父节点		
		}
		if(y.parent==null){//y的父亲是空
			bst.mRoot=x;//x就是根了
		}else if(y==y.parent.left){//这就去除y了，也就是判断y是否是父亲的左节点，如果是，用x顶替
			y.parent.left=x;
		}else{
			y.parent.right=x;//这就去除y了，也就是判断y是否是父亲的右节点，如果是，用x顶替
		}
		if(y!=z){//y和z不是一个节点,y是后继节点，把y的值付给要删除的z节点，返回的节点是(删除的)后继节点，
			//因为后继节点的值已经付给将要删除那个节点z的位置了的节点了
			z.key=y.key;
		}
		return y;
	}
	/*
	 * 删除节点z，并返回被删除的节点
	 * tree：二叉树的根节点
	 * z 删除的节点
	 */
	public void remove(T key){
		BSTNode<T> z, node;
		if((z=this.search(mRoot, key))!=null){
			if((node=remove(this,z))!=null){
				node=null;
			}
		}
	}

	/*
	 * 打印"二叉查找树"
	 *
	 * key        -- 节点的键值 
	 * direction  --  0，表示该节点是根节点;
	 *               -1，表示该节点是它的父结点的左孩子;
	 *                1，表示该节点是它的父结点的右孩子。
	 */
	private void print(BSTNode<T> tree, T key, int direction) {

		if(tree != null) {

			if(direction==0)    // tree是根节点
				System.out.printf("%2d is root\n", tree.key);
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
	/*
	 * 销毁二叉树
	 */
	private void destroy(BSTNode<T> tree) {
		if (tree==null)
			return ;

		if (tree.left != null)
			destroy(tree.left);
		if (tree.right != null)
			destroy(tree.right);

		tree=null;
	}

	public void clear() {
		destroy(mRoot);
		mRoot = null;
	}


	private static final int arr[] = {1,5,4,3,2,6};
	/*
	 * 		    1
	 * 		     \ 
	 *            5
	 *          /   \
	 *         4     6
	 *        /
	 *       3
	 *      /
	 *     2
	 */


	public static void main(String[] args) {
		int i, ilen;
		BSTree<Integer> tree=new BSTree<Integer>();

		System.out.print("== 依次添加: ");
		ilen = arr.length;
		for(i=0; i<ilen; i++) {
			System.out.print(arr[i]+" ");
			tree.insert(arr[i]);
		}
		System.out.print("\n== 前序遍历DLR: ");
		tree.preOrder();

		System.out.print("\n== 中序遍历LDR: ");
		tree.inOrder();

		System.out.print("\n== 后序遍历LRD: ");
		tree.postOrder();
		System.out.println();

		System.out.println("== 最小值: "+ tree.minimum());
		System.out.println("== 最大值: "+ tree.maximum());
		System.out.println("== 树的详细信息: ");
		tree.print();

		System.out.print("\n== 删除节点: "+ arr[1]);
		tree.remove(arr[1]);

		System.out.print("\n== 中序遍历: ");
		tree.inOrder();
		System.out.println();

		// 销毁二叉树
		tree.clear();
	}


}
