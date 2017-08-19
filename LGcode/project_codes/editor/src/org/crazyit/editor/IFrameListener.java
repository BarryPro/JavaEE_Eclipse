package org.crazyit.editor;

import javax.swing.JInternalFrame;
import javax.swing.event.InternalFrameAdapter;
import javax.swing.event.InternalFrameEvent;

import editor.src.org.crazyit.editor.commons.EditFile;

/**
 * ���ڼ�����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class IFrameListener extends InternalFrameAdapter {

	private EditorFrame editorFrame;
	
	public IFrameListener(EditorFrame editorFrame) {
		this.editorFrame = editorFrame;
	}

	public void internalFrameActivated(InternalFrameEvent e) {
		JInternalFrame iframe = editorFrame.getDesk().getSelectedFrame();
		int tapIndex = editorFrame.getTabIndex(iframe.getTitle());
		editorFrame.getTabPane().setSelectedIndex(tapIndex);
	}

	public void internalFrameClosing(InternalFrameEvent e) {
		//��ȡ��ǰ�رղ�������Ӧ��JInternalFrame
		JInternalFrame iframe = (JInternalFrame)e.getSource();
		//��ȡ��ǰ�������ļ�
		EditFile editFile = editorFrame.getCurrentFile();
		//ѯ���Ƿ�Ҫ����
		editorFrame.askSave(editFile); 
		//�رյ�ǰ��iframe
		editorFrame.closeIFrame(iframe);
	}
}
