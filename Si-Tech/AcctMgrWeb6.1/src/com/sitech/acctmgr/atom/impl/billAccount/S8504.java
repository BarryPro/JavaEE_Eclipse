package com.sitech.acctmgr.atom.impl.billAccount;

import java.util.ArrayList;
import java.util.List;

import com.sitech.acctmgr.atom.domains.query.LocationCodeEntity;
import com.sitech.acctmgr.atom.domains.record.ActQueryOprEntity;
import com.sitech.acctmgr.atom.dto.query.S8504InitInDTO;
import com.sitech.acctmgr.atom.dto.query.S8504InitOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBillAccount;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.billAccount.I8504;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ 
	@ParamType(m = "query", c = S8504InitInDTO.class, oc = S8504InitOutDTO.class)
})
public class S8504 extends AcctMgrBaseService implements I8504{

	protected IBillAccount billAccount;
	protected IRecord record;
	
	@Override
	public OutDTO query(InDTO inParam) {
		// TODO Auto-generated method stub
		List<LocationCodeEntity> resultList = new ArrayList<LocationCodeEntity>();
		
		S8504InitInDTO inDto = (S8504InitInDTO)inParam;
		String queryType = inDto.getQueryType();
		
		if(queryType.equals("1")) {
			String cellId = inDto.getCellId();
			String lacCode = inDto.getLacCode();
			resultList = billAccount.getLocationInfo(lacCode, cellId, null);
		}else if(queryType.equals("2")) {
			String flagCode = inDto.getFlagCode();
			resultList = billAccount.getLocationInfo(null, null, flagCode);
		}
		
		ActQueryOprEntity oprEntity = new ActQueryOprEntity();
		oprEntity.setQueryType("0");
		oprEntity.setOpCode("8504");
		oprEntity.setContactId("");
		oprEntity.setBrandId("");
		oprEntity.setLoginNo(inDto.getLoginNo());
		oprEntity.setLoginGroup(inDto.getGroupId());
		oprEntity.setRemark("小区计费数据查询");
		oprEntity.setProvinceId(inDto.getProvinceId());
		record.saveQueryOpr(oprEntity, false);
		
		S8504InitOutDTO outDto = new S8504InitOutDTO();
		outDto.setResultList(resultList);
		return outDto;
	}

	/**
	 * @return the billAccount
	 */
	public IBillAccount getBillAccount() {
		return billAccount;
	}

	/**
	 * @param billAccount the billAccount to set
	 */
	public void setBillAccount(IBillAccount billAccount) {
		this.billAccount = billAccount;
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
	
}
