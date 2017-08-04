package com.sitech.acctmgrint.atom.busi.intface.odrblob;

import com.sitech.acctmgrint.common.BaseBusi;

public class OdrLineContDAO extends BaseBusi {
	
	public void insertOdrLineCont(OdrLineContVO odrLineContVO) {
		log.info("---------插入消息 开始--------");
		Object oCount =  baseDao.insert("in_msgsend_info_INT.insertOdrCont", odrLineContVO);
		log.info("---插入消息结束，插入消息成功-----");
		
	}
	
	/**
	 * Title 插入接口表错误表
	 * @param odrLineErrVO
	 */
	public int insertMsgErrCont(OdrLineErrVO odrLineErrVO) {
		log.info("------insert msgsend stt------");
		int i = 0;
		i = (Integer) baseDao.insert("in_msgsend_err_INT.insert", odrLineErrVO);
		log.info("------insert msgsend end------");
		return i;
	}
	
}
