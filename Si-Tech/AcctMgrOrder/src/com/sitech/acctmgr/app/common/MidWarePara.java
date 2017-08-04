package com.sitech.acctmgr.app.common;

public class MidWarePara {
	
	/*消息中间件主题相关信息*/
	
	String topic;
	String addr;
	String client;
	int priori;
	int timeOut;
	int sleepSec;
	int thrdNum;
	
	public String getTopic() {
		return topic;
	}
	public void setTopic(String topic) {
		this.topic = topic;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	public int getPriori() {
		return priori;
	}
	public void setPriori(int priori) {
		this.priori = priori;
	}
	public int getTimeOut() {
		return timeOut;
	}
	public void setTimeOut(int timeOut) {
		this.timeOut = timeOut;
	}
	public int getSleepSec() {
		return sleepSec;
	}
	public void setSleepSec(int sleepSec) {
		this.sleepSec = sleepSec;
	}
	public int getThrdNum() {
		return thrdNum;
	}
	public void setThrdNum(int thrdNum) {
		this.thrdNum = thrdNum;
	}
	
}
