package org.crazyit.editor.handler.save;

import editor.src.org.crazyit.editor.EditorFrame;
import editor.src.org.crazyit.editor.commons.EditFile;

/**
 * ִ����ͨ����Ĵ�����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class CommonSaveHandler implements SaveHandler {

	//�ṩһ�����淽������Ϊ��ͨ�ı���
	public String save(EditorFrame editorFrame) {
		EditFile editFile = editorFrame.getCurrentFile();
		FileUtil.writeFile(editFile.getFile(), editFile.getEditPane().getText());
		return null; 
	}

}
