package com.sitech.acctmgr.atom.busi.invoice;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.sitech.acctmgr.atom.busi.invoice.inter.IInvFee;
import com.sitech.acctmgr.atom.busi.pay.inter.IWriteOffer;
import com.sitech.acctmgr.atom.busi.query.inter.IRemainFee;
import com.sitech.acctmgr.atom.domains.balance.ReturnFeeEntity;
import com.sitech.acctmgr.atom.domains.balance.TransFeeEntity;
import com.sitech.acctmgr.atom.domains.bill.BillEntity;
import com.sitech.acctmgr.atom.domains.bill.UnBillData;
import com.sitech.acctmgr.atom.domains.bill.UnbillEntity;
import com.sitech.acctmgr.atom.domains.invoice.BalInvprintInfoEntity;
import com.sitech.acctmgr.atom.domains.invoice.MealEntity;
import com.sitech.acctmgr.atom.domains.invoice.MonthInvoiceDispEntity;
import com.sitech.acctmgr.atom.domains.invoice.PreInvoiceDispEntity;
import com.sitech.acctmgr.atom.domains.invoice.TaxInvoiceFeeEntity;
import com.sitech.acctmgr.atom.domains.pay.PayMentEntity;
import com.sitech.acctmgr.atom.domains.pub.PubCodeDictEntity;
import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.atom.entity.inter.IAdj;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.IBill;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.IInvoice;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.acctmgr.common.constant.CommonConst;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;

/**
 * 名称：发票展示上跟费用有关的信息
 * 
 * @author fanck
 *
 */
@SuppressWarnings({ "unchecked", "unused" })
public class InvFee extends BaseBusi implements IInvFee {

	private IBill bill;
	protected IInvoice invoice;
	protected IBalance balance;
	protected IRecord record;
	protected IAccount account;
	protected IControl control;
	protected IAdj adj;
	protected IUser user;
	private IRemainFee reFee;
	private IGroup group;
	protected UnBillData unBillData;
	protected IWriteOffer writeOffer;

	// 6税率
	private final double addTaxRate = 0.06;
	// 11税率
	private final double telTaxRate = 0.11;

	@Override
	public PreInvoiceDispEntity getPreInvoiceFee(Map<String, Object> inParam) {
		long balanceFee = 0;
		long unbillFee = 0;
		long remainFee = 0;
		long billFee = 0;
		long delayFee = 0;
		long cashMoney = 0;
		long checkMoney = 0;
		long posMoney = 0;
		long printFee = 0;
		String checkNo = "";
		int yearMonth = 0;

		int userFlag = ValueUtils.intValue(inParam.get("USER_FLAG").toString());
		// String opCode = inParam.get("OP_CODE").toString();
		long paySn = ValueUtils.longValue(inParam.get("PAY_SN"));
		int billCycle = ValueUtils.intValue(inParam.get("BILL_CYCLE"));

		// 根据流水获取缴费信息
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("PAY_SN", paySn);
		inMap.put("SUFFIX", billCycle);
		inMap.put("CONTRACT_NO", inParam.get("CONTRACT_NO"));
		inMap.put("ACCPERT_PAYTYPE", "zhixing");
		log.debug("查询缴费信息的入参：" + inMap);
		List<PayMentEntity> paymentList = record.getPayMentList(inMap);
		log.debug("查询缴费记录：" + paymentList);
		if (paymentList.size() == 0 || paymentList == null) {
			throw new BusiException(AcctMgrError.getErrorCode("0000", "70001"), "未查询到相关的缴费记录!");
		}
		// PayMentEntity payment = new PayMentEntity();
		for (PayMentEntity payment : paymentList) {
			printFee += payment.getPayFee();

			if (payment.getPayMethod().equals("9")) {
				checkMoney += payment.getPayFee();
				// 查询支票号码
				inMap.put("PAY_SN", paySn);
				Map<String, Object> checkMap = (Map<String, Object>) baseDao.queryForObject("bal_checkopr_recd.qryCheckNo", inMap);
				if (checkMap != null) {
					checkNo = checkMap.get("CHECK_NO").toString();
				}

			} else if (payment.getPayMethod().equals("0") || payment.getPayMethod().equals("i")) {
				cashMoney += payment.getPayFee();
			} else if (payment.getPayMethod().equals("W")) {
				posMoney += payment.getPayFee();
				// 查询pos机缴费信息
				yearMonth = payment.getYearMonth();
			}
		}

		if (userFlag == CommonConst.IN_NET) {
			log.debug("查询在网用户的费用信息");
			// 查询话费余额，未出帐话费，当前可用余额

			long contractNo = ValueUtils.longValue(inParam.get("CONTRACT_NO").toString());
			log.debug(inParam.get("CONTRACT_NO").toString() + "查询话费时的账号：" + contractNo);
			long idNo = 0;
			if (inParam.get("ID_NO") != null && ValueUtils.longValue(inParam.get("ID_NO")) > 0) {
				ValueUtils.longValue(inParam.get("ID_NO"));
			}
			long prepay = balance.getAcctBookSum(contractNo, "");
			UnbillEntity unbillEntity = bill.getUnbillFee(contractNo, idNo, CommonConst.UNBILL_TYPE_BILL_TOT);
			unbillFee = unbillEntity.getUnBillFee();
			// 获取欠费信息
			Map<String, Long> oweMap = bill.getSumUnpayInfo(contractNo, idNo, 0);
			long oweFee = oweMap.get("OWE_FEE");
			balanceFee = prepay - oweFee > 0 ? prepay - oweFee : 0;
			remainFee = balanceFee - unbillFee > 0 ? balanceFee - unbillFee : 0;
			// OutFeeData outFee = remainFee.getConRemainFee(contractNo);
		} else {
			// 获取冲销的账单和滞纳金
			inMap = new HashMap<String, Object>();
			inMap.put("PAY_SN", paySn);
			inMap.put("YEAR_MONTH", billCycle);
			Map<String, Object> outFeeMap = balance.getWriteFeeByPaySn(inMap);
			billFee = ValueUtils.longValue(outFeeMap.get("OUT_FEE"));
			delayFee = ValueUtils.longValue(outFeeMap.get("DELAY_FEE"));
		}

		PreInvoiceDispEntity preInvoiceDisp = new PreInvoiceDispEntity();
		preInvoiceDisp.setBalanceFee(balanceFee);
		preInvoiceDisp.setBillFee(billFee);
		preInvoiceDisp.setCashMoney(cashMoney);
		preInvoiceDisp.setCheckMoney(checkMoney);
		preInvoiceDisp.setDelayFee(delayFee);
		preInvoiceDisp.setPosMoney(posMoney);
		preInvoiceDisp.setPrintFee(printFee);
		preInvoiceDisp.setRemainFee(remainFee);
		preInvoiceDisp.setPayMethod(paymentList.get(0).getPayMethod());
		preInvoiceDisp.setRemark(paymentList.get(0).getRemark());
		preInvoiceDisp.setUnbillFee(unbillFee);
		preInvoiceDisp.setBillCycle(billCycle);
		preInvoiceDisp.setCheckNo(checkNo);
		preInvoiceDisp.setPayDate(paymentList.get(0).getTotalDate());
		preInvoiceDisp.setOpName(paymentList.get(0).getFunctionName());
		preInvoiceDisp.setOpCode(paymentList.get(0).getOpCode());
		return preInvoiceDisp;
	}

