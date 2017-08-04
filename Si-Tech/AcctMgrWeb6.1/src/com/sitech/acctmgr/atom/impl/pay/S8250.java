package com.sitech.acctmgr.atom.impl.pay;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.sitech.acctmgr.atom.domains.balance.MkYxzfactEntity;
import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.base.LoginEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.dto.pay.S8250DeleteRestMoneyInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8250DeleteRestMoneyOutDTO;
import com.sitech.acctmgr.atom.dto.pay.S8250QueryInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8250CfmInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8250CfmOutDTO;
import com.sitech.acctmgr.atom.dto.pay.S8250QueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.ILogin;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IRegionConfig;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.inter.pay.I8250;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.util.DateUtil;

@ParamTypes({ 
	@ParamType(m="confirm",c= S8250CfmInDTO.class,oc=S8250CfmOutDTO.class),
	
	@ParamType(m="query",c= S8250QueryInDTO.class,oc=S8250QueryOutDTO.class),
	@ParamType(m="deleteRestMoney",c= S8250DeleteRestMoneyInDTO.class,oc=S8250DeleteRestMoneyOutDTO.class)
})

public class S8250 extends AcctMgrBaseService implements I8250 {

	/*
	 * private String regionCode; private String opCode;
	 */
	private ILogin login;
	private IRegionConfig regionConfig;
	private IUser user;
	private IRecord record;// 操作记录
	private IControl control;
	private IGroup	group;


	@Override
	public OutDTO confirm(InDTO inParam) {

		S8250CfmInDTO inDto = (S8250CfmInDTO) inParam;
		String regionCode = "";
		String opCode = "";
		
		if( StringUtils.isEmptyOrNull(inDto.getGroupId()) ){
			LoginEntity  loginEntity = login.getLoginInfo(inDto.getLoginNo(), inDto.getProvinceId());
			inDto.setGroupId(loginEntity.getGroupId());
		}
		ChngroupRelEntity chngroupRelInfo = group.getRegionDistinct(inDto.getGroupId(), "2", inDto.getProvinceId());
		
		regionCode = inDto.getRegionCode();
		opCode = inDto.getOpCode();
		//返费月数
		int restMonth = Integer.parseInt(inDto.getRestMonth());
		
		long restPay = Long.parseLong(inDto.getRestPay());
		//消费月数
		int expenseMonth = Integer.parseInt(inDto.getExpenseMonth());
		//是否累计到次月
		String accumulateType = inDto.getAccumulateType();
		
		/**
		 * 工号业务办理权限验证未完成
		 */
		
		// 1. 根据入参的region_code 判断是否已经录入过 如果已录入则报错
		if (regionConfig.isRegion(regionCode, opCode)) {
			log.info("地市 配置记录已存在");
			throw new BusiException(AcctMgrError.getErrorCode("8250", "00001"),
					"地市 配置记录已存在!");
		}
		
		String logionRegionCode = chngroupRelInfo.getRegionCode();
		if(!logionRegionCode.equals(regionCode)){
			log.info("工号归属与所选择地市不一致！");
			throw new BusiException(AcctMgrError.getErrorCode("8250", "00002"),
					"工号归属与所选择地市不一致！");
		}
		
		if(restMonth > expenseMonth ){
			log.info("消费月数不能小于返费月数！ ");
			throw new BusiException(AcctMgrError.getErrorCode("8250", "00004"),
					"消费月数不能小于返费月数！ ");
		}
		
		//消费月数大于返费月数时，只能选择累积到次月！ 
		if(expenseMonth > restMonth && 	!"1".equals(accumulateType) ){
			log.info("消费月数大于返费月数时，只能选择累积到次月！  ");
			throw new BusiException(AcctMgrError.getErrorCode("8250", "00005"),
					"消费月数大于返费月数时，只能选择累积到次月！  ");
		}
		
		String sCurDate = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		String totalDate = sCurDate.substring(0, 8);

		long loginAccept = control.getSequence("SEQ_SYSTEM_SN");

		MkYxzfactEntity mkyxz = new MkYxzfactEntity();

		
		mkyxz.setOpCode(opCode);
		mkyxz.setRegionCode(regionCode);
		mkyxz.setLoginNo(inDto.getLoginNo());
		mkyxz.setRestTotalPay(restMonth * restPay);
		mkyxz.setAccumulateType(inDto.getAccumulateType());
		mkyxz.setRestPayType(inDto.getRestPayType());
		mkyxz.setRestMonth(restMonth);
		mkyxz.setRestPay(restPay);
		mkyxz.setExpenseMonth(Integer.parseInt(inDto.getExpenseMonth()));
		mkyxz.setLoginAccept(loginAccept);
		mkyxz.setLjPay(restPay);
		mkyxz.setLjPayType(inDto.getRestPayType());
		mkyxz.setOpTime(sCurDate);
		
		// 2. 插入 BAL_MK_YXZFACT
		regionConfig.saveMkYxzfact(mkyxz);

		// 记录营业员操作日志
		LoginOprEntity in = new LoginOprEntity();
		/*
		 * in.setIdNo(userInfo.getIdNo()); in.setBrandId(userInfo.getBrandId());
		 * in.setPhoneNo(userInfo.getPhoneNo());
		 */
		in.setPayType("");
		in.setPayFee(0);
		in.setLoginSn(loginAccept);
		in.setLoginNo(inDto.getLoginNo());
		in.setLoginGroup(inDto.getGroupId());
		in.setOpCode("8250");
		in.setTotalDate(Long.parseLong(totalDate));
		in.setRemark("8250配置地市信息成功！");
		record.saveLoginOpr(in);

		S8250CfmOutDTO outDto = new S8250CfmOutDTO();
		return outDto;
	}

