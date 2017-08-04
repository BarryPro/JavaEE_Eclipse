package com.sitech.acctmgr.app.odrBlob;

import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.common.BaseBusi;

public class OdrLineContDAO extends BaseBusi {

	
	/**
	 * Title 查询info表信息
	 * @param odrLineContVO
	 * @return
	 */
	public List queryOdrLineCont(OdrLineContVO odrLineContVO) {
		log.info("----------queyrystmpt-sfadfa--"+odrLineContVO.getGsTopicId());
		List list = baseDao.queryForList("in_msgsend_info.queryOdrCont", odrLineContVO);
		return list;
	}
	
	public List queryOdrListCont(Map<String, Object> inMap) {
		log.info("----------queyrystmpt-inMap--"+inMap.toString());
		List rstList =  baseDao.queryForList("in_msgsend_info.queryOdrCont", inMap);
		log.info("----------queyrystmpt-rstList--"+rstList.size());
		return rstList;
	}
	
	public List queryThrdListCont(Map<String, Object> inMap) {
		log.info("----------queyrystmpt-inMap--"+inMap.toString());
		List rstList =  baseDao.queryForList("in_msgsend_info.queryThrdCont", inMap);
		log.info("----------queyrystmpt-rstList--"+rstList.size());
		return rstList;
	}
	
	public List qErrTopicList(Map<String, Object> inMap) {
		log.info("----------qErrlist-inMap--"+inMap.toString());
		List rstList =  baseDao.queryForList("in_msgsend_err.qTopic", inMap);
		log.info("----------qErrlist-rstList--"+rstList.size());
		return rstList;
	}
	
	/**
	 * Title 插入接口表
	 * @param odrLineContVO
	 */
	public int insertOdrLineCont(OdrLineContVO odrLineContVO) {
		int i = (Integer) baseDao.insert("in_msgsend_info.insertOdrCont", odrLineContVO);
		return i;
	}
	
	/**
	 * Title 插入接口表
	 * @param odrLineContVO
	 */
	public int insertRcvOdrCont(OdrLineContVO odrLineContVO) {
		Object object = baseDao.insert("in_msgrcv_his.insertOdrCont", odrLineContVO);
		return 0;
	}
	
	/**
	 * Title 插入接收表错误表
	 * @param odrLineErrVO
	 */
	public int insertOdrErrCont(OdrLineErrVO odrLineErrVO) {
		log.info("------insert errodr stt------");
		int i = 0;
		//i = (Integer) 
		baseDao.insert("in_msgrcv_err.insert", odrLineErrVO);
		log.info("------insert errodr end------");
		return i;
	}
	
}