	@Override
	// 由于在更新冲销记录的时候，需要使用bill_id，所以返回bill_id
	public Map<String, Object> getMonthInvoiceFee(Map<String, Object> inParam) {
		// 根据账务日期查询冲销的账单金额
		int billCycle = ValueUtils.intValue(inParam.get("BILL_CYCLE"));

		long totalPrinted = 0l;// 总的已打印发票金额
		long systemPrint = 0;// 系统充值账本冲销的账单金额
		long cardPrint = 0;// 卡类账本冲销的账单金额
		long prepayPrinted = 0l;// 预存款已出具发票金额
		long cardPrinted = 0l;// 卡类已出具发票金额
		long systemPrinted = 0l;// 系统充值已出具发票金额
		long billFeeTotal = 0l;// 通信服务费
		long discountFee = 0l;// 销售折扣
		long mealFee = 0l;// 合约套餐费
		long otherPrinted = 0l;// 其他已出具发票金额
		long totalprint = 0;// 合计
		long printFee = 0;// 发票金额
		long monthPrinted = 0;// 已打印月结发票
		Map<String, Object> inMap = new HashMap<String, Object>();

		// 判断是否打印过月结发票
		boolean isPrintMonthInv = invoice.isPrintMonthInvoice(ValueUtils.intValue(inParam.get("BILL_CYCLE")),
				ValueUtils.longValue(inParam.get("CONTRACT_NO")), billCycle);
		if (isPrintMonthInv) {
			throw new BusiException(AcctMgrError.getErrorCode("8224", "00001"), "已打印过月结发票或增值税发票");
		}

		// 查询合约套餐的pay_type
		List<String> mealPayTypeList = new ArrayList<String>();
		if (StringUtils.isNotEmptyOrNull(inParam.get("MEAL_LIST"))) {

			List<MealEntity> mealList = (List<MealEntity>) inParam.get("MEAL_LIST");
			for (MealEntity mealEntity : mealList) {
				// 判断是否已经打印了预存发票
				String foreignSn = mealEntity.getHyAccept();
				List<ReturnFeeEntity> returnFeeList = balance.getReturnFeeInfo(ValueUtils.longValue(inParam.get("CONTRACT_NO")), foreignSn, "1");
				a: for (ReturnFeeEntity returnFee : returnFeeList) {
					// 判断是否打印过预存发票，由于割接前的打印发票的数据不在bal_writeoff中记录，所以根据foreign_sn查询bal_invprint_info表中的记录
					int beginTime = ValueUtils.intValue(returnFee.getBeginTime());
					String printSn = returnFee.getForeginSn();
					Map<String, Object> invoiceMap = new HashMap<String, Object>();
					invoiceMap.put("PRINT_SN", printSn);
					for (int ym = beginTime; ym <= DateUtils.getCurYm(); ym = DateUtils.addMonth(ym, 1)) {
						invoiceMap.put("SUFFIX", ym + "");
						BalInvprintInfoEntity invoiceEntity = invoice.qryInvoiceInfo(inParam);
						if (invoiceEntity != null) {
							continue a;
						}
					}
					mealPayTypeList.add(returnFee.getPayType());
				}
			}
		}

		List<Map<String, Object>> payTypeMapList = balance.getGiftPayType();
		// 话费红包充值也不允许打印发票
		long codeClass = 1108;
		List<PubCodeDictEntity> pubCodeList = control.getPubCodeList(codeClass, "", "", "");
		List<String> payTypeList = new ArrayList<>();
		for (Map<String, Object> payTypeMap : payTypeMapList) {
			payTypeList.add(payTypeMap.get("PAY_TYPE").toString());
		}
		for (PubCodeDictEntity pubCode : pubCodeList) {
			payTypeList.add(pubCode.getCodeId());
		}
		List<BillEntity> billList = new ArrayList<BillEntity>();
		List<Long> billIdList = new ArrayList<Long>();
		BillEntity billEntity = new BillEntity();
		inMap.put("CONTRACT_NO", inParam.get("CONTRACT_NO"));
		inMap.put("BILL_CYCLE", inParam.get("BILL_CYCLE"));
		inMap.put("STATUS", "0");
		inMap.put("BILL_DAY", 9000);
		List<Map<String, Object>> writeoffList = new ArrayList<Map<String, Object>>();
		Set<Long> balanceSet = new HashSet<Long>();
		for (int yearMonth = billCycle; yearMonth <= DateUtils.getCurYm(); yearMonth = DateUtils.addMonth(yearMonth, 1)) {
			// 从冲销表中查询冲销的账单，冲销的账单如果已经打印过，获取账单id
			inMap.put("SUFFIX", yearMonth);
			List<Map<String, Object>> writeOffListTmp = bill.getWriteInfo(inMap);
			log.debug("冲销记录为：" + writeOffListTmp);

			for (Map<String, Object> writeOff : writeOffListTmp) {
				balanceSet.add(ValueUtils.longValue(writeOff.get("BALANCE_ID")));
				long payFee = ValueUtils.longValue(writeOff.get("PAY_FEE"));
				// billFeeTotal += payFee;
				String payType = writeOff.get("PAY_TYPE").toString();
				int printFlag = ValueUtils.intValue(writeOff.get("PRINT_FLAG"));
				if (payTypeList.contains(payType) && printFlag != 2) {

					systemPrint += payFee;
				}
				if (payType.equals("d") && printFlag != 2) {
					cardPrint += payFee;
				}
				if (mealPayTypeList.contains(payType) && printFlag != 2) {
					mealFee += payFee;
				}
				if (printFlag == 2) {
					totalPrinted += payFee;
					if (payTypeList.contains(payType)) {
						systemPrinted += payFee;
					}
					if (payType.equals("d")) {
						cardPrinted += payFee;
					}
				}
				// 由于老系统冲销记录表中不会标记状态，所以从bal_invprint_info表中查询是否打印过记录，如果打印过，不予许打印
				if (printFlag == 1 || printFlag == 3) {
					throw new BusiException(AcctMgrError.getErrorCode("8224", "00001"), "已打印过月结发票或增值税发票");
				}
			}
		}
		// 根据balance_id判断该账本是否还有余额
		List<Long> paySnList = new ArrayList<Long>();
		for (long balanceId : balanceSet) {
			Map<String, Object> balanceMap = new HashMap<String, Object>();
			balanceMap.put("BALANCE_ID", balanceId);
			Map<String, Object> outMap = (Map<String, Object>) baseDao.queryForObject("bal_acctbook_info.qByBalanceId", balanceMap);
			long curBalance = 0;
			if (outMap != null) {
				curBalance = ValueUtils.longValue(outMap.get("CUR_BALANCE"));
			}

			if (curBalance > 0) {
				// 查询pay_sn
				paySnList.add(ValueUtils.longValue(outMap.get("PAY_SN")));
			}
		}
		cardPrinted += cardPrint;
		systemPrinted += systemPrint;
		totalPrinted = totalPrinted + cardPrint + systemPrint;
		// 预存已出具发票金额
		prepayPrinted = totalPrinted - cardPrinted - systemPrinted;

		// 查询总金额和优惠金额
		inMap = new HashMap<>();
		inMap.put("CONTRACT_NO", inParam.get("CONTRACT_NO"));
		inMap.put("BILL_CYCLE", billCycle);
		inMap.put("BUSHOU", "y");
		Map<String, Long> payMap = bill.getSumPayedInfo(inMap);
		discountFee = ValueUtils.longValue(payMap.get("FAVOUR_FEE"));
		billFeeTotal = ValueUtils.longValue(payMap.get("SHOULD_PAY"));
		totalprint = billFeeTotal - discountFee;
		printFee = totalprint - totalPrinted;
		if (printFee < 0) {
			printFee = 0;
		}

		MonthInvoiceDispEntity monthInvoDisp = new MonthInvoiceDispEntity();

		monthInvoDisp.setCommuniteFee(billFeeTotal);
		monthInvoDisp.setDiscountFee(discountFee);
		monthInvoDisp.setMealFee(mealFee);
		monthInvoDisp.setTotalFee(totalprint);

		monthInvoDisp.setPrintedFee(totalPrinted);
		monthInvoDisp.setPrePrintedFee(prepayPrinted);
		monthInvoDisp.setCardPrintedFee(cardPrinted);
		monthInvoDisp.setSysPayPrintedFee(systemPrinted);
		monthInvoDisp.setOtherPrintFee(otherPrinted);
		monthInvoDisp.setBillCycle(billCycle);

		monthInvoDisp.setPrintFee(printFee);
		Map<String, Object> outMap = new HashMap<String, Object>();
		outMap.put("MONTH_INVOICE_DISP", monthInvoDisp);
		outMap.put("BILL_ID_LIST", billIdList);
		outMap.put("PAY_SN_LIST", paySnList);
		return outMap;
	}

