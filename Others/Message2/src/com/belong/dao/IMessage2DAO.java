package com.belong.dao;

import java.util.List;

import com.belong.vo.Message2;

public interface IMessage2DAO {
	public boolean addMessage(Message2 message);
	public boolean delMessage(Message2 message);
	public List<Message2> queryMessage();
}
