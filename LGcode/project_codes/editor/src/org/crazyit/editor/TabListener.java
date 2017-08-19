package org.crazyit.editor;

import javax.swing.JInternalFrame;
import javax.swing.JTabbedPane;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;

import editor.src.org.crazyit.editor.commons.EditFile;

/**
 * tabҳת��������
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class TabListener implements ChangeListener {

	private EditorFrame editorFrame;
	
	public TabListener(EditorFrame editorFrame) {
		this.editorFrame = editorFrame;
	}
	
	public void stateChanged(ChangeEvent e) {
		//��õ�ǰ���tabҳ����
		JTabbedPane tab = (JTabbedPane)e.getSource();
		//���tabҳ������
		int index = tab.getSelectedIndex();
		if (index == -1) return; 
		//����tabҳ��tips(�ļ��ľ���·��)��õ�ǰ��JInternalFrame����
		JInternalFrame currentFrame = editorFrame.getIFrame(tab.getToolTipTextAt(index));
		//�õ�ǰ�����JInternalFrame����ɼ�
		editorFrame.showIFrame(currentFrame);
		//���ݵ�ǰ��JInternalFrame�����ö�Ӧ���ļ�
		EditFile currentFile = editorFrame.getEditFile(currentFrame);
		//����EditorFrame��ǰ�༭���ļ�Ϊtab��Ӧ���ļ�
		editorFrame.setCurrentFile(currentFile);
	}

}