	@Override
	public List<TaxInvoiceFeeEntity> getTaxInvoFeeTotalForTaxPrint(List<TaxInvoiceFeeEntity> invoiceFeeDetailList) {
		// List<TaxInvoiceFeeEntity> invoiceFeeDetailList = getTaxInvoFeeDetail(contractStr, beginYm, endYm);
		List<TaxInvoiceFeeEntity> invoiceFeeTotalList = new ArrayList<TaxInvoiceFeeEntity>();
		TaxInvoiceFeeEntity taxInvoice61 = new TaxInvoiceFeeEntity();// 0.06税率的非折扣折让
		TaxInvoiceFeeEntity taxInvoice62 = new TaxInvoiceFeeEntity();// 0.06税率的折扣折让
		TaxInvoiceFeeEntity taxInvoice111 = new TaxInvoiceFeeEntity();// 0.11税率的非折扣折让
		TaxInvoiceFeeEntity taxInvoice112 = new TaxInvoiceFeeEntity();// 0.11税率的折扣折让

		// 税率为0.06的变量
		long taxFee6 = 0;
		long discountTaxFee6 = 0;

		long write6 = 0;
		long discountWrite6 = 0;

		// 税率为0.11的变量
		long taxFee11 = 0;
		long discountTaxFee11 = 0;

		long write11 = 0;
		long discountWrite11 = 0;

		List<Map<String, Object>> payTypeMapList = balance.getGiftPayType();
		List<String> payTypeList = new ArrayList<String>();
		for (Map<String, Object> payTypeMap : payTypeMapList) {
			payTypeList.add(payTypeMap.get("PAY_TYPE").toString());
		}
		log.debug("冲销列表：" + invoiceFeeDetailList);
		for (TaxInvoiceFeeEntity invoiceDetail : invoiceFeeDetailList) {
			// log.debug(invoiceDetail);
			if (payTypeList.contains(invoiceDetail.getPayType())) {
				// 折扣折让的
				if (Double.parseDouble(invoiceDetail.getTaxRate()) == 0.06) {
					discountWrite6 -= invoiceDetail.getWriteFee();
					discountTaxFee6 = ValueUtils.longValue(discountTaxFee6) - ValueUtils.longValue(invoiceDetail.getTaxFee());
					write6 += invoiceDetail.getWriteFee();
					taxFee6 = ValueUtils.longValue(taxFee6) + ValueUtils.longValue(invoiceDetail.getTaxFee());
				}
				if (Double.parseDouble(invoiceDetail.getTaxRate()) == 0.11) {
					discountWrite11 -= invoiceDetail.getWriteFee();
					discountTaxFee11 = ValueUtils.longValue(discountTaxFee11) - ValueUtils.longValue(invoiceDetail.getTaxFee());
					write11 += invoiceDetail.getWriteFee();
					taxFee11 = ValueUtils.longValue(taxFee11) + ValueUtils.longValue(invoiceDetail.getTaxFee());
				}
				// 黑龙江没有找到tax_rate=1的数据，如果有的话再补充
				if (Double.parseDouble(invoiceDetail.getTaxRate()) == 1) {

				}
			} else {
				// 折扣折让的
				if (Double.parseDouble(invoiceDetail.getTaxRate()) == 0.06) {
					write6 += invoiceDetail.getWriteFee();
					taxFee6 = ValueUtils.longValue(taxFee6) + ValueUtils.longValue(invoiceDetail.getTaxFee());
				}
				if (Double.parseDouble(invoiceDetail.getTaxRate()) == 0.11) {
					write11 += invoiceDetail.getWriteFee();
					taxFee11 = ValueUtils.longValue(taxFee11) + ValueUtils.longValue(invoiceDetail.getTaxFee());
				}
				// 黑龙江没有找到tax_rate=1的数据，如果有的话再补充
				if (Double.parseDouble(invoiceDetail.getTaxRate()) == 1) {

				}
			}
		}
		// // 获取商品名称
		// long codeClass = 105;
		if (write11 > 0) {
			// 获取商品名称
			String groupId = "0";
			String codeId = "0.11";
			// String codeValue = control.getPubCodeValue(codeClass, codeId, groupId);
			taxInvoice111.setGoodsName("基础通信费");
			taxInvoice111.setGoodsNum("1");
			taxInvoice111.setGoodsPrice((new BigDecimal(write11 - ValueUtils.longValue(taxFee11) / 100.0).setScale(0, BigDecimal.ROUND_HALF_UP)
					.longValue()) + "");
			taxInvoice111.setInvoiceFee((new BigDecimal(write11 - ValueUtils.longValue(taxFee11) / 100.0).setScale(0, BigDecimal.ROUND_HALF_UP)
					.longValue()) + "");
			taxInvoice111.setTaxRate("0.11");
			taxInvoice111.setTaxFee(new BigDecimal(taxFee11 / 100.0).setScale(0, BigDecimal.ROUND_HALF_UP).longValue() + "" + "");
			invoiceFeeTotalList.add(taxInvoice111);
		}
		if (write6 > 0) {
			// 获取商品名称
			String groupId = "0";
			// String codeId = "0.06";
			// String codeValue = control.getPubCodeValue(codeClass, codeId, groupId);
			taxInvoice61.setGoodsName("增值业务费");
			taxInvoice61.setGoodsNum("1");
			taxInvoice61.setGoodsPrice((new BigDecimal(write6 - ValueUtils.longValue(taxFee6) / 100.0).setScale(0, BigDecimal.ROUND_HALF_UP)
					.longValue()) + "");
			taxInvoice61.setInvoiceFee((new BigDecimal(write6 - ValueUtils.longValue(taxFee6) / 100.0).setScale(0, BigDecimal.ROUND_HALF_UP)
					.longValue()) + "");
			taxInvoice61.setTaxRate("0.06");
			taxInvoice61.setTaxFee(new BigDecimal(taxFee6 / 100.0).setScale(0, BigDecimal.ROUND_HALF_UP).longValue() + "");
			invoiceFeeTotalList.add(taxInvoice61);
		}
		if (discountWrite11 < 0) {
			// 获取商品名称
			String groupId = "1";
			// String codeId = "0.11";
			// String codeValue = control.getPubCodeValue(codeClass, codeId, groupId);
			log.debug("折扣金额：" + discountWrite11 + "    冲销金额：" + write11);
			String discountRate = discountRate((0 - discountWrite11), write11, 3);
			log.debug("discountRate:" + discountRate);
			taxInvoice112.setGoodsName("折扣(" + discountRate + ")");
			taxInvoice112.setGoodsNum("1");
			taxInvoice112.setGoodsPrice((new BigDecimal(discountWrite11 - ValueUtils.longValue(discountTaxFee11) / 100.0).setScale(0,
					BigDecimal.ROUND_HALF_UP).longValue()) + "");
			taxInvoice112.setInvoiceFee((new BigDecimal(discountWrite11 - ValueUtils.longValue(discountTaxFee11) / 100.0).setScale(0,
					BigDecimal.ROUND_HALF_UP).longValue()) + "");
			taxInvoice112.setTaxRate("0.11");
			taxInvoice112.setTaxFee(new BigDecimal(discountTaxFee11 / 100.0).setScale(0, BigDecimal.ROUND_HALF_UP).longValue() + "");
			invoiceFeeTotalList.add(taxInvoice112);
		}
		if (discountWrite6 < 0) {
			// 获取商品名称
			String discountRate = discountRate((0 - discountWrite6), write6, 3);
			taxInvoice62.setGoodsName("折扣(" + discountRate + ")");
			taxInvoice62.setGoodsNum("1");
			taxInvoice62.setGoodsPrice((new BigDecimal(discountWrite6 - ValueUtils.longValue(discountTaxFee6) / 100.0).setScale(0,
					BigDecimal.ROUND_HALF_UP).longValue()) + "");
			taxInvoice62.setInvoiceFee((new BigDecimal(discountWrite6 - ValueUtils.longValue(discountTaxFee6) / 100.0).setScale(0,
					BigDecimal.ROUND_HALF_UP).longValue()) + "");
			taxInvoice62.setTaxRate("0.06");
			taxInvoice62.setTaxFee(new BigDecimal(discountWrite6 / 100.0).setScale(0, BigDecimal.ROUND_HALF_UP).longValue() + "");
			invoiceFeeTotalList.add(taxInvoice62);
		}

		return invoiceFeeTotalList;
	}

