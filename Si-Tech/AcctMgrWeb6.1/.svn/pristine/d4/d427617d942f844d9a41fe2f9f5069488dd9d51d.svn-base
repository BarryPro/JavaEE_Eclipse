package com.sitech.acctmgr.atom.impl.cct;

import java.util.HashMap;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.cct.CctDynamicCreditInfoEntity;
import com.sitech.acctmgr.atom.domains.cct.CreditAdjEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.cct.SDnyCreditCfmInDTO;
import com.sitech.acctmgr.atom.dto.cct.SDnyCreditCfmOutDTO;
import com.sitech.acctmgr.atom.dto.cct.SDnyCreditQryInDTO;
import com.sitech.acctmgr.atom.dto.cct.SDnyCreditQryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.ICredit;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.inter.cct.IDnyCreditOpr;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ @ParamType(c = SDnyCreditQryInDTO.class, m = "query", oc = SDnyCreditQryOutDTO.class),
		@ParamType(c = SDnyCreditCfmInDTO.class, m = "cfm", oc = SDnyCreditCfmOutDTO.class) })
public class SDnyCreditOpr extends AcctMgrBaseService implements IDnyCreditOpr {

	ICredit credit;
	IControl control;
	IRecord record;
	IUser user;
	IGroup group;

	@Override
	public OutDTO query(InDTO inParam) {
		SDnyCreditQryInDTO inDto = (SDnyCreditQryInDTO) inParam;
		String phoneNo = "";
		long idNo = 0;
		if (StringUtils.isNotEmpty(inDto.getPhoneNo())) {
			phoneNo = inDto.getPhoneNo();
			UserInfoEntity userEnt = user.getUserInfo(phoneNo);
			idNo = userEnt.getIdNo();
		}
		if (inDto.getIdNo() > 0) {
			idNo = inDto.getIdNo();
		}
		// long idNo = inDto.getIdNo();
		long limitOwe = 0;
		String expTime = "";
		// 从cct_dynamiccredit_info 表中查询limit_owe，expire_time
		CctDynamicCreditInfoEntity creditEnt = credit.getDynamicCredit(idNo);
		if (creditEnt != null) {
			limitOwe = creditEnt.getLimitOwe();
			expTime = creditEnt.getExpTime();
		} /* else { throw new BusiException(AcctMgrError.getErrorCode("0000", "00013"), "该用户不是动态信用度用户"); } */
		log.debug(creditEnt + ">>>>>>>>>>>>>>>>");
		SDnyCreditQryOutDTO outDto = new SDnyCreditQryOutDTO();

		// 设置出参credit_code和limitOwe
		outDto.setLimitOwe(limitOwe);
		outDto.setExpireTime(expTime);
		outDto.setIdNo(idNo);

		return outDto;
	}

