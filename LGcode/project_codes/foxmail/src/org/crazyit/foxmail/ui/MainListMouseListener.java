package org.crazyit.foxmail.ui;

import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.io.File;

import javax.swing.JFileChooser;
import javax.swing.JList;
import javax.swing.JOptionPane;

/**
 * ���������ʼ������б�ļ�����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class MainListMouseListener extends MouseAdapter {

	@Override
	public void mouseClicked(MouseEvent e) {
		if (e.getClickCount() == 2) {
			JList list = (JList)e.getSource();
			FileObject file = (FileObject)list.getSelectedValue();
			if (file == null) return;
			handle(file);
		}
	}
	
	public void handle(FileObject file) {
		int result = JOptionPane.showOptionDialog(null, "��ѡ�����", "ѡ��",
				0, JOptionPane.QUESTION_MESSAGE, null, 
				new Object[]{"��", "���Ϊ", "ȡ��"}, null);
		if (result == 0) {
			openFile(file);//�򿪲���
		} else if (result == 1) {
			saveAs(file);//���Ϊ����
		}
	}
	
	//�򿪲���
	public void openFile(FileObject file) {
		try {
			Runtime.getRuntime().exec("cmd /c \"" + 
					file.getFile().getAbsolutePath() + "\"");
		} catch (Exception e) {
			e.printStackTrace();
			JOptionPane.showConfirmDialog(null, "���ļ�����, " + 
					file.getSourceName() + "�ļ�������", "����", 
					JOptionPane.OK_CANCEL_OPTION);
		}
	}
	
	//���Ϊ����, ���ļ�ѡ����
	public void saveAs(FileObject file) {
		FolderChooser chooser = new FolderChooser(file);
		chooser.showSaveDialog(null);
	}
}

class FolderChooser extends JFileChooser {
	//��Ҫ���Ϊ���ļ�
	private FileObject sourceFile;
	
	public FolderChooser(FileObject sourceFile) {
		this.sourceFile = sourceFile;
		//ֻ��ѡĿ¼
		this.setFileSelectionMode(DIRECTORIES_ONLY); 
	}
	//���ļ�ѡ������ѡ�����ļ�����Ŀ¼��
	public void approveSelection() {
		File targetFile = getSelectedFile();
		if (targetFile.isDirectory()) {
			//����û�ѡ����Ŀ¼, ��û�������µ��ļ���, ����sourceName��Ϊ�ļ���
			File newFile = new File(targetFile.getAbsolutePath() + File.separator 
					+ this.sourceFile.getSourceName());
			FileUtil.copy(this.sourceFile.getFile(), newFile);
		} else {
			//�û��������µ��ļ���, ֱ�Ӹ���
			FileUtil.copy(this.sourceFile.getFile(), targetFile);
		}
		super.approveSelection();
	}	
}