	@Override
	public List<TaxInvoiceFeeEntity> getTaxInvoFeeTotalForInvPrint(List<TaxInvoiceFeeEntity> invoiceFeeDetailList) {
		// List<TaxInvoiceFeeEntity> invoiceFeeDetailList = getTaxInvoFeeDetail(contractStr, beginYm, endYm);
		// String[] contractArray = contractStr.split(",");
		List<Map<String, Object>> payTypeMapList = balance.getGiftPayType();
		List<String> payTypeList = new ArrayList<String>();
		for (Map<String, Object> payTypeMap : payTypeMapList) {
			payTypeList.add(payTypeMap.get("PAY_TYPE").toString());
		}
		List<TaxInvoiceFeeEntity> taxInvTotal = new ArrayList<TaxInvoiceFeeEntity>();
		int flag = 0;// 一个标志，1表示没有
		log.debug("明细：" + invoiceFeeDetailList);
		// 按账号分类
		Map<Long, List<TaxInvoiceFeeEntity>> contractMap = new HashMap<Long, List<TaxInvoiceFeeEntity>>();
		for (TaxInvoiceFeeEntity invoiceDetail : invoiceFeeDetailList) {
			if (payTypeList.contains(invoiceDetail.getPayType())) {
				continue;
			}
			flag = 0;// 一个标志，1表示没有
			if (contractMap != null) {
				for (long key : contractMap.keySet()) {
					if (key == invoiceDetail.getContractNo()) {
						contractMap.get(key).add(invoiceDetail);
						flag = 1;
						break;
					}
				}
			}
			if (contractMap == null || flag == 0) {
				List<TaxInvoiceFeeEntity> taxInvoiceList = new ArrayList<TaxInvoiceFeeEntity>();
				taxInvoiceList.add(invoiceDetail);
				contractMap.put(invoiceDetail.getContractNo(), taxInvoiceList);
			}
		}
		log.debug("按照账户分类之后的map：" + contractMap);
		// 再按照账期把账户的分类
		for (long key : contractMap.keySet()) {
			List<TaxInvoiceFeeEntity> invoiceFeeList = contractMap.get(key);
			Map<Integer, List<TaxInvoiceFeeEntity>> billMap = new HashMap<Integer, List<TaxInvoiceFeeEntity>>();
			for (TaxInvoiceFeeEntity invoiceDetail : invoiceFeeList) {
				flag = 0;
				if (billMap != null) {
					for (int billkey : billMap.keySet()) {
						if (billkey == invoiceDetail.getBillCycle()) {
							billMap.get(billkey).add(invoiceDetail);
							flag = 1;
							break;
						}
					}
				}
				if (billMap == null || flag == 0) {
					List<TaxInvoiceFeeEntity> taxInvoiceList = new ArrayList<TaxInvoiceFeeEntity>();
					taxInvoiceList.add(invoiceDetail);
					billMap.put(invoiceDetail.getBillCycle(), taxInvoiceList);
				}
			}
			log.debug("按照账户，账期，分类之后的map：" + billMap);
			for (int billKey : billMap.keySet()) {
				TaxInvoiceFeeEntity taxInvoiceFee = new TaxInvoiceFeeEntity();
				taxInvoiceFee.setBillCycle(billKey);
				taxInvoiceFee.setContractNo(key);
				long taxFee = 0;
				long wrtFee = 0;
				List<TaxInvoiceFeeEntity> taxInvoiceFeeList = billMap.get(billKey);
				for (TaxInvoiceFeeEntity taxInvoiceFeeEntity : taxInvoiceFeeList) {
					taxFee = ValueUtils.longValue(taxInvoiceFeeEntity.getTaxFee()) + taxFee;
					wrtFee = taxInvoiceFeeEntity.getWriteFee() + wrtFee;
				}
				taxInvoiceFee.setTaxFee(taxFee + "");
				taxInvoiceFee.setWriteFee(wrtFee);
				taxInvoiceFee.setMainContractNo(taxInvoiceFeeList.get(0).getMainContractNo());
				taxInvTotal.add(taxInvoiceFee);
			}

		}
		log.debug("按照账户，账期，税率分类之后的list：" + taxInvTotal);
		return taxInvTotal;
	}

