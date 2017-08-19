package org.crazyit.editor.handler.add;

import java.io.File;

import javax.swing.JOptionPane;

import editor.src.org.crazyit.editor.AddFrame;
import editor.src.org.crazyit.editor.EditorFrame;
import editor.src.org.crazyit.editor.tree.ProjectTreeNode;

/**
 * ���Ŀ¼������
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class AddFolderHandler implements AddHandler {

	public void afterAdd(EditorFrame editorFrame, AddFrame addFrame, Object data) {
		try {
			//���������ѡȡ�Ľڵ�
			ProjectTreeNode selectNode = editorFrame.getSelectNode();
			//��ȡ�ýڵ�����Ӧ���ļ�����
			File folder = selectNode.getFile();
			//���folder����һ��Ŀ¼������selectNode�ĸ��ڵ㣨��һ��Ŀ¼����Ϊ��Ŀ¼�ĸ�Ŀ¼
			if (!folder.isDirectory()) {
				ProjectTreeNode parent = (ProjectTreeNode)selectNode.getParent();
				//�õ�ǰ��ѡ����ļ��ĸ�Ŀ¼��Ϊ��ǰѡ���Ŀ¼
				selectNode = parent;
				folder = parent.getFile();
			}
			//����һ���ļ�Ŀ¼����
			File newFolder = new File(folder.getAbsoluteFile() + File.separator + data);
			//�����Ŀ¼�Ѿ����ڣ�������ʾ������
			if (newFolder.exists()) {
				JOptionPane.showMessageDialog(addFrame, "Ŀ¼�Ѿ�����");
				return;
			}
			//�����µ�Ŀ¼
			newFolder.mkdir();
			//ˢ�����Ľڵ�
			editorFrame.reloadNode(selectNode);
			//��EditorFrame����
			editorFrame.setEnabled(true);
			//����ӵ�frame���ɼ�
			addFrame.setVisible(false);
		} catch (Exception e) {
			throw new FileException("create folder error: " + e.getMessage());
		}
	}

}
