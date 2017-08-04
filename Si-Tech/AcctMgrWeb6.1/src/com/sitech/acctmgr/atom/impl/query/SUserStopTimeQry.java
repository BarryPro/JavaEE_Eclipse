package com.sitech.acctmgr.atom.impl.query;

import java.util.ArrayList;
import java.util.List;

import com.sitech.acctmgr.atom.domains.record.UserChgRecdEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.query.SUserStopTimeQryInDTO;
import com.sitech.acctmgr.atom.dto.query.SUserStopTimeQryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.query.IUserStopTimeQry;
import com.sitech.billing.qdetail.common.util.DateUtils;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ @ParamType(m = "query", c = SUserStopTimeQryInDTO.class, oc = SUserStopTimeQryOutDTO.class)})
public class SUserStopTimeQry extends AcctMgrBaseService implements IUserStopTimeQry{

	private IRecord record;
	private IUser user;
	@Override
	public OutDTO query(InDTO inParam) {
		// TODO Auto-generated method stub
		List<UserChgRecdEntity> resultList = new ArrayList<UserChgRecdEntity>();
		SUserStopTimeQryInDTO inDto = (SUserStopTimeQryInDTO)inParam;
		String phoneNo = inDto.getPhoneNo();
		String beginDate = inDto.getBeginDate();
		String endDate = inDto.getEndDate();
		
		UserInfoEntity uie = user.getUserInfo(phoneNo);
		long idNo = uie.getIdNo();
		
		int beginYm = Integer.parseInt(beginDate)/100;
		int endYm = Integer.parseInt(endDate)/100;
		while(beginYm<=endYm) {
			
			List<UserChgRecdEntity> listTemp = record.getUserChgRecd(idNo, String.valueOf(beginYm));
			if(listTemp.size()>0){
				for(UserChgRecdEntity uce:listTemp) {
					UserChgRecdEntity resultEnTity = new UserChgRecdEntity();
					String runCode = uce.getRunCode();
					String runName ="";
					if(runCode.equals("C")){
						runName="单停|";
					}else if(runCode.equals("B")){
						runName="双停|";
					}else {
						runName="停漫游|";
					}
					resultEnTity.setOpTime(uce.getOpTime());
					resultEnTity.setRunCode(runName);
					resultList.add(resultEnTity);
				}
			}
			
			beginYm=DateUtils.AddMonth(beginYm, 1);
		}
		
		SUserStopTimeQryOutDTO outDto = new SUserStopTimeQryOutDTO();
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
	
}
