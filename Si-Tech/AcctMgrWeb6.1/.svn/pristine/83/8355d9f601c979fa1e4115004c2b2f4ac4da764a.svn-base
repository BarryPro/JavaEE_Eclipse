package com.sitech.acctmgr.atom.busi.pay.inter;

import java.util.Map;

import com.sitech.acctmgr.atom.domains.pay.DistrictLimitEntity;
import com.sitech.acctmgr.atom.domains.pay.RegionLimitEntity;

public interface ILimitFee {
	
	void regionDayLimit(Map<String,Object> inParam);
	
	void districtDayLimit(Map<String,Object> inParam);
	
	void updateMonthRegionLimit(long backedMonthFee,String regionGroup,String limitType);
	
	void updateDayRegionLimit(long backedDayFee,String regionGroup,String limitType);
	
	void  updateMonthDistrictLimit(long backedMonthFee,String regionGroup,String limitType,String districtGroup);
	
	void updateDayDistrictLimit(long backedDayFee,String regionGroup,String limitType,String districtGroup);
	
	void regionMonthLimit(Map<String,Object> inParam);
	
	void updateDistrictLimit(String districtGroup,String districtMonthLimit,String districtDayLimit,String regionGroup,String limitType,String msgPhone);
	
	void updateRegionLimit(String regionMonthLimit,String regionDayLimit,String regionGroup,String limitType,String msgPhone);
	
	RegionLimitEntity getRegionLimitConf(String regionGroup,String limitType);
	
	DistrictLimitEntity getDistrictLimitConf(String regionGroup,String districtGroup,String limitType);
	
}
