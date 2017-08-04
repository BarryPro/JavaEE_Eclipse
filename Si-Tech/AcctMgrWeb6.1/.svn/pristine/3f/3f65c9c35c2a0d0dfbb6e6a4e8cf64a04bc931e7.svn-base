package com.sitech.acctmgr.atom.impl.query;

import java.util.HashMap;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.user.ServAddNumEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.query.STransNoConversionInDTO;
import com.sitech.acctmgr.atom.dto.query.STransNoConversionOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.comp.busi.LoginCheck;
import com.sitech.acctmgr.inter.query.ITransNo;
import com.sitech.jcf.core.exception.BaseException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;



@ParamTypes({
	@ParamType(m="conversion",c= STransNoConversionInDTO.class,oc=STransNoConversionOutDTO.class)

})
public class STransNo extends AcctMgrBaseService implements ITransNo{
	
	private IUser user;
	

	@Override
	public OutDTO conversion(InDTO inParam) {
		// TODO Auto-generated method stub
		
		/*获取入参信息*/
		STransNoConversionInDTO inDto = (STransNoConversionInDTO)inParam;
		log.info("inDto---------->"+inDto.getMbean());
		
		String inNo = inDto.getInNo();
		String pageFlag = inDto.getPageFlag();
		
		
		/* 获取服务号码 */
		String[] addBbrTypes = new String[]{"01","02","16"};
		ServAddNumEntity servAddNumEnt = user.getPhoneNoByAsn(inNo, addBbrTypes);
		String phoneNo = servAddNumEnt.getPhoneNo();
		String addNbrType = servAddNumEnt.getAddNbrType();
		
	    /*获取账户信息*/
		
		UserInfoEntity baseInfo = user.getUserInfo(phoneNo) ;
		Long contractNo = baseInfo.getContractNo();
		String brandId = baseInfo.getBrandId();
		
	/*	//
		if(pageFlag.equals("0")){
			if(!(brandId.contains("kh"))){
			throw new BaseException(AcctMgrError.getErrorCode("8008", "00018"),"非kh品牌，无法退费!");
			}
			铁通宽带校验工号权限
			Map<String,Object> inMapTmp = new HashMap<String, Object>();
			inMapTmp.put("LOGIN_NO", inDto.getLoginNo());
			inMapTmp.put("BUSI_CODE", "BBMA0272");
			LoginCheck logincheck = new LoginCheck();
			boolean powerFlag = logincheck.pchkFuncPower(inDto.getHeader(), inMapTmp);
			log.info("powerFlag-------------->"+powerFlag);
			
		}else if(brandId.contains("kh") && bbdType.equals("2")){
			throw new BaseException(AcctMgrError.getErrorCode("8008", "00019"),"kh品牌不能在此模块补收！");
		}*/
		
		
		STransNoConversionOutDTO outDto = new STransNoConversionOutDTO();
		if(addNbrType.equals("02")){
			outDto.setNoType("宽带号码");
			if(brandId.contains("kh") && pageFlag.equals("0") && addNbrType.equals("02")){
				throw new BaseException(AcctMgrError.getErrorCode("8008", "00019"),"kh品牌不能在此模块补收！");
			}
		}else if(addNbrType.equals("16")){
			outDto.setNoType("物联网号码");
		}else if(addNbrType.equals("01")){
			outDto.setNoType("号码本身");
		}
		
		outDto.setNoTypeId(addNbrType);
		outDto.setPhoneNo(phoneNo);
		
		log.info("outDto---------->"+outDto.toJson());
		return outDto;
	}


	public IUser getUser() {
		return user;
	}


	public void setUser(IUser user) {
		this.user = user;
	}

}
