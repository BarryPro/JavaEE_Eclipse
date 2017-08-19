package org.crazyit.foxmail.ui;

import java.awt.BorderLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.swing.AbstractAction;
import javax.swing.Action;
import javax.swing.Box;
import javax.swing.ImageIcon;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.JOptionPane;
import javax.swing.JScrollPane;
import javax.swing.JSplitPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.JToolBar;
import javax.swing.ListModel;

import foxmail.src.org.crazyit.foxmail.mail.MailSender;
import foxmail.src.org.crazyit.foxmail.object.Mail;
import foxmail.src.org.crazyit.foxmail.system.SystemHandler;

/**
 * �ʼ���д����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class MailFrame extends JFrame {

	//������
	private JLabel receiverLabel = new JLabel("�����ˣ�");
	private JTextField receiver = new JTextField(60);
	//����
	private JLabel ccLabel = new JLabel("��  �ͣ�");
	private JTextField cc = new JTextField(60);
	//����
	private JLabel subjectLabel = new JLabel("��  �⣺");
	private JTextField subject = new JTextField(60);
	//�������JTextArea��JScrollPane
	private JScrollPane textScrollPane;
	//����
	private JTextArea textArea = new JTextArea(20, 50);
	//���·ָ���JSplitPane
	private JSplitPane mainPane;
	//���ĵ����ҷָ�JSplitPane
	private JSplitPane textSplitPane;
	//��Ÿ����б�JList�����JScrollPane
	private JScrollPane fileScrollPane;
	//�����б�
	private JList fileList;
	//�ռ���Box
	private Box receiverBox = Box.createHorizontalBox();
	//����Box
	private Box ccBox = Box.createHorizontalBox();
	//����Box
	private Box subjectBox = Box.createHorizontalBox();
	//����ռ���Box������Box������Box��Box
	private Box upBox = Box.createVerticalBox();
	//������
	private JToolBar toolBar = new JToolBar();
	
//	private MailContext ctx;
	
	private SystemHandler systemHander;
	
	private MailSender mailSender;
	
	private MainFrame mainFrame;
	
	//����
	private Action send = new AbstractAction("����", new ImageIcon("images/send.gif")) {
		public void actionPerformed(ActionEvent e) {
			send();
		}
	};
	
	//������������
	private Action saveOut = new AbstractAction("������������", new ImageIcon("images/out-save.gif")) {
		public void actionPerformed(ActionEvent e) {
			saveOut();
		}
	};
	
	//�������ݸ���
	private Action saveDraft = new AbstractAction("�������ݸ���", new ImageIcon("images/draft-save.gif")) {
		public void actionPerformed(ActionEvent e) {
			saveDraft();
		}
	};
	
	//�ϴ�����
	private Action file = new AbstractAction("�ϴ�����", new ImageIcon("images/file.gif")) {
		public void actionPerformed(ActionEvent e) {
			upload();
		}
	};
	
	//ɾ������
	private Action deleteFile = new AbstractAction("ɾ������", new ImageIcon("images/delete.gif")) {
		public void actionPerformed(ActionEvent e) {
			deleteFile();
		}
	};
	
	public MailFrame(MainFrame mainFrame) {
		this.fileList = new JList();
		this.mainFrame = mainFrame;
		this.systemHander = mainFrame.getSystemHandler();
		this.mailSender = mainFrame.getMailSender();
		//��ʼ��������
		this.toolBar.add(this.send).setToolTipText("����");
		this.toolBar.addSeparator();
		this.toolBar.add(this.saveOut).setToolTipText("������������");
		this.toolBar.addSeparator();
		this.toolBar.add(this.saveDraft).setToolTipText("�������ݸ���");
		this.toolBar.addSeparator();
		this.toolBar.add(this.file).setToolTipText("�ϴ�����");
		this.toolBar.add(this.deleteFile).setToolTipText("ɾ������");
		this.toolBar.setMargin(new Insets(5, 10, 5, 5));//���ù������ı߾�

		//��������¼�������
		this.fileList.addMouseListener(new SendListMouseListener());
		//�ռ��˵�Box
		this.receiverBox.add(Box.createHorizontalStrut(10));
		this.receiverBox.add(receiverLabel);
		this.receiverBox.add(Box.createHorizontalStrut(5));
		this.receiverBox.add(receiver);
		this.receiverBox.add(Box.createHorizontalStrut(10));
		//���͵�Box
		this.ccBox.add(Box.createHorizontalStrut(10));
		this.ccBox.add(ccLabel);
		this.ccBox.add(Box.createHorizontalStrut(12));
		this.ccBox.add(cc);
		this.ccBox.add(Box.createHorizontalStrut(10));
		//�����Box
		this.subjectBox.add(Box.createHorizontalStrut(10));
		this.subjectBox.add(subjectLabel);
		this.subjectBox.add(Box.createHorizontalStrut(12));
		this.subjectBox.add(subject);
		this.subjectBox.add(Box.createHorizontalStrut(10));
		//�������ϵ�Box
		this.upBox.add(Box.createVerticalStrut(10));
		this.upBox.add(this.receiverBox);
		this.upBox.add(Box.createVerticalStrut(5));
		this.upBox.add(this.ccBox);
		this.upBox.add(Box.createVerticalStrut(5));
		this.upBox.add(this.subjectBox);
		this.upBox.add(Box.createVerticalStrut(10));
		
		this.textArea.setLineWrap(true);
		this.textScrollPane = new JScrollPane(this.textArea);
		//������JScrollPane
		this.fileScrollPane = new JScrollPane(this.fileList);
		//�����븽����JSplitPane
		this.textSplitPane = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT, 
				this.fileScrollPane, this.textScrollPane);
		this.textSplitPane.setDividerSize(5);
		this.textSplitPane.setDividerLocation(100);
		//���ĺ�������Ϣ��JSplitPane
		this.mainPane = new JSplitPane(JSplitPane.VERTICAL_SPLIT, 
				this.upBox, this.textSplitPane);
		this.mainPane.setDividerSize(5);
		//����JFrame����Ϣ
		this.add(this.toolBar, BorderLayout.NORTH);
		this.setTitle("д�ʼ�");
		this.add(this.mainPane);
		this.pack();
		this.addWindowListener(new WindowAdapter(){
			public void windowClosing(WindowEvent e) {
				clean();
			}
		});
		this.setLocation(140, 80);
	}
	
	//���浽�ݸ���
	private void saveDraft() {
		if (!validateInput()) return;
		//�õ������е�Mail, �ö����λ���ڲݸ���
		Mail mail = getMail(FileUtil.DRAFT);
		this.systemHander.saveDraftBox(mail, this.mainFrame.getMailContext());
		//��ӵ�MainFrame�ķ����伯����
		this.mainFrame.addDraftMail(mail);
		showMessage("���浽�ݸ���ɹ�");
	}
	
	//���浽������
	private void saveOut() {
		if (!validateInput()) return;
		//�õ������е�Mail, �ö���ԭ����λ�õķ�����
		Mail mail = getMail(FileUtil.OUTBOX);
		saveOut(mail);
		showMessage("���浽������ɹ�");
	}
	
	private void saveOut(Mail mail) {
		this.systemHander.saveOutBox(mail, this.mainFrame.getMailContext());
		//��ӵ�MainFrame�ķ����伯����
		this.mainFrame.addOutMail(mail);
	}
	
	//ɾ������
	private void deleteFile() {
		FileObject file = (FileObject)this.fileList.getSelectedValue();
		if (file == null) {
			showMessage("��ѡ����Ҫɾ���ĸ���");
			return;
		}
		List<FileObject> files = getFileListObjects();
		files.remove(file);
		this.fileList.setListData(files.toArray());
	}
	
	//�ظ��ʼ���ʼ���������
	public void replyInit(Mail mail) {
		this.setVisible(true);
		this.fileList.setListData(mail.getFiles().toArray());
		this.receiver.setText(mail.getSender());
		this.subject.setText("RE: " + mail.getSubject());
		this.textArea.setText(mail.getContent());
		this.cc.setText(mail.getCCString());
	}
	
	//ת���ʼ���ʼ������
	public void transmitInit(Mail mail) {
		this.setVisible(true);
		this.fileList.setListData(mail.getFiles().toArray());
		this.subject.setText(mail.getSubject());
		this.textArea.setText(mail.getContent());
		this.cc.setText(mail.getCCString());
	}
	
	//�������������ʼ�ʱ��ʼ������
	public void sendInit(Mail mail) {
		this.setVisible(true);
		this.fileList.setListData(mail.getFiles().toArray());
		this.receiver.setText(mail.getReceiverString());
		this.subject.setText(mail.getSubject());
		this.cc.setText(mail.getCCString());
		this.textArea.setText(mail.getContent());
	}
	
	public JList getFileList() {
		return this.fileList;
	}
	
	private void upload() {
		FileChooser chooser = new FileChooser(this);
		chooser.showOpenDialog(this);
	}
	
	//������������װ��һ��Mail����
	private Mail getMail(String fromBox) {
		String xmlName = UUID.randomUUID().toString() + ".xml";
		Mail mail = new Mail(xmlName, getAddressList(this.receiver), 
				this.mainFrame.getMailContext().getAccount(), 
				this.subject.getText(), new Date(), "10",
				true, this.textArea.getText(), fromBox);
		mail.setCcs(getAddressList(this.cc));
		mail.setFiles(getFileListObjects());
		return mail;
	}
	
	//���ͷ���
	private void send() {
		if (!validateInput()) return;
		//�õ�Mail����, �ö����ʾԭ����λ�����ѷ���
		Mail mail = getMail(FileUtil.SENT);
		try {
			this.mailSender.send(mail, this.mainFrame.getMailContext());
			//��Mail���󱣴浽���ͳɹ���Ŀ¼(sent)
			this.systemHander.saveSent(mail, this.mainFrame.getMailContext());
			//������ѷ��͵ļ�����
			this.mainFrame.addSentMail(mail);
			showMessage("����ʼ��ѳɹ�����");
			//��ս��������ֵ
			clean();
			this.setVisible(false);
		} catch (Exception e) {
			//����ʧ�ܱ��浽������
			saveOut(mail);
			showMessage(e.getMessage());
		}
	}

	
	//�յĸ����б�����
	private Object[] emptyListData = new Object[]{};
	//��ս������Ԫ��
	private void clean() {
		this.receiver.setText("");
		this.cc.setText("");
		this.subject.setText("");
		this.textArea.setText("");
		this.fileList.setListData(this.emptyListData);
	}
	
	//���ص�ַ
	private List<String> getAddressList(JTextField field) {
		String all = field.getText();
		List<String> result = new ArrayList<String>();
		if (all.equals("")) return result; 
		for (String re : all.split(",")) {
			result.add(re);
		}
		return result;
	}
	
	private boolean validateInput() {
		if (this.receiver.getText().equals("")) {
			showMessage("�������ռ���");
			return false;
		}
		if (this.subject.getText().equals("")) {
			showMessage("����������");
			return false;
		}
		if (this.mainFrame.getMailContext().getAccount() == null || 
				"".equals(this.mainFrame.getMailContext())) {
			showMessage("����������ʺ���Ϣ");
			return false;
		}
		return true;
	}
	
	private int showMessage(String s) {
		return JOptionPane.showConfirmDialog(this, s, "����", 
				JOptionPane.OK_CANCEL_OPTION);
	}
	
	//��JList�еõ������Ķ��󼯺�
	public List<FileObject> getFileListObjects() {
		ListModel model = this.fileList.getModel();
		List<FileObject> files = new ArrayList<FileObject>();
		for (int i = 0; i < model.getSize(); i++) {
			files.add((FileObject)model.getElementAt(i));
		}
		return files;
	}
}

class FileChooser extends JFileChooser {
	
	MailFrame mailFrame;
	
	public FileChooser(MailFrame mailFrame) {
		this.mailFrame = mailFrame;
		this.setFileSelectionMode(FILES_ONLY); 
	}

	@Override
	public void approveSelection() {
		File file = this.getSelectedFile();
		FileObject fo = new FileObject(file.getName(), file);
		List<FileObject> files = this.mailFrame.getFileListObjects();
		files.add(fo);
		mailFrame.getFileList().setListData(files.toArray());
		super.approveSelection();
	}
	
	
}