	@Override
	public List<TaxInvoiceFeeEntity> getTaxInvoFeeDetail(List<TransFeeEntity> transFeeList, int beginYm, int endYm) {

		Map<String, Object> inMap = new HashMap<String, Object>();
		List<TaxInvoiceFeeEntity> taxInvList = new ArrayList<TaxInvoiceFeeEntity>();

		int curYm = DateUtils.getCurYm();
		for (TransFeeEntity transFee : transFeeList) {
			long paySn = transFee.getTransSn();
			long contractNo = transFee.getContractnoIn();
			int suffix = transFee.getTotalDate() / 100;
			// 根据流水账户时间获取账本ID
			inMap = new HashMap<String, Object>();
			inMap.put("PAY_SN", paySn);
			inMap.put("SUFFIX", suffix);
			inMap.put("CONTRACT_NO", contractNo);
			Map<String, Object> sourceMap = (Map<String, Object>) baseDao.queryForObject("bal_booksource_info.qBookSourceByPaySn", inMap);
			// 根据账本ID获取冲销的账单
			inMap = new HashMap<String, Object>();
			inMap.put("CONTRACT_NO", contractNo);
			inMap.put("BALANCE_ID", sourceMap.get("BALANCE_ID"));
			for (int ym = suffix; ym <= curYm; ym = DateUtils.addMonth(ym, 1)) {
				List<Map<String, Object>> writeoffList = new ArrayList<Map<String, Object>>();
				inMap.put("YEAR_MONTH", ym);
				for (int naturalMonth = beginYm; naturalMonth < endYm; naturalMonth = DateUtils.addMonth(naturalMonth, 1)) {
					inMap.put("NATURAL_MONTH", naturalMonth);
					writeoffList = baseDao.queryForList("bal_writeoff_yyyymm.qTaxFeeForWriteOff", inMap);
					for (Map<String, Object> writeoff : writeoffList) {
						TaxInvoiceFeeEntity taxInvoiceFee = new TaxInvoiceFeeEntity();
						taxInvoiceFee.setContractNo(ValueUtils.longValue(writeoff.get("CONTRACT_NO")));
						taxInvoiceFee.setBillCycle(ValueUtils.intValue(writeoff.get("BILL_CYCLE")));
						taxInvoiceFee.setWriteFee(ValueUtils.longValue(writeoff.get("WRITE_FEE")));
						taxInvoiceFee.setPayType(writeoff.get("PAY_TYPE").toString());
						taxInvoiceFee.setTaxFee(writeoff.get("TAX_FEE").toString());
						taxInvoiceFee.setTaxRate(writeoff.get("TAX_RATE").toString());
						taxInvList.add(taxInvoiceFee);
					}
				}
			}
		}
		return taxInvList;
	}