	@Override
	public OutDTO query(InDTO inParam) {

		S8250QueryInDTO inDto = (S8250QueryInDTO) inParam;

		String workNo = inDto.getWorkNo();
		String regionCode = inDto.getRegionCode();
		String selectFlag = inDto.getSelectFlag();
		
		
		List<MkYxzfactEntity> mk = new ArrayList<>();
		if("2".equals(selectFlag)){
			if("Value".equals(regionCode)){
				throw new BusiException(AcctMgrError.getErrorCode("8250", "00007"),
						"请选择地市！  ");
			}else{
				//按地市查询
				mk = regionConfig.getMkYxzfactInfo(null, regionCode,inDto.getProvinceId());
			}
			
		}else if("1".equals(selectFlag)){
			//按工号查询
			if(StringUtils.isEmpty(workNo)){
				throw new BusiException(AcctMgrError.getErrorCode("8250", "00008"),
						"请输入工号！  ");
			}else{
				mk = regionConfig.getMkYxzfactInfo(workNo, null,inDto.getProvinceId());
			}
		}else if("0".equals(selectFlag)){
			log.info("请选择检索条件！");
			throw new BusiException(AcctMgrError.getErrorCode("8250", "00006"),
					"请选择检索条件！  ");
		}
		
		S8250QueryOutDTO outDto = new S8250QueryOutDTO();
		
		outDto.setOutList(mk);

		return outDto;

	}

	@Override
	public OutDTO deleteRestMoney(InDTO inParam) {
		
		S8250DeleteRestMoneyInDTO inDto = (S8250DeleteRestMoneyInDTO) inParam;
		
		// 1.传入参数 OpCode LoginNo RrgionCode  loginAccept
		String opCode = inDto.getOpCode1();
		String loginNo = inDto.getLoginNo();
		String workNo = inDto.getWorkNo();
		String regionCode = inDto.getRegionCode();
		Long loginAccept = inDto.getLoginAccept();
		
		//是否跨地市删除未完成
		if( StringUtils.isEmptyOrNull(inDto.getGroupId()) ){
			LoginEntity  loginEntity = login.getLoginInfo(loginNo, inDto.getProvinceId());
			inDto.setGroupId(loginEntity.getGroupId());
		}
		
		//获取工号归属地市
		ChngroupRelEntity chngroupRelInfo = group.getRegionDistinct(inDto.getGroupId(), "2", inDto.getProvinceId());
		String logionRegionCode = chngroupRelInfo.getRegionCode();
		
		if(!logionRegionCode.equals(regionCode)){
			log.info("工号归属与所选择地市不一致！");
			throw new BusiException(AcctMgrError.getErrorCode("8250", "00003"),
					"工号归属与所选择地市不一致！不能跨地市删除！: " + logionRegionCode+"当前工号归属地："+chngroupRelInfo.getRegionName());
		}
		// 2.调用方法向历史表插入数据、、3.删除表中数据
		regionConfig.deleteMkYxzfactInfo(workNo, regionCode, opCode,loginAccept);

		// 4.记录操作记录
		
		String sCurDate = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		String totalDate = sCurDate.substring(0, 8);
		
		LoginOprEntity in = new LoginOprEntity();
		in.setPayType("");
		in.setPayFee(0);
		in.setLoginSn(loginAccept);
		in.setLoginNo(inDto.getLoginNo());
		in.setLoginGroup(inDto.getGroupId());
		in.setOpCode("8250");
		in.setTotalDate(Long.parseLong(totalDate));
		in.setRemark("8250地市信息配置删除成功！");
		record.saveLoginOpr(in);
		
		S8250DeleteRestMoneyOutDTO outDto = new S8250DeleteRestMoneyOutDTO();
		return outDto;
	}

	public ILogin getLogin() {
		return login;
	}

	public void setLogin(ILogin login) {
		this.login = login;
	}

	public IRegionConfig getRegionConfig() {
		return regionConfig;
	}

	public void setRegionConfig(IRegionConfig regionConfig) {
		this.regionConfig = regionConfig;
	}

	public IUser getUser() {
		return user;
	}

	public void setUser(IUser user) {
		this.user = user;
	}

	public IRecord getRecord() {
		return record;
	}

	public void setRecord(IRecord record) {
		this.record = record;
	}

	public IControl getControl() {
		return control;
	}

	public void setControl(IControl control) {
		this.control = control;
	}

	public IGroup getGroup() {
		return group;
	}

	public void setGroup(IGroup group) {
		this.group = group;
	}
	
}
