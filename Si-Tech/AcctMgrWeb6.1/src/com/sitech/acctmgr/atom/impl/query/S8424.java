package com.sitech.acctmgr.atom.impl.query;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.query.BatchPayErrEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.feeqry.S8424QryInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.S8424QryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.query.I8424;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ 
	@ParamType(c = S8424QryInDTO.class,oc=S8424QryOutDTO.class, m = "query")
	})
public class S8424 extends AcctMgrBaseService implements I8424{

	protected IRecord record;
	protected IUser user;
	protected IGroup group;
	
	@Override
	public OutDTO query(InDTO inParam) {
		Map<String,Object> inMap = new HashMap<String,Object>();
		S8424QryInDTO inDto = (S8424QryInDTO)inParam;
		String phoneNo = inDto.getPhoneNo();
		String beginYm = inDto.getBeginYm();
		String endYm = inDto.getEndYm();
		String regionCode = inDto.getRegionCode();
		
		inMap.put("PHONE_NO", phoneNo);
		inMap.put("BEGIN_YM", beginYm);
		inMap.put("END_YM", endYm);
		inMap.put("REGION_CODE", regionCode);
		List<BatchPayErrEntity> tempList = new ArrayList<BatchPayErrEntity>(); 
		tempList = record.getBatchPayErr(inMap);
		List<BatchPayErrEntity> resultList = new ArrayList<BatchPayErrEntity>();
		if(tempList!=null) {
			for(BatchPayErrEntity bee:tempList){
				BatchPayErrEntity bpee = new BatchPayErrEntity();
				String phone = bee.getPhoneNo();
				UserInfoEntity uie = user.getUserInfo(phone);
				String groupId = uie.getGroupId();
				ChngroupRelEntity cgre = group.getRegionDistinct(groupId, "2", inDto.getProvinceId());
				String regionName = cgre.getRegionName();
				bpee.setActivityName(bee.getActivityName());
				bpee.setLoseDate(bee.getLoseDate());
				bpee.setPayMoney(bee.getPayMoney());
				bpee.setPhoneNo(phone);
				bpee.setRegionName(regionName);
				resultList.add(bpee);
			}
		}
		
		
		S8424QryOutDTO outDto = new S8424QryOutDTO();
		outDto.setResultList(resultList);
		return outDto;
	}

	/**
	 * @return the record
	 */
	public IRecord getRecord() {
		return record;
	}

	/**
	 * @param record the record to set
	 */
	public void setRecord(IRecord record) {
		this.record = record;
	}

	/**
	 * @return the user
	 */
	public IUser getUser() {
		return user;
	}

	/**
	 * @param user the user to set
	 */
	public void setUser(IUser user) {
		this.user = user;
	}

	/**
	 * @return the group
	 */
	public IGroup getGroup() {
		return group;
	}

	/**
	 * @param group the group to set
	 */
	public void setGroup(IGroup group) {
		this.group = group;
	}
	
}
