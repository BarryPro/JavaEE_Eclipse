package org.crazyit.editor.tree;

import java.io.File;

import javax.swing.JTree;

import editor.src.org.crazyit.editor.EditorFrame;

/**
 * �������ӿ�
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public interface TreeCreator {

	/**
	 * ���ݱ༭��EditorFrame���󴴽���Ŀ��
	 * @param editorFrame
	 * @return
	 */
	JTree createTree(EditorFrame editorFrame);
	
	/**
	 * ����һ��Ŀ¼�������Ľڵ�
	 * @param folder
	 * @return
	 */
	ProjectTreeNode createNode(File folder);
}
