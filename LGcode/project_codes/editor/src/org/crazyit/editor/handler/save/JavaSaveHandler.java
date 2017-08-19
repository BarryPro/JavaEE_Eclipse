package org.crazyit.editor.handler.save;

import java.io.File;

import editor.src.org.crazyit.editor.EditorFrame;
import editor.src.org.crazyit.editor.config.CompileConfig;

/**
 * ����Java�ļ��Ĵ�����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class JavaSaveHandler extends CommonSaveHandler {

	
	
	public String save(EditorFrame editorFrame) {
		//���ø���ı��淽��
		super.save(editorFrame);
		return javac(editorFrame);
	}

	//ִ��javac����
	private String javac(EditorFrame editorFrame) {
		try {
			//�����Ŀ�ı���·������ĿĿ¼��CompileConfig�����õ����Ŀ¼
			String classPath = editorFrame.getCurrentProject().getAbsolutePath() 
				+ File.separator + CompileConfig.OUTPUT_DIR;
			//���Դ�ļ����ļ�·��
			String filePath = editorFrame.getCurrentFile().getFile().getAbsolutePath();
			//ƴװ�ַ������������ֻ����windows������
			String command = "javac -d \"" + classPath + "\" \"" + filePath + "\"";
			Process p = CommandUtil.executeCommand(command);
			return CommandUtil.getProcessString(p);
		} catch (Exception e) {
			return e.getMessage();
		}
	}
	

}
