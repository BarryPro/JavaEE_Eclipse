package com.belong.dao;

import java.util.List;

import com.belong.vo.Message3;

public interface IMessage3DAO {
	public boolean addMessage(Message3 message);
	public boolean delMessage(Message3 message);
	public List<Message3> queryMessage();
}
