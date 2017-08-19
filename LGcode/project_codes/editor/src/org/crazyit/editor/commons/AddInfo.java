package org.crazyit.editor.commons;

import editor.src.org.crazyit.editor.EditorFrame;
import editor.src.org.crazyit.editor.handler.add.AddHandler;

/**
 * ��ӵ���Ϣ����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class AddInfo {

	//�ַ���, �����������textǰ��ʾ, ����: �ļ�����
	private String info;
	
	//����������Ӱ�����frame
	private EditorFrame editorFrame;
	
	//�������Ĵ�����
	private AddHandler handler;
	
	public AddInfo(String info, EditorFrame editorFrame, AddHandler handler) {
		this.info = info;
		this.editorFrame = editorFrame;
		this.handler = handler;
	}

	public AddHandler getHandler() {
		return handler;
	}

	public void setHandler(AddHandler handler) {
		this.handler = handler;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	public EditorFrame getEditorFrame() {
		return editorFrame;
	}

	public void setEditorFrame(EditorFrame editorFrame) {
		this.editorFrame = editorFrame;
	}

}