	@Override
	public List<TaxInvoiceFeeEntity> getTaxInvoFeeDetail(String contractStr, int beginYm, int endYm) {
		String[] contractNoArray = contractStr.split(",");
		int curMon = DateUtils.getCurYm();
		Map<String, Object> inMap = new HashMap<String, Object>();
		List<TaxInvoiceFeeEntity> taxInvoiceList = new ArrayList<TaxInvoiceFeeEntity>();
		List<Map<String, Object>> outWriteoff = new ArrayList<Map<String, Object>>();
		for (String contractNo : contractNoArray) {
			inMap = new HashMap<String, Object>();
			inMap.put("CONTRACT_NO", ValueUtils.longValue(contractNo));
			for (int billCycle = beginYm; billCycle <= endYm; billCycle = DateUtils.addMonth(billCycle, 1)) {
				inMap.put("NATURAL_MONTH", billCycle);
				for (int yearMonth = billCycle; yearMonth <= curMon; yearMonth = DateUtils.addMonth(yearMonth, 1)) {
					inMap.put("YEAR_MONTH", yearMonth);
					List<Map<String, Object>> outWriteoffTmp = baseDao.queryForList("bal_writeoff_yyyymm.qTaxFeeForWriteOff", inMap);
					outWriteoff.addAll(outWriteoffTmp);
				}
			}
		}
		for (Map<String, Object> writeoff : outWriteoff) {
			TaxInvoiceFeeEntity taxInvoiceFee = new TaxInvoiceFeeEntity();
			taxInvoiceFee.setContractNo(ValueUtils.longValue(writeoff.get("CONTRACT_NO")));
			taxInvoiceFee.setBillCycle(ValueUtils.intValue(writeoff.get("BILL_CYCLE")));
			taxInvoiceFee.setWriteFee(ValueUtils.longValue(writeoff.get("WRITE_FEE")));
			taxInvoiceFee.setPayType(writeoff.get("PAY_TYPE").toString());
			taxInvoiceFee.setTaxFee(writeoff.get("TAX_FEE").toString());
			taxInvoiceFee.setTaxRate(writeoff.get("TAX_RATE").toString());
			taxInvoiceList.add(taxInvoiceFee);
		}
		return taxInvoiceList;
	}

