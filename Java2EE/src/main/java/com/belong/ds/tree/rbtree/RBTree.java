package com.belong.ds.tree.rbtree;
/**
 * @Description: <p>红黑树
 * 性质1：每个节点要么是红色，要么是黑色
 * 性质2：根节点永远是黑色
 * 性质3：所有的叶子节点都是空节点（即null），并且是黑色的
 * 性质4：每个红色节点的两个子节点都是黑色。（从每个叶子到根的路径上不会有两个连续红色节点）
 * 性质5：从任意节点到其子树中每个叶子节点的路径都包含相同数量的黑色节点
 * （黑色节点的数被称为黑色高度black=height）
 * <p>
 * 性质4结论（黑色高度N）：
 * 1、从根节点到叶子节点的最短路径是N-1
 * 2、最长的路径是2*（N-1）
 * <p>
 * 注意：
 * 红黑树并不是真正的平衡二叉树，但实际应用中，红黑树的统计性能高于平衡二叉树，但极端性能略差
 * <p>
 * 提示：
 * 1、插入（红色）：如果设为黑色就会导致根节点的路径上多一个额外的黑节点，这样将会很难调整，但是插入红色，
 * 可能出现两个连续的红色节点，在通过颜色调换和树的旋转调整即可
 * <p>
 * 例子：
 * JDK TreeMap本身就是一个红黑树的实现</p>
 * @Author: belong.
 * @Date: 2017/7/6.
 */
