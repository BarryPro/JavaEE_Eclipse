package org.crazyit.editor.handler.save;

import editor.src.org.crazyit.editor.EditorFrame;

/**
 * ���涯�����н���ʵ��
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class SaveMediatorConcrete extends SaveMediator {

	private SaveHandler commonHandler;
	
	private SaveHandler javaHandler;
	
	//��������������Ķ���
	public SaveMediatorConcrete() {
		this.commonHandler = new CommonSaveHandler();
		this.javaHandler = new JavaSaveHandler();
	}
	
	public String doSave(EditorFrame editorFrame) {
		//��õ�ǰ�༭���ļ���
		String fileName = editorFrame.getCurrentFile().getFile().getName();
		String result = null;
		//�ж��ļ��Ƿ�ΪJava�ļ��� �پ���������
		if (fileName.endsWith(".java")) {//����java�ļ�
			result = javaHandler.save(editorFrame);
		} else {//ִ����ͨ�ı���
			result = commonHandler.save(editorFrame);
		}
		return result;
	}

}
