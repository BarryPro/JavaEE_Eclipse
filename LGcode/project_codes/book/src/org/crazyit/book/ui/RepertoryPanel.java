package org.crazyit.book.ui;

import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.Vector;

import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JSplitPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import javax.swing.table.DefaultTableModel;

/**
 * ������
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class RepertoryPanel extends CommonPanel {

	private InRecordService inRecordService;
	//����¼�б���м���
	Vector columns;
	//�������¼���м���
	Vector bookInColumns;
	//�������б�JTable
	JTable bookInTable;
	//�������¼�б�����
	Vector<BookInRecord> bookInRecords;
	
	BookService bookService;
	//ѡ���鱾��������
	JComboBox bookComboBox;
	JTextField amount;
	JTextField inDate;
	//�������ĳ������¼��������
	JTextField inRecordId;
	//��հ�ť
	JButton clearButton;
	//�����İ�ť
	JButton addBookButton;
	//ɾ����İ�ť
	JButton deleteBookButton;
	//���������б������ʱ�����������
	JTextField bookAmount;
	//�鱾ԭ�е�����
	JLabel repertorySize;
	//ʱ���ʽ
	private SimpleDateFormat timeFormat = new SimpleDateFormat("yyyy-MM-dd HH-mm-ss");
	JButton inButton;
	
	private void initColumns() {
		this.columns = new Vector();
		this.columns.add("id");
		this.columns.add("����鱾");
		this.columns.add("�������");
		this.columns.add("�������");
		this.bookInColumns = new Vector();
		this.bookInColumns.add("id");
		this.bookInColumns.add("����");
		this.bookInColumns.add("����");
		this.bookInColumns.add("����");
		this.bookInColumns.add("bookId");
	}
	
	public RepertoryPanel(InRecordService inRecordService, BookService bookService) {
		this.inRecordService = inRecordService;
		this.bookService = bookService;
		initColumns();
		setViewDatas();
		//�����б�
		DefaultTableModel model = new DefaultTableModel(getDatas(), this.columns);
		JTable table = new CommonJTable(model);
		setJTable(table);
		
		JScrollPane upPane = new JScrollPane(table);
		upPane.setPreferredSize(new Dimension(1000, 350));
		

		//�������, �޸ĵĽ���
		JPanel downPane = new JPanel();
		downPane.setLayout(new BoxLayout(downPane, BoxLayout.Y_AXIS));
		
	
		/*******************************************************/
		//
		Box downBox1 = new Box(BoxLayout.X_AXIS);
		//��������¼��������
		this.inRecordId = new JTextField();
		downBox1.add(this.inRecordId);
		inRecordId.setVisible(false);
				
		downBox1.add(new JLabel("������ڣ�"));
		this.inDate = new JTextField(10);
		this.inDate.setEditable(false);
		setInDate();
		downBox1.add(this.inDate);
		downBox1.add(new JLabel("      "));
		
		downBox1.add(new JLabel("��������"));
		this.amount = new JTextField(10);
		this.amount.setEditable(false);
		downBox1.add(this.amount);
		downBox1.add(new JLabel("      "));

		/*******************************************************/
		//���б�
		Box downBox2 = new Box(BoxLayout.X_AXIS);
		
		this.bookInRecords = new Vector<BookInRecord>();
		DefaultTableModel bookModel = new DefaultTableModel(this.bookInRecords, 
				this.bookInColumns);
		this.bookInTable = new CommonJTable(bookModel);
		setBookInRecordFace();
		
		JScrollPane bookScrollPane = new JScrollPane(this.bookInTable);
		bookScrollPane.setPreferredSize(new Dimension(1000, 120));
		downBox2.add(bookScrollPane);

		/*******************************************************/
		Box downBox3 = new Box(BoxLayout.X_AXIS);
		downBox3.add(Box.createHorizontalStrut(300));
		
		downBox3.add(new JLabel("�鱾��"));
		downBox3.add(Box.createHorizontalStrut(20));
		this.bookComboBox = new JComboBox();
		buildBooksComboBox();
		downBox3.add(bookComboBox);
		
		downBox3.add(Box.createHorizontalStrut(50));
		
		downBox3.add(new JLabel("������"));
		downBox3.add(Box.createHorizontalStrut(20));
		this.bookAmount = new JTextField(10);
		downBox3.add(this.bookAmount);
		downBox3.add(Box.createHorizontalStrut(50));
		
		downBox3.add(new JLabel("���У�"));
		downBox3.add(Box.createHorizontalStrut(20));
		this.repertorySize = new JLabel();
		downBox3.add(this.repertorySize);
		downBox3.add(Box.createHorizontalStrut(50));
		
		this.addBookButton = new JButton("���");
		downBox3.add(this.addBookButton);

		downBox3.add(Box.createHorizontalStrut(30));
		
		this.deleteBookButton = new JButton("ɾ��");
		downBox3.add(this.deleteBookButton);
		
		/*******************************************************/
		Box downBox4 = new Box(BoxLayout.X_AXIS);
		
		this.inButton = new JButton("���");
		downBox4.add(this.inButton);
		
		downBox4.add(Box.createHorizontalStrut(130));
		
		this.clearButton = new JButton("���");
		downBox4.add(this.clearButton);
		
		/*******************************************************/
		downPane.add(getSplitBox());
		downPane.add(downBox1);
		downPane.add(getSplitBox());
		downPane.add(downBox2);
		downPane.add(getSplitBox());
		downPane.add(downBox3);
		downPane.add(getSplitBox());
		downPane.add(downBox4);
		
		/*******************��ѯ******************/
		JPanel queryPanel = new JPanel();
		Box queryBox = new Box(BoxLayout.X_AXIS);
		queryBox.add(new JLabel("���ڣ�"));
		queryBox.add(Box.createHorizontalStrut(30));
		queryBox.add(new JTextField(20));
		queryBox.add(Box.createHorizontalStrut(30));
		queryBox.add(new JButton("��ѯ"));
		queryPanel.add(queryBox);
		this.add(queryPanel);
		
		//�б�Ϊ��ӽ���
		JSplitPane split = new JSplitPane(JSplitPane.VERTICAL_SPLIT, upPane, downPane);
		split.setDividerSize(5);
		this.add(split);
		//��ʼ��������
		initListeners();
	}
	
	//��ʼ��������
	private void initListeners() {
		//���ѡ�������
		getJTable().getSelectionModel().addListSelectionListener(new ListSelectionListener(){
			public void valueChanged(ListSelectionEvent event) {
				//��ѡ����ʱ����ͷ�ʱ��ִ��
				if (!event.getValueIsAdjusting()) {
					//���û��ѡ���κ�һ��, �򷵻�
					if (getJTable().getSelectedRowCount() != 1) return;
					view();
				}
			}
		});
		//�鱾ѡ������������
		this.bookComboBox.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e) {
				changeBook();
			}
		});
		//������ʾ�����������
		changeBook();
		//��հ�ť
		this.clearButton.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent arg0) {
				clear();
			}
		});
		//���б����һ���������¼�İ�ť
		this.addBookButton.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e) {
				appendBook();
			}
		});
		//ɾ����Ľ��׼�¼��ť
		this.deleteBookButton.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e) {
				removeBook();
			}
		});
		//��ⰴť
		this.inButton.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e) {
				in();
			}
		});
	}
	
	//���ķ���
	private void in() {
		if (!this.inRecordId.getText().equals("")) {
			showWarn("������ٽ��в���"); 
			return;
		}
		//���û�гɽ��κ���, ����
		if (this.bookInRecords.size() == 0) {
			showWarn("û���κ������");
			return;
		}
		InRecord r = new InRecord();
		r.setRECORD_DATE(this.inDate.getText());
		r.setBookInRecords(this.bookInRecords);
		inRecordService.save(r);
		//���¶�ȡ����
		setViewDatas();
		//��ս���
		clear();
	}
	
	//���б����Ƴ�һ���������¼
	private void removeBook() {
		if (!this.inRecordId.getText().equals("")) {
			showWarn("������ٽ��в���"); 
			return;
		}
		if (this.bookInTable.getSelectedRow() == -1) {
			showWarn("��ѡ����Ҫɾ������");
			return;
		}
		//�ڼ�����ɾ����Ӧ������������
		this.bookInRecords.remove(this.bookInTable.getSelectedRow());
		//ˢ���б�
		refreshBookInRecordTableData();
		//���¼���������
		countAmount();
	}
	
	//���������¼�б������һ����
	private void appendBook() {
		if (!this.inRecordId.getText().equals("")) {
			showWarn("������ٽ��в���"); 
			return;
		}
		if (this.bookAmount.getText().equals("")) {
			showWarn("�������������"); 
			return;
		}
		//���ѡ�еĶ���
		Book book = (Book)bookComboBox.getSelectedItem();
		String amount = this.bookAmount.getText();
		appendOrUpdate(book, amount);
		refreshBookInRecordTableData();
		//��������
		countAmount();
	}
	
	//���鱾ѡ�����������ı�ʱ, ִ�и÷���
	private void changeBook() {
		//���ѡ���Book����
		Book book = (Book)bookComboBox.getSelectedItem();
		if (book == null) return;
		this.repertorySize.setText(book.getREPERTORY_SIZE());
	}
	
	//����һ������������
	private void countAmount() {
		int amount = 0;
		for (BookInRecord r : this.bookInRecords) {
			amount += Integer.valueOf(r.getIN_SUM());
		}
		this.amount.setText(String.valueOf(amount));
	}
	
	//��ӻ����޸��鱾���׼�¼�еĶ���
	private void appendOrUpdate(Book book, String amount) {
		BookInRecord r = getBookInRecordFromView(book);
		//���Ϊ��, ��Ϊ����ӵ���, �ǿ�, ������Ѿ����б���
		if (r == null) {
			//����BookSaleRecord������ӵ����ݼ�����
			BookInRecord record = new BookInRecord();
			record.setBook(book);
			record.setIN_SUM(amount);
			this.bookInRecords.add(record);
		} else {
			int newAmount = Integer.valueOf(amount) + Integer.valueOf(r.getIN_SUM());
			r.setIN_SUM(String.valueOf(newAmount));
		}
	}
	
	//��ȡ���б����Ƿ��Ѿ�������ͬ����
	private BookInRecord getBookInRecordFromView(Book book) {
		for (BookInRecord r : this.bookInRecords) {
			if (r.getBook().getID().equals(book.getID())) {
				return r;
			}
		}
		return null;
	}
	
	//ˢ�±�����
	public void clear() {
		//ˢ�����б�
		refreshTable();
		this.inRecordId.setText("");
		this.amount.setText("");
		this.inDate.setText("");
		//����������¼������
		this.bookInRecords.removeAll(this.bookInRecords);
		refreshBookInRecordTableData();
		//ˢ������
		this.bookComboBox.removeAllItems();
		buildBooksComboBox();
		setInDate();
	}
	
	//�����������¼���б�
	private void setBookInRecordFace() {
		this.bookInTable.setRowHeight(30);
		//����������¼��id��
		this.bookInTable.getColumn("id").setMinWidth(-1);
		this.bookInTable.getColumn("id").setMaxWidth(-1);
		//����������¼��Ӧ����id��
		this.bookInTable.getColumn("bookId").setMinWidth(-1);
		this.bookInTable.getColumn("bookId").setMaxWidth(-1);
	}
	
	//�鿴һ������¼
	private void view() {
		//�������¼��id
		String id = getSelectId(getJTable());
		//�����ݿ��в���
		InRecord r = inRecordService.get(id);
		//�����б����ݶ�Ӧ�ļ���
		this.bookInRecords = r.getBookInRecords();
		//ˢ���������¼�б�
		refreshBookInRecordTableData();
		//���õ�ǰ�鿴��¼��������id
		this.inRecordId.setText(r.getID());
		//���ý������������������
		this.amount.setText(String.valueOf(r.getAmount()));
		this.inDate.setText(r.getRECORD_DATE());
	}

	@Override
	public Vector<String> getColumns() {
		return this.columns;
	}


	@Override
	public void setTableFace() {
		getJTable().getColumn("����鱾").setMinWidth(350);
		getJTable().setRowHeight(30);
		getJTable().getColumn("id").setMinWidth(-1);
		getJTable().getColumn("id").setMaxWidth(-1);
	}

	//���¶�ȡ����
	public void setViewDatas() {
		Vector<InRecord> records = (Vector<InRecord>)inRecordService.getAll(new Date());
		Vector<Vector> datas = changeDatas(records);
		setDatas(datas);
	}
	
	//������ת�������б�����ݸ�ʽ
	private Vector<Vector> changeDatas(Vector<InRecord> records) {
		Vector<Vector> view = new Vector<Vector>();
		for (InRecord r : records) {
			Vector v = new Vector();
			v.add(r.getID());
			v.add(r.getBookNames());
			v.add(r.getRECORD_DATE());
			v.add(r.getAmount());
			view.add(v);
		}
		return view;
	}
	
	//ˢ���鱾����¼���б�
	private void refreshBookInRecordTableData() {
		Vector<Vector> view = changeBookInRecordDate(this.bookInRecords);
		DefaultTableModel tableModel = (DefaultTableModel)this.bookInTable.getModel();
		//������������Model��
		tableModel.setDataVector(view, this.bookInColumns);
		//���ñ����ʽ
		setBookInRecordFace();
	}
	
	//���������¼ת�����б��ʽ
	private Vector<Vector> changeBookInRecordDate(Vector<BookInRecord> records) {
		Vector<Vector> view = new Vector<Vector>();
		for (BookInRecord r : records) {
			Vector v = new Vector();
			v.add(r.getID());
			v.add(r.getBook().getBOOK_NAME());
			v.add(r.getBook().getBOOK_PRICE());
			v.add(r.getIN_SUM());
			v.add(r.getBook().getID());
			view.add(v);
		}
		return view;
	}
	
	//����������ѡ�����������
	private void buildBooksComboBox() {
		Collection<Book> books = bookService.getAll();
		for (Book book : books) {
			this.bookComboBox.addItem(makeBook(book));
		}
	}

	//����Book����, ������ӵ���������, ��д��equals��toString����
	private Book makeBook(final Book source) {
		Book book = new Book(){
			public boolean equals(Object obj) {
				if (obj instanceof Book) {
					Book b = (Book)obj;
					if (getID().equals(b.getID())) return true; 
				}
				return false;
			}
			public String toString() {
				return getBOOK_NAME();
			}
		};
		book.setBOOK_NAME(source.getBOOK_NAME());
		book.setBOOK_PRICE(source.getBOOK_PRICE());
		book.setREPERTORY_SIZE(source.getREPERTORY_SIZE());
		book.setID(source.getID());
		return book;
	}
	
	//���ý�����ʾ�Ľ���ʱ��
	private void setInDate() {
		//���óɽ�����Ϊ��ǰʱ��
		Date now = new Date();
		timeFormat.format(now);
		this.inDate.setText(timeFormat.format(now));
	}

}
