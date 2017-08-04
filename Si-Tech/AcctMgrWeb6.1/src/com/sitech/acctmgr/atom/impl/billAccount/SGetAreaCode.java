package com.sitech.acctmgr.atom.impl.billAccount;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.sitech.acctmgr.atom.domains.query.ChatTypeEntity;
import com.sitech.acctmgr.atom.domains.query.ProvCityListEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.query.SGetAreaCodeInDTO;
import com.sitech.acctmgr.atom.dto.query.SGetAreaCodeOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBillAccount;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.billAccount.IGetAreaCode;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ 
	@ParamType(m = "query", c = SGetAreaCodeInDTO.class, oc = SGetAreaCodeOutDTO.class)
})
public class SGetAreaCode extends AcctMgrBaseService implements IGetAreaCode{

	protected IBillAccount billAccount;
	protected IUser user;
	
	@Override
	public OutDTO query(InDTO inParam) {
		
		SGetAreaCodeInDTO inDto = (SGetAreaCodeInDTO)inParam;
		String phoneNo = inDto.getPhoneNo();
		String phoneNoSeven = "";
		String phoneNoEight = "";
		String phoneHead = "";
		
		if(phoneNo.length()>7) {
			phoneNoSeven = phoneNo.substring(0, 7);
			phoneNoEight = phoneNo.substring(0, 8);
			phoneHead = billAccount.getPhoneHead(phoneNoSeven, phoneNoEight);
		}else {
			phoneHead = phoneNo.substring(0, 7);
		}
		
		String homeArea="";
		ProvCityListEntity pcle = billAccount.getProvCityInfo(phoneHead);
		String provCode = pcle.getProvCode();
		String provName = pcle.getProvName();
		String longCode = pcle.getLongCode();
		String cityName = pcle.getCityName();
		
		if(longCode.equals(provCode.substring(0,longCode.length()))&&provName.equals(cityName)) {
			homeArea = cityName+"市";
		}else {
			homeArea = provName + "省" +cityName + "市";
		}
		
		/*0 代表 非本省的 非移动号码  1 代表 本省移动号码  2 代表  非本省的 移动号码*/
		String HLJphone = "0";
		UserInfoEntity uie = user.getUserInfo(phoneNo);
		if(uie!=null){
			HLJphone="1";
		}else {
			List<ChatTypeEntity> resultList = billAccount.getChatTypeInfo();
			//正则表达式匹配
			for(ChatTypeEntity cte:resultList) {
				String regEx = cte.getCharacterStr();
				Pattern p=Pattern.compile(regEx); 
				Matcher m=p.matcher(phoneNo);
				if(m.find()) {
					HLJphone="2";
					break;
				}
			}
		}
		
		SGetAreaCodeOutDTO outDto = new SGetAreaCodeOutDTO();
		outDto.setCityName(cityName);
		outDto.setHljFlag(HLJphone);
		outDto.setHomeArea(homeArea);
		outDto.setLongCode(longCode);
		outDto.setPhoneNo(phoneNo);
		outDto.setProvCode(provCode);
		outDto.setProvName(provName);		
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
