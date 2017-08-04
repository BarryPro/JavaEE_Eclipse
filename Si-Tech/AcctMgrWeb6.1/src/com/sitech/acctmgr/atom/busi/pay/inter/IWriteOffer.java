package com.sitech.acctmgr.atom.busi.pay.inter;

import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.balance.BalanceEntity;
import com.sitech.acctmgr.atom.domains.bill.BillEntity;
import com.sitech.acctmgr.atom.domains.bill.UnbillEntity;
import com.sitech.acctmgr.atom.domains.fee.OutFeeData;

/**
 *
 * <p>
 * Title:
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author
 * @version 1.0
 */
public interface IWriteOffer {

	/**
	 * 名称：冲销<br/>
	 * <ol>
	 * <li>判断是否执行冲销</li>
	 * <ol>
	 * <li>判断是否出账期间，出账期间不做冲销</li>
	 * <li>判断是否有库内欠费</li>
	 * </ol>
	 * <li>根据配置判断执行实时冲销或者异步冲销</li> 
	 * <li>调用实时冲销方法或者异步冲销方法完成冲销</li> </ol>
	 * 
	 * @param Header: Map<String, Object>
	 * @param PAY_SN:		缴费入账流水
	 * @param CONTRACT_NO: 	账户Id
	 * @param PHONE_NO:		用户号码，可空
	 * @param LOGIN_NO: 	缴费工号
	 * @param GROUP_ID:		 缴费工号机构归属
	 * @param DELAY_FAVOUR_RATE: 滞纳金优惠率 ,可空，默认0
	 * @param OP_CODE:		 模块编码
	 * @param BILL_YM: 		 冲销账期，可空
	 * @param ANSY_FLAG: 	 同步冲销标志，默认为0(自动判断是否异步冲销),1为异步
	 * @param PAY_PATH: 	 渠道标识
	 * 
	 * @return 如果不需要冲销返回0，如果发生冲销，返回冲销流水
	 * @author qiaolin
	 */
	public abstract long doWriteOff(Map<String, Object> inParam);

	/**
	 * 名称：实时冲销<br/>
	 * <ol>
	 * <li>判断是否执行冲销</li>
	 * <ol>
	 * <li>判断是否出账期间，出账期间不做冲销</li>
	 * <li>判断是否有库内欠费</li>
	 * </ol>
	 * <li>冲销数据准备</li>
	 * <ol>
	 * <li>读取滞纳金标志和比率</li>
	 * <li>按账本优先级读取预存，将账本预存放到balanceList中</li>
	 * <li>读取欠费账期,将账期存放到billcycleList中</li>
	 * <li>按付费顺序读取用户，将用户存放到phoneList中</li>
	 * <li>取冲销流水</li>
	 * </ol>
	 * <li>调用实际冲销函数做冲销</li> </ol>
	 * 
	 * @param PAY_SN: 缴费入账流水
	 * @param CONTRACT_NO: 账户Id
	 * @param PHONE_NO: 用户号码，可空
	 * @param LOGIN_NO: 缴费工号
	 * @param GROUP_ID: 缴费工号机构归属
	 * @param DELAY_FAVOUR_RATE: 滞纳金优惠率 ,可空，默认0
	 * @param OP_CODE: 模块编码
	 * @param BILL_YM: 冲销账期，可空
	 * @param flag: int, 判断是否直接调用 0 否 1 直接调用
	 * 
	 * @return 如果不需要冲销返回NULL，如果发生冲销，返回WRITEOFF_SN
	 * @author qiaolin
	 */
	public abstract long doRealWriteOff(Map<String, Object> inParam, int flag);

	/**
	 * 名称：离网账单冲销
	 * 
	 * @param inMapTmp
	 * @author guowy
	 */
	public abstract void doRealDeadWriteOff(Map<String, Object> inMapTmp);

	/**
	 * 功能：获取帐户虚拟划拨后余额信息
	 * 
	 * @param contractNo
	 * @param unbill		: 包含调用完帐处接口的未出帐账单信息
	 * @return OutFeeData	: 返回 remainFee: 当前余额；commonRemainFee： 普通预存款余额； specialRemainFee：专款预存款余额
	 */
	OutFeeData getOffLineConPre(Long contractNo, Double delayFavourRate, UnbillEntity unbill);

	Map<String, Object> getOnLineConPre(Long contractNo, Double delayFavourRate, List<BalanceEntity> unBillBookList, List<BillEntity> unBillBillList);

	/**
	 * 功能：读取离网未冲销欠费账期
	 * 
	 * @param idNo
	 * @param contractNo
	 * @param status
	 *            陈死账账单状态 1：陈账 4：死账
	 * @return
	 */
	List<Map<String, Object>> getDeadOweBillCycle(Long idNo, Long contractNo, String status);
}