	@Override
	public OutDTO cfm(InDTO inParam) {

		SDnyCreditCfmInDTO inDTO = (SDnyCreditCfmInDTO) inParam;

		Map<String, Object> inMap = new HashMap<String, Object>();
		long idNo = inDTO.getIdNo();
		long limitOwe = inDTO.getLimitOwe();
		// String creditCode = inDTO.getCreditCode();
		String expireTime = inDTO.getExpireTime();
		String opNote = inDTO.getOpNote();
		long loginAccept = inDTO.getLoginAccept();
		String opCode = inDTO.getOpCode();
		log.debug("入参流水：" + loginAccept);

		String loginNo = inDTO.getLoginNo();
		String groupId = inDTO.getGroupId();
		long userLimitOwe = 0;
		// 获取当前时间：
		Map<String, Object> outMap = control.getSysDate();
		String totalDate = (String) outMap.get("CUR_DATE");

		// 查询用户信息
		UserInfoEntity userEntity = user.getUserEntity(idNo, "", 0l, true);
		// 查询用户归属地市
		ChngroupRelEntity chnGroupRel = group.getRegionDistinct(userEntity.getGroupId(), "2", inDTO.getProvinceId());
		// TODO:智能网神州行移植用户不允许办理此业务
		// TODO:该用户为一卡多号副卡不允许办理该业务！
		// TODO:物联网用户不能办理此业务

		// opType Y:修改 N：申请 R：取消
		String opType = inDTO.getOpType();

		// 获取用户的信用度
		CctDynamicCreditInfoEntity dynamicCredit = credit.getDynamicCredit(idNo);
		// CreditInfoEntity creditEnt = credit.getCreditInfoByIdNo(idNo, "1");
		if (dynamicCredit != null) {
			userLimitOwe = dynamicCredit.getLimitOwe();
		} else {
			userLimitOwe = 0;
		}

		// 获取操作流水
		if (loginAccept == 0) {
			loginAccept = control.getSequence("SEQ_SYSTEM_SN");
		}
		// TODO：判断是否为标准神州行用户，标准神州行用户不允许办理

		CreditAdjEntity creditAdjEntity = new CreditAdjEntity();
		creditAdjEntity.setIdNo(idNo);
		creditAdjEntity.setOldLimitOwe(userLimitOwe);
		creditAdjEntity.setNewLimitOwe(limitOwe);
		creditAdjEntity.setLoginNo(loginNo);
		creditAdjEntity.setExpireTime(expireTime);
		creditAdjEntity.setLoginAccept(loginAccept);
		creditAdjEntity.setPhoneNo(userEntity.getPhoneNo());
		creditAdjEntity.setRegionId(chnGroupRel.getRegionCode());
		creditAdjEntity.setOpCode(opCode);
		log.debug("loginAccept:" + loginAccept);
		if (opType.equals("Y")) {
			log.debug(loginNo + "给" + idNo + "用户修改动态信用度");

			creditAdjEntity.setStatus(opType);
			if (opNote == null || opNote.equals("")) {
				opNote = loginNo + "给" + idNo + "用户修改动态信用度";
			}
			creditAdjEntity.setOpNote(opNote);
			credit.uDnyCredit(creditAdjEntity);

		} else if (opType.equals("N")) {
			creditAdjEntity.setStatus(opType);
			log.debug(loginNo + "给" + idNo + "用户申请动态信用度");

			// 为了防止再次申请因信誉度变零而被停机，如果用户信用度>0，不能申请
			if (userLimitOwe > 0) {
				// throw busi
				throw new BusiException(AcctMgrError.getErrorCode("0000", "00012"), "该用户有信用度，不能重复申请");
			}

			if (opNote == null || opNote.equals("")) {
				opNote = loginNo + "给" + idNo + "用户申请动态信用度";
			}
			creditAdjEntity.setOpNote(opNote);

			credit.applyDnyCredit(creditAdjEntity);

		} else {
			creditAdjEntity.setStatus(opType);
			log.debug(loginNo + "给" + idNo + "用户取消动态信用度");

			// 失效日期
			creditAdjEntity.setExpireTime("20160101");

			if (opNote == null || opNote.equals("")) {
				opNote = loginNo + "给" + idNo + "用户取消动态信用度";
			}
			creditAdjEntity.setOpNote(opNote);
			credit.cancleDnyCredit(creditAdjEntity);

		}
		// 记录营业员操作日志表
		LoginOprEntity in = new LoginOprEntity();
		in.setIdNo(idNo);
		in.setBrandId("");
		in.setPhoneNo("");
		// in.setPayType(0);
		in.setPayFee(0);
		in.setLoginSn(loginAccept);
		in.setLoginNo(loginNo);
		in.setLoginGroup(groupId);
		in.setOpCode(inDTO.getOpCode());
		in.setTotalDate(Integer.parseInt(totalDate));
		in.setRemark(opNote);
		log.debug(">>>>>>" + in);
		record.saveLoginOpr(in);
		SDnyCreditCfmOutDTO outDTO = new SDnyCreditCfmOutDTO();

		return outDTO;
	}

	public ICredit getCredit() {
		return credit;
	}

	public void setCredit(ICredit credit) {
		this.credit = credit;
	}

	public IControl getControl() {
		return control;
	}

	public void setControl(IControl control) {
		this.control = control;
	}

	public IRecord getRecord() {
		return record;
	}

	public void setRecord(IRecord record) {
		this.record = record;
	}

	public IUser getUser() {
		return user;
	}

	public void setUser(IUser user) {
		this.user = user;
	}

	public IGroup getGroup() {
		return group;
	}

	public void setGroup(IGroup group) {
		this.group = group;
	}

}
