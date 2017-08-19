package org.crazyit.foxmail.ui;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;
import java.util.Vector;

import javax.swing.AbstractAction;
import javax.swing.Action;
import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.JOptionPane;
import javax.swing.JScrollPane;
import javax.swing.JSplitPane;
import javax.swing.JTextArea;
import javax.swing.JToolBar;
import javax.swing.JTree;
import javax.swing.ListSelectionModel;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import javax.swing.table.DefaultTableModel;
import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.TreePath;

import foxmail.src.org.crazyit.foxmail.box.DeletedBox;
import foxmail.src.org.crazyit.foxmail.box.DraftBox;
import foxmail.src.org.crazyit.foxmail.box.InBox;
import foxmail.src.org.crazyit.foxmail.box.MailBox;
import foxmail.src.org.crazyit.foxmail.box.OutBox;
import foxmail.src.org.crazyit.foxmail.box.SentBox;
import foxmail.src.org.crazyit.foxmail.mail.MailLoader;
import foxmail.src.org.crazyit.foxmail.mail.MailLoaderImpl;
import foxmail.src.org.crazyit.foxmail.mail.MailSender;
import foxmail.src.org.crazyit.foxmail.mail.MailSenderImpl;
import foxmail.src.org.crazyit.foxmail.object.Mail;
import foxmail.src.org.crazyit.foxmail.system.SystemHandler;
import foxmail.src.org.crazyit.foxmail.system.SystemLoader;
import foxmail.src.org.crazyit.foxmail.system.impl.SystemHandlerImpl;
import foxmail.src.org.crazyit.foxmail.system.impl.SystemLoaderImpl;

