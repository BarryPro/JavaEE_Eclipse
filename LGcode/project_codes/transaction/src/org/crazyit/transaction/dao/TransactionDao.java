package org.crazyit.transaction.dao;

import java.util.List;

import transaction.src.org.crazyit.transaction.model.Transaction;

public interface TransactionDao {

	/**
	 * ���ݴ�����ID������״̬��������
	 * @param state
	 * @param userId
	 * @return
	 */
	List<Transaction> findHandlerTransactions(String state, String userId);
	
	/**
	 * ��������
	 * @param t
	 */
	void save(Transaction t);
	
	/**
	 * ���ݷ�����ID������״̬��������
	 * @param state
	 * @param userId
	 * @return
	 */
	List<Transaction> findInitiatorTransactions(String state, String userId);
	
	/**
	 * �߰�����
	 * @param id
	 */
	void hurry(String id);
	
	/**
	 * ��������Ϊ��Ч
	 * @param id
	 */
	void invalid(String id);
		
	/**
	 * ����ID��������
	 * @param id
	 * @return
	 */
	Transaction find(String id);
	
	/**
	 * ������״̬�ı�Ϊ��ʱ����
	 * @param id
	 */
	void forAWhile(String id);
	
	/**
	 * ������״̬�ı�Ϊ����
	 * @param id
	 */
	void notToDo(String id);
	
	/**
	 * ������״̬�ı�Ϊ���
	 * @param id
	 * @param date �������
	 */
	void finish(String id, String date);
	
	/**
	 *  �ı�����Ĵ�����
	 * @param currentHandlerId
	 * @param preHandlerId
	 * @param transactionId
	 */
	void changeHandler(String currentHandlerId, String preHandlerId, 
			String transactionId);
}
