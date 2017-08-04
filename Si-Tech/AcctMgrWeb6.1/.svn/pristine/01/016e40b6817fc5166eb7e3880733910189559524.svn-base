package com.sitech.acctmgr.atom.entity;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.prod.UserPdPrcDetailInfoEntity;
import com.sitech.acctmgr.atom.entity.inter.IGoods;
import com.sitech.acctmgr.common.BaseBusi;

/**
 *
 * <p>
 * Title: 用户商品订购类
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author qiaolin
 * @version 1.0
 */
public class Goods extends BaseBusi implements IGoods {

	@Override
	public boolean isOrderGoods(long idNo, String prcId){
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("ID_NO", idNo);
		inMap.put("PRC_IDS", prcId.split("\\,"));
		Integer result = (Integer)baseDao.queryForObject("ur_usergoods_info.qCntByPrcId", inMap);
		if(result > 0){
			return true;
		}else{
			return false;
		}
		
	}

	@Override
	public UserPdPrcDetailInfoEntity getPacketPrcInfo(long idNo) {

		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("ID_NO", idNo);
		UserPdPrcDetailInfoEntity upe = (UserPdPrcDetailInfoEntity)baseDao.queryForObject("ur_usergoods_info.qryPacketPrcInfo", inMap);
		return upe;
	}

	@Override
	public List<Map<String, Object>> getMonthFee(long idNo, String[] attrId, String[] prcClass) {
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("ID_NO", idNo);
		inMap.put("ATTR_ID", attrId);
		inMap.put("RPC_CLASS", prcClass);
		List<Map<String, Object>> outList = baseDao.queryForList("ur_usergoods_info.qMonthInfo", inMap);
		return outList;
	}
}
