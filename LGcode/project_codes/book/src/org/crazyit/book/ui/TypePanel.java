package org.crazyit.book.ui;

import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Vector;

import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JSplitPane;
import javax.swing.JTable;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import javax.swing.table.DefaultTableModel;

/**
 * ����������
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class TypePanel extends CommonPanel {

	//ҵ�����
	private TypeService service;
	
	//�еļ���
	private Vector columns;
	
	//������ܵ��ı���
	private JTextArea intro;
	
	//�������Ƶ��ı���
	private JTextField typeName;
	
	//���ص�����id
	private JTextField typeId;
	
	//����İ�ť
	private JButton saveButton;
	
	//��յİ�ť
	private JButton clearButton;
	
	//�������ֲ�ѯ�������
	private JTextField queryByNameTextField;
	
	//��ѯ��ť
	private JButton queryButton;
	
	//��ʼ����
	public void initColumns() {
		this.columns = new Vector();
		this.columns.add("id");
		this.columns.add("��������");
		this.columns.add("���");
	}
	
	/*
	 * ʵ�ָ��෽��, ��ѯ���ݿⲢ���ض�Ӧ�����ݸ�ʽ, ���ø����setDatas�����������ݼ���
	 */
	public void setViewDatas() {
		Vector<Type> types = (Vector<Type>)service.getAll();
		Vector<Vector> datas =  changeDatas(types);
		setDatas(datas);
	}
	
	public TypePanel(TypeService service) {
		this.service = service;
		//��������
		setViewDatas();
		//��ʼ����
		initColumns();
		//�����б�
		DefaultTableModel model = new DefaultTableModel(null, this.columns);
		JTable table = new CommonJTable(model);
		//���ø����JTable����
		setJTable(table);
		JScrollPane upPane = new JScrollPane(table);
		upPane.setPreferredSize(new Dimension(1000, 350));

		//�������, �޸ĵĽ���
		JPanel downPane = new JPanel();
		downPane.setLayout(new BoxLayout(downPane, BoxLayout.Y_AXIS));
		
		Box downBox1 = new Box(BoxLayout.X_AXIS);
		//���id���ı���
		typeId = new JTextField();
		typeId.setVisible(false);
		downBox1.add(typeId);
		//�б������box
		downBox1.add(new JLabel("�������ƣ�"));
		downBox1.add(Box.createHorizontalStrut(10));
		
		typeName = new JTextField(10);
		downBox1.add(typeName);
		downBox1.add(Box.createHorizontalStrut(100));

		Box downBox2 = new Box(BoxLayout.X_AXIS);
		downBox2.add(new JLabel("�����飺"));
		downBox2.add(Box.createHorizontalStrut(10));

		intro = new JTextArea("", 5, 5);
		JScrollPane introScrollPane = new JScrollPane(intro);
		intro.setLineWrap(true);
		downBox2.add(introScrollPane);
		downBox2.add(Box.createHorizontalStrut(100));
		/*******************************************************/
		Box downBox3 = new Box(BoxLayout.X_AXIS);
		
		saveButton = new JButton("����");
		downBox3.add(saveButton);
		downBox3.add(Box.createHorizontalStrut(30));
		clearButton = new JButton("���");
		downBox3.add(clearButton);
		downBox3.add(Box.createHorizontalStrut(30));

		downPane.add(getSplitBox());
		downPane.add(downBox1);
		downPane.add(getSplitBox());
		downPane.add(downBox2);
		downPane.add(getSplitBox());
		downPane.add(downBox3);
		
		//��ѯ��JPanel
		JPanel queryPanel = new JPanel();
		Box queryBox = new Box(BoxLayout.X_AXIS);
		queryBox.add(new JLabel("���ƣ�"));
		queryBox.add(Box.createHorizontalStrut(30));
		queryByNameTextField = new JTextField(20);
		queryBox.add(queryByNameTextField);
		queryBox.add(Box.createHorizontalStrut(30));
		queryButton = new JButton("��ѯ");
		queryBox.add(queryButton);
		queryPanel.add(queryBox);
		this.add(queryPanel);
		
		JSplitPane split = new JSplitPane(JSplitPane.VERTICAL_SPLIT, upPane, downPane);
		split.setDividerSize(5);
		this.add(split);
		//��Ӽ�����
		initListeners();
	}
	
	//��Ӽ�����
	private void initListeners() {
		//���ѡ�������
		getJTable().getSelectionModel().addListSelectionListener(new ListSelectionListener(){
			public void valueChanged(ListSelectionEvent event) {
				//��ѡ����ʱ����ͷ�ʱ��ִ��
				if (!event.getValueIsAdjusting()) {
					//���û��ѡ���κ�һ��, �򷵻�
					if (getJTable().getSelectedRowCount() != 1) return;
					//���ø���ķ������ѡ���е�id
					String id = getSelectId(getJTable());
					view(id);
				}
			}
		});
		//��հ�ť������
		clearButton.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent arg0) {
				clear();
			}
		});
		//���水ť������
		saveButton.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent arg0) {
				//��֤��ֵ
				if (typeName.getText().trim().equals("")) {
					showWarn("����������");
					return;
				}
				//�ж�����id�Ƿ���ֵ, ��ֵ��Ϊ�޸�, û��ֵΪ����
				if (typeId.getText().equals("")) add();
				else update();
			}
		});
		queryButton.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent arg0) {
				String name = queryByNameTextField.getText();
				query(name);
			}
		});
	}
	
	//��ѯ����
	private void query(String name) {
		//ͨ��service�������ҽ��
		Vector<Type> types = (Vector<Type>)service.query(name);
		//ת�����ݸ�ʽ
		Vector<Vector> datas =  changeDatas(types);
		//��������
		setDatas(datas);
		//ˢ���б�
		refreshTable();
	}
	
	//���
	public void clear() {
		refreshTable();
		typeId.setText("");
		typeName.setText("");
		intro.setText("");
	}
	
	//����һ������
	private void add() {
		String typeName = this.typeName.getText();
		String intro = this.intro.getText();
		Type type = new Type(null, typeName, intro);
		//����ҵ�񷽷�����һ������
		type = service.add(type);
		//���¶�ȡ����
		setViewDatas();
		//ˢ���б�
		clear();
	}
	
	//�޸�һ������
	private void update() {
		String typeId = this.typeId.getText();
		String typeName = this.typeName.getText();
		String intro = this.intro.getText();
		Type type = new Type(typeId, typeName, intro);
		service.update(type);
		//���¶�ȡ����
		setViewDatas();
		//ˢ���б�
		refreshTable();
	}

	
	//ʵ�ָ���ķ���, �����б�����
	public void setTableFace() {
		//����id��
		getJTable().getColumn("id").setMinWidth(-1);
		getJTable().getColumn("id").setMaxWidth(-1); 
		//���ü���е���С���
		getJTable().getColumn("���").setMinWidth(350);
		//���ñ����п�
		getJTable().setRowHeight(30);
	}
	
	//�鿴һ������
	public void view(String id) {
		Type data = service.get(id);
		typeId.setText(data.getID());
		typeName.setText(data.getTYPE_NAME());
		intro.setText(data.getTYPE_INTRO());
	}


	//ʵ�ָ���ķ���, �������������
	public Vector<String> getColumns() {
		return this.columns;
	}

	/**
	 * ������ת������ͼ���ĸ�ʽ
	 * @param datas
	 * @return
	 */
	private Vector<Vector> changeDatas(Vector<Type> datas) {
		Vector<Vector> view = new Vector<Vector>();
		for (Type type : datas) {
			Vector v = new Vector();
			v.add(type.getID());
			v.add(type.getTYPE_NAME());
			v.add(type.getTYPE_INTRO());
			view.add(v);
		}
		return view;
	}

}
