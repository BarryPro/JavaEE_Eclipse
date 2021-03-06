package com.sitech.acctmgr.atom.impl.acctmng;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.invoice.inter.IPreInvHeader;
import com.sitech.acctmgr.atom.busi.pay.inter.IPreOrder;
import com.sitech.acctmgr.atom.domains.account.ContractInfoEntity;
import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.query.VitualErrEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.domains.user.VirtualGrpEntity;
import com.sitech.acctmgr.atom.dto.acctmng.S8293BatchInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.S8293BatchOutDTO;
import com.sitech.acctmgr.atom.dto.acctmng.S8293DetailInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.S8293DetailOutDTO;
import com.sitech.acctmgr.atom.dto.acctmng.S8293InDTO;
import com.sitech.acctmgr.atom.dto.acctmng.S8293InitInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.S8293InitNameOutDTO;
import com.sitech.acctmgr.atom.dto.acctmng.S8293InitOutDTO;
import com.sitech.acctmgr.atom.dto.acctmng.S8293OutDTO;
import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.common.utils.FtpUtils;
import com.sitech.acctmgr.inter.acctmng.I8293;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.util.DateUtil;

@ParamTypes({ @ParamType(c = S8293InDTO.class, oc = S8293OutDTO.class, m = "add"),
		@ParamType(c = S8293InDTO.class, oc = S8293OutDTO.class, m = "del"),
		@ParamType(c = S8293DetailInDTO.class, oc = S8293DetailOutDTO.class, m = "detailAdd"),
		@ParamType(c = S8293DetailInDTO.class, oc = S8293DetailOutDTO.class, m = "detailDel"),
		@ParamType(c = S8293InitInDTO.class, oc = S8293InitOutDTO.class, m = "query"),
		@ParamType(c = S8293InDTO.class, oc = S8293InitNameOutDTO.class, m = "queryName"),
		@ParamType(c = S8293BatchInDTO.class, oc = S8293BatchOutDTO.class, m = "batchAdd") })
public class S8293 extends AcctMgrBaseService implements I8293 {

	private IGroup group;
	private IRecord record;
	private IControl control;
	private IAccount account;
	private IUser user;
	private IPreInvHeader preInvHeader;
	private IPreOrder preOrder;

	@Override
	public OutDTO add(InDTO inParam) {

		S8293InDTO inDto = (S8293InDTO) inParam;
		String unitId = inDto.getUnitId();
		String unitName = inDto.getUnitName();
		String groupId = inDto.getGroupId();
		String loginNo = inDto.getLoginNo();

		// 取工号归属地市group_id
		ChngroupRelEntity cgre = group.getRegionDistinct(groupId, "2", inDto.getProvinceId());
		String loginGroup = cgre.getParentGroupId();

		// 取操作流水
		long loginAccept = control.getSequence("SEQ_SYSTEM_SN");
		
		long cnt = record.cntVirtualGrp(Long.parseLong(unitId));
		if(cnt>0) {
			throw new BusiException(AcctMgrError.getErrorCode("8293", "00001"), "该集团编码已存在!");
		}

		// 虚拟集团添加
		VirtualGrpEntity vge = new VirtualGrpEntity();
		vge.setGroupId(loginGroup);
		vge.setLoginAccpet(loginAccept);
		vge.setLoginNo(loginNo);
		vge.setUnitId(Long.parseLong(unitId));
		vge.setUnitName(unitName);
		record.saveVirtualGrp(vge);
		
		//取系统时间
		String sCurTime = DateUtil.format(new Date(), "yyyyMMddHHmmss");
				
		//同步CRM统一接触
		Map<String, Object> oprCnttMap = new HashMap<String, Object>();
		oprCnttMap.put("Header", inDto.getHeader());
		oprCnttMap.put("PAY_SN", loginAccept);
		oprCnttMap.put("LOGIN_NO", inDto.getLoginNo());
		oprCnttMap.put("GROUP_ID", inDto.getGroupId());
		oprCnttMap.put("OP_CODE", inDto.getOpCode());
		oprCnttMap.put("REGION_ID", cgre.getRegionCode());
		oprCnttMap.put("OP_NOTE", "虚拟集团添加");
		oprCnttMap.put("TOTAL_FEE", 0);
		oprCnttMap.put("CUST_ID_TYPE", "1");
		oprCnttMap.put("CUST_ID_VALUE", "99999999999");
		oprCnttMap.put("OP_TIME", sCurTime);
		preOrder.sendOprCntt(oprCnttMap);

		// 记录操作记录表
		LoginOprEntity loe = new LoginOprEntity();
		loe.setIdNo(Long.parseLong(unitId));
		loe.setLoginGroup(inDto.getGroupId());
		loe.setLoginNo(inDto.getLoginNo());
		loe.setLoginSn(loginAccept);
		loe.setOpCode(inDto.getOpCode());
		loe.setTotalDate(DateUtils.getCurDay());
		loe.setRemark("虚拟集团信息录入");
		record.saveLoginOpr(loe);

		S8293OutDTO outDto = new S8293OutDTO();
		return outDto;
	}

