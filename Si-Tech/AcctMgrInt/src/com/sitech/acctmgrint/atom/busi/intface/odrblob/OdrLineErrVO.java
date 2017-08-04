package com.sitech.acctmgrint.atom.busi.intface.odrblob;

public class OdrLineErrVO {
	
	String gsTopicId;
	byte[] gbContent;
	String gsLoginAct;
	//String gsOpTime;
	String gsOpCode;
	String gsLoginNo;
	long   glCreatAct;
	String gsDataSrc;
	String gsBusiidType;
	String gsBusiidNo;
	//String gsRcvTime;
	String gsErrCode;
	String gsErrMsg;
	
	public String getGsErrCode() {
		return gsErrCode;
	}
	public void setGsErrCode(String gsErrCode) {
		this.gsErrCode = gsErrCode;
	}
	public String getGsErrMsg() {
		return gsErrMsg;
	}
	public void setGsErrMsg(String gsErrMsg) {
		this.gsErrMsg = gsErrMsg;
	}
	public String getGsTopicId() {
		return gsTopicId;
	}
	public void setGsTopicId(String gsTopicId) {
		this.gsTopicId = gsTopicId;
	}
	public byte[] getGbContent() {
		return gbContent;
	}
	public void setGbContent(byte[] gbContent) {
		this.gbContent = gbContent;
	}
	public String getGsLoginAct() {
		return gsLoginAct;
	}
	public void setGsLoginAct(String gsLoginAct) {
		this.gsLoginAct = gsLoginAct;
	}
	public String getGsOpCode() {
		return gsOpCode;
	}
	public void setGsOpCode(String gsOpCode) {
		this.gsOpCode = gsOpCode;
	}
	public String getGsLoginNo() {
		return gsLoginNo;
	}
	public void setGsLoginNo(String gsLoginNo) {
		this.gsLoginNo = gsLoginNo;
	}
	public long getGlCreatAct() {
		return glCreatAct;
	}
	public void setGlCreatAct(long glCreatAct) {
		this.glCreatAct = glCreatAct;
	}
	public String getGsDataSrc() {
		return gsDataSrc;
	}
	public void setGsDataSrc(String gsDataSrc) {
		this.gsDataSrc = gsDataSrc;
	}
	public String getGsBusiidType() {
		return gsBusiidType;
	}
	public void setGsBusiidType(String gsBusiidType) {
		this.gsBusiidType = gsBusiidType;
	}
	public String getGsBusiidNo() {
		return gsBusiidNo;
	}
	public void setGsBusiidNo(String gsBusiidNo) {
		this.gsBusiidNo = gsBusiidNo;
	}


}
