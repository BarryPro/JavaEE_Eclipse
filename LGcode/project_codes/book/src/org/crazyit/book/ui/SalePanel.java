package org.crazyit.book.ui;

import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.text.ParseException;
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
 * ���۽���
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class SalePanel extends CommonPanel {

	BookService bookService;
	//���ۼ�¼��
	Vector columns;
	//������ۼ�¼��
	Vector bookSaleRecordColumns;
	//���ۼ�¼��ҵ��ӿ�
	SaleRecordService saleRecordService;
	//��Ľ��׼�¼�б�
	JTable bookSaleRecordTable;
	//�鱾ѡ���������
	JComboBox bookComboBox;
	//������ۼ�¼����
	Vector<BookSaleRecord> bookSaleRecordDatas;
	//���ۼ�¼��id�ı���
	JTextField saleRecordId;
	//���ۼ�¼�ܼ�
	JTextField totalPrice;
	//��������
	JTextField recordDate;
	//����������
	JTextField amount;
	//��հ�ť
	JButton clearButton;
	//��ĵ���
	JLabel singlePrice;
	//�����������
	JTextField bookAmount;
	//���Ӧ�Ŀ��
	JLabel repertorySize;
	//�����İ�ť
	JButton addBookButton;
	//ɾ����İ�ť
	JButton deleteBookButton;
	//�ɽ���ť
	JButton confirmButton;
	//��ѯ��ť
	JButton queyrButton;
	//��ѯ���������
	JTextField queryDate;
	//���ڸ�ʽ
	private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	//ʱ���ʽ
	private SimpleDateFormat timeFormat = new SimpleDateFormat("yyyy-MM-dd HH-mm-ss");
	
	private void initColumns() {
		//��ʼ�����ۼ�¼�б����
		this.columns = new Vector();
		this.columns.add("id");
		this.columns.add("�����鱾");
		this.columns.add("�ܼ�");
		this.columns.add("��������");
		this.columns.add("������");
		//��ʼ�����ۼ�¼�����б����
		this.bookSaleRecordColumns = new Vector();
		this.bookSaleRecordColumns.add("id");
		this.bookSaleRecordColumns.add("����");
		this.bookSaleRecordColumns.add("����");
		this.bookSaleRecordColumns.add("����");
		this.bookSaleRecordColumns.add("bookId");
	}
	
	public SalePanel(BookService bookService, SaleRecordService saleRecordService) {
		this.bookService = bookService;
		this.saleRecordService = saleRecordService;
		//�����б�����
		setViewDatas();
		//��ʼ����
		initColumns();
		//�����б�
		DefaultTableModel model = new DefaultTableModel(datas, columns);
		JTable table = new CommonJTable(model);
		setJTable(table);
		JScrollPane upPane = new JScrollPane(table);
		upPane.setPreferredSize(new Dimension(1000, 350));
		//�������, �޸ĵĽ���
		JPanel downPane = new JPanel();
		downPane.setLayout(new BoxLayout(downPane, BoxLayout.Y_AXIS));
		/*******************************************************/
		Box downBox1 = new Box(BoxLayout.X_AXIS);
		this.saleRecordId = new JTextField(10);
		downBox1.add(this.saleRecordId);
		this.saleRecordId.setVisible(false);
		//�б������box
		downBox1.add(new JLabel("�ܼۣ�"));
		this.totalPrice = new JTextField(10);
		this.totalPrice.setEditable(false);
		downBox1.add(this.totalPrice);
		downBox1.add(new JLabel("      "));
		downBox1.add(new JLabel("�������ڣ�"));
		this.recordDate = new JTextField(10);
		this.recordDate.setEditable(false);
		//���õ�ǰ����ʱ��
		setRecordDate();
		downBox1.add(this.recordDate);
		downBox1.add(new JLabel("      "));
		downBox1.add(new JLabel("��������"));
		this.amount = new JTextField(10);
		this.amount.setEditable(false);
		downBox1.add(this.amount);
		downBox1.add(new JLabel("      "));
		/*******************************************************/
		//���б�
		Box downBox2 = new Box(BoxLayout.X_AXIS);
		this.bookSaleRecordDatas = new Vector();
		DefaultTableModel bookModel = new DefaultTableModel(this.bookSaleRecordDatas, 
				this.bookSaleRecordColumns);
		this.bookSaleRecordTable = new CommonJTable(bookModel);
		//�����鱾���׼�¼�б����ʽ
		setBookSaleRecordTableFace();
		JScrollPane bookScrollPane = new JScrollPane(this.bookSaleRecordTable);
		bookScrollPane.setPreferredSize(new Dimension(1000, 120));
		downBox2.add(bookScrollPane);
		/*******************************************************/
		Box downBox3 = new Box(BoxLayout.X_AXIS);
		downBox3.add(Box.createHorizontalStrut(100));
		downBox3.add(new JLabel("�鱾��"));
		downBox3.add(Box.createHorizontalStrut(20));
		//�������������������
		this.bookComboBox = new JComboBox();
		//Ϊ�������������
		buildBooksComboBox();
		downBox3.add(this.bookComboBox);
		downBox3.add(Box.createHorizontalStrut(50));
		downBox3.add(new JLabel("������"));
		downBox3.add(Box.createHorizontalStrut(20));
		this.bookAmount = new JTextField(10);
		downBox3.add(this.bookAmount);
		downBox3.add(Box.createHorizontalStrut(50));
		downBox3.add(new JLabel("���ۣ�"));
		downBox3.add(Box.createHorizontalStrut(20));
		this.singlePrice = new JLabel();
		downBox3.add(this.singlePrice);
		downBox3.add(Box.createHorizontalStrut(100));
		downBox3.add(new JLabel("��棺"));
		downBox3.add(Box.createHorizontalStrut(20));
		this.repertorySize = new JLabel();
		downBox3.add(this.repertorySize);
		downBox3.add(Box.createHorizontalStrut(80));
		this.addBookButton = new JButton("���");
		downBox3.add(this.addBookButton);
		downBox3.add(Box.createHorizontalStrut(30));
		this.deleteBookButton = new JButton("ɾ��");
		downBox3.add(this.deleteBookButton);
		/*******************************************************/
		Box downBox4 = new Box(BoxLayout.X_AXIS);
		this.confirmButton = new JButton("�ɽ�");
		downBox4.add(this.confirmButton);
		downBox4.add(Box.createHorizontalStrut(120));
		clearButton = new JButton("���");
		downBox4.add(clearButton);
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
		this.queryDate = new JTextField(20);
		queryBox.add(this.queryDate);
		queryBox.add(Box.createHorizontalStrut(30));
		this.queyrButton = new JButton("��ѯ");
		queryBox.add(this.queyrButton);
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
		//��հ�ť������
		this.clearButton.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent arg0) {
				clear();
			}
		});
		//�鱾ѡ������������
		this.bookComboBox.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e) {
				changeBook();
			}
		});
		//������ʾ��ĵ���
		changeBook();
		//���б����һ��������ۼ�¼�İ�ť
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
		//�ɽ���ť
		this.confirmButton.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e) {
				sale();
			}
		});
		//��ѯ
		this.queyrButton.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e) {
				query();
			}
		});
	}
	
	private void query() {
		String date = this.queryDate.getText();
		Date d = null;
		try {
			d = dateFormat.parse(date);
		} catch (ParseException e) {
			showWarn("������yyyy-MM-dd�ĸ�ʽ����");
			return;
		}
		//����ִ�в�ѯ
		Vector<SaleRecord> records = (Vector<SaleRecord>)saleRecordService.getAll(d);
		Vector<Vector> datas = changeDatas(records);
		setDatas(datas);
		//ˢ���б�
		refreshTable();
	}
	
	//�ɽ��ķ���
	private void sale() {
		if (!this.saleRecordId.getText().equals("")) {
			showWarn("������ٽ��в���"); 
			return;
		}
		//���û�гɽ��κ���, ����
		if (this.bookSaleRecordDatas.size() == 0) {
			showWarn("û�г����κε���, ���óɽ�");
			return;
		}
		SaleRecord r = new SaleRecord();
		r.setRECORD_DATE(this.recordDate.getText());
		r.setBookSaleRecords(this.bookSaleRecordDatas);
		try {
			saleRecordService.saveRecord(r);
		} catch (BusinessException e) {//�˴����쳣��ҵ���쳣
			showWarn(e.getMessage());
			return;
		}
		//���¶�ȡ����
		setViewDatas();
		//��ս���
		clear();
	}
	
	//���б����һ��������ۼ�¼
	private void appendBook() {
		if (!this.saleRecordId.getText().equals("")) {
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
		//ˢ���б�
		refreshBookSaleRecordTableData();
		//�����ܼ�
		countTotalPrice();
		//����������
		setTotalAmount();
	}
	
	//��ӻ����޸��鱾���׼�¼�еĶ���
	private void appendOrUpdate(Book book, String amount) {
		BookSaleRecord r = getBookSaleRecordFromView(book);
		//���Ϊ��, ��Ϊ����ӵ���, �ǿ�, ������Ѿ����б���
		if (r == null) {
			//����BookSaleRecord������ӵ����ݼ�����
			BookSaleRecord record = new BookSaleRecord();
			record.setBook(book);
			record.setTRADE_SUM(amount);
			this.bookSaleRecordDatas.add(record);
		} else {
			int newAmount = Integer.valueOf(amount) + Integer.valueOf(r.getTRADE_SUM());
			r.setTRADE_SUM(String.valueOf(newAmount));
		}
	}
	
	//��ȡ���б����Ƿ��Ѿ�������ͬ����
	private BookSaleRecord getBookSaleRecordFromView(Book book) {
		for (BookSaleRecord r : this.bookSaleRecordDatas) {
			if (r.getBook().getID().equals(book.getID())) {
				return r;
			}
		}
		return null;
	}
	
	//����������
	private void setTotalAmount() {
		int amount = 0;
		for (BookSaleRecord r : this.bookSaleRecordDatas) {
			amount += Integer.valueOf(r.getTRADE_SUM());
		}
		this.amount.setText(String.valueOf(amount));
	}
	
	//�����ܼ�
	private void countTotalPrice() {
		double totalPrice = 0;
		for (BookSaleRecord r : this.bookSaleRecordDatas) {
			totalPrice += (Integer.valueOf(r.getTRADE_SUM()) * 
					Double.valueOf(r.getBook().getBOOK_PRICE()));
		}
		this.totalPrice.setText(String.valueOf(totalPrice));
	}
	
	//���б����Ƴ�һ��������ۼ�¼
	private void removeBook() {
		if (!this.saleRecordId.getText().equals("")) {
			showWarn("������ٽ��в���"); 
			return;
		}
		if (bookSaleRecordTable.getSelectedRow() == -1) {
			showWarn("��ѡ����Ҫɾ������");
			return;
		}
		//�ڼ�����ɾ����Ӧ������������
		this.bookSaleRecordDatas.remove(bookSaleRecordTable.getSelectedRow());
		//ˢ���б�
		refreshBookSaleRecordTableData();
		//���¼����ܼۺ�������
		setTotalAmount();
		countTotalPrice();
	}
	
	
	//���鱾ѡ�����������ı�ʱ, ִ�и÷���
	private void changeBook() {
		//���ѡ���Book����
		Book book = (Book)bookComboBox.getSelectedItem();
		if (book == null) return;
		//������ʾ����ļ۸�
		this.singlePrice.setText(book.getBOOK_PRICE());
		this.repertorySize.setText(book.getREPERTORY_SIZE());
	}
	
	//���
	public void clear() {
		//ˢ�����б�
		refreshTable();
		this.saleRecordId.setText("");
		this.totalPrice.setText("");
		//���ý���Ľ���ʱ��Ϊ��ǰʱ��
		setRecordDate();
		this.amount.setText("");
		this.bookSaleRecordDatas.removeAll(this.bookSaleRecordDatas);
		refreshBookSaleRecordTableData();
		//ˢ������
		this.bookComboBox.removeAllItems();
		buildBooksComboBox();
	}
	
	//������ͼ����
	public void setViewDatas() {
		Vector<SaleRecord> records = (Vector<SaleRecord>)saleRecordService.getAll(new Date());
		Vector<Vector> datas = changeDatas(records);
		setDatas(datas);
	}
	
	//������ת�������б�����ݸ�ʽ
	private Vector<Vector> changeDatas(Vector<SaleRecord> records) {
		Vector<Vector> view = new Vector<Vector>();
		for (SaleRecord record : records) {
			Vector v = new Vector();
			v.add(record.getID());
			v.add(record.getBookNames());
			v.add(record.getTotalPrice());
			v.add(record.getRECORD_DATE());
			v.add(record.getAmount());
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
	
	//�鿴һ�����ۼ�¼
	private void view() {
		String saleRecordId = getSelectId(getJTable());
		//�õ���Ľ��׼�¼
		SaleRecord record = saleRecordService.get(saleRecordId);
		//���õ�ǰ�鱾��������
		this.bookSaleRecordDatas = record.getBookSaleRecords();
		//ˢ���鱾�����б�
		refreshBookSaleRecordTableData();
		this.saleRecordId.setText(record.getID());
		this.totalPrice.setText(String.valueOf(record.getTotalPrice()));
		this.recordDate.setText(record.getRECORD_DATE());
		this.amount.setText(String.valueOf(record.getAmount()));
	}
	
	//��������ۼ�¼ת�����б��ʽ
	private Vector<Vector> changeBookSaleRecordDate(Vector<BookSaleRecord> records) {
		Vector<Vector> view = new Vector<Vector>();
		for (BookSaleRecord r : records) {
			Vector v = new Vector();
			v.add(r.getID());
			v.add(r.getBook().getBOOK_NAME());
			v.add(r.getBook().getBOOK_PRICE());
			v.add(r.getTRADE_SUM());
			v.add(r.getBook().getID());
			view.add(v);
		}
		return view;
	}
	
	//ˢ���鱾���ۼ�¼���б�
	private void refreshBookSaleRecordTableData() {
		Vector<Vector> view = changeBookSaleRecordDate(this.bookSaleRecordDatas);
		DefaultTableModel tableModel = (DefaultTableModel)this.bookSaleRecordTable.getModel();
		//������������Model��
		tableModel.setDataVector(view, this.bookSaleRecordColumns);
		//���ñ����ʽ
		setBookSaleRecordTableFace();
	}
	
	//�����鱾���ۼ�¼����ʽ
	private void setBookSaleRecordTableFace() {
		this.bookSaleRecordTable.setRowHeight(30);
		//�������ۼ�¼id��
		this.bookSaleRecordTable.getColumn("id").setMinWidth(-1);
		this.bookSaleRecordTable.getColumn("id").setMaxWidth(-1);
		//���ض�Ӧ����id��
		this.bookSaleRecordTable.getColumn("bookId").setMinWidth(-1);
		this.bookSaleRecordTable.getColumn("bookId").setMaxWidth(-1);
	}
	
	@Override
	public Vector<String> getColumns() {
		return this.columns;
	}

	@Override
	public void setTableFace() {
		getJTable().getColumn("id").setMinWidth(-1);
		getJTable().getColumn("id").setMaxWidth(-1);
		getJTable().getColumn("�����鱾").setMinWidth(350);
		getJTable().setRowHeight(30);
	}

	//���ý�����ʾ�Ľ���ʱ��
	private void setRecordDate() {
		//���óɽ�����Ϊ��ǰʱ��
		Date now = new Date();
		timeFormat.format(now);
		this.recordDate.setText(timeFormat.format(now));
	}
}
