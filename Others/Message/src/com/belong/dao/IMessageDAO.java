package com.belong.dao;

import java.util.List;

import com.belong.vo.Message;

public interface IMessageDAO {
	public boolean addMessage(Message message);//增加消息
	public List<Message> queryMessage();//查询消息
	public boolean delMessage(Message message);
}
