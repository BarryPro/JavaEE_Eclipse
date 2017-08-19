package org.crazyit.book.service.impl;

import java.util.Collection;
import java.util.Date;
import java.util.Vector;

/**
 * ���ۼ�¼ҵ��ʵ����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class SaleRecordServiceImpl implements SaleRecordService {
	
	private SaleRecordDao saleRecordDao;
	
	private BookSaleRecordDao bookSaleRecordDao;
	
	private BookDao bookDao;
	
	public SaleRecordServiceImpl(SaleRecordDao saleRecordDao, 
			BookSaleRecordDao bookSaleRecordDao, BookDao bookDao) {
		this.saleRecordDao = saleRecordDao;
		this.bookSaleRecordDao = bookSaleRecordDao;
		this.bookDao = bookDao;
	}
	
	@Override
	public SaleRecord get(String id) {
		SaleRecord r = saleRecordDao.findById(id);
		return processDatas(r);
	}

	@Override
	//ʵ�ֽӿڷ���
	public Collection<SaleRecord> getAll(Date date) {
		//�õ���һ��
		Date nextDate = DateUtil.getNextDate(date);
		//�õ����������, ��ʽΪyyyy-MM-dd
		String today = DateUtil.getDateString(date);
		//�õ����������, ��ʽΪyyyy-MM-dd
		String tomorrow = DateUtil.getDateString(nextDate);
		Collection<SaleRecord> records = saleRecordDao.findByDate(today, tomorrow);
		for (SaleRecord r : records) {
			processDatas(r);
		}
		return records;
	}
	
	//����һ��SaleRecord, ���������鱾���ۼ�¼���Ժ��鱾��������
	private SaleRecord processDatas(SaleRecord r) {
		//���Ҹü�¼����Ӧ��������ۼ�¼
		Collection<BookSaleRecord> brs = bookSaleRecordDao.findBySaleRecord(r.getID());
		//���ý�����е�ÿһ��book����
		setBook(brs);
		//����SaleRecord�����е�������ۼ�¼����
		r.setBookSaleRecords((Vector<BookSaleRecord>)brs);
		//����SaleRecord����������
		r.setBookNames(getBookNames(brs));
		//�����������ܼ�
		r.setAmount(getAmount(brs));
		r.setTotalPrice(getTotalPrice(brs));
		return r;
	}
	
	//��ȡһ�ν������漰���ܼ�
	private double getTotalPrice(Collection<BookSaleRecord> brs) {
		double result = 0;
		for (BookSaleRecord br : brs) {
			//�鱾�Ľ�����
			int tradeSum = Integer.valueOf(br.getTRADE_SUM());
			//��ĵ���
			double bookPrice = Double.valueOf(br.getBook().getBOOK_PRICE());
			result += (bookPrice * tradeSum);
		}
		return result;
	}
	
	//��ȡһ�ν����������鱾�Ľ�����
	private int getAmount(Collection<BookSaleRecord> brs) {
		int result = 0;
		//������Ľ��׼�¼�������ܼ�
		for (BookSaleRecord br : brs) {
			result += Integer.valueOf(br.getTRADE_SUM());
		}
		return result;
	}
	
	//���ò����е�ÿһ��BookSaleRecord��book����
	private void setBook(Collection<BookSaleRecord> brs) {
		for (BookSaleRecord br : brs) {
			//���鱾�����ݷ��ʲ�ӿ�
			Book book = bookDao.find(br.getBOOK_ID_FK());
			br.setBook(book);
		}
	}
	
	//��ȡһ�ν����������鱾������, �Զ��Ÿ���
	private String getBookNames(Collection<BookSaleRecord> brs) {
		if (brs.size() == 0) return ""; 
		StringBuffer result = new StringBuffer();
		for (BookSaleRecord br : brs) {
			Book book = br.getBook();
			result.append(book.getBOOK_NAME() + ", ");
		}
		//ȥ�����Ķ��Ų�����
		return result.substring(0, result.lastIndexOf(","));
	}
	

	@Override
	public void saveRecord(SaleRecord record) {
		//�����ж���Ŀ���Ƿ񲻹�
		for (BookSaleRecord r : record.getBookSaleRecords()) {
			String bookId = r.getBook().getID();
			Book b = bookDao.find(bookId);
			//����ⲻ��ʱ,�׳��쳣
			if (Integer.valueOf(r.getTRADE_SUM()) > 
				Integer.valueOf(b.getREPERTORY_SIZE())) {
				throw new BusinessException(b.getBOOK_NAME() + " �Ŀ�治��");
			}
		}
		//�ȱ��潻�׼�¼
		String id = saleRecordDao.save(record);
		//�ٱ�����Ľ��׼�¼
		for (BookSaleRecord r : record.getBookSaleRecords()) {
			//�������ۼ�¼id
			r.setT_SALE_RECORD_ID_FK(id);
			bookSaleRecordDao.saveBookSaleRecord(r);
			//�޸���Ŀ��
			String bookId = r.getBook().getID();
			Book b = bookDao.find(bookId);
			//����ʣ��Ŀ��
			int leave = Integer.valueOf(b.getREPERTORY_SIZE()) - 
				Integer.valueOf(r.getTRADE_SUM());
			//���ÿ�沢����������浽���ݿ�
			b.setREPERTORY_SIZE(String.valueOf(leave));
			bookDao.updateRepertory(b);
		}
	}

}
