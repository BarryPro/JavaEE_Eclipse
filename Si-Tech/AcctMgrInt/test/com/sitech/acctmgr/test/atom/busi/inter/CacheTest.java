package com.sitech.acctmgr.test.atom.busi.inter;

import java.util.HashMap;
import java.util.Map;
import org.junit.Test;

import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.acctmgrint.atom.busi.intface.ISvcOrder;
import com.sitech.acctmgrint.atom.busi.intface.cfgcache.DataBaseCache;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.util.DateUtil;

public class CacheTest extends BaseTestCase {

	@Test
	public void testCacheCfg() {
		
		/*
		//分转元
		double dFen = 1234.54;
		log.info("dFen="+dFen+",trans to YUAN ,yuan="
				+ValueUtils.transFenToYuan(dFen));
		//元转分
		double dYuan = 12.3454;
		log.info("dYuan="+dYuan+",trans to PENNY ,fen="
				+ValueUtils.transYuanToFen(dYuan));
		
		 *输出结果： 
		 *dFen=1234.54,trans to YUAN ,yuan=12.35
		 *dYuan=12.3454,trans to PENNY ,fen=1235
		 */
		
//		ISvcOrder svcOrder = (ISvcOrder) getBean("NewSvcOrderEnt");
//		DataBaseCache dataBaseCache = (DataBaseCache) getBean("DataBaseCache");
//		Map<String, Object> cfgMap = new HashMap<String, Object>();
//		log.info("----------------konglj test:stt----------------");
//		cfgMap = dataBaseCache.getDestTabCfgMap("IN_BSSVC_DICT", "B01001");;
//		log.info("----------------konglj test bssvc:end cfgMap="+cfgMap.toString());
		
//		cfgMap = new HashMap<String, Object>();
//		cfgMap = DataBaseCache.getDestTabCfgMap("IN_BSSTATUSTOACTION_REL", "A#B01001");
//		log.info("----------------konglj test BSSTATUSTOACTION :end cfgMap="+cfgMap.toString());
//		
//		cfgMap = new HashMap<String, Object>();
//		cfgMap = DataBaseCache.getDestTabCfgMap("IN_BSMODTABLE_REL", "8901#B01001");
//		log.info("----------------konglj test BSMODTABLE :end cfgMap="+cfgMap.toString());
//		
//		//cfgMap = new HashMap<String, Object>();
//		List<Map<String, Object>> list = DataBaseCache.getDestTabCfgList("IN_BSPRIPARM_DICT", "8901#B01001");
//		for (Map<String, Object> tmMap : list) {
//			log.info("----------------konglj test BSPRIPARM :end tmMap="+tmMap.toString());
//		}
//		
//		cfgMap = new HashMap<String, Object>();
//		cfgMap = DataBaseCache.getDestTabCfgMap("IN_BSDATASOURCE_DICT", "10011");
//		log.info("----------------konglj test BSDATASOURCE :end cfgMap="+cfgMap.toString());
//		
//		
//		list = DataBaseCache.getDestTabCfgList("IN_BSSVC_ATTRGROUP_REL", "B01001#8901#M");
//		for (Map<String, Object> tmMap : list) {
//			log.info("----------------konglj test BSSVC_ATTRGROUP :end tmMap="+tmMap.toString());
//		}
	}
	
}