	@Override
	public OutDTO del(InDTO inParam) {

		S8293InDTO inDto = (S8293InDTO) inParam;
		String unitId = inDto.getUnitId();
		String unitName = inDto.getUnitName();
		String groupId = inDto.getGroupId();
		String loginNo = inDto.getLoginNo();

		// 取工号归属地市group_id
		ChngroupRelEntity cgre = group.getRegionDistinct(groupId, "2", inDto.getProvinceId());
		String loginGroup = cgre.getParentGroupId();

		// 取操作流水
		long loginAccept = control.getSequence("SEQ_SYSTEM_SN");
		
		long cnt = record.cntVirtualGrp(Long.parseLong(unitId));
		if(cnt==0) {
			throw new BusiException(AcctMgrError.getErrorCode("8293", "00010"), "虚拟集团编码不存在!");
		}

		// 虚拟集团删除
		record.delVirtualGrp(unitId, loginAccept);
		
		//取系统时间
		String sCurTime = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		
		//同步CRM统一接触
		Map<String, Object> oprCnttMap = new HashMap<String, Object>();
		oprCnttMap.put("Header", inDto.getHeader());
		oprCnttMap.put("PAY_SN", loginAccept);
		oprCnttMap.put("LOGIN_NO", inDto.getLoginNo());
		oprCnttMap.put("GROUP_ID", inDto.getGroupId());
		oprCnttMap.put("OP_CODE", inDto.getOpCode());
		oprCnttMap.put("REGION_ID", cgre.getRegionCode());
		oprCnttMap.put("OP_NOTE", "虚拟集团信息删除");
		oprCnttMap.put("TOTAL_FEE", 0);
		oprCnttMap.put("CUST_ID_TYPE", "1");
		oprCnttMap.put("CUST_ID_VALUE", "99999999999");
		oprCnttMap.put("OP_TIME", sCurTime);
		preOrder.sendOprCntt(oprCnttMap);

		// 记录操作记录表
		LoginOprEntity loe = new LoginOprEntity();
		loe.setIdNo(Long.parseLong(unitId));
		loe.setLoginGroup(inDto.getGroupId());
		loe.setLoginNo(inDto.getLoginNo());
		loe.setLoginSn(loginAccept);
		loe.setOpCode(inDto.getOpCode());
		loe.setTotalDate(DateUtils.getCurDay());
		loe.setRemark("虚拟集团信息删除");
		record.saveLoginOpr(loe);

		S8293OutDTO outDto = new S8293OutDTO();
		return outDto;
	}

