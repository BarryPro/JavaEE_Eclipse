package com.sitech.acctmgr.atom.impl.pay;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.pay.inter.IPreOrder;
import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.pay.S2309CfmInDTO;
import com.sitech.acctmgr.atom.dto.pay.S2309CfmOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.utils.FtpUtils;
import com.sitech.acctmgr.inter.pay.I2309;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 *
 * <p>Title: 手工系统充值导入  </p>
 * <p>Description: 手工系统充值数据文件入库等操作。支持到账多个月  </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
@ParamTypes({
	@ParamType(c=S2309CfmInDTO.class,oc=S2309CfmOutDTO.class,m="cfm")
})
public class S2309 extends AcctMgrBaseService  implements I2309 {
	
	private IControl	control;
	private IGroup		group;
	private IRecord		record;
	private IUser		user;
	private IBalance	balance;
	private IPreOrder	preOrder;

	@Override
	public OutDTO cfm(InDTO inParam) {

		// 调用S8011CfmInDTO 获取入参
		S2309CfmInDTO inDto = (S2309CfmInDTO) inParam;
		
		log.error("S2309 cfm begin:" + inDto.getMbean());

		// 获取时间
		String curTime = control.getSysDate().get("CUR_TIME").toString();
		String curYm = curTime.substring(0, 6);
		String totalDate = curTime.substring(0, 8);
		
		ChngroupRelEntity groupRelEntity = group.getRegionDistinct(inDto.getGroupId(), "2", inDto.getProvinceId());
		String LoginRegionCode = groupRelEntity.getRegionCode();
		
		//获取批次流水lBatchSn
		long batchSn = control.getSequence("SEQ_SYSTEM_SN");

		Map<String, Object> inMapTmp = null;
		Map<String, Object> outMapTmp = null;
		
		// 读取&下载 动态表单上传的文件
		String fileName = "";
		String enCode = "";
		try {
			log.debug("下载上传文件：" + inDto.getRelPath());
			outMapTmp = FtpUtils.download(inDto.getRelPath());
			fileName = outMapTmp.get("FILENAME").toString();    //绝对路径+文件名
			enCode = outMapTmp.get("ENCODE").toString();
		} catch (Exception e) {
			e.printStackTrace();
			throw new BusiException(AcctMgrError.getErrorCode("2309", "00001"),
					"读取上传文件失败，请检查批量缴费文件上传主机是否正常！");
		}
		log.error("------>fileName=" + fileName);
		log.error("------>enCode" + enCode);

		// 上传文件不能为空
		InputStreamReader isr_pre1 = null;
		BufferedReader br_pre1 = null;
		try {
			isr_pre1 = new InputStreamReader(new FileInputStream(fileName),enCode);
			br_pre1 = new BufferedReader(isr_pre1);
			if (br_pre1.readLine() == null) {
				throw new BusiException(AcctMgrError.getErrorCode("0000","00073"), "上传文件不能为空！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new BusiException(AcctMgrError.getErrorCode("0000", "00073"),"上传文件不能为空！");
		} finally {
			try {
				if (br_pre1 != null) {
					br_pre1.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		// 号码重复次数 单个号码金额 总号码数
		String phoneTmp = "";
		long idNoTmp = 0;
		
		// N未处理 Y审核通过 X审核不通过 S赠送 C取消赠送 F赠送成功 E失败用户 K跨库用户
		String auditFlag = "N";

		//循环文件内容，做业务校验
		int totalNum = 0;
		long totalFee = 0;
		InputStreamReader isr_pre2 = null;
		BufferedReader br_pre2 = null;
		int checkFlag = 0;
		List<String> phoneList = new ArrayList<String>();
		try {
			isr_pre2 = new InputStreamReader(new FileInputStream(fileName),enCode);
			br_pre2 = new BufferedReader(isr_pre2);
			String lineStr = null;
			while ((lineStr = br_pre2.readLine()) != null) {
				log.debug("--->readLine =" + totalNum + ", lineStr=" + lineStr);

				String phoneNo = StringUtils.split(lineStr, "|")[0].trim();
				long contractNo = Long.parseLong(StringUtils.split(lineStr, "|")[1].trim());
				String sumFee = StringUtils.split(lineStr, "|")[2].trim();	//每个用户多次赠送总额
				long lSumFee = Math.round(Double.parseDouble(sumFee) * 100);
				String effDate = StringUtils.split(lineStr, "|")[3].trim();	//返费开始时间
				String expDate = StringUtils.split(lineStr, "|")[4].trim();	//返费结束时间
				String returnCount = StringUtils.split(lineStr, "|")[5].trim(); //返费次数
				String remark = StringUtils.split(lineStr, "|")[6].trim(); //返费备注
				
				if (phoneList.contains(phoneNo)) {

					checkFlag = 4;
					phoneTmp = phoneNo;
					throw new BusiException(AcctMgrError.getErrorCode("2309",
							"00003"), "文件中包含重复号码，请核查数据");
				} else {

					phoneList.add(phoneNo);
				}
				totalNum++;
				totalFee = totalFee + lSumFee;
			}
			if(totalNum != inDto.getSumNum()){

				checkFlag = 1;
				throw new BusiException(AcctMgrError.getErrorCode("2309",
						"00002"), "文件中包含数据条数与充值总用户数不符，文件中包含数据条数："+totalNum+"充值总用户数"+inDto.getSumNum());
			}
			if(totalFee != inDto.getSumFee()){

				checkFlag = 2;
				throw new BusiException(AcctMgrError.getErrorCode("2309",
						"00004"),  "文件中充值总金额与充值总金额不符，文件中充值总金额："+totalFee+"充值总金额"+inDto.getSumFee());
			}
		} catch (Exception e) {
			e.printStackTrace();
			if (checkFlag == 1) {
				throw new BusiException(AcctMgrError.getErrorCode("2309",
						"00002"), "文件中包含数据条数与充值总用户数不符，文件中包含数据条数："+totalNum+"充值总用户数"+inDto.getSumNum());
			}else if (checkFlag == 2) {
				throw new BusiException(AcctMgrError.getErrorCode("2309",
						"00004"),  "文件中充值总金额与充值总金额不符，文件中充值总金额："+totalFee+"充值总金额"+inDto.getSumFee());
			}else if (checkFlag == 4) {
				throw new BusiException(AcctMgrError.getErrorCode("2309",
						"00003"), "文件中包含重复号码，请核查数据,[" + phoneTmp + "]");
			}else if (checkFlag == 5) {
				throw new BusiException(AcctMgrError.getErrorCode("2309",
						"00009"), "文件中送费类型不正确，请核查数据");
			} else {
				throw new BusiException(AcctMgrError.getErrorCode("2309","00008"), "文件读取失败，请核查上传文件格式！");
			}

		} finally {
			try {
				if (br_pre2 != null) {
					br_pre2.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		String payType = "T";

		// 循环处理文件
		int setialNo = 0;
		int validNum = 0;
		long validFee = 0;
		BufferedReader br_fee = null;
		String lineStr_fee = null;
		try {
			
			InputStreamReader isr_fee = new InputStreamReader(new FileInputStream(fileName), enCode);
			br_fee = new BufferedReader(isr_fee);
			while ((lineStr_fee = br_fee.readLine()) != null) {
				// 打印每行
				log.debug("--->readLine_setialNo =" + setialNo+ ", lineStr_fee=" + lineStr_fee);
				lineStr_fee.trim();
				
				// 循环处理文件每一行数据
				String phoneNo = StringUtils.split(lineStr_fee, "|")[0].trim();
				long contractNo = Long.parseLong(StringUtils.split(lineStr_fee, "|")[1].trim());
				String sumFee = StringUtils.split(lineStr_fee, "|")[2].trim();	//每个用户多次赠送总额
				long lSumFee = Math.round(Double.parseDouble(sumFee) * 100);
				String effDate = StringUtils.split(lineStr_fee, "|")[3].trim();	//返费开始时间
				String expDate = StringUtils.split(lineStr_fee, "|")[4].trim();	//返费结束时间
				String returnCount = StringUtils.split(lineStr_fee, "|")[5].trim(); //返费次数
				String remark = StringUtils.split(lineStr_fee, "|")[6].trim(); //返费备注

				long paySn = control.getSequence("SEQ_SYSTEM_SN");

				String opType = "0"; //默认赠费
				// 查询当前用户
				UserInfoEntity userEntity = user.getUserEntity(null, phoneNo, null, false);
				if (contractNo == 0) {
					contractNo = userEntity.getContractNo();
				}
				long idNo = userEntity.getIdNo();
				if (userEntity == null) {
					log.error("------->查询用户失败 phoneNo=" + phoneNo);
					opType = "E";  //用户不存在为 E
				}

				// 插入按月返费接口表
				inMapTmp = new HashMap<>();
				inMapTmp.put("BATCH_SN", batchSn);
				inMapTmp.put("ID_NO", idNo);
				inMapTmp.put("CONTRACT_NO", contractNo);
				inMapTmp.put("PHONE_NO", phoneNo);
				inMapTmp.put("RETURNFEE_SUM", lSumFee);
				inMapTmp.put("RETURN_COUNT", returnCount);
				inMapTmp.put("PAY_TYPE", payType);
				inMapTmp.put("EFF_DATE", effDate);
				inMapTmp.put("EXP_DATE", expDate);
				inMapTmp.put("PAYED_COUNT", 0);
				inMapTmp.put("PAYED_MONEY", 0);
				inMapTmp.put("RETURN_RULE", inDto.getBackRule());
				inMapTmp.put("DEAL_FLAG", "99");
				inMapTmp.put("OP_CODE", inDto.getOpCode());
				inMapTmp.put("REMARK", remark);
				inMapTmp.put("LOGIN_NO", inDto.getLoginNo());
				balance.iMonthReturnFeeInfo(inMapTmp);

				setialNo++;
				if ("0".equals(opType)) {
					validNum++;
					validFee = validFee + lSumFee;
					phoneTmp = phoneNo;
					idNoTmp = idNo;
				}
				log.debug("------------> lPaySn= " + paySn + ",setialNo="+ setialNo);
			
			log.info("------------ end 遍历节点结束,totalFee=" + totalFee
					+ ",totalNum=" + totalNum);
			}// 遍历节点结束
		} catch (Exception e) {
			e.printStackTrace();
			
			if (checkFlag == 5) {
				throw new BusiException(AcctMgrError.getErrorCode("2309","00006"), "不能跨地市赠费[" + phoneTmp + "]]");
			} else if (checkFlag == 6) {
				throw new BusiException(AcctMgrError.getErrorCode("2309","00007"), "用户状态异常[" + phoneTmp + "]]");
			}
		} finally {
			// 关闭流
			try {
				if (br_fee != null) {
					br_fee.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		String smsFlag = "1";
		if(inDto.getShortPart1()!=null && !inDto.getShortPart1().equals("")){
			smsFlag = "0";
		}

		// 记录赠送总表
		inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("REGION_ID", LoginRegionCode);
		inMapTmp.put("ACT_ID", inDto.getPayNote());
		inMapTmp.put("BATCH_SN", batchSn);
		inMapTmp.put("ACT_TYPE", "A");
		inMapTmp.put("MEANS_ID", "");
		inMapTmp.put("ACT_NAME", "XXXXX");	//暂时入空
		inMapTmp.put("SEND_DATE", inDto.getSendDay());
		inMapTmp.put("SMS_FLAG", smsFlag);
		inMapTmp.put("SEND_MONTH", 0);
		inMapTmp.put("YEAR_MONTH", curYm);
		inMapTmp.put("LOGIN_NO", inDto.getLoginNo());
		inMapTmp.put("OP_CODE", inDto.getOpCode());
		inMapTmp.put("OP_NOTE", inDto.getRemark());
		inMapTmp.put("FILE_NAME", fileName);
		inMapTmp.put("AUDIT_FLAG", auditFlag);
		inMapTmp.put("TOTAL_NUM", totalNum);
		inMapTmp.put("INVALID_NUM", validNum);
		inMapTmp.put("TOTAL_FEE", totalFee);
		inMapTmp.put("INVALID_FEE", validFee);
		//inMapTmp.put("USER_PHONE", inDto.getUserPhone());
		inMapTmp.put("DOCUMENT_NO", inDto.getDocumentNo());
		inMapTmp.put("DOCUMENT_NAME", inDto.getDocumentName());
		inMapTmp.put("BACK_RULE", inDto.getBackRule());
		inMapTmp.put("FACTOR_ONE", inDto.getShortPart1());
		inMapTmp.put("FACTOR_TWO", inDto.getShortPart2());
		balance.saveBatchPayRecd(inMapTmp);

		//营业员操作日志
		LoginOprEntity in = new LoginOprEntity();
		in.setIdNo(0);
		in.setPhoneNo("");
		in.setPayType(payType);
		in.setPayFee(totalFee);
		in.setLoginSn(batchSn);
		in.setLoginNo(inDto.getLoginNo());
		in.setLoginGroup(inDto.getGroupId());
		in.setOpCode(inDto.getOpCode());
		in.setTotalDate(Long.parseLong(totalDate));
		in.setRemark("手工系统充值数据导入");
		record.saveLoginOpr(in);

		//发送统一接触
		
		
		
		S2309CfmOutDTO outDto = new S2309CfmOutDTO();
		outDto.setTotalFee(totalFee);
		outDto.setValidFee(validFee);
		outDto.setTotalNum(totalNum);
		outDto.setValidNum(validNum);
		outDto.setBatchSn(batchSn);

		log.error("------> 2309cfm_out" + outDto.toJson());
		return outDto;
		
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

	public IBalance getBalance() {
		return balance;
	}

	public void setBalance(IBalance balance) {
		this.balance = balance;
	}

	public IPreOrder getPreOrder() {
		return preOrder;
	}

	public void setPreOrder(IPreOrder preOrder) {
		this.preOrder = preOrder;
	}

}
