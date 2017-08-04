package com.sitech.acctmgr.atom.impl.cct;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.cct.CreditDetailEntity;
import com.sitech.acctmgr.atom.domains.cct.CreditOpenEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.cct.SCreditOpenInDTO;
import com.sitech.acctmgr.atom.dto.cct.SCreditOpenOutDTO;
import com.sitech.acctmgr.atom.entity.inter.ICredit;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.cct.ICreditOpen;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ @ParamType(c = SCreditOpenInDTO.class, m = "query", oc = SCreditOpenOutDTO.class)

})
public class SCreditOpen extends AcctMgrBaseService implements ICreditOpen{

	private ICredit credit;
	private IUser user;
	
	@Override
	public OutDTO query(InDTO inParam) {
		
		SCreditOpenOutDTO outDto = new SCreditOpenOutDTO();
		SCreditOpenInDTO inDto = (SCreditOpenInDTO)inParam;
		String phoneNo = inDto.getServiceNumber();
		
        String retCode = "0000";
        String retMsg = "成功";
        UserInfoEntity uie = user.getUserEntityByPhoneNo(phoneNo, false);
        if (uie == null) {
            retCode = "4005";
            retMsg = "使用用户手机号码非法（不存在）";

            outDto.setRetCode(retCode);
            outDto.setRetMsg(retMsg);

            return outDto;
        }
		long idNo = uie.getIdNo();
		
		String StarLevel = "13";		
		Map<String, Object> creditMap = credit.getCreditInfo(idNo);
		if (creditMap.get("IS_CREDIT").equals("1")) {
			// 信用度等级
			if (creditMap.get("CREDIT_CODE") != null
					&& !creditMap.get("CREDIT_CODE").equals("")) {
				StarLevel = creditMap.get("CREDIT_CODE").toString().trim();
			}
		}
		
		switch(Integer.parseInt(StarLevel)) {
			case 0:StarLevel="12";
			break;
			case 1:StarLevel="11";
			break;
			case 2:StarLevel="10";
			break;
			case 3:StarLevel="09";
			break;
			case 4:StarLevel="08";
			break;
			case 5:StarLevel="07";
			break;
			case 6:StarLevel="06";
			break;
			case 7:StarLevel="05";
			break;
			default:StarLevel="13";
		}
		
		String ARPUScore = "";
		String NetAgeScore = "";
		String dedScore = "";
		List<CreditDetailEntity> detailList= new ArrayList<CreditDetailEntity>();
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("ID_NO", idNo);
		detailList = credit.qCreditDetail(inMap);
		for(CreditDetailEntity cde:detailList) {
			String codeType = cde.getCodeType();
			if(codeType.equals("02")) {
				NetAgeScore=cde.getCodePoint();
			}else if(codeType.equals("03")) {
				ARPUScore=cde.getCodePoint();
			}else if(codeType.equals("04")) {
				dedScore=cde.getCodePoint();
			}
		}
		
		CreditOpenEntity coe = new CreditOpenEntity();
		coe.setARPUScore(ARPUScore);
		coe.setDedScore(dedScore);
		coe.setNetAgeScore(NetAgeScore);
		List<CreditOpenEntity> creditList = new ArrayList<CreditOpenEntity>();
		creditList.add(coe);
		
		outDto.setRetCode(retCode);
		outDto.setRetMsg(retMsg);
		outDto.setQueryTime(DateUtils.getCurDate(DateUtils.DATE_FORMAT_YYYYMMDDHHMISS));
		outDto.setStarLevel(StarLevel);
		//outDto.setCreditList(creditList);
		return outDto;
	}

	/**
	 * @return the credit
	 */
	public ICredit getCredit() {
		return credit;
	}

	/**
	 * @param credit the credit to set
	 */
	public void setCredit(ICredit credit) {
		this.credit = credit;
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