	@Override
	public OutDTO detailAdd(InDTO inParam) {
		// TODO Auto-generated method stub
		S8293DetailInDTO inDto = (S8293DetailInDTO) inParam;
		String unitId = inDto.getUnitId();
		String unitName = inDto.getUnitName();
		String groupId = inDto.getGroupId();
		String loginNo = inDto.getLoginNo();
		String phoneNo = inDto.getPhoneNo();
		long contractNo = inDto.getContractNo();

		ContractInfoEntity cie = account.getConInfo(contractNo);
		String accountType = cie.getContractattType();
		if (!accountType.equals("1") && !accountType.equals("0") && !accountType.equals("A")) {
			throw new BusiException(AcctMgrError.getErrorCode("8293", "00003"), "非个人、集团账户、一点支付账户类型不许进行虚拟集团添加!");
		}
		
		if (accountType.equals("A")) {
			if (!phoneNo.equals("0")) {
				throw new BusiException(AcctMgrError.getErrorCode("8293", "00006"), "一点支付账户手机号码请输入0!");
			}
		}else {
			UserInfoEntity uie = user.getUserInfo(phoneNo);
			long uieContractNo = uie.getContractNo();
			if (accountType.equals("0")) {
				if (uieContractNo == contractNo) {
					if (!account.isDeflaultUser(uieContractNo)) {
						throw new BusiException(AcctMgrError.getErrorCode("8293", "00004"), "个人信息录入不正确!");
					}
				} else {
					throw new BusiException(AcctMgrError.getErrorCode("8293", "00004"), "个人信息录入不正确!");
				}
			}
			if (accountType.equals("1")) {
				log.debug(uieContractNo + "**********" + contractNo);
				if (uieContractNo != contractNo) {
					throw new BusiException(AcctMgrError.getErrorCode("8293", "00005"), "集团账号信息录入不正确!");
				}
			}
		}
		

		// 取工号归属地市group_id
		ChngroupRelEntity cgre = group.getRegionDistinct(groupId, "2", inDto.getProvinceId());
		String loginGroup = cgre.getParentGroupId();

		// 取操作流水
		long loginAccept = control.getSequence("SEQ_SYSTEM_SN");
		
		long cnt = record.cntVirtualGrp(Long.parseLong(unitId));
		if(cnt==0) {
			throw new BusiException(AcctMgrError.getErrorCode("8293", "00010"), "虚拟集团编码不存在!");
		}

		// 虚拟集团成员添加
		VirtualGrpEntity vge = new VirtualGrpEntity();
		vge.setGrpContractNo(String.valueOf(contractNo));
		vge.setGrpPhoneNo(phoneNo);
		vge.setGroupId(loginGroup);
		vge.setLoginAccpet(loginAccept);
		vge.setLoginNo(loginNo);
		vge.setUnitId(Long.parseLong(unitId));
		vge.setUnitName(unitName);
		record.saveVirtualDetail(vge);
		
		//取系统时间
		String sCurTime = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		
		//同步CRM统一接触
		Map<String, Object> oprCnttMap = new HashMap<String, Object>();
		oprCnttMap.put("Header", inDto.getHeader());
		oprCnttMap.put("PAY_SN", loginAccept);
		oprCnttMap.put("LOGIN_NO", inDto.getLoginNo());
		oprCnttMap.put("GROUP_ID", inDto.getGroupId());
		oprCnttMap.put("OP_CODE", inDto.getOpCode());
		oprCnttMap.put("REGION_ID", cgre.getRegionCode());
		oprCnttMap.put("OP_NOTE", "虚拟集团成员添加");
		oprCnttMap.put("TOTAL_FEE", 0);
		oprCnttMap.put("CUST_ID_TYPE", "1");
		oprCnttMap.put("CUST_ID_VALUE", phoneNo);
		oprCnttMap.put("OP_TIME", sCurTime);
		preOrder.sendOprCntt(oprCnttMap);

		// 记录操作记录表
		LoginOprEntity loe = new LoginOprEntity();
		loe.setIdNo(Long.parseLong(unitId));
		loe.setLoginGroup(inDto.getGroupId());
		loe.setLoginNo(inDto.getLoginNo());
		loe.setLoginSn(loginAccept);
		loe.setOpCode(inDto.getOpCode());
		loe.setTotalDate(DateUtils.getCurDay());
		loe.setRemark("虚拟集团明细信息录入");
		record.saveLoginOpr(loe);

		S8293DetailOutDTO outDto = new S8293DetailOutDTO();
		return outDto;
	}

