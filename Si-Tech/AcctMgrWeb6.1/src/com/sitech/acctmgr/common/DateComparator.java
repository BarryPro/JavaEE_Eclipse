package com.sitech.acctmgr.common;

import java.util.Comparator;

import com.sitech.acctmgr.atom.domains.query.FreeMinBill;

/**
 * 功能：套餐优惠信息排序
 *
 */
public class DateComparator implements Comparator<FreeMinBill> {

	@Override
	public int compare(FreeMinBill o1, FreeMinBill o2) {
	
		String key1 = o1.getPrcType() + "^" +o1.getProdPrcId() + "^" + o1.getBusiCode();
		String key2 = o2.getPrcType() + "^" +o2.getProdPrcId() + "^" + o2.getBusiCode();
		
		return key1.compareTo(key2);
	}

}