/**
 * ������
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class MainFrame extends JFrame {

	//��ӭ��JLabel
	private JLabel welcome = new JLabel("��ӭ����");
	//�ָ���ߵ������ұ��ʼ���Ϣ��JSplitPane
	private JSplitPane mailSplitPane;
	//�ұ��ʼ��б����ʼ���Ϣ��JSplitPane
	private JSplitPane mailListInfoPane;
	//�ʼ���ϸ��Ϣ��JSplitPane, ������ʼ���Ϣ, �ұ��Ǹ���
	private JSplitPane mailInfoPane;
	//�ʼ��б��JTable
	private MailListTable mailListTable;
	//����б�ĵ�JScrollPane
	private JScrollPane tablePane;
	//�ʼ���������JScrollPane
	private JScrollPane treePane;
	//�ʼ�������
	private JTree tree;
	//�ʼ���ʾJTextArea
	private JTextArea mailTextArea = new JTextArea(10, 80);
	//�ʼ���ʾ��JScrollPane, �����ʾ�ʼ���JTextArea
	private JScrollPane mailScrollPane;
	//�ʼ������б�
	private JScrollPane filePane;
	//�ʼ�����������ʾ
	private JList fileList;
	//������
	private JToolBar toolBar = new JToolBar();
	
	//�ռ����Mail���󼯺ϣ������������ռ����е��ʼ�
	private List<Mail> inMails;
	//��������ʼ�����
	private List<Mail> outMails;
	//�ɹ����͵��ʼ�����
	private List<Mail> sentMails;
	//�ݸ�����ʼ�����
	private List<Mail> draftMails;
	//��������ʼ�����
	private List<Mail> deleteMails;
	//��ǰ�����б�����ʾ�Ķ���
	private List<Mail> currentMails;
	
	//д�ʼ���JFrame
	private MailFrame mailFrame;
	//ϵͳ���ý������
	private SetupFrame setupFrame;
	//������ض���
	private MailLoader mailLoader = new MailLoaderImpl();
	//�����е��ʼ��������
	private SystemHandler systemHandler = new SystemHandlerImpl();
	//�����е��ʼ����ض���
	private SystemLoader systemLoader = new SystemLoaderImpl();
	//�����ʼ�����
	private MailSender mailSender = new MailSenderImpl();
	//��ǰ�򿪵��ļ�����
	private Mail currentMail;
	//�����ʼ��ļ��, ��λ����
	private long receiveInterval = 1000 * 10;
	
	//��ȡ�ʼ�
	private Action in = new AbstractAction("��ȡ�ʼ�", new ImageIcon("images/in.gif")) {
		public void actionPerformed(ActionEvent e) {
			receive();
		}
	};
	
	//�����ʼ�
	private Action sent = new AbstractAction("�����ʼ�", new ImageIcon("images/out.gif")) {
		public void actionPerformed(ActionEvent e) {
			send();
		}
	};
	
	//д�ʼ�
	private Action write = new AbstractAction("д�ʼ�", new ImageIcon("images/new.gif")) {
		public void actionPerformed(ActionEvent e) {
			write();
		}
	};
	
	//�ظ��ʼ�
	private Action reply = new AbstractAction("�ظ��ʼ�", new ImageIcon("images/reply.gif")) {
		public void actionPerformed(ActionEvent e) {
			reply();
		}
	};
	
	//�ظ��ʼ�
	private Action transmit = new AbstractAction("ת���ʼ�", new ImageIcon("images/transmit.gif")) {
		public void actionPerformed(ActionEvent e) {
			transmit();
		}
	};
	
	//ɾ���ʼ�, �Ž�������
	private Action delete = new AbstractAction("ɾ���ʼ�", new ImageIcon("images/delete.gif")) {
		public void actionPerformed(ActionEvent e) {
			delete();
		}
	};
	
	//����ɾ���ʼ�
	private Action realDelete = new AbstractAction("����ɾ���ʼ�", new ImageIcon("images/real-delete.gif")) {
		public void actionPerformed(ActionEvent e) {
			realDelete();
		}
	};
	
	//���������л�ԭ�ʼ�
	private Action revert = new AbstractAction("��ԭ�ʼ�", new ImageIcon("images/revert.gif")) {
		public void actionPerformed(ActionEvent e) {
			revert();
		}
	};
	
	//����
	private Action setup = new AbstractAction("����", new ImageIcon("images/setup.gif")) {
		public void actionPerformed(ActionEvent e) {
			setup();
		}
	};
	
	private MailContext ctx;
	
	public MainFrame(MailContext ctx) {
		this.ctx = ctx;
		this.mailFrame = new MailFrame(this);
		//��ʼ�������б���
		initMails();
		//���õ�ǰ��ʾ���ʼ�����Ϊ�ռ���ļ���
		this.currentMails = this.inMails;
		//�����ʼ�������
		this.tree = createTree();
		//�ʼ��б�JTable
		DefaultTableModel tableMode = new DefaultTableModel();
		this.mailListTable = new MailListTable(tableMode);
		tableMode.setDataVector(createViewDatas(this.currentMails), getListColumn());
		//�����ʼ��б����ʽ
		setTableFace();
		this.tablePane = new JScrollPane(this.mailListTable);
		this.tablePane.setBackground(Color.WHITE);
		//�ʼ������б�
		this.fileList = new JList();
		this.fileList.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
		this.fileList.addMouseListener(new MainListMouseListener());
		this.filePane = new JScrollPane(fileList);
		this.mailTextArea.setLineWrap(true);
		this.mailTextArea.setEditable(false);
		this.mailTextArea.setFont(new Font(null, Font.BOLD, 14));
		//��ʾ�ʼ����ݵ�JScrollPane
		this.mailScrollPane =  new JScrollPane(this.mailTextArea);
		//�ʼ�����Ϣ
		this.mailInfoPane = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT, 
				this.filePane, this.mailScrollPane);
		this.mailInfoPane.setDividerSize(3);
		this.mailInfoPane.setDividerLocation(80);
		//�ʼ��б���ʼ���Ϣ��JSplitPane
		this.mailListInfoPane = new JSplitPane(JSplitPane.VERTICAL_SPLIT, 
				this.tablePane, mailInfoPane);
		this.mailListInfoPane.setDividerLocation(300);
		this.mailListInfoPane.setDividerSize(20);
		
		//����JScrollPane
		this.treePane = new JScrollPane(this.tree);
		//�������ʼ������JSplitPane
		this.mailSplitPane = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT, 
				this.treePane, this.mailListInfoPane);
		this.mailSplitPane.setDividerLocation(150);
		this.mailSplitPane.setDividerSize(3);
		//�����û������ַ����ʾ
		this.welcome.setText(this.welcome.getText() + ctx.getUser());
		//����������
		createToolBar();
		//����JFrame�ĸ�������
		this.add(mailSplitPane);
		this.setTitle("�ʼ��շ��ͻ���");
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.setExtendedState(JFrame.MAXIMIZED_BOTH);
		initListeners();
		Timer timer = new Timer();
		timer.schedule(new ReceiveTask(this), 10000, this.receiveInterval);
	}
	
	public SystemHandler getSystemHandler() {
		return this.systemHandler;
	}
	
	public MailSender getMailSender() {
		return this.mailSender;
	}
	
	private void initListeners() {
		//�б�ѡ�������
		this.mailListTable.getSelectionModel().addListSelectionListener(new ListSelectionListener(){
			public void valueChanged(ListSelectionEvent event) {
				//��ѡ����ʱ����ͷ�ʱ��ִ��
				if (!event.getValueIsAdjusting()) {
					//���û��ѡ���κ�һ��, �򷵻�
					if (mailListTable.getSelectedRowCount() != 1) return;
					viewMail();
				}
			}
		});
	}
	
	private boolean noSelectData(Mail mail) {
		if (mail == null) {
			showMessage("��ѡ����Ҫ����������");
			return true;
		}
		return false;
	}
	
	//����һ���ʼ�
	private void send() {
		Mail mail = getSelectMail();
		if (noSelectData(mail)) return;
		if (isReceive(mail)) {
			showMessage("�ռ�����ʼ����ܷ���");
			return;
		}
		//����д�ʼ�����
		this.mailFrame.sendInit(mail);
	}
	
	//�ظ��ʼ�
	private void reply() {
		Mail mail = getSelectMail();
		if (noSelectData(mail)) return;
		//��Ҫ�жϻظ��ʼ��Ƿ����ռ�����
		if (!isReceive(mail)) {
			showMessage("ֻ�ܻظ��ռ����е��ʼ�");
			return;
		}
		this.mailFrame.replyInit(mail);
	}
	
	//�ж��ʼ��Ƿ����ռ�����
	private boolean isReceive(Mail mail) {
		for (Mail m : this.inMails) {
			if (m.getXmlName().equals(mail.getXmlName())) return true;
		}
		return false;
	}
	
	//ת��
	private void transmit() {
		Mail mail = getSelectMail();
		if (noSelectData(mail)) return;
		this.mailFrame.transmitInit(mail);
	}
	
	//��ԭ�ʼ�
	public void revert() {
		Mail mail = getSelectMail();
		if (noSelectData(mail)) return;
		//������������Mail����Ž��л�ԭ
		if (this.deleteMails.contains(mail)) {
			//�������伯����ɾ��
			this.deleteMails.remove(mail);
			//�����ļ�, ��deletedĿ¼�е�xml��
			this.systemHandler.revert(mail, this.ctx);
			//��ԭ������������
			revertMailToList(mail);
		}
		this.currentMail = null;
		refreshTable();
		cleanMailInfo();
	}
	
	//��ԭMail���󵽸�����Ӧ�ļ���
	private void revertMailToList(Mail mail) {
		if (mail.getFrom().equals(FileUtil.INBOX)) {
			this.inMails.add(mail);
		} else if (mail.getFrom().equals(FileUtil.SENT)) {
			this.sentMails.add(mail);
		} else if (mail.getFrom().equals(FileUtil.DRAFT)) {
			this.draftMails.add(mail);
		} else if (mail.getFrom().equals(FileUtil.OUTBOX)) {
			this.outMails.add(mail);
		}
	}
		
	//ɾ���ʼ�
	public void delete() {
		Mail mail = getSelectMail();
		if (noSelectData(mail)) return;
		//�ж����������Ƿ��и÷��ʼ�(�Ѿ����ŵ���������), �еĻ������д���
		if (!this.deleteMails.contains(mail)) {
			//�ӵ�ǰ�ļ�����ɾ��
			this.currentMails.remove(mail);
			//�ӵ�������ļ�����
			this.deleteMails.add(0, mail);
			//���ʼ���Ӧ��xml�ļ��ŵ�deleted��Ŀ¼��
			this.systemHandler.delete(mail, this.ctx);
		}
		this.currentMail = null;
		//ˢ���б�
		refreshTable();
		cleanMailInfo();
	}
	
	//����ɾ��һ���ʼ�
	private void realDelete() {
		Mail mail = getSelectMail();
		if (noSelectData(mail)) return;
		//�ӵ�ǰ�ļ�����ɾ�� 
		this.currentMails.remove(mail);
		//ɾ��xml�ļ��Ͷ�Ӧ�ĸ���
		this.systemHandler.realDelete(mail, this.ctx);
		this.currentMail = null;
		refreshTable();
		cleanMailInfo();
	}
	
	//����б�����ѡ�е�xmlName�е�ֵ����ֵ��Ψһ�ģ�
	private String getSelectXmlName() {
		int row = this.mailListTable.getSelectedRow();
		int column = this.mailListTable.getColumn("xmlName").getModelIndex();
		if (row == -1) return null;
		String xmlName = (String)this.mailListTable.getValueAt(row, column);
		return xmlName;
	}
	
	//�鿴һ���ʼ�
	private void viewMail() {
		this.mailTextArea.setText("");
		Mail mail = getSelectMail();
		this.mailTextArea.append("�����ˣ�  " + mail.getSender());
		this.mailTextArea.append("\n");
		this.mailTextArea.append("���ͣ�  " + mail.getCCString());
		this.mailTextArea.append("\n");
		this.mailTextArea.append("�ռ���:   " + mail.getReceiverString());
		this.mailTextArea.append("\n");
		this.mailTextArea.append("���⣺  " + mail.getSubject());
		this.mailTextArea.append("\n");
		this.mailTextArea.append("�������ڣ�  " + dateFormat.format(mail.getReceiveDate()));
		this.mailTextArea.append("\n\n");
		this.mailTextArea.append("�ʼ����ģ�  ");
		this.mailTextArea.append("\n\n");
		this.mailTextArea.append(mail.getContent());
		//��Ӹ���
		this.fileList.setListData(mail.getFiles().toArray());
		//���õ�ǰ���򿪵��ʼ�����
		this.currentMail = mail;
		//����ʼ�û�б��鿴�������޸�ͼ�꣬�������Ѿ��򿪵�״̬
		if (!mail.getHasRead()) {
			//�����ʼ��Ѿ����鿴
			mail.setHasRead(true);
			//�����ŷ�ͼ��
			openEnvelop();
		}
	}
	
	
	//��ȡ���б�����ѡ���Mail����
	private Mail getSelectMail() {
		String xmlName = getSelectXmlName();
		return getMail(xmlName, this.currentMails);
	}
	//�Ӽ������ҵ�xmlName�����һ�µ�Mail����
	private Mail getMail(String xmlName, List<Mail> mails) {
		for (Mail m : mails) {
			if (m.getXmlName().equals(xmlName))return m;
		}
		return null;
	}
	
	//��ʼ��ʱ��������box�е�����
	private void initMails() {
		this.inMails = this.systemLoader.getInBoxMails(this.ctx);
		this.draftMails = this.systemLoader.getDraftBoxMails(this.ctx);
		this.deleteMails = this.systemLoader.getDeletedBoxMails(this.ctx);
		this.outMails = this.systemLoader.getOutBoxMails(this.ctx);
		this.sentMails = this.systemLoader.getSentBoxMails(this.ctx);
	}
	
	/*
	 * ������������ȡ�ʼ�
	 */
	public void receive() {
		try {
			System.out.println("�����ʼ�");
			List<Mail> newMails = this.mailLoader.getMessages(this.ctx);
			//�õ�Mail����, ��ӵ�inMails������
			this.inMails.addAll(0, newMails);
			//���浽���ص��ռ�����
			saveToInBox(newMails);
			//ˢ���б�
			refreshTable();
		} catch (Exception e) {
			e.printStackTrace();
			showMessage(e.getMessage());
		}
	}
	
	private int showMessage(String s) {
		return JOptionPane.showConfirmDialog(this, s, "����", 
				JOptionPane.OK_CANCEL_OPTION);
	}
	
	//���浽���ص��ռ�����, ����Ŀ¼��: �û���/�ʼ��ʺ���/inbox/Mail�����uuid.xml
	private void saveToInBox(List<Mail> newMails) {
		for (Mail mail : newMails) {
			//����xml�������Щ�µ��ʼ�
			systemHandler.saveInBox(mail, this.ctx);
		}
	}
	
	//���ѷ��͵ļ��������һ���ʼ�����
	public void addSentMail(Mail mail) {
		this.sentMails.add(0, mail);
		refreshTable();
	}
	
	//�ڷ�����ļ��������һ���ʼ�����
	public void addOutMail(Mail mail) {
		this.outMails.add(0, mail);
		refreshTable();
	}
	
	//�ڲݸ���ļ��������һ���ʼ�����
	public void addDraftMail(Mail mail) {
		this.draftMails.add(0, mail);
		refreshTable();
	}
	
	//ˢ���б�ķ���, �����ǲ�ͬ������
	public void refreshTable() {
		DefaultTableModel tableModel = (DefaultTableModel)this.mailListTable.getModel();
		tableModel.setDataVector(createViewDatas(this.currentMails), getListColumn());
		setTableFace();
	}
	
	//����ȡ�ʼ���ͼƬ�ı�Ϊ���ŷ�ͼƬ
	private void openEnvelop() {
		int row = this.mailListTable.getSelectedRow();
		int column = this.mailListTable.getColumn("��").getModelIndex();
		this.mailListTable.setValueAt(this.envelopOpen, row, column);
		//���±����ʼ�״̬��xml�ļ�
		this.systemHandler.saveMail(this.currentMail, this.ctx);
	}
	
	/*
	 * ���÷����� �����ý���
	 */
	private void setup() {
		if (this.setupFrame == null) {
			this.setupFrame = new SetupFrame(this);
		}
		this.setupFrame.setVisible(true);
	}
	
	//��������������������������
	public void setMailContext(MailContext ctx) {
		this.ctx = ctx;
	}
	
	public MailContext getMailContext() {
		return this.ctx;
	}
	
	public MailLoader getMailLoader() {
		return mailLoader;
	}

	public void setMailLoader(MailLoader mailLoader) {
		this.mailLoader = mailLoader;
	}

	private void write() {
		this.mailFrame.setVisible(true);
	}
	
	//û�в鿴���ʼ���ʾ�رյ��ŷ��ͼƬ��ַ
	private static String CLOSE_ENVELOP_PATH = "images/envelop-close.gif";
	//�Ѿ��鿴���ʼ���ʾ�򿪵��ŷ��ͼƬ��ַ
	private static String OPEN_ENVELOP_PATH = "images/envelop-open.gif";
	//�ŷ�򿪵�Icon����
	private ImageIcon envelopOpen = new ImageIcon(OPEN_ENVELOP_PATH);
	//�ŷ�رյ�Icon����
	private ImageIcon envelopClose = new ImageIcon(CLOSE_ENVELOP_PATH);
	//ʱ���ʽ����
	private DateFormat dateFormat = new SimpleDateFormat("yyyy��MM��dd�� HH:mm:ss");
	
	//���ʼ����ݼ���ת������ͼ�ĸ�ʽ
	@SuppressWarnings("unchecked")
	private Vector<Vector> createViewDatas(List<Mail> mails) {
		Vector<Vector> views = new Vector<Vector>();
		for (Mail mail : mails) {
			Vector view = new Vector();
			view.add(mail.getXmlName());
			if (mail.getHasRead()) view.add(envelopOpen);
			else view.add(envelopClose);
			view.add(mail.getSender());
			view.add(mail.getSubject());
			view.add(formatDate(mail.getReceiveDate()));
			view.add(mail.getSize() + "k");
			views.add(view);
		}
		return views;
	}
	
	//��ʽʱ��
	private String formatDate(Date date) {
		return dateFormat.format(date);
	}
	
	//����ʼ��б������
	@SuppressWarnings("unchecked")
	private Vector getListColumn() {
		Vector columns = new Vector();
		columns.add("xmlName");
		columns.add("��");
		columns.add("������");
		columns.add("����");
		columns.add("����");
		columns.add("��С");
		return columns;
	}
	
	//�����ʼ��б����ʽ
	private void setTableFace() {
		//�����ʼ���Ӧ��xml�ļ�������
		this.mailListTable.getColumn("xmlName").setMinWidth(0);
		this.mailListTable.getColumn("xmlName").setMaxWidth(0);
		this.mailListTable.getColumn("��").setCellRenderer(new MailTableCellRenderer());
		this.mailListTable.getColumn("��").setMaxWidth(40);
		this.mailListTable.getColumn("������").setMinWidth(200);
		this.mailListTable.getColumn("����").setMinWidth(320);
		this.mailListTable.getColumn("����").setMinWidth(130);
		this.mailListTable.getColumn("��С").setMinWidth(80);
		this.mailListTable.setRowHeight(30);
	}
	
	//��ʼ��������
	private void createToolBar() {
		this.toolBar.add(this.in).setToolTipText("��ȡ�ʼ�");
		this.toolBar.add(this.sent).setToolTipText("�����ʼ�");
		this.toolBar.add(this.write).setToolTipText("д�ʼ�");
		this.toolBar.addSeparator(new Dimension(20, 0));
		this.toolBar.add(this.reply).setToolTipText("�ظ��ʼ�");
		this.toolBar.add(this.transmit).setToolTipText("ת���ʼ�");
		this.toolBar.add(this.delete).setToolTipText("ɾ���ʼ�");
		this.toolBar.add(this.realDelete).setToolTipText("����ɾ���ʼ�");
		this.toolBar.add(this.revert).setToolTipText("��ԭ�ʼ�");
		this.toolBar.addSeparator(new Dimension(20, 0));
		this.toolBar.add(this.setup).setToolTipText("����");
		
		this.toolBar.addSeparator(new Dimension(50, 0));
		this.toolBar.add(this.welcome);
		this.toolBar.setFloatable(false);//���ù����������ƶ�
		this.toolBar.setMargin(new Insets(5, 10, 5, 5));//���ù������ı߾�
		this.add(this.toolBar, BorderLayout.NORTH);
	}
	
	//������������
	private JTree createTree() {
		//�������ڵ�
		DefaultMutableTreeNode root = new DefaultMutableTreeNode();
		//��������ӽڵ�
		root.add(new DefaultMutableTreeNode(new InBox()));
		root.add(new DefaultMutableTreeNode(new OutBox()));
		root.add(new DefaultMutableTreeNode(new SentBox()));
		root.add(new DefaultMutableTreeNode(new DraftBox()));
		root.add(new DefaultMutableTreeNode(new DeletedBox()));
		//������
		JTree tree = new JTree(root);
		//������������
		tree.addMouseListener(new SailTreeListener(this));
		//���ظ��ڵ�
		tree.setRootVisible(false);
		//���ýڵ㴦����
		SailTreeCellRenderer cellRenderer = new SailTreeCellRenderer();
		tree.setCellRenderer(cellRenderer);
		return tree;
	}

	private Object[] emptyListData = new Object[]{};
	
	public void select() {
		MailBox box = getSelectBox();
		if (box instanceof InBox) {
			this.currentMails = this.inMails;
		} else if (box instanceof OutBox) {
			this.currentMails = this.outMails;
		} else if (box instanceof SentBox) {
			this.currentMails = this.sentMails;
		} else if (box instanceof DraftBox) {
			this.currentMails = this.draftMails;
		} else {
			this.currentMails = this.deleteMails;
		}
		//ˢ���б�
		refreshTable();
		//���õ�ǰ�򿪵��ʼ�����Ϊ�ղ�������
		cleanMailInfo();
	}
	
	//��յ�ǰ�򿪵��ʼ�����Ӧ�Ľ������
	public void cleanMailInfo() {
		//���õ�ǰ�򿪵��ʼ�����Ϊ��
		this.currentMail = null;
		this.mailTextArea.setText("");
		this.fileList.setListData(this.emptyListData);
	}
	
	//��õ�ǰѡ�е�box
	private MailBox getSelectBox() {
		TreePath treePath = this.tree.getSelectionPath();
		if (treePath == null) return null;
		//���ѡ�е�TreeNode
		DefaultMutableTreeNode node = (DefaultMutableTreeNode)treePath.getLastPathComponent();
		return (MailBox)node.getUserObject();
	}
}

/**
 * �ʼ����յ�task����
 * @author yangenxiong
 *
 */
class ReceiveTask extends TimerTask {

	private MainFrame mainFrame;
	
	public ReceiveTask(MainFrame mainFrame) {
		this.mainFrame = mainFrame;
	}
	
	public void run() {
		try {
			this.mainFrame.getMailContext().getStore();
			this.mainFrame.receive();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("�����쳣, ������");
		}
	}

	
}