	@Override
	public List<TaxInvoiceFeeEntity> getUnPayInvoFee(String contractStr, int beginYm, int endYm) {
		String[] contractNoArray = contractStr.split(",");
		List<BillEntity> billList = new ArrayList<BillEntity>();
		for (String contractNo : contractNoArray) {
			Map<String, Object> inMap = new HashMap<String, Object>();
			inMap.put("MIN_BILL_CYCLE", beginYm);
			inMap.put("MAX_BILL_CYCLE", endYm);
			inMap.put("CONTRACT_NO", contractNo);
			List<BillEntity> billListTmp = bill.getUnPayOwe(inMap);
			billList.addAll(billListTmp);
		}

		List<TaxInvoiceFeeEntity> taxInvoiceList = new ArrayList<TaxInvoiceFeeEntity>();
		for (BillEntity billEnt : billList) {
			TaxInvoiceFeeEntity taxInvoiceFee = new TaxInvoiceFeeEntity();
			taxInvoiceFee.setContractNo(billEnt.getContractNo());
			taxInvoiceFee.setBillCycle(billEnt.getBillCycle());
			taxInvoiceFee.setWriteFee(billEnt.getOweFee());
			taxInvoiceFee.setPayType("0");
			taxInvoiceFee.setTaxFee(billEnt.getTaxFee() - billEnt.getPayedTax() + "");
			taxInvoiceFee.setTaxRate(billEnt.getTaxRate() + "");
			taxInvoiceList.add(taxInvoiceFee);
		}
		return taxInvoiceList;
	}
	@Override
	public List<TaxInvoiceFeeEntity> getSubTaxInvoFeeDetail(List<TransFeeEntity> transFeeList) {
		Map<String, Object> inMap = new HashMap<String, Object>();
		List<TaxInvoiceFeeEntity> taxInvList = new ArrayList<TaxInvoiceFeeEntity>();
		int curYm = DateUtils.getCurYm();
		log.debug("transFeeList的大小：" + transFeeList.size());
		for (TransFeeEntity transFee : transFeeList) {
			long writeoffFee = 0;
			long initBalance = 0;
			long curBalance = 0;
			long paySn = transFee.getTransSn();
			long contractNo = transFee.getContractnoIn();
			int suffix = transFee.getTotalDate() / 100;
			// 根据流水账户时间获取账本ID
			inMap = new HashMap<String, Object>();
			inMap.put("PAY_SN", paySn);
			inMap.put("SUFFIX", suffix);
			inMap.put("CONTRACT_NO", contractNo);
			Map<String, Object> sourceMap = (Map<String, Object>) baseDao.queryForObject("bal_booksource_info.qBookSourceByPaySn", inMap);
			if (sourceMap == null) {
				continue;
			}
			// 根据账本ID获取冲销的账单
			inMap = new HashMap<String, Object>();
			inMap.put("CONTRACT_NO", contractNo);
			inMap.put("BALANCE_ID", sourceMap.get("BALANCE_ID"));
			log.debug(">>>>>>>>>BALANCE_ID:" + sourceMap.get("BALANCE_ID"));
			// 查询账本记录，如果账本没有发生过冲销退出循环，不再查询
			Map<String, Object> balanceMap = balance.getAccountInfo(ValueUtils.longValue(sourceMap.get("BALANCE_ID")));
			if (balanceMap != null) {
				curBalance = ValueUtils.longValue(balanceMap.get("CUR_BALANCE"));
				initBalance = ValueUtils.longValue(balanceMap.get("INIT_BALANCE"));
				if (initBalance == curBalance) {
					continue;
				}
			}
			for (int ym = suffix; ym <= curYm; ym = DateUtils.addMonth(ym, 1)) {
				List<Map<String, Object>> writeoffList = new ArrayList<Map<String, Object>>();
				inMap.put("YEAR_MONTH", ym);
				writeoffList = baseDao.queryForList("bal_writeoff_yyyymm.qTaxFeeForWriteOff", inMap);
				for (Map<String, Object> writeoff : writeoffList) {
					TaxInvoiceFeeEntity taxInvoiceFee = new TaxInvoiceFeeEntity();
					taxInvoiceFee.setContractNo(ValueUtils.longValue(writeoff.get("CONTRACT_NO")));
					taxInvoiceFee.setBillCycle(transFee.getTotalDate() / 100);
					taxInvoiceFee.setWriteFee(ValueUtils.longValue(writeoff.get("WRITE_FEE")));
					taxInvoiceFee.setPayType(writeoff.get("PAY_TYPE").toString());
					taxInvoiceFee.setTaxFee(writeoff.get("TAX_FEE").toString());
					taxInvoiceFee.setTaxRate(writeoff.get("TAX_RATE").toString());
					taxInvoiceFee.setMainContractNo(transFee.getContractnoOut());
					taxInvoiceFee.setBalanceId(ValueUtils.longValue(sourceMap.get("BALANCE_ID")));
					taxInvList.add(taxInvoiceFee);

					writeoffFee += taxInvoiceFee.getWriteFee();
					if (writeoffFee == initBalance) {
						break;
					}
				}
			}
		}
		log.debug("统付划拨子账户冲销明细：" + taxInvList);
		log.debug("冲销明细：" + taxInvList.size());
		return taxInvList;
	}

