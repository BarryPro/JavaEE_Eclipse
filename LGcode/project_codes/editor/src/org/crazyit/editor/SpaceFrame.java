package org.crazyit.editor;

import java.awt.Label;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;

import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

import editor.src.org.crazyit.editor.commons.WorkSpace;

/**
 * �����ռ����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class SpaceFrame extends JFrame {

	private JPanel mainPanel;
	
	private JLabel infoLabel;
	
	private JPanel chosePanel;
	
	private JLabel workTextLabel;
	
	//�����ռ�����ʾ�û�ѡ���ļ�Ŀ¼��JTextField
	private JTextField pathText;
	
	private JButton choseButton;
	
	
	private JPanel buttonPanel;
	
	//�����ռ��е�ȷ����ť
	private JButton confirmButton;
	
	private JButton cancelButton;
	
	private SpaceChooser chooser;
	
	//�û�ѡ����ļ�Ŀ¼����
	private File folder;
	
	public SpaceFrame(EditorFrame editorFrame) {
		mainPanel = new JPanel();
		infoLabel = new JLabel("��ѡ�����ռ�");
		chosePanel = new JPanel();
		workTextLabel = new JLabel("�����ռ�: ");
		pathText = new JTextField("", 40);
		choseButton = new JButton("ѡ��");
		buttonPanel = new JPanel();
		confirmButton = new JButton("ȷ��");
		cancelButton = new JButton("ȡ��");
		chooser = new SpaceChooser(this);
		
		//������Panel�Ĳ���
		mainPanel.setLayout(new BoxLayout(mainPanel, BoxLayout.Y_AXIS));
		mainPanel.add(infoLabel);
		//����ѡ�����Ĳ���
		chosePanel.setLayout(new BoxLayout(chosePanel, BoxLayout.X_AXIS));
		choseButton.addActionListener(new ChoseButtonListener(chooser));
		pathText.setEditable(false);
		chosePanel.add(workTextLabel);
		chosePanel.add(pathText);
		chosePanel.add(choseButton);
		mainPanel.add(chosePanel);

		confirmButton.setEnabled(false);
		//Ϊȷ����ť���ȷ�����¼�, ������һ��WorkSpace����
		confirmButton.addActionListener(new ConfirmButtonListener(this, editorFrame));
		buttonPanel.add(confirmButton);
		buttonPanel.add(new Label("    "));
		buttonPanel.add(cancelButton);
		//Ϊȡ����ť����˳��¼�
		cancelButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				System.exit(0);
			}
		});
		mainPanel.add(buttonPanel);
		add(mainPanel);
		pack();
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setLocation(300, 200);
		setResizable(false);
	}

	public File getFolder() {
		return folder;
	}

	public void setFolder(File folder) {
		this.folder = folder;
	}
		
	public JTextField getPathText() {
		return pathText;
	}

	public JButton getConfirmButton() {
		return confirmButton;
	}
}

/**
 * ȷ����ť�ļ�����
 * @author hp
 *
 */
class ConfirmButtonListener implements ActionListener {
	
	private SpaceFrame spaceFrame;
	
	private EditorFrame editorFrame;
	
	public ConfirmButtonListener(SpaceFrame spaceFrame, EditorFrame editorFrame) {
		this.spaceFrame = spaceFrame;
		this.editorFrame = editorFrame;
	}
	
	public void actionPerformed(ActionEvent arg0) {
		//��EditorFrame��initFrame������ʼ������
		editorFrame.initFrame(new WorkSpace(spaceFrame.getFolder(), editorFrame));
		//��EditorFrame��Ϊ�ɼ�
		editorFrame.setVisible(true);
		editorFrame.setSize(900, 600);
		//�ù���ѡ��ռ���治�ɼ�
		spaceFrame.setVisible(false);
	}
}

/**
 * ѡ��ť�ļ�����
 * @author hp
 *
 */
class ChoseButtonListener implements ActionListener {

	private JFileChooser chooser;
	
	public ChoseButtonListener(JFileChooser chooser) {
		this.chooser = chooser;
	}
	
	@Override
	public void actionPerformed(ActionEvent arg0) {
		chooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
		chooser.showOpenDialog(null);
	}
	
}

/**
 * �ļ�ѡ����
 * @author hp
 *
 */
class SpaceChooser extends JFileChooser {
	
	private SpaceFrame spaceFrame;
	
	//��Ҫ��SpaceFrame��Ϊ�������
	public SpaceChooser(SpaceFrame spaceFrame) {
		//����ѡ������ʱ��Ŀ¼
		super("/");
		this.spaceFrame = spaceFrame;
	}
	
	//��д�����ѡ���ļ�����
	public void approveSelection() {
		//��ȡ�û�ѡ����ļ�
		File folder = getSelectedFile();
		//����SpaceFrame������folder��ֵ
		spaceFrame.setFolder(folder);
		//����SpaceFrame�ı���
		spaceFrame.getPathText().setText(folder.getAbsolutePath());
		//����ȷ����ť����
		spaceFrame.getConfirmButton().setEnabled(true);
		//���ø����ѡ���ļ�����
		super.approveSelection();
	}
}
