package com.belong.dao;

import java.util.List;

import com.belong.vo.Message;

public interface IMessageDAO {
	public boolean addMessage(Message message);//������Ϣ
	public List<Message> queryMessage();//��ѯ��Ϣ
	public boolean delMessage(Message message);
}