public class RBTree <T extends Comparable <T>> {//红黑树基本定义
	private RBTNode<T> mRoot;//根节点
	private static final boolean RED=false;
	private static final boolean BLACK=true;
	public class RBTNode<T extends Comparable<T>>{
		boolean color;//颜色
		T key;//关键字(键值)
		RBTNode<T> left;//左孩子
		RBTNode<T> right;//右孩子
		RBTNode<T> parent;//父节点		
		public RBTNode (T key,boolean color,RBTNode<T> parent,RBTNode<T> left,RBTNode<T> right){
			this.key=key;
			this.color=color;
			this.parent=parent;
			this.left=left;
			this.right=right;			
		}
		public T getKey(){
			return key;
		}
		public String toString(){
			return ""+key+(this.color==RED?"(R)":"B");
		}


	}
	public RBTree(){
		mRoot=null;
	}
	private RBTNode<T> parentOf(RBTNode<T> node){
		return node!=null?node.parent:null;

	}
	private boolean colorOf(RBTNode<T> node){
		return node!=null?node.color:BLACK;
	}
	private boolean isRed(RBTNode<T> node){
		return ((node != null) && (node.color == RED));
	}
	private boolean isBlack(RBTNode<T> node){
		return !isRed(node);

	}
	private void setBlack(RBTNode<T> node){
		if(node!=null){
			node.color=BLACK;
		}
	}
	private void setRed(RBTNode<T> node){
		if(node!=null){
			node.color=RED;
		}
	}
	private void setParent(RBTNode<T> node, RBTNode<T> parent) {
		if (node!=null)
			node.parent = parent;
	}
	private void setColor(RBTNode<T> node ,boolean color){
		if(node!=null){
			node.color=color;
		}
	}
	/*
	 * 前序遍历红黑树
	 */
	private void preOrder(RBTNode<T> tree){
		if(tree!=null){
			System.out.print(tree.key+" ");
			preOrder(tree.left);
			preOrder(tree.right);
		}
	}
	public void preOrder(){
		preOrder(mRoot);
	}
	/*
	 * 中序遍历红黑树
	 */
	private void inOrder(RBTNode<T> tree){
		if(tree!=null){
			inOrder(tree.left);
			System.out.print(tree.key+" ");
			inOrder(tree.right);
		}
	}
	public void inOrder(){
		inOrder(this.mRoot);
	}
	/*
	 * 后序遍历红黑树
	 */
	private void postOrder(RBTNode<T> tree){
		if(tree!=null){
			postOrder(tree.left);
			postOrder(tree.right);
			System.out.print(tree.key+" ");
		}
	}
	public void postOrder(){
		postOrder(mRoot);
	}
	/*
	 * 递归实现查找红黑树x中键值为key的节点
	 */
	public RBTNode<T> search(RBTNode<T> x,T key){
		if(x==null){
			return x;
		}
		int cmp=key.compareTo(x.key);
		if(cmp<0){
			return search(x.left,key);
		}else if(cmp>0){
			return search(x.right,key);
		}else{
			return x;
		}
	}
	public RBTNode<T> search(T key){
		return search(mRoot,key);
	}
	/*
	 * 非递归实现，查找红黑树x中键值为key的节点
	 */
	private RBTNode<T> iterativeSearch(RBTNode<T> x,T key){
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
	public RBTNode <T> iterativeSearch(T key){
		return iterativeSearch(mRoot,key);
	}
	/*
	 * 查找最小节点，返回tree为根节点的红黑树的最小节点
	 * Java实现二叉搜索树
	 * 1.若他的左子树不空，则左子树上所有节点的值均小于它的根节点的值；
   		2.若他的右子树不空，则右子树上所有节点的值均大于它的根节点的值。
   		3.它的左、右子树也分别为排序二叉树。
	 * 
	 */

	private RBTNode<T> minimum(RBTNode <T> tree){
		if(tree==null){
			return null;
		}
		while(tree.left!=null){
			tree=tree.left;
		}
		return tree;

	}
	public T minimum(){
		RBTNode<T> p=minimum(mRoot);
		if(p!=null){
			return p.key;
		}
		return null;
	}
	/*
	 * 查找最大节点，返回tree为根节点的红黑树的最大节点
	 * Java实现二叉搜索树
	 * 1.若他的左子树不空，则左子树上所有节点的值均小于它的根节点的值；
   		2.若他的右子树不空，则右子树上所有节点的值均大于它的根节点的值。
   		3.它的左、右子树也分别为排序二叉树。
	 */
	private RBTNode<T> maximum(RBTNode<T> tree){
		if(tree==null){
			return null;
		}
		while(tree.right!=null){
			tree=tree.right;
		}
		return tree;

	}
	public T maximum(){
		RBTNode<T> p=maximum(mRoot);
		if(p!=null){
			return p.key;
		}
		return null;
	}
	/*
	 * 找节点x的后继节点，即，查找红黑树中数据值大于该结点的最小节点
	 * http://dongxicheng.org/structure/red-black-tree/
	 * http://blog.csdn.net/jk198310/article/details/9950157
	 */
	public RBTNode<T> successor(RBTNode<T> x){
		//如果x存在右孩子，则x的后继节点为以其右孩子为根的子树的最小节点
		if(x.right!=null){
			return minimum(x.right);
		}
		/*
		 * 如果x没有右孩子，则x有以下两种可能。
		 * a.x是一个左孩子，则x的后继节点为它的父节点。
		 * b.x是一个右孩子，则查找x的最低的父节点，并且该父节点要具有左孩子，
		 * 找到这个最低的父节点就是x的后继节点
		 */
		RBTNode<T> y=x.parent;//x是一个左孩子，则x的后继节点为它的父节点。
		while((y!=null)&&(x==y.right)){
			x=y;
			y=y.parent;
		}
		return y;
	}
	/*
	 * 找节点x的前驱节点，即：查找红黑树中数据值小于该节点的最大节点
	 * 
	 */
	public RBTNode<T> predecessor(RBTNode<T> x){
		//如果x存在左孩子，则x的前驱节点为以其左孩子为根的子树的最大节点
		if(x.left!=null){
			return maximum(x.left);
		}

		/*
		 * 如果x没有左孩子，则x有以下两种可能
		 * a.x是一个右孩子，则x的前驱节点为它的父节点。
		 * b.x是一个左孩子，则查找x的最低的父节点，并且该父节点要具有右孩子，
		 * 找到的这个最低的父节点就是x的前驱节点。
		 */
		RBTNode <T> y=x.parent;
		while((y!=null)&&(x==y.left)){
			x=y;
			y=y.parent;
		}
		return y;
	}
	/*
	 * 对红黑树的节点(x)进行左旋转
	 * 左旋转示意图(对节点x进行左旋)
	 * 				
	 * 					   px								     px
	 * 					  /									    /
	 * 					 x									   y
	 * 				   /    \				--x左旋--         /   \
	 * 				  lx     y							   x	 ry
	 * 					   /    \						  /  \
	 * 					  ly    ry						 lx	 ly
	 * 
	 */
	public void leftRotate(RBTNode<T> x){		
		RBTNode <T> y=x.right;//取x的右孩子为y		
		x.right=y.left;//将"y的左孩子"设为"x的右孩子"
		if(y.left!=null){//如果y的左孩子非空，将x设为y的左孩子的父亲。
			y.left.parent=x;
		}		
		y.parent=x.parent;//将x的父亲设为y的父亲。		
		if(x.parent==null){
			this.mRoot=y;//如果x的父亲是空节点，则将y设为根节点
		}else{
			if(x.parent.left==x){//如果x是它父节点的左孩子，则将y设为x的父节点的左孩子。
				x.parent.left=y;
			}else{
				x.parent.right=y;//如果x是它父节点的左孩子，则将y设为x的父节点的左孩子。
			}
		}		
		y.left=x;//将x设为y的左孩子		
		x.parent=y;//将x的父节点设为y		
	}
	/*
	 * 对红黑树的节点y进行右旋转
	 * 如下：
	 *                   py               py
	 *                  /                 /
	 *                 y                 x
	 *               /	\   --y右旋--    /  \
	 *              x    ry          lx    y	               
	 *            /   \                  /   \
	 *           lx    rx               rx   ry
	 * 
	 */
	public void rightRotate(RBTNode<T> y){		
		RBTNode <T> x=y.left;//设置x是当前节点的孩子
		y.left=x.right;	//将x的右孩子设为y的左孩子
		if(x.right!=null){//如果x的右孩子不为空的话，将y设为x的右孩子的父亲
			x.right.parent=y;
		}		
		x.parent=y.parent;//将y的父亲设为x的父亲
		if(y.parent==null){//如果y的父亲是空节点，则将x设为根节点
			this.mRoot=x;			
		}else{
			if(y==y.parent.right){//如果y是它父节点的右孩子，则将x设为y的父节点的右孩子
				y.parent.right=x;				
			}else{
				y.parent.left=x;//y是它父节点的左孩子，将x设为x的父节点的左孩子。
			}
		}		
		x.right=y;//将y设为x的右孩子		
		y.parent=x;//将y的父节点设为x
	}
	/*
	 * 内部方法，将节点node插入到红黑树中
	 * node插入的节点
	 * 
	 *  二叉搜索树性质
	 * 1.若他的左子树不空，则左子树上所有节点的值均小于它的根节点的值；
   2.若他的右子树不空，则右子树上所有节点的值均大于它的根节点的值。
   3.它的左、右子树也分别为排序二叉树。
	 */
	public void insert(RBTNode<T> node){

		int cmp;
		RBTNode<T> y=null;
		RBTNode<T> x=this.mRoot;
		//1将红黑树当做一颗二叉查找树，将节点添加到二叉查找树中。
		while(x!=null){
			y=x;
			cmp=node.key.compareTo(x.key);//看是否在原树中有否要插入的节点,<0，根据二叉搜索树特性，新节点将在左侧插入，>0，新节点将在右侧插入
			if(cmp<0){
				x=x.left;
			}else{
				x=x.right;
			}
		}
		node.parent=y;//当退出循环后，y就是将要插入节点的父节点
		if(y!=null){//如果找到y
			cmp=node.key.compareTo(y.key);
			if(cmp<0){//找的节点的值小于y的值
				y.left=node;//小于的放在y的做吗
			}else{
				y.right=node;//大于的放在y的右面
			}

		}else{//没有找到y
			this.mRoot=node;//当前节点就是根节点
		}

		//2设置节点的颜色为红色
		node.color=RED;
		//3将它重新修正为一颗二叉查找树
		insertFixUp(node);

	}
	/*对外方法，新建节点key，并将其插入到红黑树中
	 * key：插入节点的键值
	 * 
	 */
	public void insert(T key){
		RBTNode<T> node=new RBTNode<T>(key,BLACK,null,null,null);
		//如果新建节点失败，将返回
		if(node!=null){
			insert(node);
		}
	}
	/**
     * 插入节点后修复红黑树（进行颜色调换和树旋转）
     * <p>
     * 情形1：新节点N是树的根节点，没有父节点
     * 这种情形下，直接将它设置为黑色以满足性质2
     * <p>
     * 情形2：新节点的父节点P是黑色
     * 这种情形下，新插入的节点是红色的，因此依然满足性质4.而且因为新节点N有两个黑色叶子节点，
     * 但是由于新节点N是红色，通过它的每个子节点的路径依然保持相同的黑色节点数，因此依然满足性质5
     * <p>
     * 情形3：如果父节点P和父节点的兄弟节点U都是红色
     * 这种情况下：程序应该将P节点、U节点都设置成黑色，并将P节点的父节点设为红色（用来保持性质5）
     * 现在，新节点N有了一个黑色的父节点P。由于从P节点、U节点到根节点的任何路径都必须通过G（P节点
     * 的父节点）节点，这些路径上的黑节点数目没有变化（原来有叶子和G节点两个黑色节点，现在有叶子
     * 和P两个黑色节点）
     * 经过情形3处理后，红色的G节点的父节点也可能是红色的、这就违反了性质4，因此还需要对G节点递归进行
     * 整个过程（把G当成新插入的节点进行处理）
     * <p>
     * 情形4：父节点P是红色，而其兄弟节点U是黑色或缺失；且新节点N是父节点P的右子节点，而父节点P又是其
     * 父节点G的左子节点
     * 这种情形下，对新节点和其父节点进行一次左旋转。接着，按情形5处理以前的父节点P（也就是把P当成新插
     * 入的节点）。这将导致某些路径通过它们以前不通过的新节点N或父节点P其中之一，但是这两个节点都是红色，
     * 因此不影响性质5
     * <p>
     * 情形5：父节点P是红色，而其兄弟节点U是黑色或缺少；且新节点N是其父节点的左子节点，而其父节点P又是其
     * 父节点G的左子节点
     * 这种情况下，需要对节点G进行一次右旋转。在旋转产生的树中，以前的父节点P现在是新节点N和节点G的父节点
     * 由于以前的节点G是黑色（否则父节点P就不能是红色），切换以前的父节点P和节点G的颜色，使之满足性质4。
     * 性质5也仍然保持满足，因为通过这3个节点中任何一个的所有路径以前都通过节点G，现在它们都通过以前的父节
     * 点P。在各自的情形下，这都是3个节点中唯一的黑色节点
     *
     * @param x 修复新插入的节点
     */
	public void insertFixUp(RBTNode<T> node){
		RBTNode<T> parent,gparent;//父亲，和祖父
		//若父节点存在，并且父节点的颜色是红色
		while(((parent=this.parentOf(node))!=null)&&isRed(parent)){

			gparent=this.parentOf(parent);
			//根据课件所写的三种增加修复情况,只针对父节点是祖父节点的左孩子。
			if(parent==gparent.left){
				//找到叔叔节点
				RBTNode<T> uncle=gparent.right;
				//case1 ：叔叔节点是红色，对应PPT的增加修复第一种复杂情况

				if((uncle!=null)&&isRed(uncle)){
					this.setBlack(uncle);//叔叔变黑色
					this.setBlack(parent);//父亲变黑色
					this.setRed(gparent);//祖父变红色
					node=gparent;//把祖父当做当前节点
					continue;//继续
				}
				//case2 ：叔叔是黑色，且当前节点是右孩子，对应PPT的增加修复第二种复杂情况
				if(parent.right==node){
					RBTNode<T> tmp;
					//左旋
					this.leftRotate(parent);
					// 重新设置当前节点，为以后打基础
					tmp=parent;
					parent=node;
					node=tmp;
				}
				//case 3条件：叔叔是黑色，且当前节点是左孩子
				//当前父亲变为黑色
				this.setBlack(parent);
				this.setRed(gparent);//祖父变红色
				this.rightRotate(gparent);//以祖父节点右旋

			}else{//若父节点是祖父节点的右孩子，采用对称特性
				//case 1条件:叔叔节点是红色
				//找到叔叔节点
				RBTNode<T> uncle=gparent.left;

				if((uncle!=null)&&isRed(uncle)){
					this.setBlack(uncle);//叔叔变黑色
					this.setBlack(parent);//父亲变黑色
					this.setRed(gparent);//祖父变红色
					node=gparent;//把祖父当做当前节点
					continue;//继续
				}
				//case 2条件：叔叔是黑色，且当前节点是左孩子
				if(parent.left==node){
					RBTNode<T> tmp;
					//右旋
					this.rightRotate(parent);
					// 重新设置当前节点，为以后打基础
					tmp=parent;
					parent=node;
					node=tmp;
				}
				//case 3条件：叔叔是黑色，且当前节点是右孩子
				this.setBlack(parent);
				this.setRed(gparent);//祖父变红色
				this.leftRotate(gparent);//以祖父节点右旋
			}

		}
		//1新节点位于树的根上，没有父节点
		this.setBlack(this.mRoot);
	}
	/*先以二叉搜索树删除
	 * 删除节点，并返回被删除的节点
	 * node:删除的节点
	 * 后继节点：后继节点：某个节点的后继节点，是指比该节点大的所有节点中的最小的一个节点。
		第一步：将红黑树当做一棵二叉查找树，将节点删除，分三种情况。
		1.被删除节点没有儿子，即为叶节点，直接把父节点的对应儿子指针设为null，删除儿子节点就ok。
		2.被删除节点只有一个儿子，那么直接删除该节点，并用该节点的唯一子节点顶替它的位置。
		3.被删除节点有两个儿子，那么，先找出它的后继节点(是该节点的右子树中的最小节点)；
		然后把"它的后继节点的内容复制给"该节点的内容";之后，删除"它的后继节点"。
	 */
	private void remove(RBTNode<T> node){
		RBTNode<T> child,parent;
		boolean color;
		//被删除节点的“左右孩子都不为空”的情况
		if((node.left!=null)&&(node.right!=null)){
			//被删节点的后继节点:(取代节点),用它来取代被删节点的位置，然后再将被删节点去掉
			RBTNode<T> replace=node;
			//获取后继节点，在右树中找到最小节点(该节点有左子树的，就是他的左子树的节点，但该节点必没有左子树)
			replace=replace.right;
			while(replace.left!=null){
				replace=replace.left;//左树的节点都比replace节点小
			}
			//node节点不是根节点（只有根节点不存在父节点）
			if(this.parentOf(node)!=null){
				if(this.parentOf(node).left==node){//判断自己是不是左节点
					parentOf(node).left=replace;//后继节点给要删除节点的左，

				}else{
					parentOf(node).right=replace;//判断自己是不是右节点，后继节点给要删除节点的右，
				}
			}else{
				//要删除的节点没有父亲，是根节点，后继节点更新为根节点
				this.mRoot=replace;
			}
			/*
			 * 图示参考二叉排序树PPT的第12页
			 */
			//child是取代节点的右孩子，也是需要调整的节点
			//取代节点肯定不存在左孩子，因为他是一个后继节点
			child=replace.right;
			parent=parentOf(replace);//找到后继节点的父节点
			//保存取代节点的颜色
			color=colorOf(replace);
			//被删除节点是它的后继节点的父节点
			if(parent==node){
				parent=replace;
			}else{//被删除节点不是后继节点的父亲
				//后继节点的右节点不为空
				if(child!=null){
					this.setParent(child, parent);//后继节点的父节点付给这个后继节点的右节点
				}
				parent.left=child;//后继节点的右节点变成当前节点父节点的左节点
				replace.right=node.right;//删除的右节点变为后继节点的右节点
				this.setParent(node.right, replace);//把后继节点当做删除右节点的父节点
			}
			/*
			 * 后继节点将要替代删除节点的位置，包括设置其父亲，其颜色，和其左节点
			 */
			replace.parent=node.parent;//要删除节点的父亲 赋值给后继节点的父亲
			replace.color=node.color;////要删除节点的父亲 赋值给后继节点的父亲
			replace.left=node.left;//要删除节点的左 赋值给后继节点的左节点
			node.left.parent=replace;//要删除节点的父亲就是后继节点
			if(color==BLACK){
				//remove
				removeFixUp(child,parent);
			}
			node=null;
			return ;


		}
		//有一个左子树，或右子树
		if(node.left!=null){
			child=node.left;
		}else{
			child=node.right;
		}
		parent=node.parent;
		//保存取代节点的颜色
		color=node.color;
		if(child!=null){
			child.parent=parent;
		}
		//node节点不是根节点，分别把自己的左右儿子付给自己
		if(parent!=null){
			if(parent.left==node){
				parent.left=child;
			}else{
				parent.right=child;
			}
		}else{//其子节点就是根
			this.mRoot=child;
		}
		if(color==BLACK){
			removeFixUp(child,parent);
		}
		node=null;

	}
	/*
	 * tree:红黑树的根节点
	 * z 删除的结点
	 */
	public void remove(T key){
		RBTNode<T> node;
		if((node=search(mRoot,key))!=null){
			remove(node);
		}
	}
	/*
	 * 红黑树的修正函数
	 * 在从红黑树中删除插入节点之后(红黑树失去平衡)，再调用该函数；
	 * 目的是将它重新塑造成一颗红黑树
	 * node：待修正的节点
	 */
	private void removeFixUp(RBTNode<T> node,RBTNode<T> parent) {
		RBTNode<T> other;
		// TODO Auto-generated method stub
		while((node!=null||this.isBlack(node))&&(node!=this.mRoot)){
			if(parent.left==node){
				other=parent.right;//调整节点有右子树
				//C情况：case1 :node的兄弟other是红色的
				if(this.isRed(other)){//且是红色，则将其子节点提升到该节点的位置，颜色变黑					
					this.setBlack(other);
					this.setRed(parent);
					this.leftRotate(parent);
					//左旋后，由于node的兄弟节点发生了变化，需要更新node的兄弟节点，从而进行后续处理。
					other=parent.right;
				}
				////D情况：case 2:node的兄弟other是黑色，且other的两个孩子也都是黑色的
				if((other.left==null||this.isBlack(other.left))&&
						(other.right==null ||this.isBlack(other.right))){
					this.setRed(other);
					node=parent;
					parent=this.parentOf(node);					

				}else{//E情况case3:node的兄弟other是黑色的，并且other的左孩子时红色，右孩子为黑色
					if(other.right==null ||this.isBlack(other.right)){
						this.setBlack(other.left);
						this.setRed(other);
						this.rightRotate(other);
						//右旋后，由于node的兄弟节点发生了变化，需要更新node的兄弟节点，从而进行后续处理。
						other=parent.right;
					}
					//F情况case 4:node的兄弟other是黑色，并且other的右孩子是红色，左孩子时任意色
					this.setColor(other, colorOf(parent));
					this.setBlack(parent);
					this.setBlack(other.right);
					this.leftRotate(parent);
					node=this.mRoot;
					break;


				}
			}else{//调整节点有左子树，对称写
				other=parent.left;
				if(this.isRed(other)){
					//Case 1:node的兄弟other是红色的
					this.setBlack(other);
					this.setRed(parent);
					this.rightRotate(parent);
					other=parent.left;
				}

				if((other.left==null||
						this.isBlack(other.left))&&
						(other.right==null||this.isBlack(other.right))){
					//Case 2 node的兄弟other是黑色，且other的两个孩子也都是黑色的
					this.setRed(other);
					node=parent;
					parent=this.parentOf(node);


				}else{
					if(other.left==null||this.isBlack(other.left)){
						//Case 3:node的兄弟other是黑色的，并且other的左孩子时红色，右孩子为黑色
						this.setBlack(other.right);
						this.setRed(other);
						this.leftRotate(other);
						other=parent.left;
					}
					//Case 4:node的兄弟other是黑色的，并且other的右孩子是红色的，左孩子任意色
					this.setColor(other, this.colorOf(parent));
					this.setBlack(parent);
					this.setBlack(other.left);
					this.rightRotate(parent);
					node=this.mRoot;
					break;

				}

			}
		}
		if(node!=null){
			this.setBlack(node);
		}
	}
	/*
	 * 打印红黑树
	 * key--节点的键值
	 * direction--
	 *   	0：表示该节点是根节点
	 *      1：表示该节点是它的父节点的左孩子
	 *      2：表示该节点是它的父节点的右孩子
	 */
	private void  print(RBTNode<T> tree,T key,int direction){
		if(tree!=null){
			if(direction==0){//tree是根节点
				System.out.printf("%2d(B) is root \n",tree.key);
			}else{//tree是分支节点
				System.out.printf("%2d(%s) is %2d's %6s child\n",tree.key,isRed(tree)?"R":"B",key,direction==1?"right":"left");

			}
			print(tree.left,tree.key,-1);
			print(tree.right,tree.key,1);

		}
	}
	public void print(){
		if(mRoot!=null){
			print(mRoot,mRoot.key,0);
		}
	}
	/*
	 * 销毁红黑树
	 */

	private void destroy(RBTNode<T> tree){
		if(tree==null){
			return;
		}
		if(tree.left!=null){
			destroy(tree.left);
		}
		if(tree.right!=null){
			destroy(tree.right);
		}
		tree=null;

	}
	public void clear(){
		destroy(mRoot);
		mRoot=null;
	}
}

