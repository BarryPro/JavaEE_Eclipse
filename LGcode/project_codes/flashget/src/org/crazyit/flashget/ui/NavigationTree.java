package org.crazyit.flashget.ui;

import javax.swing.JTree;
import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.TreePath;

/**
 * ������
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class NavigationTree extends JTree {

	public NavigationTree(DefaultMutableTreeNode root) {
		super(root);
		this.setRootVisible(false);
		this.setShowsRootHandles(true);
		this.setCellRenderer(new NavigationTreeCellRender());
		//չ����һ��ڵ�
		for (int i = 0; i < root.getChildCount(); i++) {
			DefaultMutableTreeNode node = (DefaultMutableTreeNode)root.getChildAt(i);
			this.expandPath(new TreePath(node.getPath()));
		}
	}
}