	@Override
	public OutDTO detailDel(InDTO inParam) {

		S8293DetailInDTO inDto = (S8293DetailInDTO) inParam;
		String unitId = inDto.getUnitId();
		String unitName = inDto.getUnitName();
		String groupId = inDto.getGroupId();
		String loginNo = inDto.getLoginNo();
		String phoneNo = inDto.getPhoneNo();
		long contractNo = inDto.getContractNo();

		// 取工号归属地市group_id
		ChngroupRelEntity cgre = group.getRegionDistinct(groupId, "2", inDto.getProvinceId());
		String loginGroup = cgre.getParentGroupId();

		// 取操作流水
		long loginAccept = control.getSequence("SEQ_SYSTEM_SN");

		record.delVirtualDetail(unitId, phoneNo, contractNo, loginAccept);
		
		//取系统时间
		String sCurTime = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		
		//同步CRM统一接触
		Map<String, Object> oprCnttMap = new HashMap<String, Object>();
		oprCnttMap.put("Header", inDto.getHeader());
		oprCnttMap.put("PAY_SN", loginAccept);
		oprCnttMap.put("LOGIN_NO", inDto.getLoginNo());
		oprCnttMap.put("GROUP_ID", inDto.getGroupId());
		oprCnttMap.put("OP_CODE", inDto.getOpCode());
		oprCnttMap.put("REGION_ID", cgre.getRegionCode());
		oprCnttMap.put("OP_NOTE", "虚拟集团明细信息删除");
		oprCnttMap.put("TOTAL_FEE", 0);
		oprCnttMap.put("CUST_ID_TYPE", "1");
		oprCnttMap.put("CUST_ID_VALUE", phoneNo);
		oprCnttMap.put("OP_TIME", sCurTime);
		preOrder.sendOprCntt(oprCnttMap);


		// 记录操作记录表
		LoginOprEntity loe = new LoginOprEntity();
		loe.setIdNo(Long.parseLong(unitId));
		loe.setLoginGroup(inDto.getGroupId());
		loe.setLoginNo(inDto.getLoginNo());
		loe.setLoginSn(loginAccept);
		loe.setOpCode(inDto.getOpCode());
		loe.setTotalDate(DateUtils.getCurDay());
		loe.setRemark("虚拟集团明细信息删除");
		record.saveLoginOpr(loe);

		S8293DetailOutDTO outDto = new S8293DetailOutDTO();
		return outDto;
	}

	@Override
	public OutDTO query(InDTO inParam) {

		List<VirtualGrpEntity> virtualList = new ArrayList<VirtualGrpEntity>();

		S8293InitInDTO inDto = (S8293InitInDTO) inParam;
		String unitInparam = inDto.getUniInparam();
		String queryType = inDto.getQueryType();

		if (queryType.equals("1")) {
			virtualList = preInvHeader.getUserInfoByVtrBloc(Long.parseLong(unitInparam), null);
		} else if (queryType.equals("2")) {
			virtualList = preInvHeader.getUserInfoByVtrBloc(0, unitInparam);
		}

		S8293InitOutDTO outDto = new S8293InitOutDTO();
		outDto.setVirtualInfo(virtualList);
		return outDto;
	}

	@Override
	public OutDTO queryName(InDTO inParam) {

		S8293InDTO inDto = (S8293InDTO) inParam;
		String unitId = inDto.getUnitId();

		String unitName = preInvHeader.getVirtualName(Long.parseLong(unitId));

		S8293InitNameOutDTO outDto = new S8293InitNameOutDTO();
		outDto.setUnitName(unitName);
		return outDto;
	}

