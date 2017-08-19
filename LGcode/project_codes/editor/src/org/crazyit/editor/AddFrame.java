package org.crazyit.editor;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.awt.event.WindowAdapter;

import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

import editor.src.org.crazyit.editor.commons.AddInfo;

/**
 * ��ӽ���
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class AddFrame extends JFrame {

	//��Frame��JPanel
	private JPanel mainPanel;
	
	//��Ŀ����
	private JPanel namePanel;
	
	//��ʾ�ļ���JLabel
	private JLabel nameLabel;
	
	//�������Ƶ�JTextField
	private JTextField nameText;
	
	//�Ű�ť��Panel
	private JPanel buttonPanel;
	
	//ȷ����ť
	private JButton confirmButton;
	
	//ȡ����ť
	private JButton cancelButton;
	
	
	public AddFrame(final AddInfo info) {
		mainPanel = new JPanel();
		namePanel = new JPanel();
		//����nameLabel������
		nameLabel = new JLabel(info.getInfo());
		nameText = new JTextField("", 20);
		buttonPanel = new JPanel();
		confirmButton = new JButton("ȷ��");
		cancelButton = new JButton("ȡ��");
		
		mainPanel.setLayout(new BoxLayout(mainPanel, BoxLayout.Y_AXIS));
		addWindowListener(new WindowAdapter() {
			public void windowClosing(java.awt.event.WindowEvent e) {
				cancel(info);
			}
		});
		setLocation(200, 200);
		setResizable(false);
		//�ı���ǰ�����
		namePanel.setLayout(new BoxLayout(namePanel, BoxLayout.X_AXIS));		
		namePanel.add(nameLabel);
		namePanel.add(nameText);
		nameText.addKeyListener(new KeyAdapter() {
			public void keyReleased(KeyEvent e) {
				//�ж���Ŀ·���������Ƿ���ֵ, �������text field����ֵ, ��ȷ����ť����
				if (nameText.getText().equals("")) {
					confirmButton.setEnabled(false);
				} else {
					confirmButton.setEnabled(true);
				}
			}
		});
		
		//ȷ����ȡ���İ�ť
		buttonPanel.setLayout(new BoxLayout(buttonPanel, BoxLayout.X_AXIS));
		confirmButton.setEnabled(false);
		buttonPanel.add(confirmButton);
		buttonPanel.add(new JLabel("    "));
		buttonPanel.add(cancelButton);
		
		//Ϊȡ����ť��Ӽ�����
		cancelButton.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e) {
				cancel(info);
			}
		});
		//Ϊȷ����ť��Ӽ�����
		confirmButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				//��������û��ֵ������
				if (nameText.getText() == "") return;
				handerConfirm(info);
			}
		});
		mainPanel.add(namePanel);
		mainPanel.add(buttonPanel);
		add(mainPanel);
		pack();
	}
	
	//����ȷ����ť�ĵ��
	private void handerConfirm(AddInfo info) {
		//��ȡ���û�����
		String data = nameText.getText();
		//��������漰��һЩ��ҵ����صĲ�������Handler�ദ��
		info.getHandler().afterAdd(info.getEditorFrame(), this, data);
	}
	
	private void cancel(AddInfo info) {
		//����EditorFrame����
		info.getEditorFrame().setEnabled(true);
		//�ñ����ڲ��ɼ�
		setVisible(false);
	}
	

	
}


