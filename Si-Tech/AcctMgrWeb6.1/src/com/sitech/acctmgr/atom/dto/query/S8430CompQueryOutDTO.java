package com.sitech.acctmgr.atom.dto.query;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.balance.ActEntity;
import com.sitech.acctmgr.atom.domains.balance.ImeiFileMsgInfoEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8430CompQueryOutDTO extends CommonOutDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 7507082989391045800L;
	
	@JSONField(name="ACT_LIST")
	@ParamDesc(path="ACT_LIST",cons=ConsType.CT001,type="compx",len="1",desc="活动订购信息",memo="略")
	private List<ActEntity> actList;
	
	
	@JSONField(name="REAL_TIME_OWEFEE_LIST")
	@ParamDesc(path="IMEI_FILE_MSG_LIST",cons=ConsType.CT001,type="compx",len="1",desc="Imei信息",memo="略")
	private List<ImeiFileMsgInfoEntity> imeiFileMsgList;
	
	
	@Override
	public MBean encode() {
		MBean result = super.encode();
 		result.setBody(getPathByProperName("imeiFileMsgList"), imeiFileMsgList);
		result.setBody(getPathByProperName("actList"), actList);
		log.info(result.toString());
		return result;
	}


	/**
	 * @return the actList
	 */
	public List<ActEntity> getActList() {
		return actList;
	}


	/**
	 * @return the imeiFileMsgList
	 */
	public List<ImeiFileMsgInfoEntity> getImeiFileMsgList() {
		return imeiFileMsgList;
	}


	/**
	 * @param actList the actList to set
	 */
	public void setActList(List<ActEntity> actList) {
		this.actList = actList;
	}


	/**
	 * @param imeiFileMsgList the imeiFileMsgList to set
	 */
	public void setImeiFileMsgList(List<ImeiFileMsgInfoEntity> imeiFileMsgList) {
		this.imeiFileMsgList = imeiFileMsgList;
	}

	
	
	
	
}
