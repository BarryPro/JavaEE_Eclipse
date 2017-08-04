package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.atom.domains.query.Query8128Entity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.ArrayList;
import java.util.List;

/**
*
* <p>Title: 出参  </p>
* <p>Description: 出参  </p>
* <p>Copyright: Copyright (c) 2015</p>
* <p>Company: SI-TECH </p>
* @author zhanghp
* @version 1.0
*/
public class S8128QueryOutDTO extends CommonOutDTO {
	
	@ParamDesc(path="PHONE_NO",cons=ConsType.CT001,type="String",len="20",desc="服务号码",memo="略")
	private String phoneNo = "";
	@ParamDesc(path="FINISH_FLAG",cons=ConsType.CT001,type="String",len="5",desc="启用标志",memo="0:Y,1:N")
	private String finishFlag = "";
	@ParamDesc(path="OLD_EXPIRE",cons=ConsType.CT001,type="String",len="20",desc="上次到期时间",memo="略")
	private String oldExpire = "";
	@ParamDesc(path="EXPIRE_TIME",cons=ConsType.CT001,type="String",len="20",desc="到期时间",memo="略")
	private String expireTime = "";
	@ParamDesc(path="OP_TIME",cons=ConsType.CT001,type="String",len="20",desc="开户时间",memo="略")
	private String opTime = "";
	@ParamDesc(path="DAYS",cons=ConsType.CT001,type="int",len="20",desc="到期天数",memo="略")
	private int days = 0;
	@ParamDesc(path="STATUS",cons=ConsType.CT001,type="String",len="20",desc="有效期",memo="略")
	private String status = "";
	@ParamDesc(path="QUERY_LIST",cons=ConsType.STAR,type="compx",len="1",desc="查询操作列表",memo="略")
	private List<Query8128Entity> outParamList = new ArrayList<Query8128Entity>();
	
	
	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("phoneNo"), phoneNo);
		result.setRoot(getPathByProperName("finishFlag"), finishFlag);
		result.setRoot(getPathByProperName("oldExpire"), oldExpire);
		result.setRoot(getPathByProperName("expireTime"), expireTime);
		result.setRoot(getPathByProperName("opTime"), opTime);
		result.setRoot(getPathByProperName("days"), days);
		result.setRoot(getPathByProperName("outParamList"), outParamList);
		result.setRoot(getPathByProperName("status"), status);
		return result;
	}


	/**
	 * @return the phoneNo
	 */
	public String getPhoneNo() {
		return phoneNo;
	}

	/**
	 * @param phoneNo the phoneNo to set
	 */
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}


	

	/**
	 * @return the finishFlag
	 */
	public String getFinishFlag() {
		return finishFlag;
	}


	/**
	 * @param finishFlag the finishFlag to set
	 */
	public void setFinishFlag(String finishFlag) {
		this.finishFlag = finishFlag;
	}


	/**
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}


	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}




	/**
	 * @return the oldExpire
	 */
	public String getOldExpire() {
		return oldExpire;
	}

	/**
	 * @param oldExpire the oldExpire to set
	 */
	public void setOldExpire(String oldExpire) {
		this.oldExpire = oldExpire;
	}

	/**
	 * @return the expireTime
	 */
	public String getExpireTime() {
		return expireTime;
	}





	/**
	 * @param expireTime the expireTime to set
	 */
	public void setExpireTime(String expireTime) {
		this.expireTime = expireTime;
	}





	/**
	 * @return the opTime
	 */
	public String getOpTime() {
		return opTime;
	}





	/**
	 * @param opTime the opTime to set
	 */
	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}





	/**
	 * @return the days
	 */
	public int getDays() {
		return days;
	}





	/**
	 * @param days the days to set
	 */
	public void setDays(int days) {
		this.days = days;
	}


	/**
	 * @return the outParamList
	 */
	public List<Query8128Entity> getOutParamList() {
		return outParamList;
	}





	/**
	 * @param outParamList the outParamList to set
	 */
	public void setOutParamList(List<Query8128Entity> outParamList) {
		this.outParamList = outParamList;
	}	
	
}
