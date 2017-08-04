package com.sitech.acctmgr.app.msgodrsend;

import java.util.HashMap;
import java.util.Map;

import com.sitech.acctmgr.app.common.InterBusiConst;
import com.sitech.acctmgr.app.common.JdbcConn;
import com.sitech.acctmgr.app.odrBlob.OdrLineContVO;
import com.sitech.acctmgr.app.odrBlob.OdrLineErrVO;
import com.sitech.acctmgr.common.BaseBusi;

public class MsgSendDAO extends BaseBusi {

	public boolean dealMidErrData(Map<String, Object> inDataMap) {
		//是否入历史
		if (InterBusiConst.MSGSND_ERRFLAG.equals("Y"))
				baseDao.insert("in_msgsend_err.iDatabyAccept", inDataMap);
		//删除接口表数据
		baseDao.delete("in_msgsend_info.dDatabyAccept", inDataMap);
		return false;
	}
	
	public boolean dealMidHisData(Map<String, Object> inDataMap) {
		
		try {
			if (InterBusiConst.MSGSND_HISFLAG.equals("Y"))
				baseDao.insert("in_msgsend_his.iDatabyAccept", inDataMap);
		} catch (Exception e) {
			//删除接口表数据
			baseDao.delete("in_msgsend_info.dDatabyAccept", inDataMap);
			return true;
		}
		//删除接口表数据
		baseDao.delete("in_msgsend_info.dDatabyAccept", inDataMap);
		return true;
	}
	
	/**
	 * @title 使用JDBC操作数据库
	 * @description 由于使用ibatis需要对事务Bean+Svc声明，
	 * 				但是MsgThread不是接口，所以数据无法自动提交
	 * @param indatamap
	 * @param sDbid
	 * @return
	 */
	public boolean inputHisAndDel(Map<String, Object> indatamap, JdbcConn jdbc) {
		
		jdbc.setSqlBuffer(InterBusiConst.MSGSND_INHIS);
		//注意顺序 TOPIC_ID=? AND CREATE_ACCEPT=?
		jdbc.addParam("MSG_ID", indatamap.get("MSG_ID").toString());
		jdbc.addParam("TOPIC_ID", indatamap.get("TOPIC_ID").toString());
		jdbc.addParam("CREATE_ACCEPT", indatamap.get("CREATE_ACCEPT").toString(), 1);
		jdbc.execAndComm();

		//执行删除操作
		jdbc.setSqlBuffer(InterBusiConst.MSGSND_DELETE);
		jdbc.addParam("TOPIC_ID", indatamap.get("TOPIC_ID").toString());
		jdbc.addParam("CREATE_ACCEPT", indatamap.get("CREATE_ACCEPT").toString(), 1);
		System.out.println("提交消息数："+jdbc.execAndComm());
		
		return true;
	}
	
	/**
	 * @title 使用JDBC操作err数据库
	 * @description 由于使用ibatis需要对事务Bean+Svc声明，
	 * 				但是MsgThread不是接口，所以数据无法自动提交
	 * @param indatamap
	 * @param sDbid
	 * @return
	 */
	public boolean inputErrAndDel(Map<String, Object> indatamap, JdbcConn jdbc) {
		
		jdbc.setSqlBuffer(InterBusiConst.MSGSND_INSTERR);
		//注意顺序 #ERR_MSG# ,#ERR_CODE# FROM ... TOPIC_ID=#TOPIC_ID# AND CREATE_ACCEPT=#CREATE_ACCEPT#"
		jdbc.addParam("ERR_MSG", indatamap.get("ERR_MSG").toString());
		jdbc.addParam("ERR_CODE", indatamap.get("ERR_CODE").toString());
		jdbc.addParam("TOPIC_ID", indatamap.get("TOPIC_ID").toString());
		jdbc.addParam("CREATE_ACCEPT", indatamap.get("CREATE_ACCEPT").toString(), 1);
		jdbc.execAndComm();
		
		//执行删除INFO正表操作
		jdbc.setSqlBuffer(InterBusiConst.MSGSND_DELETE);
		jdbc.addParam("TOPIC_ID", indatamap.get("TOPIC_ID").toString());
		jdbc.addParam("CREATE_ACCEPT", indatamap.get("CREATE_ACCEPT").toString(), 1);
		jdbc.execAndComm();
		
		return true;
	}
	
