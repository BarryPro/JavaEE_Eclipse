package com.sitech.acctmgr.atom.busi.pay;

import static com.sitech.acctmgr.common.utils.ValueUtils.longValue;
import static org.apache.commons.collections.MapUtils.safeAddToMap;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.pay.inter.IWriteOffer;
import com.sitech.acctmgr.atom.domains.balance.BalanceEntity;
import com.sitech.acctmgr.atom.domains.bill.BillEntity;
import com.sitech.acctmgr.atom.domains.bill.UnbillEntity;
import com.sitech.acctmgr.atom.domains.fee.OutFeeData;
import com.sitech.acctmgr.atom.domains.pub.PubWrtoffCtrlEntity;
import com.sitech.acctmgr.atom.domains.user.UserDeadEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.IBill;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IDelay;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.acctmgrint.atom.busi.intface.IBusiMsgSnd;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.util.DateUtil;

/**
 * @Title: []
 * @Description:
 * @Date : 2016年3月9日上午9:40:46
 * @Company: SI-TECH
 * @author : qiaolin
 * @version : 1.0
 * @modify history
 *         <p>
 *         修改日期 修改人 修改目的
 *         <p>
 */
public class WriteOffer extends BaseBusi implements IWriteOffer {

	private IControl 	control;
	private IBill 		bill;
	private IBalance 	balance;
	private IDelay 		delay;
	private IUser 		user;
	private IBusiMsgSnd	busiMsgsnd;

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.sitech.acctmgr.atom.busi.pay.inter.IWriteOffer#doWriteOff(java.util
	 * .Map)
	 */
	@Override
	public long doWriteOff(Map<String, Object> inParam) {

		log.info(" 冲销 doWriteOff begin:[" + inParam.toString() + "]");

		String sAnsyFlag = "0"; // 异步冲销标志，默认为0(自动判断是否异步冲销),1为异步
		if (inParam.get("ANSY_FLAG") != null && !inParam.get("ANSY_FLAG").equals("")) {
			sAnsyFlag = inParam.get("ANSY_FLAG").toString();
			inParam.remove("ANSY_FLAG");
		}

		Map<String, Object> inMapTmp = null; // 临时变量:入参
		Map<String, Object> outMapTmp = null; // 临时变量:出参

		if (!isWriteoff(Long.parseLong(inParam.get("CONTRACT_NO").toString()))) {

			log.info("该账户不需要冲销！");
			return 0;
		}

		String sOpCode = inParam.get("OP_CODE").toString();
		String sPayPath = inParam.get("PAY_PATH").toString();
		inParam.remove("PAY_PATH");

		if (sAnsyFlag.equals("0")) { // 读取配置决定是否同步冲销

			String realWflag = control.getPubCodeValue(2006, "OP_CODE", null);
			log.debug("doWriteOff 读取配置决定是否同步冲销冲销的OP_CODE：[" + realWflag + "]");
			// 2006-- OP_CODE配置的 op_code 并且该OP_CODE配置过的PAY_PATH走同步冲销
			if (realWflag.indexOf(sOpCode) != -1) { // 同步冲销
				String payPaths = control.getPubCodeValue(2006, sOpCode, null);
				if (payPaths.indexOf(sPayPath) != -1) {
					doRealWriteOff(inParam, 0);
				} else { // 异步冲销
					doAsynWriteOff((Map<String, Object>) inParam.get("Header"), inParam);
				}
			} else { // 异步冲销
				doAsynWriteOff((Map<String, Object>) inParam.get("Header"), inParam);
			}
		} else if (sAnsyFlag.equals("1")) { // 异步冲销

			doAsynWriteOff((Map<String, Object>) inParam.get("Header"), inParam);
		} else {
			throw new BusiException(AcctMgrError.getErrorCode("0000", "00001"), "异步冲销标志不正确!sAnsyFlag: " + sAnsyFlag);
		}

		log.info(" 冲销 doWriteOff end:[" + inParam.toString() + "]");

		return 0;
	}

	public long doRealWriteOff(Map<String, Object> inParam, int flag) {

		log.info("实时冲销doRealWriteOff begin:[" + inParam.toString() + "]");

		Map<String, Object> inMapTmp = null; // 临时变量:入参
		Map<String, Object> outMapTmp = null; // 临时变量:出参

		Map<String, Object> mOutParam = new HashMap<String, Object>(); // 出参

		List<Map<String, Object>> balanceList = null; // 账本预存
		List<Map<String, Object>> billcycleList = new ArrayList<Map<String, Object>>(); // 欠费账期
		List<Map<String, Object>> phoneList = new ArrayList<Map<String, Object>>(); // 冲销用户

		String selDate = ""; // 已冲销账单表日期
		String bill_flag = "0"; // 账单表存放规则 0: 按动态月账期存放；1: 按自然月账期存放；默认按动态月存放
		int bill_ym = 0; // 账务年月,可为空，指定冲销账期

		long contractNo = Long.parseLong(inParam.get("CONTRACT_NO").toString());
		if (inParam.get("BILL_YM") != null && !inParam.get("BILL_YM").equals("")) {
			bill_ym = (Integer) inParam.get("BILL_YM");
		}
		String phoneNo = "";
		if (inParam.get("PHONE_NO") != null && !inParam.get("PHONE_NO").equals("")) {
			phoneNo = (String) inParam.get("PHONE_NO");
		}
		double delayFavourRate = 0;
		if (inParam.get("DELAY_FAVOUR_RATE") != null && !inParam.get("DELAY_FAVOUR_RATE").equals("")) {
			delayFavourRate = Double.parseDouble(inParam.get("DELAY_FAVOUR_RATE").toString());
		}

		if (1 == flag) {

			// 1、判断是否需要冲销
			if (!isWriteoff(Long.parseLong(inParam.get("CONTRACT_NO").toString()))) {

				log.info("该账户不需要冲销！");
				return 0;
			}
		}

		/*
		 * 2 冲销数据准备
		 */

		/* 2.1读取滞纳金标志和比率 */
		inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("CONTRACT_NO", contractNo);
		outMapTmp = delay.getDelayRate(inMapTmp);
		double delayRate = (Double) outMapTmp.get("DELAY_RATE");
		int beginDelayDay = (Integer) outMapTmp.get("DELAY_BEGIN");

		/* 2.2 按账本优先级读取预存，将账本预存放到billcycleList中 */
		balanceList = getWrtOffBook(contractNo);
		if (0 == balanceList.size()) {
			log.info("无预存款，冲销结束,con: " + contractNo);
			return 0; // 无预存款，冲销结束
		}

		/* 2.3 读取欠费账期,将账期存放到billcycleList中 */
		if (0 == bill_ym) {
			billcycleList = getUnPayBillCycle(contractNo);
		} else { // 冲销指定账期
			Map<String, Object> tmp = new HashMap<String, Object>();
			tmp.put("BILL_CYCLE", bill_ym);
			billcycleList.add(tmp);
		}

		/* 2.4 按付费顺序读取用户，将用户存放到WriteOffPhone中 */
		inMapTmp = new HashMap<String, Object>();
		if (!phoneNo.equals("")) {
			inMapTmp.put("PHONE_NO", phoneNo);
		}
		inMapTmp.put("CONTRACT_NO", contractNo);
		phoneList = getWriteoffPhone(inMapTmp);

		/* 2.5 取冲销流水 */
		long wrtoffSn = control.getSequence("SEQ_WRTOFF_SN");

		/*
		 * 3 做实际冲销
		 */
		inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("PAY_SN", inParam.get("PAY_SN"));
		inMapTmp.put("WRTOFF_SN", wrtoffSn);
		inMapTmp.put("CONTRACT_NO", contractNo);
		inMapTmp.put("DELAY_RATE", delayRate);
		inMapTmp.put("DELAY_BEGIN", beginDelayDay);
		inMapTmp.put("DELAY_FAVOUR_RATE", delayFavourRate);
		inMapTmp.put("LOGIN_NO", inParam.get("LOGIN_NO"));
		inMapTmp.put("GROUP_ID", inParam.get("GROUP_ID"));
		inMapTmp.put("OP_CODE", inParam.get("OP_CODE"));
		inMapTmp.put("BALANCE_LIST", balanceList);
		inMapTmp.put("BILLCYCLE_LIST", billcycleList);
		inMapTmp.put("PHONE_LIST", phoneList);
		doWriteOffOpr(inMapTmp);

		/* 同步实时销账 */
		Map<String, Object> rtWrtoffMap = new HashMap<String, Object>();
		rtWrtoffMap.put("Header", inParam.get("Header"));
		rtWrtoffMap.put("PAY_SN", inParam.get("PAY_SN"));
		rtWrtoffMap.put("CONTRACT_NO", contractNo);
		rtWrtoffMap.put("WRTOFF_FLAG", "2");
		rtWrtoffMap.put("REMARK", "冲销同步");
		rtWrtoffMap.put("J_FLAG", inParam.get("J_FLAG"));
		balance.saveRtwroffChg(rtWrtoffMap);

		/*
		 * 4 0账本移入历史
		 */
		balance.removeAcctBook(contractNo, inParam.get("LOGIN_NO").toString());

		log.info("实时冲销doRealWriteOff end!");

		return wrtoffSn;

	}

	private boolean isWriteoff(long contractNo) {

		/*
		 * 1 判断是否执行冲销
		 */
		// 1.1 判断是否出账期间，出账期间不做冲销
		PubWrtoffCtrlEntity wrtoffCtrlEntity = control.getWriteOffFlagAndMonth();
		if (wrtoffCtrlEntity.getWrtoffFlag().equals("1")) { // 出账期间

			log.info("出账期间，不冲销");
			return false;
		}

		// 1.2 判断是否有库内欠费
		boolean isOwe = bill.isUnPayOwe(contractNo);
		if (!isOwe) {
			log.info("用户无欠费，不冲销");
			return false;
		}

		return true;
	}

	/**
	 * 名称：按账本优先级读取预存<br/>
	 * 
	 * @param lContractNo: 账户ID
	 * 
	 * @return LIST : 包含每条账本信息和账本能冲销的账面项组
	 * @author qiaolin
	 **/
	private List<Map<String, Object>> getWrtOffBook(long contractNo) {

		Map<String, Object> inMapTmp = null;

		inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("CONTRACT_NO", contractNo);
		// inMapTmp.put( "SUFFIX" , Long.toString(lContractNo%10) );
		List<Map<String, Object>> resultList = (List<Map<String, Object>>) baseDao.queryForList("bal_acctbook_info.qGetAcctbookByCon", inMapTmp);

		List<Map<String, Object>> acctbookList = new ArrayList<Map<String, Object>>();
		for (Map<String, Object> resultMap : resultList) {

			if (Long.valueOf(resultMap.get("CUR_BALANCE").toString()) <= 0) {
				// 无预存款不加入列表
				continue;
			}

			/* 查找账本能够冲销的账面项组 */
			inMapTmp = new HashMap<String, Object>();
			inMapTmp.put("PAY_TYPE", resultMap.get("PAY_TYPE"));
			Map<String, Object> result = (Map<String, Object>) baseDao.queryForObject("bal_writeplan_conf.qWriteplanConf", inMapTmp);
			String acct_item_group = result.get("ACCT_ITEM_GROUP").toString();

			resultMap.put("ACCT_ITEM_GROUP", acct_item_group);

			acctbookList.add(resultMap);
		}

		return acctbookList;
	}

	/**
	 * 名称：按付费顺序读取用户，将用户存放到智能指针WriteOffPhone中<br/>
	 * 
	 * @param CONTRACT_NO: 账户Id
	 * @param PHONE_NO: 可空，缴费用户
	 * @return List<Map<String, Object>> : 冲销用户列表, Map中包含 ID_NO 、 PHONE_NO
	 * @author qiaolin
	 * */
	private List<Map<String, Object>> getWriteoffPhone(Map<String, Object> inParam) {

		Map<String, Object> inMapTmp = null; // 临时变量:入参
		Map<String, Object> outMapTmp = null; // 临时变量:出参

		List<Map<String, Object>> writeoffPhoneList = new ArrayList<Map<String, Object>>();
		/* 缴费用户优先冲销欠费 */
		long payIdNo = 0;
		if (inParam.get("PHONE_NO") != null && !inParam.get("PHONE_NO").equals("")) {

			UserInfoEntity userEntity = user.getUserEntity(null, inParam.get("PHONE_NO").toString(), null, true);

			Map<String, Object> payMap = new HashMap<String, Object>();
			payMap.put("ID_NO", userEntity.getIdNo());
			payMap.put("PHONE_NO", (String) inParam.get("PHONE_NO"));

			writeoffPhoneList.add(payMap);
		}

		inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("CONTRACT_NO", inParam.get("CONTRACT_NO"));
		String sContractNo = inParam.get("CONTRACT_NO").toString();
		inMapTmp.put("SUFFIX", sContractNo.substring(sContractNo.length() - 2));
		List<Map<String, Object>> resultList = (List<Map<String, Object>>) baseDao.queryForList("cs_conuserrel_info.qForWriteoff", inMapTmp);
		for (Map<String, Object> mapTmp : resultList) {

			long idNo = Long.parseLong(mapTmp.get("ID_NO").toString());

			// 如果缴费号码不为空，则此处剔除
			if (payIdNo == idNo) {
				continue;
			}

			// 如果目前账务关系失效 ， 剔除付费关系解除后又重新绑定的用户，避免重复冲销
			if (0 == Integer.parseInt(mapTmp.get("VALID_FLAG").toString())) {
				int flag = 0;
				for (Map<String, Object> idTmp : resultList) {
					if (idNo == Long.parseLong(idTmp.get("ID_NO").toString()) && 1 == Integer.parseInt(idTmp.get("VALID_FLAG").toString())) {
						flag = 1;
						break;
					}
				}
				if (1 == flag) {
					continue;
				}
			}

			// 全部是离网 并且id_no相同，剔除重复id_no
			int valid_flag = 0;
			for (Map<String, Object> idTmp2 : writeoffPhoneList) {

				if (idNo == Long.parseLong(idTmp2.get("ID_NO").toString())) {
					valid_flag = 1;
					break;
				}
			}
			if (1 == valid_flag) {
				continue;
			}

			String phoneNo = "";
			UserInfoEntity userEntity = user.getUserEntity(idNo, null, null, false);
			if (userEntity == null) {

				List<UserDeadEntity> userDeadList = user.getUserdeadEntity(null, idNo, null);
				phoneNo = userDeadList.get(0).getPhoneNo();
			} else {

				phoneNo = userEntity.getPhoneNo();
			}

			Map<String, Object> payMap = new HashMap<String, Object>();
			payMap.put("ID_NO", idNo);
			payMap.put("PHONE_NO", phoneNo);

			writeoffPhoneList.add(payMap);
		}

		return writeoffPhoneList;
	}

	/**
	 * 名称：异步冲销 功能：向消息中间件发送异步冲销消息
	 * 
	 * @param Header: Map<String, Object>
	 * @param PAY_SN : 缴费入账流水
	 * @param CONTRACT_NO: 账户Id
	 * @param PHONE_NO: 用户号码，可空
	 * @param LOGIN_NO: 缴费工号
	 * @param GROUP_ID: 缴费工号机构归属
	 * @param DELAY_FAVOUR_RATE: 滞纳金优惠率 ,可空，默认0
	 * @param OP_CODE: 模块编码
	 * @param CONTACT_ID: 统一流水，可空
	 * @return boolean
	 * @author qiaolin
	 */
	private boolean doAsynWriteOff(Map<String, Object> Header, Map<String, Object> inParam) {
		log.info("异步冲销开始");

		String contactId = null;
		if (inParam.get("CONTACT_ID") != null && !((String) inParam.get("CONTACT_ID")).equals("")) {
			contactId = (String) inParam.get("CONTACT_ID");
		}

		if (inParam.get("DELAY_FAVOUR_RATE") != null && !inParam.get("DELAY_FAVOUR_RATE").toString().equals("")) {
			inParam.put("DELAY_FAVOUR_RATE", inParam.get("DELAY_FAVOUR_RATE").toString());
		}
		MBean sendBusi = new MBean();
		sendBusi.setHeader(Header);
		sendBusi.setBody(inParam);
		sendBusi.addBody("OP_TYPE", "02");// 操作类型 01[只做开机] 02[只做冲销] 03[冲销开机]
		sendBusi.addBody("BUSI_CODE", "ASYWRTOFF");

		Map<String, Object> bbMap = new HashMap<String, Object>();
		bbMap.put("LOGIN_ACCEPT", inParam.get("PAY_SN").toString());
		bbMap.put("CONTACT_ID", contactId); // 统一流水
		bbMap.put("BUSIID_NO", inParam.get("CONTRACT_NO"));
		bbMap.put("LOGIN_NO", (String) inParam.get("LOGIN_NO"));
		bbMap.put("OP_CODE", (String) inParam.get("OP_CODE"));
		bbMap.put("OWNER_FLAG", "1");
		bbMap.put("ORDER_ID", "20000");// 工单模板号
		bbMap.put("ODR_CONT", sendBusi);
		log.info("调用发送消息中间件接口opPubOdrSndInter begin: " + bbMap.toString());
		busiMsgsnd.opPubOdrSndInter(bbMap); //向消息中间件发送消息
		log.info("调用发送消息中间件接口opPubOdrSndInter end!");

		return true;
	}

	/**
	 * 名称：冲销过程，被doRealWriteOff调用<br/>
	 * 1冲销欠费<br/>
	 * 2更新或记录响应的账本、账单列表，数据落地<br/>
	 * 备注：<br/>
	 * 冲销顺序依次为：账本、账期、用户、账目项(部分冲销或者专项冲销时使用)<br/>
	 * 账本顺序：BAL_ACCTBOOK_X.END_TIME,BAL_BOOKTYPE_DICT.PRIORITY,BAL_ACCTBOOK_X.BALANCE_ID <br/>
	 * 账期顺序：ACT_UNPAYOWE_XX.BILL_CYCLE<br/>
	 * 用户顺序: 缴费用户优先级最高，其次是AC_CONUSERREL_INFO.CHKOUT_PRI<br/>
	 * 账目项顺序:ACT_ITEM_GROUP_DETAIL.PRIORITY <br/>
	 * 
	 * @param PAY_SN
	 * @param WRITEOFF_SN
	 * @param CONTRACT_NO
	 * @param DELAY_RATE
	 * @param DELAY_BEGIN
	 * @param DELAY_FAVOUR_RATE
	 * @param LOGIN_NO
	 * @param LOGIN_GROUP
	 * @param OP_CODE
	 * @param BALANCE_LIST:   账本列表List
	 * @param BILLCYCLE_LIST: 欠费账期列表List
	 * @param PHONE_LIST: 	     用户列表List
	 * @author qiaolin
	 */
	private void doWriteOffOpr(Map<String, Object> inParam) {

		Map<String, Object> inMapTmp = null; // 临时变量:入参
		Map<String, Object> outMapTmp = null; // 临时变量:出参

		List<Map<String, Object>> balanceList = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> billcycleList = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> phoneList = new ArrayList<Map<String, Object>>();

		long contractNo = (Long) inParam.get("CONTRACT_NO");
		balanceList = (List<Map<String, Object>>) inParam.get("BALANCE_LIST");
		billcycleList = (List<Map<String, Object>>) inParam.get("BILLCYCLE_LIST");
		phoneList = (List<Map<String, Object>>) inParam.get("PHONE_LIST");

		log.info("doWriteOffOpr begin: balanceList: " + balanceList.toString() + "billcycleList: " + billcycleList + "phoneList: " + phoneList);

		/* 取当前年月和当前时间 */
		String sCurTime = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		String sCurYm = sCurTime.substring(0, 6);
		String sTotaldate = sCurTime.substring(0, 8);

		List<Map<String, Object>> phoneListTmp = new ArrayList<Map<String, Object>>();
		phoneListTmp.addAll(phoneList);
		log.debug("用户数量： " + phoneList.size());

		List<Map<String, Object>> billcycleTmp = null;
		
		/*
		 * 按账本顺序依次取账本
		 */
		long curBalance = 0;
		for (Map<String, Object> balanceMap : balanceList) {

			long balancePayedOwe = 0;
			curBalance = Long.parseLong(balanceMap.get("CUR_BALANCE").toString());

			if (curBalance <= 0) {
				continue;
			}
			
			String payAttr = balanceMap.get("PAY_ATTR").toString();

			/* 冲销几个核心对象初始化 */
			List<Map<String, Object>> writeoffAcct = new ArrayList<Map<String, Object>>(); // 记录账本余额
			List<Map<String, Object>> writeoffBill = new ArrayList<Map<String, Object>>(); // 记录本次冲销的账单
			List<Map<String, Object>> writeoffResult = new ArrayList<Map<String, Object>>(); // 记录冲销信息
			List<Map<String, Object>> writeoffPayOut = new ArrayList<Map<String, Object>>(); // 记录支出信息

			/* 按账期从小到大的顺序依次遍历 */
			// 新的账本，重新加载账期列表
			billcycleTmp = new ArrayList<Map<String, Object>>();
			billcycleTmp.addAll(billcycleList);
			log.debug("防止专款账本将账期删除后，重新加载账期。billcycleTmp: " + billcycleTmp.toString());
			
			for (Iterator bC = billcycleTmp.iterator(); bC.hasNext();) {

				Map<String, Object> billCycle = (Map<String, Object>) bC.next();

				if (curBalance <= 0) {
					break;
				}

				/* 按用户优先级依次遍历 */
				// for (Map<String, Object> phone : phoneList) {
				for (Iterator it = phoneListTmp.iterator(); it.hasNext();) {

					Map<String, Object> phone = (Map<String, Object>) it.next();
					long idNo = (Long) phone.get("ID_NO");
					String phoneNo = (String) phone.get("PHONE_NO");

					if (curBalance <= 0) {
						break;
					}

					// 按账单一条条冲销
					// 取账单
					inMapTmp = new HashMap<String, Object>();
					inMapTmp.put("CONTRACT_NO", contractNo);
					inMapTmp.put("ID_NO", idNo);
					inMapTmp.put("BILL_CYCLE", billCycle.get("BILL_CYCLE"));
					inMapTmp.put("ACCT_ITEM_GROUP", balanceMap.get("ACCT_ITEM_GROUP"));
					List<Map<String, Object>> unpayOweList = (List<Map<String, Object>>) baseDao.queryForList("act_unpayowe_info.qForWriteoff",inMapTmp);

					int allPayFlag = 1;
					for (Map<String, Object> unpayOweMap : unpayOweList) { // 循环未冲销账单

						long oweFee = Long.parseLong(unpayOweMap.get("OWE_FEE").toString());
						long billId = Long.parseLong(unpayOweMap.get("BILL_ID").toString());
						long taxFee = Long.parseLong(unpayOweMap.get("TAX_FEE").toString()) - Long.parseLong(unpayOweMap.get("PAYED_TAX").toString());

						allPayFlag = 0;

						if (0 == oweFee) {
							continue;
						}

						if (curBalance <= 0) {
							break;
						}

						// 计算滞纳金
						long delayFavour, delayFee;
						BigDecimal bDelayFavour = new BigDecimal(0);
						if (oweFee > 0) {

							inMapTmp = new HashMap<String, Object>();
							inMapTmp.put("BILL_BEGIN", unpayOweMap.get("BILL_BEGIN"));
							inMapTmp.put("OWE_FEE", oweFee);
							inMapTmp.put("DELAY_BEGIN", inParam.get("DELAY_BEGIN"));
							inMapTmp.put("DELAY_RATE", inParam.get("DELAY_RATE"));
							inMapTmp.put("BILL_CYCLE", unpayOweMap.get("BILL_CYCLE"));
							inMapTmp.put("TOTAL_DATE", sTotaldate);
							long delayFee1 = delay.getDelayFee(inMapTmp);

							BigDecimal bDelayFavourRate = new BigDecimal(inParam.get("DELAY_FAVOUR_RATE").toString());
							BigDecimal bDelayFeeBefore = new BigDecimal(delayFee1);
							bDelayFavour = bDelayFeeBefore.multiply(bDelayFavourRate);
							// 将BigDecimal转化为long前四舍五入
							delayFavour = bDelayFavour.setScale(0, BigDecimal.ROUND_HALF_UP).longValue();
							delayFee = delayFee1 - delayFavour; // 滞纳金减去优惠的滞纳金
						} else {

							delayFavour = 0;
							delayFee = 0;
						}

						log.info("按条冲销----基本数据：balance_id[" + balanceMap.get("BALANCE_ID") + "]" + "pay_type[" + balanceMap.get("PAY_TYPE") + "]"
								+ "bill_id[" + billId + "]");

						long payedOwe = 0;
						long payedDelay = 0;
						long payedDelayFavour = 0;
						long payedTax = 0;
						String payedStatus = "";
						if (curBalance >= oweFee + delayFee) { // 单条账单全部冲销

							log.info("按条冲销----完全冲销----冲销前：账本余额[" + curBalance + "]" + "欠费[" + oweFee + "]" + "滞纳金[" + delayFee + "]" + "滞纳金优惠["
									+ delayFavour + "]" + "税额[" + taxFee + "]");

							curBalance = curBalance - oweFee - delayFee;
							payedOwe = oweFee;
							payedDelay = delayFee;
							payedDelayFavour = delayFavour;
							payedTax = taxFee;
							payedStatus = "2";
							oweFee = 0;
							delayFee = 0;
							delayFavour = 0;
							taxFee = 0;

							allPayFlag = 1;

							log.info("按条冲销----完全冲销----冲销：冲销欠费[" + payedOwe + "]" + "冲销滞纳金[" + payedDelay + "]" + "滞纳金优惠[" + payedDelayFavour + "]"
									+ "冲销税额[" + payedTax + "]");

							log.info("按条冲销----完全冲销----冲销后：账本余额[" + curBalance + "]" + "欠费[" + oweFee + "]" + "滞纳金[" + delayFee + "]" + "滞纳金优惠["
									+ delayFavour + "]" + "税额[" + taxFee + "]");

						} else { // 单条账单部分冲销

							log.info("按条冲销----部分冲销----冲销前：账本余额[" + curBalance + "]" + "欠费[" + oweFee + "]" + "滞纳金[" + delayFee + "]" + "滞纳金优惠["
									+ delayFavour + "]" + "税额[" + taxFee + "]");

							BigDecimal bCurBalance = new BigDecimal(curBalance);
							BigDecimal bOweFee = new BigDecimal(oweFee);
							BigDecimal bDelayFee = new BigDecimal(delayFee);

							BigDecimal tmp1 = bOweFee.add(bDelayFee);
							BigDecimal bPayedOwe = bCurBalance.multiply(bOweFee.divide(tmp1, 10, BigDecimal.ROUND_HALF_UP));
							BigDecimal bPayedDelay = bCurBalance.subtract(bPayedOwe);
							BigDecimal bPayedDelayFavour = new BigDecimal(0);
							if (1 == Double.parseDouble(inParam.get("DELAY_FAVOUR_RATE").toString())) {
								bPayedDelayFavour = bPayedOwe.multiply(bDelayFavour).divide(bOweFee, 10, BigDecimal.ROUND_HALF_UP);
							} else {
								double tmp = 1 - Double.parseDouble(inParam.get("DELAY_FAVOUR_RATE").toString());
								bPayedDelayFavour = (bPayedDelay.divide(BigDecimal.valueOf(tmp), 10, BigDecimal.ROUND_HALF_UP)).subtract(bPayedDelay);
							}

							/* 将计算后的BigDecimal数据四舍五入后转换为long */
							curBalance = 0;
							payedOwe = bPayedOwe.setScale(0, BigDecimal.ROUND_HALF_UP).longValue();
							payedDelay = bPayedDelay.setScale(0, BigDecimal.ROUND_HALF_UP).longValue();
							payedDelayFavour = bPayedDelayFavour.setScale(0, BigDecimal.ROUND_HALF_UP).longValue();
							
							long payedTaxTmp = getTaxFee(payedOwe, Double.parseDouble(unpayOweMap.get("TAX_RATE").toString()));
							
							payedTax = (payedTaxTmp > taxFee) ? taxFee : payedTaxTmp;
							payedStatus = "0";
							oweFee = oweFee - payedOwe;
							delayFee = delayFee - payedDelay;
							delayFavour = delayFavour - payedDelayFavour;
							taxFee = taxFee - payedTax;

							log.info("按条冲销----部分冲销----冲销：冲销欠费[" + payedOwe + "]" + "冲销滞纳金[" + payedDelay + "]" + "滞纳金优惠[" + payedDelayFavour + "]"
									+ "冲销税额[" + payedTax + "]");

							log.info("按条冲销----部分冲销----冲销后：账本余额[" + curBalance + "]" + "欠费[" + oweFee + "]" + "滞纳金[" + delayFee + "]" + "滞纳金优惠["
									+ delayFavour + "]" + "税额[" + taxFee + "]");

						}

						balancePayedOwe = balancePayedOwe + payedOwe + payedDelay;
						
						//系统充值账本，记录LATER_FAVOUR_EXTAX和LATER_FAVOUR_TAX
						long laterFavourTax = 0;
						long laterFavourExtax = 0;
						log.debug("qiaolin test: " + payAttr);
						if("1".equals(payAttr.substring(5, 6))){
							laterFavourTax = payedTax;
							laterFavourExtax = payedOwe*100 - payedTax;
						}

						// 记录账单变更List writeoffBill
						Map<String, Object> billMap = new HashMap<String, Object>();
						billMap.put("BILL_ID", billId);
						billMap.put("PAYED_LATER", payedOwe);
						billMap.put("PAYED_TAX", payedTax);
						billMap.put("PAYED_STATUS", payedStatus);
						billMap.put("PAYED_TYPE", 1); // 0：按账期冲销 1：按账单一条条冲销
						billMap.put("BILL_CYCLE", billCycle.get("BILL_CYCLE"));
						billMap.put("NATURAL_MONTH", unpayOweMap.get("NATURAL_MONTH"));
						billMap.put("VIRTUAL_OWE", "0");
						billMap.put("LATER_FAVOUR_TAX", laterFavourTax);
						billMap.put("LATER_FAVOUR_EXTAX", laterFavourExtax);
						writeoffBill.add(billMap);

						// 记录冲销List writeoffResult
						Map<String, Object> writeoffMap = new HashMap<String, Object>();
						writeoffMap.put("BALANCE_ID", balanceMap.get("BALANCE_ID"));
						writeoffMap.put("PAY_TYPE", balanceMap.get("PAY_TYPE"));
						writeoffMap.put("BILL_ID", billId);
						writeoffMap.put("PAYED_LATER", payedOwe);
						writeoffMap.put("PAYED_TAX", payedTax);
						writeoffMap.put("PAYED_TYPE", 1); // 0：按账期冲销 1：按账单一条条冲销
						writeoffMap.put("PRINT_FLAG", balanceMap.get("PRINT_FLAG"));
						writeoffMap.put("DELAY_FAVOUR_RATE", inParam.get("DELAY_FAVOUR_RATE").toString());
						writeoffMap.put("PAYED_DELAY", payedDelay);
						writeoffMap.put("DELAY_FAVOUR", payedDelayFavour);
						writeoffResult.add(writeoffMap);

						// 记录支出List writeoffPayOut
						int payoutFlag = 0;
						for (Map<String, Object> payoutMapTmp : writeoffPayOut) { // 按ID_NO合并支出记录

							if (idNo == longValue(payoutMapTmp.get("ID_NO"))
									&& longValue(balanceMap.get("BALANCE_ID")) == longValue(payoutMapTmp.get("BALANCE_ID"))) {
								long outBalanceTmp = longValue(payoutMapTmp.get("OUT_BALANCE"));
								long delayFeeTmp = longValue(payoutMapTmp.get("DELAY_FEE"));
								long delayFavourTmp = longValue(payoutMapTmp.get("DELAY_FAVOUR"));
								payoutMapTmp.put("OUT_BALANCE", outBalanceTmp + payedOwe);
								payoutMapTmp.put("DELAY_FEE", delayFeeTmp + payedDelay);
								payoutMapTmp.put("DELAY_FAVOUR", delayFavourTmp + payedDelayFavour);
								payoutFlag = 1;
								break;
							}

						}
						if (0 == payoutFlag) {
							Map<String, Object> payoutMap = new HashMap<String, Object>();
							payoutMap.put("ID_NO", idNo);
							payoutMap.put("PHONE_NO", phoneNo);
							payoutMap.put("BALANCE_ID", balanceMap.get("BALANCE_ID"));
							payoutMap.put("PAY_TYPE", balanceMap.get("PAY_TYPE"));
							payoutMap.put("OPER_TYPE", 0);
							payoutMap.put("OUT_BALANCE", payedOwe);
							payoutMap.put("DELAY_FEE", payedDelay);
							payoutMap.put("DELAY_FAVOUR", payedDelayFavour);
							writeoffPayOut.add(payoutMap);
						}

					}

					// 如果该用户此账期已全部冲销，则从list列表中删除该用户，减少循环次数
					if (allPayFlag == 1) {

						log.debug("该用户此账期已全部冲销，从list里面去除改id,去除前 list 长度: " + phoneListTmp.size() + "用户是：" + idNo);

						it.remove();

						log.debug("该用户此账期已全部冲销，从list里面去除改id,去除后 list 长度: " + phoneListTmp.size() + "用户是：" + idNo);
					}

				}

				// 该账期没有欠费，把该账期从list中去除
				if (phoneListTmp.size() == 0) {

					log.debug("该账期没有欠费，从list里面去除该账期,去除前 list: " + billcycleList.toString() + "账期：" + billCycle.get("BILL_CYCLE"));

					bC.remove();

					log.debug("该账期没有欠费，从list里面去除改id,去除后 list: " + billcycleList.toString() + "账期：" + billCycle.get("BILL_CYCLE"));

					// 重新加载用户列表
					phoneListTmp.addAll(phoneList);
					log.debug("重新加载用户列表候，用户量: " + phoneListTmp.size() + ", 最开始用户数据量:" + phoneList.size());

				}

			}

			if (0 == balancePayedOwe) {
				log.info("该账本没有支出,退出");
				continue;
			}

			// 更新账本List writeoffAcct
			Map<String, Object> acctbookMap = new HashMap<String, Object>();
			acctbookMap.put("BALANCE_ID", balanceMap.get("BALANCE_ID"));
			acctbookMap.put("PAYED_OWE", balancePayedOwe);
			writeoffAcct.add(acctbookMap);

			/*
			 * 将表中数据实际落地
			 */
			Map<String, Object> doRecdMap = new HashMap<String, Object>();
			doRecdMap.put("PAY_SN", inParam.get("PAY_SN"));
			doRecdMap.put("WRTOFF_SN", inParam.get("WRTOFF_SN"));
			doRecdMap.put("CONTRACT_NO", contractNo);
			doRecdMap.put("BILL_LIST", writeoffBill);
			doRecdMap.put("BALANCE_LIST", writeoffAcct);
			doRecdMap.put("WRITEOFF_LIST", writeoffResult);
			doRecdMap.put("PAYOUT_LIST", writeoffPayOut);
			doRecdMap.put("LOGIN_NO", inParam.get("LOGIN_NO"));
			doRecdMap.put("GROUP_ID", inParam.get("GROUP_ID"));
			doRecdMap.put("OP_CODE", inParam.get("OP_CODE"));
			doRecdMap.put("YEAR_MONTH", sCurYm);
			doWriteOffRecd(doRecdMap);
		}

	}
	
	
	/**
	* 名称：根据含税金额计算税额   税额 = 税率 * （(应收-优惠)*100/(1+税率)）
	*/
	private long getTaxFee(long fee, double taxRate){
		
		BigDecimal bOweFee = new BigDecimal(fee);
		
		BigDecimal bTmp = bOweFee.multiply(BigDecimal.valueOf(100)).divide(
				BigDecimal.valueOf((1 + taxRate)), 10,
				BigDecimal.ROUND_HALF_UP);
		BigDecimal bPayedTaxTmp = BigDecimal.valueOf(taxRate).multiply(bTmp);

		/* 将计算后的BigDecimal数据四舍五入后转换为long */
		long taxFee = bPayedTaxTmp.setScale(0, BigDecimal.ROUND_HALF_UP).longValue();

		return taxFee;
	}

	/**
	 * 名称：冲销数据落地
	 * 
	 * @param PAY_SN
	 * @param WRTOFF_SN
	 * @param CONTRACT_NO
	 * @param BILL_LIST: 冲销账单List
	 * @param BALANCE_LIST: 账本List
	 * @param WRITEOFF_LIST: 冲销表List
	 * @param PAYOUT_LIST: 支出表List
	 * @param LOGIN_NO
	 * @param GROUP_ID
	 * @param OP_CODE
	 * @param YEAR_MONTH
	 * @author qiaolin
	 */
	private void doWriteOffRecd(Map<String, Object> inParam) {

		Map<String, Object> inMapTmp = null;
		Map<String, Object> outMapTmp = null;

		log.info("冲销数据落地 doWriteOffRecd begin : " + inParam.toString());

		long contractNo = Long.parseLong(inParam.get("CONTRACT_NO").toString());
		List<Map<String, Object>> balanceList = (List<Map<String, Object>>) inParam.get("BALANCE_LIST");
		List<Map<String, Object>> writeoffList = (List<Map<String, Object>>) inParam.get("WRITEOFF_LIST");
		List<Map<String, Object>> payoutList = (List<Map<String, Object>>) inParam.get("PAYOUT_LIST");
		List<Map<String, Object>> billList = (List<Map<String, Object>>) inParam.get("BILL_LIST");

		// 更新账本预存
		for (Map<String, Object> balanceMap : balanceList) {

			if (longValue(balanceMap.get("PAYED_OWE")) != 0) {
				inMapTmp = new HashMap<String, Object>();
				inMapTmp.putAll(balanceMap);
				// inMapTmp.put("SUFFIX", contractNo%10);
				balance.updateAcctBook(inMapTmp);
			}
		}

		// 记录账本支出表
		for (Map<String, Object> payoutMap : payoutList) {

			inMapTmp = new HashMap<String, Object>();
			inMapTmp.putAll(payoutMap);
			inMapTmp.put("PAY_SN", inParam.get("PAY_SN"));
			inMapTmp.put("WRTOFF_SN", inParam.get("WRTOFF_SN"));
			inMapTmp.put("CONTRACT_NO", contractNo);
			inMapTmp.put("STATUS", "0");
			inMapTmp.put("LOGIN_NO", inParam.get("LOGIN_NO"));
			inMapTmp.put("GROUP_ID", inParam.get("GROUP_ID"));
			inMapTmp.put("YEAR_MONTH", inParam.get("YEAR_MONTH"));
			baseDao.insert("bal_bookpayout_info.iBookPayOutInfo", inMapTmp);

		}

		// 记录冲销表
		for (Map<String, Object> writeoffMap : writeoffList) {

			int payedType = Integer.parseInt(writeoffMap.get("PAYED_TYPE").toString()); // 0：按账期冲销

			inMapTmp = new HashMap<String, Object>();
			inMapTmp.putAll(writeoffMap);
			inMapTmp.put("WRTOFF_SN", inParam.get("WRTOFF_SN"));
			inMapTmp.put("STATUS", "0");
			inMapTmp.put("LOGIN_NO", inParam.get("LOGIN_NO"));
			inMapTmp.put("YEAR_MONTH", inParam.get("YEAR_MONTH"));
			if (1 == payedType) {
				baseDao.insert("bal_writeoff_yyyymm.iForWriteoff", inMapTmp);
			}

		}

		// 更新未冲销账单表 或 将未冲销账单移动到已冲销账单
		/* 取配置最小已冲销账单表日期 */
		String selDate = control.getPubCodeValue(108, "HISBILLYM", null); // 取配置的最小已冲销账单日期
		int billRules = Integer.parseInt(control.getPubCodeValue(101, "PAYEDOWE", null)); // 取是否动态月或者自然月配置
		log.info("qiaolin selDate: " + selDate + "afdfd " + billRules);
		String tablePayedowe = "";

		for (Map<String, Object> billMap : billList) {

			if (0 == billRules) { // 0: 按动态月账期存放
				if (longValue(billMap.get("BILL_CYCLE")) >= longValue(selDate)) {
					tablePayedowe = "ACT_PAYEDOWE_" + billMap.get("BILL_CYCLE").toString();
				} else {
					tablePayedowe = "ACT_PAYEDOWE_HIS";
				}
			} else {
				if (longValue(billMap.get("NATURAL_MONTH")) >= longValue(selDate)) {
					tablePayedowe = "ACT_PAYEDOWE_" + billMap.get("NATURAL_MONTH").toString();
				} else {
					tablePayedowe = "ACT_PAYEDOWE_HIS";
				}
			}

			if (0 == Integer.valueOf(billMap.get("PAYED_STATUS").toString())) { // 部分冲销
				// 更新未冲销账单
				inMapTmp = new HashMap<String, Object>();
				inMapTmp.put("BILL_ID", billMap.get("BILL_ID"));
				inMapTmp.put("PAYED_LATER", longValue(billMap.get("PAYED_LATER")));
				inMapTmp.put("PAYED_TAX", longValue(billMap.get("PAYED_TAX")));
				inMapTmp.put("LATER_FAVOUR_EXTAX", billMap.get("LATER_FAVOUR_EXTAX"));
				inMapTmp.put("LATER_FAVOUR_TAX", billMap.get("LATER_FAVOUR_TAX"));
				int sqlRows = baseDao.update("act_unpayowe_info.uByBillid", inMapTmp);
				if (0 == sqlRows) {
					log.info("未冲销账单不存在或正在冲销");
					throw new BusiException(AcctMgrError.getErrorCode("0000", "0000"), "未冲销账单不存在或正在冲销bill_id :  " + billMap.get("BILL_ID"));
				}

			} else { // 当条账单全部冲销
				// 账单移入已冲销账单表
				inMapTmp = new HashMap<String, Object>();
				inMapTmp.put("BILL_ID", billMap.get("BILL_ID"));
				inMapTmp.put("TABLE_PAYEDOWE", tablePayedowe);
				inMapTmp.put("BILL_CYCLE", billMap.get("BILL_CYCLE"));
				inMapTmp.put("VIRTUAL_OWE", billMap.get("VIRTUAL_OWE"));
				inMapTmp.put("LATER_FAVOUR_EXTAX", billMap.get("LATER_FAVOUR_EXTAX"));
				inMapTmp.put("LATER_FAVOUR_TAX", billMap.get("LATER_FAVOUR_TAX"));
				baseDao.insert("act_payedowe_info.iForWriteoff", inMapTmp);

				inMapTmp = new HashMap<String, Object>();
				inMapTmp.put("BILL_ID", billMap.get("BILL_ID"));
				int sqlRows = baseDao.delete("act_unpayowe_info.delUnpayById", inMapTmp);
				log.info("删除未冲销账单条数: " + sqlRows);
				if (0 == sqlRows) {
					log.info("未冲销账单不存在或正在冲销");
					throw new BusiException(AcctMgrError.getErrorCode("0000", "0000"), "未冲销账单不存在或正在冲销bill_id :  " + billMap.get("BILL_ID"));
				}
			}

		}

	}

	/*
	 * @see
	 * com.sitech.acctmgr.atom.busi.pay.inter.IWriteOffer#doRealDeadWriteOff
	 * (java.util.Map)
	 */
	@SuppressWarnings("unchecked")
	@Override
	/* 离网账单冲销 */
	public void doRealDeadWriteOff(Map<String, Object> inMapTmp) {
		Map<String, Object> inMap = new HashMap<String, Object>();
		long contractNo = Long.parseLong(inMapTmp.get("CONTRACT_NO").toString());
		long balanceId = Long.parseLong(inMapTmp.get("BALANCE_ID").toString());
		long paySn = Long.parseLong(inMapTmp.get("PAY_SN").toString());
		long wrtoffSn = Long.parseLong(inMapTmp.get("WRTOFF_SN").toString());
		String payMonth = String.valueOf(inMapTmp.get("PAY_MONTH"));
		String loginNo = String.valueOf(inMapTmp.get("LOGIN_NO"));
		String groupId = String.valueOf(inMapTmp.get("GROUP_ID"));
		String opCode = String.valueOf(inMapTmp.get("GROUP_ID"));
		String phoneNo = (String) inMapTmp.get("PHONE_NO");
		String oweStatus = (String) inMapTmp.get("OWE_STATUS");
		String payStatus = (String) inMapTmp.get("PAY_STATUS");
		String curTime = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		String operType = String.valueOf(inMapTmp.get("OPER_TYPE"));
		String delayFavourRate = String.valueOf(inMapTmp.get("DELAY_RATE"));
		long idNo = Long.parseLong(inMapTmp.get("ID_NO").toString());
		List<Map<String, Object>> billYMList = (List<Map<String, Object>>) inMapTmp.get("BILL_YEAR_MONTH");

		log.info("doRealDeadWriteOff inParam:" + inMapTmp.toString());

		/* 获取滞纳金信息 */
		inMap.put("NET_FLAG", "1");
		inMap.put("CONTRACT_NO", contractNo);
		Map<String, Object> delayRateMap = delay.getDelayRate(inMap);

		double delayRate = Double.parseDouble(String.valueOf(delayRateMap.get("DELAY_RATE")));
		int delayBeginDay = Integer.parseInt(String.valueOf(delayRateMap.get("DELAY_BEGIN")));

		/* 离网账户按账本优先级读取预存及账本所属账目组 */
		List<Map<String, Object>> bookList = getWrtOffBookDead(contractNo);

		/* 读取欠费账期,将账期存放到billcycleList中 */
		List<Map<String, Object>> billcycleList = new ArrayList<Map<String, Object>>();
		if (billYMList == null || billYMList.size() == 0) {
			billcycleList = getDeadOweBillCycle(idNo, contractNo, oweStatus);
		} else { // 冲销指定账期
			billcycleList = billYMList;
		}

		for (Map<String, Object> bookMap : bookList) {
			
			String payAttr = bookMap.get("PAY_ATTR").toString();

			long curBalance = Long.parseLong(bookMap.get("CUR_BALANCE").toString());
			String acctItemGroup = bookMap.get("ACCT_ITEM_GROUP").toString();
			long balancePayedOwe = 0; // 冲销余额记录
			if (curBalance <= 0) {
				continue;
			}
			log.info("curBalance=" + curBalance + "--billcycleList size:" + billcycleList.size());

			List<Map<String, Object>> witeOffBalance = new ArrayList<Map<String, Object>>(); // 账本变化记录
			List<Map<String, Object>> writeOffBill = new ArrayList<Map<String, Object>>(); // 账单变更记录
			List<Map<String, Object>> writeOffResult = new ArrayList<Map<String, Object>>(); // 冲销结果记录
			List<Map<String, Object>> payOutResult = new ArrayList<Map<String, Object>>(); // 支出表结果记录

			for (Map<String, Object> billCycleMap : billcycleList) {
				
				if (curBalance <= 0) {
					break;
				}

				int billCycle = Integer.parseInt(billCycleMap.get("BILL_CYCLE").toString());
				inMap = new HashMap<String, Object>();
				inMap.put("STATUS", oweStatus);
				inMap.put("ID_NO", idNo);
				List<Map<String, Object>> oweConList = baseDao.queryForList("act_deadowe_info.qDeadOweConByIdNo", inMap);

				log.info("CON_LIST=" + oweConList + "--billCycle=" + billCycle);

				for (Map<String, Object> conMap : oweConList) {

					long conNo = ValueUtils.longValue(conMap.get("CONTRACT_NO"));

					log.info("doRealDeadWriteOff当前冲销phone [" + phoneNo + "] id_no [" + idNo + "] 在账户contract_no[" + conNo + "] 上的欠费");

					Map<String, Object> inOweMap = new HashMap<String, Object>();
					inOweMap.put("CONTRACT_NO", conNo);
					inOweMap.put("ID_NO", idNo);
					inOweMap.put("BILL_CYCLE", billCycle);
					inOweMap.put("STATUS", oweStatus);
					inOweMap.put("ACCT_ITEM_GROUP", acctItemGroup);
					List<Map<String, Object>> outWriteOffCon = baseDao.queryForList("act_deadowe_info.qDeadWriteoff", inOweMap);

					// 账单一条一条进行冲销
					for (Map<String, Object> outWriteOffConOne : outWriteOffCon) {
						long billId = Long.parseLong(outWriteOffConOne.get("BILL_ID").toString());
						long oweFee = Long.parseLong(outWriteOffConOne.get("OWE_FEE").toString());
						int naturalMonth = Integer.parseInt(outWriteOffConOne.get("NATURAL_MONTH").toString());
						long taxFee = Long.parseLong(outWriteOffConOne.get("TAX_FEE").toString())
								- Long.parseLong(outWriteOffConOne.get("PAYED_TAX").toString());
						double taxRate = Double.parseDouble(outWriteOffConOne.get("TAX_RATE").toString());

						if (oweFee == 0) {
							continue;
						}

						/* 获取滞纳金 */
						Map<String, Object> delayFeeInMap = new HashMap<String, Object>();
						delayFeeInMap.put("OWE_FEE", oweFee);
						delayFeeInMap.put("BILL_BEGIN", outWriteOffConOne.get("BILL_BEGIN"));
						delayFeeInMap.put("DELAY_RATE", delayRate);
						delayFeeInMap.put("DELAY_BEGIN", delayBeginDay);
						delayFeeInMap.put("BILL_CYCLE", outWriteOffConOne.get("BILL_CYCLE"));
						delayFeeInMap.put("TOTAL_DATE", curTime.substring(0, 8));
						long delayFeeTmp = delay.getDelayFee(delayFeeInMap);

						BigDecimal bDelayFavourRate = new BigDecimal(delayFavourRate);
						BigDecimal bDelayFeeBefore = new BigDecimal(delayFeeTmp);
						BigDecimal bDelayFavour = bDelayFeeBefore.multiply(bDelayFavourRate);
						// 将BigDecimal转化为long前四舍五入
						long delayFavour = bDelayFavour.setScale(0, BigDecimal.ROUND_HALF_UP).longValue();
						long delayFee = delayFeeTmp - delayFavour; // 滞纳金减去优惠的滞纳金
						if (oweFee < 0) {
							delayFee = 0;
						}
						log.debug("owe fee of this bill  :   " + oweFee);
						log.debug("delay fee of this bill  :  " + delayFee);

						String payedStatus = ""; // 0:部分冲销 2:全部冲销
						long payedTax = 0;
						long payedOweTmp = 0;
						long payedDelayTmp = 0;
						long delayFavourTmp = 0;

						if (curBalance >= oweFee + delayFee) {/* 单条账单全部冲销 */
							log.info("单条账单全部冲销");
							payedOweTmp = oweFee;
							payedDelayTmp = delayFee;
							delayFavourTmp = delayFavour;
							curBalance = curBalance - oweFee - delayFee;
							payedTax = taxFee;
							oweFee = 0;
							delayFee = 0;
							delayFavour = 0;
							taxFee = 0;
							payedStatus = payStatus;

							log.info("按条冲销----完全冲销----冲销：冲销欠费[" + payedOweTmp + "]" + "冲销滞纳金[" + payedDelayTmp + "]" + "滞纳金优惠[" + delayFavourTmp
									+ "]" + "冲销税额[" + payedTax + "]");

							log.info("按条冲销----完全冲销----冲销后：账本余额[" + curBalance + "]" + "欠费[" + oweFee + "]" + "滞纳金[" + delayFee + "]" + "滞纳金优惠["
									+ delayFavour + "]" + "税额[" + taxFee + "]");
						} else {/* 单条账单部分冲销 */
							log.info("单条账单部分冲销");
							BigDecimal bCurBalance = new BigDecimal(curBalance);
							BigDecimal bOweFee = new BigDecimal(oweFee);
							BigDecimal bDelayFee = new BigDecimal(delayFee);

							BigDecimal tmp1 = bOweFee.add(bDelayFee);
							BigDecimal bPayedOwe = bCurBalance.multiply(bOweFee.divide(tmp1, 10, BigDecimal.ROUND_HALF_UP));
							BigDecimal bPayedDelay = bCurBalance.subtract(bPayedOwe);
							BigDecimal bPayedDelayFavour = new BigDecimal(0);
							if (1 == Double.parseDouble(delayFavourRate)) {
								bPayedDelayFavour = bPayedOwe.multiply(bDelayFavour).divide(bOweFee, 10, BigDecimal.ROUND_HALF_UP);
							} else {
								double tmp = 1 - Double.parseDouble(delayFavourRate);
								bPayedDelayFavour = (bPayedDelay.divide(BigDecimal.valueOf(tmp), 10, BigDecimal.ROUND_HALF_UP)).subtract(bPayedDelay);
							}
							BigDecimal bTmp = bPayedOwe.multiply(BigDecimal.valueOf(100)).divide(BigDecimal.valueOf((1 + taxRate)), 10,
									BigDecimal.ROUND_HALF_UP);
							BigDecimal bPayedTaxTmp = BigDecimal.valueOf(taxRate).multiply(bTmp);

							/* 将计算后的BigDecimal数据四舍五入后转换为long */
							payedOweTmp = bPayedOwe.setScale(0, BigDecimal.ROUND_HALF_UP).longValue();
							payedDelayTmp = bPayedDelay.setScale(0, BigDecimal.ROUND_HALF_UP).longValue();
							delayFavourTmp = bPayedDelayFavour.setScale(0, BigDecimal.ROUND_HALF_UP).longValue();
							long payedTaxTmp = bPayedTaxTmp.setScale(0, BigDecimal.ROUND_HALF_UP).longValue();
							payedTax = (payedTaxTmp > taxFee) ? taxFee : payedTaxTmp;

							payedStatus = "1";
							curBalance = 0;
							oweFee = oweFee - payedOweTmp;
							delayFee = delayFee - payedDelayTmp;
							delayFavour = delayFavour - delayFavourTmp;
							taxFee = taxFee - payedTax;

							log.info("按条冲销----部分冲销----冲销：冲销欠费[" + payedOweTmp + "]" + "冲销滞纳金[" + payedDelayTmp + "]" + "滞纳金优惠[" + delayFavourTmp
									+ "]" + "冲销税额[" + payedTax + "]");

							log.info("按条冲销----部分冲销----冲销后：账本余额[" + curBalance + "]" + "欠费[" + oweFee + "]" + "滞纳金[" + delayFee + "]" + "滞纳金优惠["
									+ delayFavour + "]" + "税额[" + taxFee + "]");
						}

						balancePayedOwe = balancePayedOwe + payedOweTmp + payedDelayTmp;
						
						//系统充值账本，记录LATER_FAVOUR_EXTAX和LATER_FAVOUR_TAX
						long laterFavourTax = 0;
						long laterFavourExtax = 0;
						log.debug("liuyc_billing test: " + payAttr);
						if("1".equals(payAttr.substring(5, 6))){
							laterFavourTax = payedTax;
							laterFavourExtax = payedOweTmp*100 - payedTax;
						}
						
						

						log.info("当前账本冲销余额curBalance" + curBalance);
						log.info("payed for Delay Fee in the balance" + payedDelayTmp);

						// 记录账单变更List writeoffBill
						Map<String, Object> billMap = new HashMap<String, Object>();
						billMap.put("BILL_ID", billId);
						billMap.put("PAYED_LATER", payedOweTmp);
						billMap.put("PAYED_TAX", payedTax);
						billMap.put("PAYED_STATUS", payedStatus);
						billMap.put("PAY_STATUS", payStatus); // 账单类型
						billMap.put("PAYED_TYPE", 1); // 0：按账期冲销 1：按账单一条条冲销
						billMap.put("BILL_CYCLE", billCycle);
						billMap.put("NATURAL_MONTH", naturalMonth);
						billMap.put("VIRTUAL_OWE", "0");
						billMap.put("LATER_FAVOUR_TAX", laterFavourTax);
						billMap.put("LATER_FAVOUR_EXTAX", laterFavourExtax);
						writeOffBill.add(billMap);

						// 记录冲销List writeoffResult
						Map<String, Object> writeoffMap = new HashMap<String, Object>();
						writeoffMap.put("BALANCE_ID", bookMap.get("BALANCE_ID"));
						writeoffMap.put("PAY_TYPE", bookMap.get("PAY_TYPE"));
						writeoffMap.put("BILL_ID", billId);
						writeoffMap.put("PAYED_LATER", payedOweTmp);
						writeoffMap.put("PAYED_TAX", payedTax);
						writeoffMap.put("PAYED_TYPE", 1); // 0：按账期冲销 1：按账单一条条冲销
						writeoffMap.put("PRINT_FLAG", bookMap.get("PRINT_FLAG"));
						writeoffMap.put("DELAY_FAVOUR_RATE", delayFavourRate);
						writeoffMap.put("PAYED_DELAY", payedDelayTmp);
						writeoffMap.put("DELAY_FAVOUR", delayFavourTmp);
						writeoffMap.put("VIRTUAL_OWE", "0");
						writeOffResult.add(writeoffMap);

						// 记录支出List writeoffPayOut
						int payoutFlag = 0;
						for (Map<String, Object> payoutMapTmp : payOutResult) { // 合并支出记录

							if (conNo == longValue(payoutMapTmp.get("CONTRACT_NO"))
									&& longValue(bookMap.get("BALANCE_ID")) == longValue(payoutMapTmp.get("BALANCE_ID"))) {
								long outBalanceTmp = longValue(payoutMapTmp.get("OUT_BALANCE"));
								long delayFeeTmp1 = longValue(payoutMapTmp.get("DELAY_FEE"));
								long delayFavourTmp1 = longValue(payoutMapTmp.get("DELAY_FAVOUR"));
								payoutMapTmp.put("OUT_BALANCE", outBalanceTmp + payedOweTmp);
								payoutMapTmp.put("DELAY_FEE", delayFeeTmp1 + payedDelayTmp);
								payoutMapTmp.put("DELAY_FAVOUR", delayFavourTmp1 + delayFavourTmp);
								payoutFlag = 1;
								break;
							}

						}
						if (0 == payoutFlag) {
							Map<String, Object> payoutMap = new HashMap<String, Object>();
							payoutMap.put("ID_NO", idNo);
							payoutMap.put("PHONE_NO", phoneNo);
							payoutMap.put("CONTRACT_NO", conNo);
							payoutMap.put("BALANCE_ID", bookMap.get("BALANCE_ID"));
							payoutMap.put("PAY_TYPE", bookMap.get("PAY_TYPE"));
							payoutMap.put("OPER_TYPE", operType);
							payoutMap.put("OUT_BALANCE", payedOweTmp);
							payoutMap.put("DELAY_FEE", payedDelayTmp);
							payoutMap.put("DELAY_FAVOUR", delayFavourTmp);
							payOutResult.add(payoutMap);
						}
					}

				}
			}
			if (0 == balancePayedOwe) {
				log.info("该账本没有支出,退出");
				continue;
			}

			// 更新账本List writeoffAcct
			Map<String, Object> acctbookMap = new HashMap<String, Object>();
			acctbookMap.put("BALANCE_ID", bookMap.get("BALANCE_ID"));
			acctbookMap.put("PAYED_OWE", balancePayedOwe);
			witeOffBalance.add(acctbookMap);

			/*
			 * 将表中数据实际落地
			 */
			Map<String, Object> doRecdMap = new HashMap<String, Object>();
			doRecdMap.put("PAY_SN", paySn);
			doRecdMap.put("WRTOFF_SN", wrtoffSn);
			doRecdMap.put("BILL_LIST", writeOffBill);
			doRecdMap.put("BALANCE_LIST", witeOffBalance);
			doRecdMap.put("WRITEOFF_LIST", writeOffResult);
			doRecdMap.put("PAYOUT_LIST", payOutResult);
			doRecdMap.put("LOGIN_NO", loginNo);
			doRecdMap.put("GROUP_ID", groupId);
			doRecdMap.put("OP_CODE", opCode);
			doRecdMap.put("YEAR_MONTH", curTime.substring(0, 6));
			doDeadWriteOffRecd(doRecdMap);

		}

	}

	/**
	 * 名称：离网账户按账本优先级读取预存<br/>
	 * 
	 * @param contractNo: 账户ID
	 * @return LIST : 包含每条账本信息和账本能冲销的账目组
	 * @author guwoy
	 **/
	@SuppressWarnings("unchecked")
	private List<Map<String, Object>> getWrtOffBookDead(long contractNo) {

		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("CONTRACT_NO", contractNo);
		List<Map<String, Object>> bookList = baseDao.queryForList("bal_acctbook_dead.qGetAcctbookDeadByCon", inMap);
		List<Map<String, Object>> acctbookList = new ArrayList<Map<String, Object>>();
		for (Map<String, Object> bookMap : bookList) {

			if (Long.valueOf(bookMap.get("CUR_BALANCE").toString()) <= 0) {
				// 无预存款不加入列表
				continue;
			}

			/* 查找账本能够冲销的账面项组 */
			Map<String, Object> inMapTmp = new HashMap<String, Object>();
			inMapTmp.put("PAY_TYPE", bookMap.get("PAY_TYPE"));
			Map<String, Object> result = (Map<String, Object>) baseDao.queryForObject("bal_writeplan_conf.qWriteplanConf", inMapTmp);
			String acctItemGroup = result.get("ACCT_ITEM_GROUP").toString();

			bookMap.put("ACCT_ITEM_GROUP", acctItemGroup);

			acctbookList.add(bookMap);
		}

		return acctbookList;
	}

	@SuppressWarnings("unchecked")
	private void doDeadWriteOffRecd(Map<String, Object> inParam) {

		Map<String, Object> inMapTmp = null;

		log.info("冲销数据落地 doDeadWriteOffRecd begin : " + inParam.toString());

		List<Map<String, Object>> balanceList = (List<Map<String, Object>>) inParam.get("BALANCE_LIST");
		List<Map<String, Object>> writeoffList = (List<Map<String, Object>>) inParam.get("WRITEOFF_LIST");
		List<Map<String, Object>> payoutList = (List<Map<String, Object>>) inParam.get("PAYOUT_LIST");
		List<Map<String, Object>> billList = (List<Map<String, Object>>) inParam.get("BILL_LIST");

		// 更新账本预存
		for (Map<String, Object> balanceMap : balanceList) {

			if (longValue(balanceMap.get("PAYED_OWE")) != 0) {
				inMapTmp = new HashMap<String, Object>();
				inMapTmp.putAll(balanceMap);
				balance.updateAcctBookDead(longValue(balanceMap.get("BALANCE_ID")), longValue(balanceMap.get("PAYED_OWE")));
			}
		}

		// 记录账本支出表
		for (Map<String, Object> payoutMap : payoutList) {

			inMapTmp = new HashMap<String, Object>();
			inMapTmp.putAll(payoutMap);
			inMapTmp.put("PAY_SN", inParam.get("PAY_SN"));
			inMapTmp.put("WRTOFF_SN", inParam.get("WRTOFF_SN"));
			inMapTmp.put("CONTRACT_NO", payoutMap.get("CONTRACT_NO"));
			inMapTmp.put("STATUS", "0");
			inMapTmp.put("LOGIN_NO", inParam.get("LOGIN_NO"));
			inMapTmp.put("GROUP_ID", inParam.get("GROUP_ID"));
			inMapTmp.put("YEAR_MONTH", inParam.get("YEAR_MONTH"));
			baseDao.insert("bal_bookpayout_info.iBookPayOutInfo", inMapTmp);

			// 0账本移入历史表
			inMapTmp = new HashMap<String, Object>();
			inMapTmp.put("CONTRACT_NO", payoutMap.get("CONTRACT_NO"));
			inMapTmp.put("LOGIN_NO", inParam.get("LOGIN_NO"));
			balance.removeAcctBookDead(Long.parseLong(payoutMap.get("CONTRACT_NO").toString()), inParam.get("LOGIN_NO").toString(),Long.parseLong(inParam.get("WRTOFF_SN").toString()),inParam.get("OP_CODE").toString());

		}

		// 记录冲销表
		for (Map<String, Object> writeoffMap : writeoffList) {

			int payedType = Integer.parseInt(writeoffMap.get("PAYED_TYPE").toString()); // 0：按账期冲销
																						// 1：按账单一条条冲销

			inMapTmp = new HashMap<String, Object>();
			inMapTmp.putAll(writeoffMap);
			inMapTmp.put("WRTOFF_SN", inParam.get("WRTOFF_SN"));
			inMapTmp.put("STATUS", "0");
			inMapTmp.put("LOGIN_NO", inParam.get("LOGIN_NO"));
			inMapTmp.put("YEAR_MONTH", inParam.get("YEAR_MONTH"));
			if (1 == payedType) {
				baseDao.insert("bal_writeoff_yyyymm.iForBalWriteoffDead", inMapTmp);
			}

		}

		// 更新未冲销账单表 或 将未冲销账单移动到已冲销账单
		/* 取配置最小已冲销账单表日期 */
		String selDate = control.getPubCodeValue(108, "HISBILLYM", null); // 取配置的最小已冲销账单日期
		int billRules = Integer.parseInt(control.getPubCodeValue(101, "PAYEDOWE", null)); // 取是否动态月或者自然月配置

		log.info("doDeadWriteOffRecd selDate: " + selDate + "billRules " + billRules);
		String tablePayedowe = "";

		for (Map<String, Object> billMap : billList) {

			if (0 == billRules) { // 0: 按动态月账期存放
				if (longValue(billMap.get("BILL_CYCLE")) >= longValue(selDate)) {
					tablePayedowe = "ACT_PAYEDOWE_" + billMap.get("BILL_CYCLE").toString();
				} else {
					tablePayedowe = "ACT_PAYEDOWE_HIS";
				}
			} else {
				if (longValue(billMap.get("NATURAL_MONTH")) >= longValue(selDate)) {
					tablePayedowe = "ACT_PAYEDOWE_" + billMap.get("NATURAL_MONTH").toString();
				} else {
					tablePayedowe = "ACT_PAYEDOWE_HIS";
				}
			}

			if (1 == Integer.valueOf(billMap.get("PAYED_STATUS").toString())) { // 部分冲销
				// 更新未冲销账单
				inMapTmp = new HashMap<String, Object>();
				inMapTmp.put("BILL_ID", billMap.get("BILL_ID"));
				inMapTmp.put("PAYED_LATER", longValue(billMap.get("PAYED_LATER")));
				inMapTmp.put("PAYED_TAX", longValue(billMap.get("PAYED_TAX")));
				int sqlRows = baseDao.update("act_deadowe_info.uDeadpayowe", inMapTmp);
				if (0 == sqlRows) {
					log.info("未冲销账单不存在或正在冲销");
					throw new BusiException(AcctMgrError.getErrorCode("0000", "0000"), "未冲销账单不存在或正在冲销bill_id :  " + billMap.get("BILL_ID"));
				}

			} else { // 当条账单全部冲销
				// 账单移入已冲销账单表
				inMapTmp = new HashMap<String, Object>();
				inMapTmp.put("BILL_ID", billMap.get("BILL_ID"));
				inMapTmp.put("TABLE_PAYEDOWE", tablePayedowe);
				inMapTmp.put("BILL_CYCLE", billMap.get("BILL_CYCLE"));
				inMapTmp.put("PAYED_LATER", billMap.get("PAYED_LATER"));
				inMapTmp.put("PAYED_TAX", billMap.get("PAYED_TAX"));
				inMapTmp.put("PAYED_STATUS", billMap.get("PAY_STATUS"));
				inMapTmp.put("VIRTUAL_OWE", billMap.get("VIRTUAL_OWE"));
				inMapTmp.put("LATER_FAVOUR_TAX", billMap.get("LATER_FAVOUR_TAX"));
				inMapTmp.put("LATER_FAVOUR_EXTAX", billMap.get("LATER_FAVOUR_EXTAX"));
				baseDao.insert("act_payedowe_info.iPayedFromDeadOwe", inMapTmp);

				inMapTmp = new HashMap<String, Object>();
				inMapTmp.put("BILL_ID", billMap.get("BILL_ID"));
				int sqlRows = baseDao.delete("act_deadowe_info.delDeadOweById", inMapTmp);
				log.info("删除未冲销账单条数: " + sqlRows);
				if (0 == sqlRows) {
					log.info("未冲销账单不存在或正在冲销");
					throw new BusiException(AcctMgrError.getErrorCode("0000", "0000"), "未冲销账单不存在或正在冲销bill_id :  " + billMap.get("BILL_ID"));
				}
			}
		}

	}

	private List<Map<String, Object>> getUnPayBillCycle(long lContractNo) {

		Map<String, Object> mOutParam = new HashMap<String, Object>(); // 出参

		Map<String, Object> inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("CONTRACT_NO", lContractNo);

		List<Map<String, Object>> resultList = baseDao.queryForList("act_unpayowe_info.qUnpayoweBycon", inMapTmp);

		return resultList;
	}

	/**
	 * 名称：读取离网未冲销欠费账期
	 * 
	 * @param idNo 用户ID
	 * @param status 陈死账账单状态 1：陈账 4：死账
	 * @param contractNo 账户ID（可选）
	 * @return resultList.BILL_CYCLE : 存放未冲销欠费账期List
	 * @author guowy
	 * */
	@Override
	public List<Map<String, Object>> getDeadOweBillCycle(Long idNo, Long contractNo, String status) {

		Map<String, Object> inMapTmp = new HashMap<String, Object>();

		inMapTmp.put("ID_NO", idNo);
		inMapTmp.put("STATUS", status);
		if (contractNo != null && contractNo > 0) {
			inMapTmp.put("CONTRACT_NO", contractNo);
		}
		List<Map<String, Object>> resultList = baseDao.queryForList("act_deadowe_info.qryBillCycle", inMapTmp);

		return resultList;
	}

	@Override
	public OutFeeData getOffLineConPre(Long contractNo, Double delayFavourRate, UnbillEntity unbill) {

		Map<String, Object> inMapTmp = null;
		Map<String, Object> outMapTmp = null;
		long commonRemainFee = 0;		//普通预存款余额
		long prepayFee = 0;				//普通预存款
		long specialRemainFee = 0;		//专款预存款余额
		long specialFee = 0;			//专款预存款
		
		inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("CONTRACT_NO", contractNo);
		outMapTmp = delay.getDelayRate(inMapTmp);
		double delayRate = (Double) outMapTmp.get("DELAY_RATE");
		int beginDelayDay = (Integer) outMapTmp.get("DELAY_BEGIN");

		/*取预存款列表*/
		List<Map<String, Object>> balanceList = getWrtOffBook(contractNo);
		List<Map<String, Object>> specialList = new ArrayList<Map<String, Object>>();
		for(Map<String, Object> balanceTmp : balanceList){
			
			String payAttr = balanceTmp.get("PAY_ATTR").toString();
			if("0".equals(payAttr.substring(0, 1))){		//专款
				
				specialFee = specialFee + Long.parseLong(balanceTmp.get("CUR_BALANCE").toString());
				
				int flag = 0;
				for (Map<String, Object> bookTmp : specialList) {
							
					if (bookTmp.get("PAY_TYPE").toString().equals(balanceTmp.get("PAY_TYPE").toString())) {

						long curBalance = ValueUtils.longValue(bookTmp.get("CUR_BALANCE")) + ValueUtils.longValue(balanceTmp.get("CUR_BALANCE"));
						bookTmp.put("CUR_BALANCE", curBalance);

						flag = 1;
					} else {
						continue;
					}
				}
				if(0 == flag){
					
					Map<String, Object> balanceMap = new HashMap<String, Object>();
					balanceMap.put("PAY_TYPE", balanceTmp.get("PAY_TYPE"));
					balanceMap.put("CUR_BALANCE", balanceTmp.get("CUR_BALANCE"));
					balanceMap.put("PAY_ATTR", balanceTmp.get("PAY_ATTR"));
					balanceMap.put("ACCT_ITEM_GROUP", balanceTmp.get("ACCT_ITEM_GROUP"));
					specialList.add(balanceTmp);
				}
				
			}else{
				
				prepayFee = prepayFee + Long.parseLong(balanceTmp.get("CUR_BALANCE").toString());
			}
		}
		
		//取库内欠费
		inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("CONTRACT_NO", contractNo);
		List<BillEntity> billList = bill.getUnPayOwe(inMapTmp);
		
		//取账户所有代付用户总内存欠费
		List<BillEntity> unbillList = unbill.getUnBillList();
		List<BillEntity> payoweList = unbill.getPayedOweList();
		
		billList.addAll(unbillList);
		billList.addAll(payoweList);
		
		String acctItemCode = "";
		String acctItemGroup = "";
		long specialTmp = 0;
		int i = 0;
		long oweFee = 0;		//每条欠费账单
		long totalOweFee = 0;	//需要普通预存款扣减的欠费
		for(BillEntity bill: billList){
			
			acctItemCode = bill.getAcctItemCode();
			oweFee = bill.getOweFee();
			if(oweFee == 0){
				continue;
			}
			
			for(Map<String, Object> balanceTmp : specialList){
				
				if(i == specialList.size()){
					log.info("可虚拟划拨专款账本预存款已经全部划拨完毕，specialList: " + specialList);
					break;
				}
				
				specialTmp = Long.parseLong(balanceTmp.get("CUR_BALANCE").toString());
				if(specialTmp <= 0){
					i++;
					continue;
				}
				
				acctItemGroup = balanceTmp.get("ACCT_ITEM_GROUP").toString();
				if(isWriteOff(acctItemGroup, acctItemCode)){		//能否冲销
					
					if (specialTmp >= oweFee) { // 单条账单全部划拨

						log.info("按条冲销----完全冲销----冲销前：账本余额[" + specialTmp + "]" + "欠费[" + bill.getOweFee() 
								+ "]" + "滞纳金[" + 0 + "]" + "滞纳金优惠["+ 0 + "]");

						specialTmp = specialTmp - oweFee;
						oweFee = 0;
						balanceTmp.put("CUR_BALANCE", specialTmp);

						log.info("按条冲销----完全冲销----冲销后：账本余额[" + specialTmp + "]");

					} else { // 单条账单部分划拨
						
						log.info("按条冲销----部分冲销----冲销前：账本余额[" + specialTmp + "]" + "欠费[" + bill.getOweFee() 
								+ "]" + "滞纳金[" + 0 + "]" + "滞纳金优惠["+ 0 + "]");
						
						oweFee = oweFee - specialTmp;
						specialTmp = 0;
						balanceTmp.put("CUR_BALANCE", specialTmp);
						
						log.info("按条冲销----部分冲销----冲销后：账本余额[" + specialTmp + "]");
					}
				}
				
				if(oweFee == 0){
					break;
				}
			}
			
			if(oweFee > 0){
				
				totalOweFee = totalOweFee + oweFee;
			}
			
		}
		
		commonRemainFee = prepayFee - totalOweFee;
		for(Map<String, Object> balanceTmp : specialList){
			
			specialRemainFee = specialRemainFee + Long.parseLong(balanceTmp.get("CUR_BALANCE").toString());
		}

		OutFeeData outFee = new OutFeeData();
		outFee.setRemainFee(commonRemainFee + specialRemainFee);
		outFee.setCommonRemainFee(commonRemainFee);
		outFee.setSpecialRemainFee(specialRemainFee);
		
		return outFee;
	}

	@Override
	public Map<String, Object> getOnLineConPre(Long contractNo, Double delayFavourRate, List<BalanceEntity> unBillBookList,
			List<BillEntity> unBillBillList) {

		// TODO 需要完善虚销内容

		Map<String, Object> outMap = new HashMap<>();
		safeAddToMap(outMap, "CUR_PERPAY", 0);
		safeAddToMap(outMap, "OWE_FEE", 0);
		safeAddToMap(outMap, "CUR_SEPC_PERPAY", 0);
		safeAddToMap(outMap, "OWE_FEE_ALL", 0);
		safeAddToMap(outMap, "UNBILL_FEE_ALL", 0);
		return outMap;
	}
	
	private boolean isWriteOff(String acctItemGroup, String acctItemCode){
		
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("ACCT_ITEM_GROUP", acctItemGroup);
		inMap.put("ACCT_ITEM_CODE", acctItemCode);
		Integer result = (Integer)baseDao.queryForObject("act_item_group_detail.isWriteOff", inMap);
		if(result > 0){
			
			return true;
		}else{
			return false;
		}
	}

	
	public IBusiMsgSnd getBusiMsgsnd() {
		return busiMsgsnd;
	}

	public void setBusiMsgsnd(IBusiMsgSnd busiMsgsnd) {
		this.busiMsgsnd = busiMsgsnd;
	}

	public IControl getControl() {
		return control;
	}

	public void setControl(IControl control) {
		this.control = control;
	}

	public IBill getBill() {
		return bill;
	}

	public void setBill(IBill bill) {
		this.bill = bill;
	}

	public IBalance getBalance() {
		return balance;
	}

	public void setBalance(IBalance balance) {
		this.balance = balance;
	}

	public IDelay getDelay() {
		return delay;
	}

	public void setDelay(IDelay delay) {
		this.delay = delay;
	}

	public IUser getUser() {
		return user;
	}

	public void setUser(IUser user) {
		this.user = user;
	}

}
