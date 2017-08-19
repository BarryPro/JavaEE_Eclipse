package org.crazyit.editor.handler.add;

import java.io.File;

import javax.swing.JOptionPane;
import javax.swing.JTree;

import editor.src.org.crazyit.editor.AddFrame;
import editor.src.org.crazyit.editor.EditorFrame;
import editor.src.org.crazyit.editor.config.CompileConfig;

/**
 * �����Ŀ������
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class AddProjectHandler implements AddHandler {

	public void afterAdd(EditorFrame editorFrame, AddFrame addFrame, Object data) {
		try {
			//��ȡ�����ռ����ڵ�Ŀ¼
			File spaceFolder = editorFrame.getWorkSpace().getFolder();
			//����.project�ļ�
			File projectFile = new File(spaceFolder.getAbsoluteFile() + 
					File.separator + data + ".project");
			//������ĿĿ¼
			File projectFolder = new File(spaceFolder.getAbsoluteFile() + File.separator + data);
			//��Ŀ�Ѿ����ڣ��������沢����
			if (projectFile.exists() && projectFolder.exists()) {
				JOptionPane.showMessageDialog(addFrame, "��Ŀ�Ѿ�����");
				return;
			}
			//��Ŀ�ļ������ڣ� ������Ŀ�ļ�
			if (!projectFile.exists()) projectFile.createNewFile();
			//��ĿĿ¼�����ڣ� ������Ŀ�ļ�Ŀ¼
			if (!projectFolder.exists()) projectFolder.mkdir();
			//������Ŀ��srcĿ¼�ͱ���Ŀ¼
			File src = new File(projectFolder.getAbsoluteFile() + 
					File.separator + CompileConfig.SRC_DIR);
			//Java�ļ����������Ŀ¼
			File output = new File(projectFolder.getAbsoluteFile() + 
					File.separator + CompileConfig.OUTPUT_DIR);
			//����src��output����Ŀ¼
			src.mkdir();
			output.mkdir();
			//ˢ��������
			JTree newTree = editorFrame.getTreeCreator().createTree(editorFrame);
			editorFrame.refreshTree(newTree); 
			//��EditorFrame��ÿ���
			editorFrame.setEnabled(true);
			//����ӵ�frame���ɼ�
			addFrame.setVisible(false);
		} catch (Exception e) {
			throw new FileException("create project error: " + e.getMessage());
		}
	}

}
