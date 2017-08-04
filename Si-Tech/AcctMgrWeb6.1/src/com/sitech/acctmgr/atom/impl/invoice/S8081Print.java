package com.sitech.acctmgr.atom.impl.invoice;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.invoice.inter.IPrintDataXML;
import com.sitech.acctmgr.atom.domains.account.ContractDeadInfoEntity;
import com.sitech.acctmgr.atom.domains.account.ContractInfoEntity;
import com.sitech.acctmgr.atom.domains.base.LoginEntity;
import com.sitech.acctmgr.atom.domains.cust.CustInfoEntity;
import com.sitech.acctmgr.atom.domains.pay.PayMentEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.domains.user.UserBrandEntity;
import com.sitech.acctmgr.atom.domains.user.UserDeadEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.invoice.S8081PrintInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8081PrintOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.atom.entity.inter.ICust;
import com.sitech.acctmgr.atom.entity.inter.ILogin;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.acctmgr.inter.invoice.I8081Print;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ @ParamType(c = S8081PrintInDTO.class, oc = S8081PrintOutDTO.class, m = "print") })
public class S8081Print implements I8081Print {
	private IRecord record;
	private IUser user;
	private ICust cust;
	private IAccount account;
	private ILogin login;
	private IPrintDataXML printDataXml;

	@Override
	public OutDTO print(InDTO inParam) {
		S8081PrintInDTO inDto = (S8081PrintInDTO) inParam;
		long paySn = inDto.getPaySn();
		int curYm = DateUtils.getCurYm();
		// 根据paySN查询退费记录
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("SUFFIX", curYm);
		inMap.put("PAY_SN", paySn);
		List<PayMentEntity> payMentListTmp = record.getPayMentList(inMap);
		// 手机号码，客户名称，客户地址，证件号码，用户品牌，账户名称，账户号码，退预存款金额 工号，工号名称，时间
		PayMentEntity payment = payMentListTmp.get(0);
		String phoneNo = payment.getPhoneNo();
		long contractNo = payment.getContractNo();
		long idNo = payment.getIdNo();
		long custId = 0;
		String custName = "";
		String custAddress = "";
		String idIccid = "";
		String brandName = "";
		String brandId = "";
		String contractName = "";
		String loginNo = inDto.getLoginNo();
		String loginName = "";
		long refundFee = 0;
		// 获取当前时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
		String printDate = df.format(new Date());
		UserInfoEntity userInfo = user.getUserEntityByPhoneNo(phoneNo, false);
		if(userInfo==null){
			// 查询离网的
			List<UserDeadEntity> userDeadList = user.getUserdeadEntity(phoneNo, idNo, 0l);
			if (userDeadList.size() == 0) {
				throw new BusiException(AcctMgrError.getErrorCode("0000", "00003"), "查询用户信息错误");
			}
			custId = userDeadList.get(0).getCustId();

		} else {
			custId = userInfo.getCustId();
		}
		// 查询客户信息（客户名称，客户地址，身份证件）
		CustInfoEntity custInfo = cust.getCustInfo(custId, "");
		custName = custInfo.getCustName();
		custAddress = custInfo.getCustAddress();
		idIccid = custInfo.getIdIccid();
		// 查询账户信息(账户名称）
		ContractInfoEntity contractInfo = account.getConInfo(contractNo, false);
		if (contractInfo == null) {
			// 查询离网账户信息
			ContractDeadInfoEntity contractDeadInfo = account.getConDeadInfo(contractNo);
			contractName = contractDeadInfo.getContractName();
		} else {
			contractName = contractInfo.getContractName();
		}

		// 查询用户品牌
		UserBrandEntity userBrand = user.getUserBrandRel(idNo, false);
		if (userBrand != null) {
			brandName = userBrand.getBrandName();
			brandId = userBrand.getBrandId();
		}
		// 工号名称
		LoginEntity loginInfo = login.getLoginInfo(loginNo, inDto.getProvinceId());
		loginName = loginInfo.getLoginName();
		// 查询退预存金额
		for (PayMentEntity payMentEnt : payMentListTmp) {
			refundFee += payMentEnt.getPayFee();
		}
		// 拼报文
		Map<String, Object> xmlMap = new HashMap<String, Object>();
		xmlMap.put("PRINT_DATE", printDate);
		xmlMap.put("LOGIN_INFO", loginNo + "   " + loginName);
		xmlMap.put("FIRST_LINE", "手机号码：" + phoneNo);
		xmlMap.put("SECOND_LINE", "客户名称：" + custName);
		xmlMap.put("THIRD_LINE", "客户地址：" + custAddress);
		xmlMap.put("FORTH_LINE", "证件号码：" + idIccid);
		xmlMap.put("FIFTH_LINE", "用户品牌：" + brandName + "   办理业务：退预存款     操作流水：" + paySn);
		xmlMap.put("SIXTH_LINE", "账户名称：" + contractName + "   账户号码：" + contractNo + "   退预存款金额：" + ValueUtils.transFenToYuan(0 - refundFee));
		xmlMap.put("SEVENTH_LINE", loginNo + "  " + loginName);
		xmlMap.put("EIGTH_LINE", printDate);
		xmlMap.put("OP_CODE", inDto.getOpCode());
		xmlMap.put("PRINT_TYPE", "2nn");
		String xmlStr = printDataXml.getPrintXml(xmlMap);

		// 记录营业员操作日志
		LoginOprEntity in = new LoginOprEntity();
		in.setIdNo(idNo);
		in.setBrandId(brandId);
		in.setPhoneNo(phoneNo);
		in.setPayType("");
		in.setPayFee(0);
		in.setLoginSn(paySn);
		in.setLoginNo(inDto.getLoginNo());
		in.setLoginGroup(inDto.getGroupId());
		in.setOpCode(inDto.getOpCode());
		in.setTotalDate(DateUtils.getCurDay());
		in.setRemark(loginNo + "退预存款（非实名）");

		S8081PrintOutDTO outDto = new S8081PrintOutDTO();
		outDto.setXmlStr(xmlStr);
		return outDto;
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

	public ICust getCust() {
		return cust;
	}

	public void setCust(ICust cust) {
		this.cust = cust;
	}

	public IAccount getAccount() {
		return account;
	}

	public void setAccount(IAccount account) {
		this.account = account;
	}

	public ILogin getLogin() {
		return login;
	}

	public void setLogin(ILogin login) {
		this.login = login;
	}

	public IPrintDataXML getPrintDataXml() {
		return printDataXml;
	}

	public void setPrintDataXml(IPrintDataXML printDataXml) {
		this.printDataXml = printDataXml;
	}

}
