package org.crazyit.editor.handler.add;

import java.io.File;

import javax.swing.JOptionPane;

import editor.src.org.crazyit.editor.AddFrame;
import editor.src.org.crazyit.editor.EditorFrame;
import editor.src.org.crazyit.editor.tree.ProjectTreeNode;

/**
 * ����ļ�������
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class AddFileHandler implements AddHandler {

	public void afterAdd(EditorFrame editorFrame, AddFrame addFrame, Object data) {
		try {
			//��õ�ǰ��ѡ������ڵ�
			ProjectTreeNode selectNode = editorFrame.getSelectNode();
			//��ȡ��ǰѡ��ڵ�����Ӧ���ļ�
			File folder = selectNode.getFile();
			//���folder����һ��Ŀ¼������selectNode�ĸ��ڵ㣨��һ��Ŀ¼����Ϊ���ļ��Ĵ��Ŀ¼
			if (!folder.isDirectory()) {
				ProjectTreeNode parent = (ProjectTreeNode)selectNode.getParent();
				selectNode = parent;
				folder = parent.getFile();
			}
			//�����ļ����ŵ�folder��
			File newFile = new File(folder.getAbsoluteFile() + File.separator + data);
			//����ļ��Ѿ����ڣ��͵�����ʾ������
			if (newFile.exists()) {
				JOptionPane.showMessageDialog(addFrame, "�ļ��Ѿ�����");
				return;
			}
			newFile.createNewFile();
			editorFrame.reloadNode(selectNode);
			//ʹ���༭frame����
			editorFrame.setEnabled(true);
			///����ӵ�frame���ɼ�
			addFrame.setVisible(false);
		} catch (Exception e) {
			throw new FileException("create file error: " + e.getMessage());
		}
	}

}
