package org.crazyit.flashget.ui;

import java.awt.Dimension;
import java.awt.Font;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;

import javax.swing.Box;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JTextField;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;

import flashget.src.org.crazyit.flashget.ContextHolder;
import flashget.src.org.crazyit.flashget.DownloadContext;

public class NewTaskFrame extends JFrame {

	//���ص�ַ
	private JLabel addressLabel = new JLabel("���ص�ַ: ");
	private JTextField address = new JTextField(30);
	
	//��ʾ��JLabel
	private JLabel warnLabel = new JLabel(" ");
	
	//����·��
	private JLabel targetLabel = new JLabel("����Ŀ¼: ");
	private JTextField target = new JTextField(getDefaultFolder(), 22);
		
	//�߳���
	private JLabel threadCountLabel = new JLabel("�߳���: ");
	private JComboBox threadCount;
	private JButton targetSelectButton = new JButton("ѡ��Ŀ¼");
	
	//�ļ���
	private JLabel saveFileNameLabel = new JLabel("����ļ���: ");
	private JTextField saveFileName = new JTextField(5);
	
	//��ť
	private JButton confirmButton = new JButton("ȷ��");
	private JButton cancelButton = new JButton("ȡ��");
	
	private FolderChooser folderChooser;
		
	public NewTaskFrame() {
		//�����߳�����
		createThreadCountSelect();
		this.targetSelectButton.setFont(new Font(null, Font.PLAIN, 12));
		this.target.setEditable(false);
		//��Ϣ��ʾ��JLabel
		Box warnBox = Box.createHorizontalBox();
		warnBox.add(this.warnLabel);
		//���ص�ַBox
		Box addressBox = Box.createHorizontalBox();
		addressBox.add(Box.createHorizontalStrut(50));
		addressBox.add(this.addressLabel);
		addressBox.add(Box.createHorizontalStrut(20));
		addressBox.add(this.address);
		addressBox.add(Box.createHorizontalStrut(50));
		//�����ļ�����Ŀ¼
		Box targetBox = Box.createHorizontalBox();
		targetBox.add(Box.createHorizontalStrut(50));
		targetBox.add(this.targetLabel);
		targetBox.add(Box.createHorizontalStrut(20));
		targetBox.add(this.target);		
		targetBox.add(Box.createHorizontalStrut(50));
		//����ļ�����Ŀ¼ѡ��ť
		Box selectFolderBox = Box.createHorizontalBox();
		selectFolderBox.add(Box.createHorizontalStrut(50));
		selectFolderBox.add(this.saveFileNameLabel);
		selectFolderBox.add(Box.createHorizontalStrut(7));
		selectFolderBox.add(this.saveFileName);
		selectFolderBox.add(Box.createHorizontalStrut(50));
		selectFolderBox.add(this.targetSelectButton);
		selectFolderBox.add(Box.createHorizontalStrut(50));
		//�߳�ѡ��
		Box threadBox = Box.createHorizontalBox();
		threadBox.add(Box.createHorizontalStrut(50));
		threadBox.add(this.threadCountLabel);
		threadBox.add(Box.createHorizontalStrut(33));
		threadBox.add(this.threadCount);
		threadBox.add(Box.createHorizontalStrut(330));
		//��ťBox
		Box buttonBox = Box.createHorizontalBox();
		buttonBox.add(Box.createHorizontalStrut(70));
		buttonBox.add(this.confirmButton);
		buttonBox.add(Box.createHorizontalStrut(40));
		buttonBox.add(this.cancelButton);
		buttonBox.add(Box.createHorizontalStrut(50));
		//������Box
		Box mainBox = Box.createVerticalBox();
		mainBox.add(Box.createVerticalStrut(10));
		mainBox.add(warnBox);
		mainBox.add(Box.createVerticalStrut(10));
		mainBox.add(addressBox);
		mainBox.add(Box.createVerticalStrut(10));
		mainBox.add(targetBox);
		mainBox.add(Box.createVerticalStrut(10));
		mainBox.add(selectFolderBox);
		mainBox.add(Box.createVerticalStrut(10));
		mainBox.add(threadBox);
		mainBox.add(Box.createVerticalStrut(20));
		mainBox.add(buttonBox);
		mainBox.add(Box.createVerticalStrut(20));
		//�õ���Ļ��С
		Dimension screen = Toolkit.getDefaultToolkit().getScreenSize();
		this.setLocation(screen.width/4, screen.height/4);
		
		this.add(mainBox);
		this.setTitle("�½���������");
		this.pack();
		//��ʼ����ť������
		initLinsteners();
	}
	