	@Override
	public OutDTO batchAdd(InDTO inParam) {

		Map<String, Object> outMapTmp = new HashMap<String, Object>();
		List<VitualErrEntity> errList = new ArrayList<VitualErrEntity>();

		S8293BatchInDTO inDto = (S8293BatchInDTO) inParam;
		String relPath = inDto.getRelPath();

		try {
			outMapTmp = FtpUtils.download(relPath);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String fileName = outMapTmp.get("FILENAME").toString();
		String enCode = outMapTmp.get("ENCODE").toString();

		InputStreamReader isr = null;
		try {
			isr = new InputStreamReader(new FileInputStream(fileName), enCode);
		} catch (UnsupportedEncodingException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		} catch (FileNotFoundException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		BufferedReader reader = null;
		System.out.println("以行为单位读取文件内容，一次读一整行：");
		reader = new BufferedReader(isr);
		String tempString = null;
		int line = 1;
		long file_no = 0;
		long err_no = 0;
		try {
			while ((tempString = reader.readLine()) != null) {
				if(tempString.isEmpty()) {
					continue;
				}
				// 显示行号
				System.out.println("line " + line + ": " + tempString);
				tempString.trim();
				
				file_no++;

				String[] array = tempString.split("\\|");
				if(array.length!=6) {
					throw new BusiException(AcctMgrError.getErrorCode("8293", "00009"), "第"+file_no+"行数据格式不正确！");
				}
				String vitualNo = array[0];
				String vitualName = array[1];
				String loginNo = array[2];
				String regionCode = array[3];
				String phoneNo = array[4];
				long contractNo = Long.parseLong(array[5].trim());
				

				ContractInfoEntity cie = account.getConInfo(contractNo);
				String accountType = cie.getContractattType();
				VitualErrEntity vee = new VitualErrEntity();
				if (!accountType.equals("1") && !accountType.equals("0")) {
					vee.setPhoneNo(phoneNo);
					vee.setErrInfo("非集团、个人号码不可以录入");
					err_no++;
					errList.add(vee);
					continue;
				}

				if (accountType.equals("0")) {
					UserInfoEntity uie = user.getUserInfo(phoneNo);
					long uieContractNo = uie.getContractNo();
					if (uieContractNo != contractNo) {
						vee.setPhoneNo(phoneNo);
						vee.setErrInfo("个人类型账号录入信息不存在");
						err_no++;
						errList.add(vee);
						continue;
					}
				}
				if (accountType.equals("1")) {
					if (account.isGrpCon(contractNo)) {
						vee.setPhoneNo(phoneNo);
						vee.setErrInfo("集团信息不存在");
						err_no++;
						errList.add(vee);
						continue;
					}
				}

				long cnt = record.cntVirtualGrp(Long.parseLong(vitualNo));
				if(cnt==0) {
					vee.setPhoneNo(phoneNo);
					vee.setErrInfo("虚拟集团编码不存在");
					err_no++;
					errList.add(vee);
					continue;
				}
				
				// 虚拟集团成员添加
				VirtualGrpEntity vge = new VirtualGrpEntity();
				vge.setGrpContractNo(String.valueOf(contractNo));
				vge.setGrpPhoneNo(phoneNo);
				vge.setGroupId(regionCode);
				vge.setLoginAccpet(control.getSequence("SEQ_SYSTEM_SN"));
				vge.setLoginNo(loginNo);
				vge.setUnitId(Long.parseLong(vitualNo));
				vge.setUnitName(vitualName);
				try {
					record.saveVirtualDetail(vge);
				} catch (BusiException e) {
					vee.setPhoneNo(phoneNo);
					vee.setErrInfo("已录入过");
					err_no++;
					errList.add(vee);
					continue;
				}				

			}
		} catch (NumberFormatException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		try {
			reader.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		// 取操作流水
		long loginAccept = control.getSequence("SEQ_SYSTEM_SN");
		
		//取系统时间
		String sCurTime = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		
		// 取工号归属地市group_id
		ChngroupRelEntity cgre = group.getRegionDistinct(inDto.getGroupId(), "2", inDto.getProvinceId());
		String loginGroup = cgre.getParentGroupId();
		
		//同步CRM统一接触
		Map<String, Object> oprCnttMap = new HashMap<String, Object>();
		oprCnttMap.put("Header", inDto.getHeader());
		oprCnttMap.put("PAY_SN", loginAccept);
		oprCnttMap.put("LOGIN_NO", inDto.getLoginNo());
		oprCnttMap.put("GROUP_ID", inDto.getGroupId());
		oprCnttMap.put("OP_CODE", inDto.getOpCode());
		oprCnttMap.put("REGION_ID", cgre.getRegionCode());
		oprCnttMap.put("OP_NOTE", "虚拟集团信息批量录入");
		oprCnttMap.put("TOTAL_FEE", 0);
		oprCnttMap.put("CUST_ID_TYPE", "1");
		oprCnttMap.put("CUST_ID_VALUE", "99999999999");
		oprCnttMap.put("OP_TIME", sCurTime);
		preOrder.sendOprCntt(oprCnttMap);
		
		// 记录操作记录表
		LoginOprEntity loe = new LoginOprEntity();
		loe.setIdNo(0);
		loe.setLoginGroup(inDto.getGroupId());
		loe.setLoginNo(inDto.getLoginNo());
		loe.setLoginSn(loginAccept);
		loe.setOpCode(inDto.getOpCode());
		loe.setTotalDate(DateUtils.getCurDay());
		loe.setRemark("虚拟集团信息批量录入");
		record.saveLoginOpr(loe);

		S8293BatchOutDTO outDto = new S8293BatchOutDTO();
		outDto.setFileNo(file_no);
		outDto.setSuccessNo(file_no - err_no);
		outDto.setLoseNo(err_no);
		outDto.setErrList(errList);
		return outDto;
	}

	/**
	 * @return the group
	 */
	public IGroup getGroup() {
		return group;
	}

	/**
	 * @param group
	 *            the group to set
	 */
	public void setGroup(IGroup group) {
		this.group = group;
	}

	/**
	 * @return the record
	 */
	public IRecord getRecord() {
		return record;
	}

	/**
	 * @param record
	 *            the record to set
	 */
	public void setRecord(IRecord record) {
		this.record = record;
	}

	/**
	 * @return the control
	 */
	public IControl getControl() {
		return control;
	}

	/**
	 * @param control
	 *            the control to set
	 */
	public void setControl(IControl control) {
		this.control = control;
	}

	/**
	 * @return the account
	 */
	public IAccount getAccount() {
		return account;
	}

	/**
	 * @param account
	 *            the account to set
	 */
	public void setAccount(IAccount account) {
		this.account = account;
	}

	/**
	 * @return the user
	 */
	public IUser getUser() {
		return user;
	}

	/**
	 * @param user
	 *            the user to set
	 */
	public void setUser(IUser user) {
		this.user = user;
	}

	/**
	 * @return the preInvHeader
	 */
	public IPreInvHeader getPreInvHeader() {
		return preInvHeader;
	}

	/**
	 * @param preInvHeader
	 *            the preInvHeader to set
	 */
	public void setPreInvHeader(IPreInvHeader preInvHeader) {
		this.preInvHeader = preInvHeader;
	}

	/**
	 * @return the preOrder
	 */
	public IPreOrder getPreOrder() {
		return preOrder;
	}

	/**
	 * @param preOrder the preOrder to set
	 */
	public void setPreOrder(IPreOrder preOrder) {
		this.preOrder = preOrder;
	}

}
