package org.crazyit.transaction.service;

import java.util.List;

import transaction.src.org.crazyit.transaction.model.Transaction;

public interface TransactionService {

	/**
	 * ���ݴ����˻�ȡ��Ӧ״̬������
	 * @param user
	 * @return
	 */
	List<Transaction> getHandlerTransaction(User user, String state);
	 
	/**
	 * ���ݷ����˻�ȡ��Ӧ״̬������
	 * @param user
	 * @return
	 */
	List<Transaction> getInitiatorTransaction(User user, String state);
	
	/**
	 * ����id��ȡ�������
	 * @param id
	 * @return
	 */
	Transaction get(String id);
	
	/**
	 * ����һ������
	 * @param t
	 */
	void save(Transaction t);
	
	/**
	 * �߰�����
	 * @param t
	 */
	void hurry(String id);
	
	/**
	 * ��������Ϊ��Ч
	 * @param id
	 */
	void invalid(String id);
	
	/**
	 * ��������Ϊ��ʱ������״̬
	 * @param id
	 */
	void forAWhile(String id, String userId, Comment comment);
	
	/**
	 * ��������Ϊ������״̬
	 * @param id
	 */
	void notToDo(String id, String userId, Comment comment);
	
	/**
	 * �������
	 * @param id
	 */
	void finish(String id, String userId, Comment comment);
	
	/**
	 * ת������
	 * @param targetId Ŀ���û�id
	 * @param sourceId ת�����û�id
	 * @param comment ����
	 */
	void transfer(String targetUserId, String sourceUserId, Comment comment);
	
	/**
	 * �鿴����
	 * @param id
	 * @return
	 */
	Transaction view(String id);
}
