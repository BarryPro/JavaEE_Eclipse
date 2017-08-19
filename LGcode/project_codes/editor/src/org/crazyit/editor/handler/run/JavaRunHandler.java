package org.crazyit.editor.handler.run;

import java.io.File;

import editor.src.org.crazyit.editor.EditorFrame;
import editor.src.org.crazyit.editor.config.CompileConfig;

/**
 * ����Java�ļ�������
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class JavaRunHandler {

	public String run(EditorFrame editorFrame) {
		try {
			//�����ĿĿ¼��·��
			String projectPath = editorFrame.getCurrentProject().getAbsolutePath();
			//���Դ�ļ���ȫ·��
			String sourcePath = editorFrame.getCurrentFile().getFile().getAbsolutePath();
			//�����Ŀ�ı���·������ĿĿ¼��CompileConfig�����õ����Ŀ¼
			String classPath = editorFrame.getCurrentProject().getAbsolutePath() 
				+ File.separator + CompileConfig.OUTPUT_DIR;
			//��ȡ����
			String className = getClassName(projectPath, sourcePath);
			//ƴװ����
			String command = "java -cp \"" + classPath + "\" " + className;
			Process p = CommandUtil.executeCommand(command);
			return CommandUtil.getRunString(p);
		} catch (Exception e) {
			return e.getMessage();
		}
	}
	
	//������ĿĿ¼��·����JavaԴ�ļ���·����ȡһ�����ȫ�޶�����
	private String getClassName(String projectPath, String sourcePath) {
		String temp = projectPath + File.separator + CompileConfig.SRC_DIR + 
		File.separator;
		String result = sourcePath.replace(temp, "");
		result = result.replace(".java", "");
		result = result.replace(String.valueOf(File.separatorChar), ".");
		return result;
	}
	

}
