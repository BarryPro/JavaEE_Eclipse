package org.crazyit.transaction.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import transaction.src.org.crazyit.transaction.dao.CommentDao;
import transaction.src.org.crazyit.transaction.dao.LogDao;
import transaction.src.org.crazyit.transaction.dao.TransactionDao;
import transaction.src.org.crazyit.transaction.dao.UserTransferDao;
import transaction.src.org.crazyit.transaction.model.Transaction;
import transaction.src.org.crazyit.transaction.model.TransactionState;
import transaction.src.org.crazyit.transaction.model.UserTransfer;
import transaction.src.org.crazyit.transaction.util.ViewUtil;

public class TransactionServiceImpl implements TransactionService {

	private TransactionDao transactionDao;
	
	private UserDao userDao;
	
	private CommentDao commentDao;
	
	private UserTransferDao userTransferDao;
	
	private LogDao logDao;
	
	public TransactionServiceImpl(TransactionDao transactionDao, UserDao userDao, 
			CommentDao commentDao, UserTransferDao userTransferDao, LogDao logDao) {
		this.transactionDao = transactionDao;
		this.userDao = userDao;
		this.commentDao = commentDao;
		this.userTransferDao = userTransferDao;
		this.logDao = logDao;
	}
	
	public List<Transaction> getHandlerTransaction(User user, String state) {
		//���״̬������transfer(ת��������), �������ת��������
		if (state.equals(State.TRANSFER)) {
			List<Transaction> datas = new ArrayList<Transaction>();
			//����ת����¼
			List<UserTransfer> transfers = this.userTransferDao.find(user.getID());
			for (UserTransfer ut : transfers) {
				Transaction t = this.transactionDao.find(ut.getTS_ID());
				datas.add(t);
			}
			datas = removeRepeat(datas);
			return setUnion(datas);
		}
		//����״̬��ֱ�Ӹ���״̬ȥ���ݿ��ѯ
		List<Transaction> datas = this.transactionDao.findHandlerTransactions(state, 
				user.getID());
		return setUnion(datas);
	}
	
	/**
	 * ȥ���ظ������񣨲�ѯת������ʱʹ�ã�
	 * @param datas
	 * @return
	 */
	private List<Transaction> removeRepeat(List<Transaction> datas) {
		Map<String, Transaction> map = new HashMap<String, Transaction>();
		for (Transaction t : datas) {
			map.put(t.getID(), t);
		}
		List<Transaction> result = new ArrayList<Transaction>();
		for (String id : map.keySet()) {
			result.add(map.get(id));
		}
		return result;
	}
	
	/**
	 * ���ù�������
	 * @param datas
	 * @return
	 */
	private List<Transaction> setUnion(List<Transaction> datas) {
		for (Transaction t : datas) {
			setUser(t);
		}
		return datas;
	}
	
	/**
	 * ���ò���������û���������
	 * @param t
	 */
	private void setUser(Transaction t) {
		User handler = this.userDao.find(t.getHANDLER_ID());
		User initiator = this.userDao.find(t.getINITIATOR_ID());
		User preHandler = this.userDao.find(t.getPRE_HANDLER_ID());
		t.setHandler(handler);
		t.setInitiator(initiator);
		t.setPreHandler(preHandler);
	}
	
	/*
	 * �����������˺�״̬���Ҹ��û����е�����
	 * @see org.crazyit.transaction.service.TransactionService#getInitiatorProcessing(org.crazyit.transaction.model.User)
	 */
	public List<Transaction> getInitiatorTransaction(User user, String state) {
		List<Transaction> datas = this.transactionDao.findInitiatorTransactions(state, 
				user.getID());
		return setUnion(datas);
	}

	public void save(Transaction t) {
		this.transactionDao.save(t);
	}

	public void hurry(String id) {
		//��������״̬Ϊ�����л�����ʱ����, ����Դ߰�
		Transaction t = this.transactionDao.find(id);
		if (t.getTS_STATE().equals(TransactionState.PROCESSING)
				|| t.getTS_STATE().equals(TransactionState.FOR_A_WHILE)) {
			this.transactionDao.hurry(id);
		} else {
			throw new BusinessException("����ǽ�����, �����Դ߰�");
		}
	}

	public void invalid(String id) {
		//��������Ѿ���ɣ��򲻿�����Ϊ��Ч
		Transaction t = this.transactionDao.find(id);
		if (t.getTS_STATE().equals(TransactionState.FINISHED)) {
			throw new BusinessException("�����Ѿ���ɣ�����������Ϊ��Ч");
		} else {
			this.transactionDao.invalid(id);
		}
	}

