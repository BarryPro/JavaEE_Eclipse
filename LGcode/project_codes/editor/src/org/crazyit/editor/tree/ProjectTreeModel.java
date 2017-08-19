package org.crazyit.editor.tree;

import javax.swing.tree.DefaultTreeModel;

/**
 * ��Ŀ����Model����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class ProjectTreeModel extends DefaultTreeModel {
	
	public ProjectTreeModel(ProjectTreeNode arg0) {
		super(arg0);
	}

	public void reload(ProjectTreeNode node, TreeCreator creator) {
		//��ȡnode�ڵ�ĸ��ڵ�
		ProjectTreeNode parent = (ProjectTreeNode)node.getParent();
		//���ڵ�Ϊnull�����أ�����Ҫreload
		if (parent == null) return;
		//��ȡnode�ڵ��ڸ��ڵ������
		int index = parent.getIndex(node);
		//��װnode�ڵ��parent��ɾ��
		parent.remove(index);
		//��ͨ��TreeCreator��ȡ�µĽڵ�
		node = creator.createNode(node.getFile());
		//��ӵ����ڵ���
		parent.insert(node, index);
		//����DefaultTreeModel��reload����
		super.reload(node);
	}

	
	
	
	
}
