package org.crazyit.transaction.ui.dialog;

import java.awt.Dimension;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.Box;
import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;

import transaction.src.org.crazyit.transaction.model.Transaction;

public class ViewTransactionDialog extends JDialog {

	//����
	private JLabel titleLabel = new JLabel("����: ");
	private JTextField title = new JTextField(10);
	
	//����
	private JLabel contentLabel = new JLabel("����: ");
	private JTextArea content = new JTextArea(10, 40);
	private JScrollPane contentPane = new JScrollPane(content);
	
	//Ŀ�����ʱ��
	private JLabel targetDateLabel = new JLabel("���ʱ��: ");
	private JTextField targetDate = new JTextField(10);
	
	//������
	private JLabel handlerLabel = new JLabel("��ǰ������: ");
	private JTextField handler = new JTextField(10);
	//������id(����)
	private JTextField handlerId = new JTextField();
	
	//������(ϵͳ)
	private JLabel initiatorLabel = new JLabel("������: ");
	private JTextField initiator = new JTextField(10);
	
	//��ť
	private JButton confirmButton = new JButton("�ر�");
	
	private JLabel processLabel = new JLabel("�������");
	private JTextArea processArea = new JTextArea(5, 40);
	private JScrollPane processScrollPane;
	
	private Transaction transaction;
	
	public ViewTransactionDialog() {
		this.handlerId.setVisible(false);
		this.content.setEditable(false);
		this.title.setEditable(false);
		this.targetDate.setEditable(false);
		this.initiator.setEditable(false);
		this.handler.setEditable(false);
		this.processArea.setEditable(false);
		this.processScrollPane = new JScrollPane(this.processArea);
		//����
		Box titleBox = Box.createHorizontalBox();
		titleBox.add(Box.createHorizontalStrut(43));
		titleBox.add(this.titleLabel);
		titleBox.add(this.title);
		titleBox.add(Box.createHorizontalStrut(30));
		//����
		Box contentBox = Box.createHorizontalBox();
		contentBox.add(Box.createHorizontalStrut(43));
		contentBox.add(this.contentLabel);
		contentBox.add(this.contentPane);
		contentBox.add(Box.createHorizontalStrut(30));
		//���ʱ��
		Box targetDateBox = Box.createHorizontalBox();
		targetDateBox.add(Box.createHorizontalStrut(17));
		targetDateBox.add(this.targetDateLabel);
		targetDateBox.add(this.targetDate);
		targetDateBox.add(Box.createHorizontalStrut(230));
		//������
		Box handlerBox = Box.createHorizontalBox();
		handlerBox.add(Box.createHorizontalStrut(4));
		handlerBox.add(this.handlerLabel);
		handlerBox.add(this.handler);
		handlerBox.add(this.handlerId);
		handlerBox.add(Box.createHorizontalStrut(230));
		//�������
		Box processTextBox = Box.createHorizontalBox();
		processTextBox.add(this.processLabel);
		//������
		Box initiatorBox = Box.createHorizontalBox();
		initiatorBox.add(Box.createHorizontalStrut(30));
		initiatorBox.add(this.initiatorLabel);
		initiatorBox.add(this.initiator);
		initiatorBox.add(Box.createHorizontalStrut(312));
		//��ť
		Box buttonBox = Box.createHorizontalBox();
		buttonBox.add(this.confirmButton);
		
		Box mainBox = Box.createVerticalBox();
		mainBox.add(Box.createVerticalStrut(20));
		mainBox.add(titleBox);
		mainBox.add(Box.createVerticalStrut(10));
		mainBox.add(contentBox);
		mainBox.add(Box.createVerticalStrut(10));
		mainBox.add(targetDateBox);
		mainBox.add(Box.createVerticalStrut(10));
		mainBox.add(handlerBox);
		mainBox.add(Box.createVerticalStrut(10));
		mainBox.add(initiatorBox);
		mainBox.add(Box.createVerticalStrut(10));
		mainBox.add(processTextBox);
		mainBox.add(Box.createVerticalStrut(10));
		mainBox.add(this.processScrollPane);
		mainBox.add(Box.createVerticalStrut(10));
		mainBox.add(buttonBox);
		mainBox.add(Box.createVerticalStrut(20));
		this.add(mainBox);	
		this.pack();
		this.setResizable(false);
		this.setTitle("����������");
		Dimension screen = Toolkit.getDefaultToolkit().getScreenSize();
		this.setLocation((int)screen.getWidth()/4, (int)screen.getHeight()/7);
		initListeners();
		
	}
	
	private void initListeners() {
		this.confirmButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				setVisible(false);
			}
		});
	}
	
	public void setTransaction(Transaction t) {
		this.transaction = t;
	}

	public void setVisible(boolean b) {
		super.setVisible(b);
		if (!b) return;
		//�����ǰ�����Transaction����Ϊ��,��������Ӧ��ֵ
		if (this.transaction != null) {
			this.title.setText(this.transaction.getTS_TITLE());
			this.content.setText(this.transaction.getTS_CONTENT());
			this.targetDate.setText(this.transaction.getTS_TARGETDATE());
			this.handler.setText(this.transaction.getHandler().getREAL_NAME());
			this.initiator.setText(this.transaction.getInitiator().getREAL_NAME());
			this.processArea.setText("");
			for (Log log : this.transaction.getLogs()) {
				this.processArea.append(log.getHandler().getREAL_NAME() + " �� " 
						+ log.getLOG_DATE() + " ������ " + log.getTS_DESC() + ": " 
						+ log.getComment().getCM_CONTENT() + "\n");
			}
		}
	}
	
	
	
}