	private String discountRate(long v1, long v2, int scale) {
		float i = (float) v1 / v2;
		DecimalFormat df = new DecimalFormat("##.000%");
		String j = df.format(i);
		return j;
	}

	public IBill getBill() {
		return bill;
	}

	public void setBill(IBill bill) {
		this.bill = bill;
	}

	public IInvoice getInvoice() {
		return invoice;
	}

	public void setInvoice(IInvoice invoice) {
		this.invoice = invoice;
	}

	public IBalance getBalance() {
		return balance;
	}

	public void setBalance(IBalance balance) {
		this.balance = balance;
	}

	public IRecord getRecord() {
		return record;
	}

	public void setRecord(IRecord record) {
		this.record = record;
	}

	public IAccount getAccount() {
		return account;
	}

	public void setAccount(IAccount account) {
		this.account = account;
	}

	public IControl getControl() {
		return control;
	}

	public void setControl(IControl control) {
		this.control = control;
	}

	public IAdj getAdj() {
		return adj;
	}

	public void setAdj(IAdj adj) {
		this.adj = adj;
	}

	public IUser getUser() {
		return user;
	}

	public void setUser(IUser user) {
		this.user = user;
	}

	public IRemainFee getReFee() {
		return reFee;
	}

	public void setReFee(IRemainFee reFee) {
		this.reFee = reFee;
	}

	public IGroup getGroup() {
		return group;
	}

	public void setGroup(IGroup group) {
		this.group = group;
	}

	public UnBillData getUnBillData() {
		return unBillData;
	}

	public void setUnBillData(UnBillData unBillData) {
		this.unBillData = unBillData;
	}

	public IWriteOffer getWriteOffer() {
		return writeOffer;
	}

	public void setWriteOffer(IWriteOffer writeOffer) {
		this.writeOffer = writeOffer;
	}

}
