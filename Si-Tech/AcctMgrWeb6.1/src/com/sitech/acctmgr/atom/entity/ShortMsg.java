package com.sitech.acctmgr.atom.entity;

import com.sitech.acctmgr.atom.domains.pub.pubUpdateEntity;
import com.sitech.acctmgr.atom.entity.inter.IShortMsg;
import com.sitech.acctmgr.common.BaseBusi;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * <p>Title: 用户下发短信管理  </p>
 * <p>Description: 主要获取用户下发短信提醒号码以及配置  </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class ShortMsg extends BaseBusi implements IShortMsg{
	
	
	public String getConSmsPhone(long contractNo) {
		
		//获取配置的短信接收号码，如果有则直接返回null
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("CONTRACT_NO", contractNo);
		Map<String, Object> result = (Map<String, Object>)baseDao.queryForObject("bal_shortmsg_info.qShortmsg", inMap);
		if(result == null){
			return null;
		}else{
			return result.get("PHONE_NO").toString();
		}
	}
	
	public  boolean isConfig(long contractNo){
		
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("CONTRACT_NO", contractNo);
		Integer cnt = (Integer)baseDao.queryForObject("bal_shortmsg_info.qCnt", inMap);
		if(cnt > 0){
			return true;
		}else{
			return false;
		}
	}
	
	
	public void inShortMsgInfo(Map<String, Object> inParam){
		
		baseDao.insert("bal_shortmsg_info.iShortmsg", inParam);
	}
	
	public void dConfig(long contractNo){
		
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("CONTRACT_NO", contractNo);
		baseDao.delete("bal_shortmsg_info.delShortmsg", inMap);
	}
	
	public List<Map<String, Object>> getShortMsgList(String phoneNo, Long contractNo){
		
		Map<String, Object> inMap = new HashMap<String, Object>();
		if(phoneNo != null){
			inMap.put("PHONE_NO", phoneNo);
		}
		if(contractNo != null){
			inMap.put("CONTRACT_NO", contractNo);
		}
		return (List<Map<String, Object>>)baseDao.queryForList("bal_shortmsg_info.qShortmsg", inMap);
	}
	
	public void inShortMsgInfoHis(long contractNo, pubUpdateEntity updateEntity){
		
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("CONTRACT_NO", contractNo);
		log.debug("qiaolin2: " + updateEntity.toMap());
		inMap.putAll(updateEntity.toMap());
		log.debug("qiaolin2: " + inMap);
		baseDao.insert("bal_shortmsg_info_his.iShortmsgHis", inMap);
	}
	
	public  void upPhone(long contractNo, String phoneNo){
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("CONTRACT_NO", contractNo);
		inMap.put("PHONE_NO", phoneNo);
		baseDao.update("bal_shortmsg_info.uShortmsg", inMap);
	}
	
	
}