	private void initLinsteners() {
		this.confirmButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				confirm();
			}
		});
		this.cancelButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				setVisible(false);
			}
		});
		this.targetSelectButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				openFolderChooser();
			}
		});
		this.address.getDocument().addDocumentListener(new DocumentListener() {
			public void changedUpdate(DocumentEvent e) {
				setSaveFileName();
			}
			public void insertUpdate(DocumentEvent e) {
				setSaveFileName();
			}
			public void removeUpdate(DocumentEvent e) {
				setSaveFileName();
			}
		});
	}
	
	private void confirm() {
		if (getSaveFileName() == null) {
			this.warnLabel.setText("��������ȷ���ļ���");
			return;
		}
		this.warnLabel.setText(" ");
		Resource r = createResource();
		ContextHolder.ctx.resources.add(r);
		ContextHolder.dh.doDownload(r);
		this.setVisible(false);
	}
	
	//���ݽ������봴��Resource����
	private Resource createResource() {
		String url = this.address.getText();
		String filePath = this.target.getText();
		String fileName = getSaveFileName();
		int threadCount = (Integer)this.threadCount.getSelectedItem();
		return new Resource(url, filePath, fileName, threadCount);
	}
	
	/**
	 * ���������ļ�����Ϊ��, ���url�н�ȡ�ļ�����
	 * @return
	 */
	private String getSaveFileName() {
		String url = this.address.getText();
		String saveFileName = this.saveFileName.getText();
		if (saveFileName == null || saveFileName.equals("")) {
			saveFileName = FileUtil.getFileName(url);
		}
		return saveFileName;
	}
	
	/**
	 * �������Ϊ���Ƶ�ֵ
	 */
	private void setSaveFileName() {
		saveFileName.setText("");
		saveFileName.setText(FileUtil.getFileName(address.getText()));
	}
	
	/**
	 * �����߳�����
	 */
	private void createThreadCountSelect() {
		this.threadCount = new JComboBox();
		for (int i = 1; i <= DownloadContext.MAX_THREAD_COUNT; i++) {
			this.threadCount.addItem(i);
		}
	}
	
	/**
	 * ���ļ�ѡ����
	 */
	private void openFolderChooser() {
		if (this.folderChooser == null) {
			this.folderChooser = new FolderChooser();
		}
		folderChooser.showOpenDialog(null);
	}
	
	public String getDefaultFolder() {
		return System.getProperty("user.home");
	}
	
	/**
	 * ѡ��Ŀ¼��ִ�еķ���
	 * @param filePath
	 */
	public void selectFolder(String filePath) {
		this.target.setText(filePath);
	}

	class FolderChooser extends JFileChooser {
		
		public FolderChooser() {
			super(new File(System.getProperty("user.home")));
			this.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
		}
		
		public void approveSelection() {
			super.approveSelection();
			//���õ�ǰ�򿪵�Ŀ¼ΪĬ��Ŀ¼
			this.setCurrentDirectory(this.getSelectedFile());
			selectFolder(this.getSelectedFile().getAbsolutePath());
		}
	}
	
	public static void main(String[] args) {
		NewTaskFrame nsf = new NewTaskFrame();
		nsf.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		nsf.setVisible(true);
	}
}