	public boolean inputHisAndDelErr(Map<String, Object> indatamap, JdbcConn jdbc) {
		
		jdbc.setSqlBuffer(InterBusiConst.MSGSND_ERR_INHIS);
		//注意顺序 TOPIC_ID=? AND CREATE_ACCEPT=?
		jdbc.addParam("MSG_ID", indatamap.get("MSG_ID").toString());
		jdbc.addParam("TOPIC_ID", indatamap.get("TOPIC_ID").toString());
		jdbc.addParam("CREATE_ACCEPT", indatamap.get("CREATE_ACCEPT").toString(), 1);
		System.out.println("插入his提交消息数："+jdbc.execAndComm());

		//执行删除操作
		jdbc.setSqlBuffer(InterBusiConst.MSGSND_DELERR);
		jdbc.addParam("TOPIC_ID", indatamap.get("TOPIC_ID").toString());
		jdbc.addParam("CREATE_ACCEPT", indatamap.get("CREATE_ACCEPT").toString(), 1);
		System.out.println("删除err提交消息数："+jdbc.execAndComm());
		
		return true;
	}
	
	/**
	 * Title 参数类型转换为Map
	 * @param odrContVo
	 * @return
	 */
	public Map<String, Object> switchVoToMap(OdrLineContVO odrContVo) {

		Map<String, Object> outMap = new HashMap<String, Object>();
		/* CREATE_ACCEPT, DATA_SOURCE, BUSIID_NO, BUSIID_TYPE, TOPIC_ID,
           CONTENT, LOGIN_ACCEPT, OP_CODE, LOGIN_NO, SUFFIX */
		outMap.put("CREATE_ACCEPT", odrContVo.getGlCreatAct());
		outMap.put("DATA_SOURCE",   odrContVo.getGsDataSrc());
		outMap.put("BUSIID_NO",     odrContVo.getGsBusiidNo());
		outMap.put("BUSIID_TYPE",   odrContVo.getGsBusiidType());
		outMap.put("TOPIC_ID",      odrContVo.getGsTopicId());
		outMap.put("CONTENT",       odrContVo.getGbContent());
		outMap.put("LOGIN_ACCEPT",  odrContVo.getGsLoginAct());
		outMap.put("OP_CODE",       odrContVo.getGsOpCode());
		outMap.put("LOGIN_NO",      odrContVo.getGsLoginNo());
		//outMap.put("SUFFIX",        odrContVo.getGsTableSuffix());
		
		if (outMap.isEmpty())
			return null;
		else 
			return outMap;
	}
	
	public Map<String, Object> switchVoToMap(OdrLineErrVO odrContVo) {

		Map<String, Object> outMap = new HashMap<String, Object>();
		/* CREATE_ACCEPT, DATA_SOURCE, BUSIID_NO, BUSIID_TYPE, TOPIC_ID,
           CONTENT, LOGIN_ACCEPT, OP_CODE, LOGIN_NO, SUFFIX */
		outMap.put("CREATE_ACCEPT", odrContVo.getGlCreatAct());
		outMap.put("DATA_SOURCE",   odrContVo.getGsDataSrc());
		outMap.put("BUSIID_NO",     odrContVo.getGsBusiidNo());
		outMap.put("BUSIID_TYPE",   odrContVo.getGsBusiidType());
		outMap.put("TOPIC_ID",      odrContVo.getGsTopicId());
		outMap.put("CONTENT",       odrContVo.getGbContent());
		outMap.put("LOGIN_ACCEPT",  odrContVo.getGsLoginAct());
		outMap.put("OP_CODE",       odrContVo.getGsOpCode());
		outMap.put("LOGIN_NO",      odrContVo.getGsLoginNo());
		outMap.put("ERR_CODE",        odrContVo.getGsErrCode());
		outMap.put("ERR_MSG",        odrContVo.getGsErrMsg());
		
		if (outMap.isEmpty())
			return null;
		else 
			return outMap;
	}
	
	
}
