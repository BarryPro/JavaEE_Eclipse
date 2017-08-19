package org.crazyit.foxmail.ui;

import java.awt.Component;
import java.awt.Font;

import javax.swing.JTree;
import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.DefaultTreeCellRenderer;
import javax.swing.tree.TreePath;

import foxmail.src.org.crazyit.foxmail.box.MailBox;

/**
 * �̳�DefaultTreeCellRenderer��ʵ��ÿ���ڵ㶼�в�ͬ��ͼ��
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class SailTreeCellRenderer extends DefaultTreeCellRenderer {

	//���ڵ㱻ѡ��ʱ������
	private Font selectFont;
	
	public SailTreeCellRenderer() {
		this.selectFont = new Font(null, Font.BOLD, 12);
	}
	@Override
	public Component getTreeCellRendererComponent(JTree tree, Object value,
			boolean sel, boolean expanded, boolean leaf, int row,
			boolean hasFocus) {
		DefaultMutableTreeNode node = (DefaultMutableTreeNode)value;
		MailBox box = (MailBox)node.getUserObject();
		this.setText(box.getText());
		//�ж��Ƿ�ѡ��, �پ���ʹ������
		if (isSelected(node, tree)) {
			this.setFont(this.selectFont);
		} else {
			this.setFont(null);
		}
		this.setIcon(box.getImageIcon());
		return this;
	}
	
	//�ж�һ��node�Ƿ�ѡ��
	private boolean isSelected(DefaultMutableTreeNode node, JTree tree) {
		//�õ�ѡ�е�TreePath
		TreePath treePath = tree.getSelectionPath();
		if (treePath == null) return false;
		//�õ���ѡ�еĽڵ�
		DefaultMutableTreeNode selectNode = (DefaultMutableTreeNode)treePath.getLastPathComponent();
		if (node.equals(selectNode)) {
			return true;
		}
		return false;
	}
	
}
