package org.crazyit.editor.handler.add;

import editor.src.org.crazyit.editor.AddFrame;
import editor.src.org.crazyit.editor.EditorFrame;

/**
 * ����¼��Ľӿ�
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public interface AddHandler {

	//���������Ҫ�������飬��Ҫ����������ʵ����ȥʵ��
	//����ΪEditorFrame��AddFrame���������Ϣdata
	void afterAdd(EditorFrame editorFrame, AddFrame addFrame, Object data);
}
