package com.sitech.acctmgr.atom.entity.inter;

import com.sitech.acctmgr.atom.domains.base.BankEntity;
import com.sitech.acctmgr.atom.domains.cust.PostBankEntity;

import java.util.List;
import java.util.Map;

/**
*
* <p>Title: 基础类  </p>
* <p>Description:   </p>
* <p>Copyright: Copyright (c) 2014</p>
* <p>Company: SI-TECH </p>
* @version 1.0
*/
public interface IBase {

	/**
	 * 名称：查询模块名称
	 * @param opCode
	 * @return FUNCTION_NAME<br/>
	 * @
	 */
	String getFunctionName(String opCode);

	/**
	 * 功能：查询所属区县（地/省）下的银行信息，支持模糊查询
	 * <p>好市及省级groupId,直接按groupId查询银行列表信息；<br>
	 *    区县及区县以下的groupId,返回归属区县下的银行列表信息。<br>
	 *    若使用模糊匹配时，请酌情使用List的get方法；<br>完整bankcode使用时，可直接使用get(0)；
	 *     </p>
	 * @param groupId
	 * @param provinceId
	 * @param blurBankCode 模糊查询的bankcode
	 * @param blurBankName 模糊查询的bankname
     * @return
     */
	List<BankEntity> getBankInfo(String groupId, String provinceId, String blurBankCode, String blurBankName);

	/**
	 * 根据银行代码获取银行配置信息
	 * @param groupId
	 * @param provinceId
	 * @param bankCode
     * @return
     */
	BankEntity getBankInfo(String groupId, String provinceId, String bankCode);

	List<PostBankEntity> getPostBankInfo(String regionCode, String postBankCode);
}
