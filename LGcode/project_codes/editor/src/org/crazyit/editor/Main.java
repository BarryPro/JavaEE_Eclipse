package org.crazyit.editor;

import editor.src.org.crazyit.editor.tree.TreeCreator;
import editor.src.org.crazyit.editor.tree.TreeCreatorImpl;

/**
 * ���������
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class Main {

	public static void main(String[] args) {
		TreeCreator treeCreator = new TreeCreatorImpl();
		//����EditorFrame����ʱ�������ÿɼ�
		EditorFrame editorFrame = new EditorFrame("ide", treeCreator);
		//��editorFrame������ΪSpaceFrame�Ĺ������
		SpaceFrame spaceFrame = new SpaceFrame(editorFrame);
		//��SpaceFrame�ɼ�
		spaceFrame.setVisible(true);
	}
}
