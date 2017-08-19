package org.crazyit.editor.commons;

import java.io.File;

import editor.src.org.crazyit.editor.EditorFrame;

/**
 * �����ռ����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class WorkSpace {

	//�����ռ��Ӧ��Ŀ¼
	private File folder;
	
	//�����ռ��е����༭������
	private EditorFrame editorFrame;
	
	public WorkSpace(File folder, EditorFrame editorFrame) {
		this.folder = folder;
		this.editorFrame = editorFrame;
	}

	public EditorFrame getEditorFrame() {
		return editorFrame;
	}

	public void setEditorFrame(EditorFrame editorFrame) {
		this.editorFrame = editorFrame;
	}


	public File getFolder() {
		return folder;
	}

	public void setFolder(File folder) {
		this.folder = folder;
	}
	
}
