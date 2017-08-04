package com.sitech.acctmgr.atom.busi.query.inter;

import java.util.List;
import java.util.Map;

/**
 *
 * <p>Title:   账单类业务实体层</p>
 * <p>Description:   查询账单类的各种业务</p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author yankma
 * @version 1.0
 */
public interface IOweBill {
	
	/**
	 * 名称：计算在网账户物理库欠费和滞纳金，计算方法，按照账期分组取账单然后计算滞纳金
	 * 
	 * @param lContactNo
	 * @return OWE_FEE： 物理库欠费（库内欠费）<br/>
	 *         DELAY_FEE：帐户下滞纳金总额	  <br/>
	 *         OWEFEE_LIST :欠费列表		  <br/>
	 *         List.BILL_CYCLE			  <br/>
	 *         List.OWE_FEE				  <br/>
	 *         List.DELAY_FEE  			  <br/>
	 *         List.SHOULD_PAY			  <br/>
	 *         List.FAVOUR_FEE			  <br/>
	 *         List.PAYED_LATER			  <br/>
	 *         List.PAYED_PREPAY		  <br/>
	 */
	public abstract Map<String, Object> getHisOweFeeInfo(long lContractNo);
	
	/***
	 *名称：获取账户所有库内账单，每条账单添加滞纳金字段 
	 * @param lContactNo
	 * @return OWE_FEE： 物理库欠费（库内欠费）<br/>
	 *         DELAY_FEE：帐户下滞纳金总额	  <br/>
	 *         OWEFEE_LIST :欠费列表		  <br/>
	 *         List.BILL_CYCLE			  <br/>
	 *         List.OWE_FEE				  <br/>
	 *         List.DELAY_FEE  			  <br/>
	 *         List.SHOULD_PAY			  <br/>
	 *         List.FAVOUR_FEE			  <br/>
	 *         List.PAYED_LATER			  <br/>
	 *         List.PAYED_PREPAY		  <br/>
	 */
	public abstract List<Map<String, Object>> getOweDetailList(long lContractNo);
	
	/**
	 * 名称：计算在网账户总欠费和滞纳金(包括内存欠费和库内欠费)，计算方法，按照账期分组取账单然后计算滞纳金
	 * 
	 * @param lContactNo
	 * @return OWE_FEE： 总欠费（库内欠费+内存欠费）<br/>
	 *         DELAY_FEE：帐户下滞纳金总额	  <br/>
	 *         OWEFEE_LIST :欠费列表		  <br/>
	 *         List.BILL_CYCLE			  <br/>
	 *         List.OWE_FEE				  <br/>
	 *         List.DELAY_FEE  			  <br/>
	 *         List.SHOULD_PAY			  <br/>
	 *         List.FAVOUR_FEE			  <br/>
	 *         List.PAYED_LATER			  <br/>
	 *         List.PAYED_PREPAY		  <br/>
	 */
	public abstract Map<String, Object> getOweFeeInfo(long lContractNo);
	
	/**
	 * 名称：计算用户在账户总欠费和滞纳金(包括内存欠费和库内欠费)，计算方法，按照账期分组取账单然后计算滞纳金
	 * 
	 * @param lContactNo
	 * @param lIdNo
	 * @return OWE_FEE： 总欠费（库内欠费+内存欠费）<br/>
	 *         DELAY_FEE：用户在帐户下滞纳金总额	  <br/>
	 *         OWEFEE_LIST :欠费列表		  <br/>
	 *         List.BILL_CYCLE			  <br/>
	 *         List.OWE_FEE				  <br/>
	 *         List.DELAY_FEE  			  <br/>
	 *         List.SHOULD_PAY			  <br/>
	 *         List.FAVOUR_FEE			  <br/>
	 *         List.PAYED_LATER			  <br/>
	 *         List.PAYED_PREPAY		  <br/>
	 */
	public abstract Map<String, Object> getOweFeeInfo(long lContractNo, long lIdNo);
	
	/**
	 * 名称：计算离网用户总欠费和滞纳金，计算方法，按照账期分组取账单然后计算滞纳金
	 * 
	 * @param idNo
	 * @param contractNo
	 * @return OWE_FEE： 总欠费（库内欠费+内存欠费）<br/>
	 *         DELAY_FEE：用户在帐户下滞纳金总额	  <br/>
	 *         OWEFEE_LIST :欠费列表		  <br/>
	 *         List.BILL_CYCLE			  <br/>
	 *         List.OWE_FEE				  <br/>
	 *         List.DELAY_FEE  			  <br/>
	 *         List.SHOULD_PAY			  <br/>
	 *         List.FAVOUR_FEE			  <br/>
	 *         List.PAYED_LATER			  <br/>
	 *         List.PAYED_PREPAY		  <br/>
	 */
	public abstract Map<String, Object> getDeadOweFeeInfo(Long idNo, Long lcontractNo);

}