	public void forAWhile(String id, String userId, Comment comment) {
		Transaction t = this.transactionDao.find(id);
		//ֻ���Լ�������ſ�����Ϊ��ʱ����״̬
		if (!t.getHANDLER_ID().equals(userId)) {
			throw new BusinessException("ֻ�ܴ����Լ�������");
		}
		//ֻ���ڽ����е�����ſ��Ըı��״̬
		if (t.getTS_STATE().equals(TransactionState.PROCESSING)) {
			this.transactionDao.forAWhile(id);
			//��������
			Integer commentId = this.commentDao.save(comment);
			createLog(id, userId, String.valueOf(commentId), " ��ʱ����");
		} else {
			throw new BusinessException("����ǽ�����, ��������Ϊ��ʱ����״̬");
		}
	}

	public void notToDo(String id, String userId, Comment comment) {
		Transaction t = this.transactionDao.find(id);
		//ֻ���Լ�������ſ�����Ϊ����״̬
		if (!t.getHANDLER_ID().equals(userId)) {
			throw new BusinessException("ֻ�ܴ����Լ�������");
		}
		//ֻ���ڽ����е���������ʱ����������ſ��Ըı��״̬
		if (t.getTS_STATE().equals(TransactionState.PROCESSING) 
				|| t.getTS_STATE().equals(TransactionState.FOR_A_WHILE)) {
			this.transactionDao.notToDo(id);
			//��������
			Integer commentId = this.commentDao.save(comment);
			createLog(id, userId, String.valueOf(commentId), " ��������");
		} else {
			throw new BusinessException("��������Ϊ��ʱ����״̬");
		}
	}
	
	public void finish(String id, String userId, Comment comment) {
		Transaction t = this.transactionDao.find(id);
		//ֻ���Լ�������ſ�����Ϊ���״̬
		if (!t.getHANDLER_ID().equals(userId)) {
			throw new BusinessException("ֻ�ܴ����Լ�������");
		}
		//ֻ���ڽ����е���������ʱ����������ſ��Ըı��״̬
		if (t.getTS_STATE().equals(TransactionState.PROCESSING) 
				|| t.getTS_STATE().equals(TransactionState.FOR_A_WHILE)) {
			this.transactionDao.finish(id, ViewUtil.formatDate(new Date()));
			//��������
			Integer commentId = this.commentDao.save(comment);
			createLog(id, userId, String.valueOf(commentId), "������");
		} else {
			throw new BusinessException("ֻ�н����л�����ʱ����������ſ������");
		}
	}
	
	public void transfer(String targetUserId, String sourceUserId,
			Comment comment) {
		Transaction t = this.transactionDao.find(comment.getTRANSACTION_ID());
		//ֻ���Լ�������ſ���ת��
		if (!t.getHANDLER_ID().equals(sourceUserId)) {
			throw new BusinessException("ֻ�ܴ����Լ�������");
		}
		//ֻ���ڽ����е���������ʱ����������ſ���ת��
		if (t.getTS_STATE().equals(TransactionState.PROCESSING) 
				|| t.getTS_STATE().equals(TransactionState.FOR_A_WHILE)) {
			UserTransfer ut = new UserTransfer();
			ut.setTS_ID(comment.getTRANSACTION_ID());
			ut.setUSER_ID(sourceUserId);
			ut.setTARGET_USER_ID(targetUserId);
			ut.setOPERATE_DATE(ViewUtil.formatDate(new Date()));
			//����ת����¼
			this.userTransferDao.save(ut);
			//��������
			Integer commentId = this.commentDao.save(comment);
			//�ı������¼�ĵ�ǰ������id��ǰһ������id
			this.transactionDao.changeHandler(targetUserId, 
					sourceUserId, comment.getTRANSACTION_ID());
			User targetUser = this.userDao.find(targetUserId);
			createLog(t.getID(), sourceUserId, String.valueOf(commentId), "ת���� " + targetUser.getREAL_NAME() + " ");
		} else {
			throw new BusinessException("ֻ�н����л�����ʱ����������ſ���ת��");
		}
	}
	
	@Override
	public Transaction view(String id) {
		Transaction t = this.transactionDao.find(id);
		setUser(t);
		List<Log> logs = this.logDao.find(id);
		for (Log log : logs) {
			Comment comment = this.commentDao.find(log.getCOMMENT_ID());
			User user = this.userDao.find(log.getHANDLER_ID());
			log.setComment(comment);
			log.setHandler(user);
		}
		t.setLogs(logs);
		return t;
	}

	/**
	 * ������־
	 * @param tsId
	 * @param handlerId
	 * @param commentId
	 * @param desc ����
	 */
	private void createLog(String tsId, String handlerId, String commentId, String desc) {
		Log log = new Log();
		log.setCOMMENT_ID(commentId);
		log.setHANDLER_ID(handlerId);
		log.setLOG_DATE(ViewUtil.timeFormatDate(new Date()));
		log.setTS_ID(tsId);
		log.setTS_DESC(desc);
		this.logDao.save(log);
	}

	public Transaction get(String id) {
		return this.transactionDao.find(id);
	}

	
}
