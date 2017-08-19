package org.crazyit.transaction.ui;

import java.awt.Dimension;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;

import javax.swing.AbstractAction;
import javax.swing.Action;
import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;

public class MainFrame extends JFrame {

	private JMenuBar menuBar = new JMenuBar();
	
	private JMenu tsMenu = new JMenu("����");
	
	//��ǰ�Ľ���
	private BasePanel currentPanel;
	
	//�ҵ�����
	private MyTransactionPanel myTransactionPanel;
	
	//�������
	private TransactionManagePanel transactionManagePanel;
	
	//�û�����
	private UserPanel userPanel;
		
	//�ҵ�����
	private Action myTransaction = new AbstractAction("�ҵ�����", new ImageIcon("images/menu/myTransaction.gif")) {
		public void actionPerformed(ActionEvent e) {
			changePanel(myTransactionPanel);
		}
	};
	
	//�������(����Ա�����ϼ��ȷ�������)
	private Action transactionManage = new AbstractAction("�������", new ImageIcon("images/menu/transactionManage.gif")) {
		public void actionPerformed(ActionEvent e) {
			changePanel(transactionManagePanel);
		}
	};
	
	//�û�����
	private Action userManage = new AbstractAction("�û�����", new ImageIcon("images/menu/userManage.gif")) {
		public void actionPerformed(ActionEvent e) {
			changePanel(userPanel);
		}
	};
	
	//�˳�ϵͳ
	private Action exit = new AbstractAction("�˳�ϵͳ", new ImageIcon("images/menu/exit.gif")) {
		public void actionPerformed(ActionEvent e) {
			
		}
	};
	
	public MainFrame() {
		this.myTransactionPanel = new MyTransactionPanel();
		this.transactionManagePanel = new TransactionManagePanel();
		this.userPanel = new UserPanel();
		createMenu();
		this.add(this.myTransactionPanel);
		this.currentPanel = this.myTransactionPanel;
		this.pack();
		this.setTitle("�������ϵͳ");
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.setVisible(true);
		Dimension screen = Toolkit.getDefaultToolkit().getScreenSize();
		this.setLocation((int)screen.getWidth()/10, (int)screen.getHeight()/10);
	}

	private void createMenu() {
		this.tsMenu.add(this.myTransaction);
		this.tsMenu.add(this.transactionManage);
		this.tsMenu.add(this.userManage);
		this.tsMenu.add(this.exit);
		//�ж�Ȩ��
		User loginUser = ApplicationContext.loginUser;
		System.out.println(loginUser.getRole().getROLE_NAME());
		if (loginUser.getRole().getROLE_NAME().equals("manager")) {
			this.tsMenu.remove(2);
		} else if (loginUser.getRole().getROLE_NAME().equals("employee")) {
			this.tsMenu.remove(2);
			this.tsMenu.remove(1);
		}
		this.menuBar.add(this.tsMenu);
		this.setJMenuBar(this.menuBar);
	}
	
	/**
	 * ����˵�ִ�еķ���
	 */
	private void changePanel(BasePanel panel) {
		//�Ƴ���ǰ��ʾ��JPanel
		this.remove(this.currentPanel);
		//�����Ҫ��ʾ��JPanel
		this.add(panel);
		this.currentPanel = panel;
		this.currentPanel.readData();
		this.pack();
		this.repaint();
		this.setVisible(true);
	}

}
