package com.sitech.acctmgr.inter.pay;

import com.sitech.acctmgr.comp.dto.pay.S8000CompInitInDTO;
import com.sitech.acctmgr.comp.dto.pay.S8000CompInitOutDTO;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by 2014年7月15日 09:31:31
 * @author zhangjp
 * @modify 修改dto 2014/10/14
 * I8000 普通缴费接口
 */
public interface I8000Co {
	
	/** 
	* 名称：缴费查询	<br/>
	* 功能：查询用户/账户基本信息以及进行缴费前业务校验<br/>
	* @param PAY_PATH		：缴费渠道
	* @param PHONE_NO	  	：可空，服务号码
	* @param CONTRACT_NO 	：可空，账户号码
	* @return 
	* <ul>
	* 	<li>PHONE_NO  				</li>
	* 	<li>CONTRACT_NO 			</li>
	* 	<li>CONTRACT_NAME			</li>
	* 	<li>PREPAY_FEE	: 预存款		</li>
	* 	<li>SEPCIAL_FEE : 专款预存款	</li>
	* 	<li>CUR_BALANCE	: 当前余额		</li>
	* 	<li>OWE_FEE		: 当前欠费		</li>
	* 	<li>SUM_SHOULDPAY:合计应收		</li>
	* 	<li>RUN_CODE	: 运行状态		</li>
	* 	<li>RUN_NAME	: 运行状态名称	</li>
	*	<li>GROUP_NAME	: 地市归属		</li>
	*	<li>LIMIT_OWE	: 信誉度		</li>
	*	<li>PRODUCT_NAME: 主产品名称	</li>
	*	<li>BRAND_NAME	: 品牌名称		</li>
	*	<li>ACCOUNT_TYPE: 账户类型		</li>
	*	<li>ACCOUNT_TYPE_NAME 		</li>
	*	<li>USER_NAME	: 客户名称		</li>
	*	<li>CUST_TYPE_NAME : 客户等级名称	</li>
	*	<li>PAY_CODE	: 付费类型		</li>
	*	<li>PAY_CODE_NAME  : 付费类型名称 </li>
	*	<li>IS_GROUP				</li>
	*	<li>USER_CNT    : 付费用户数	</li>
	*	<li>OWEFEEINFO_SIZE : 未冲销账单条数 </li>
	*
	* 	<li>OWEFEEINFO</li>
	* 		<ul>
	*			<li>PHONE_NO	 </li>
	*			<li>CONTRACT_NO	 </li>
	*			<li>BILL_CYCLE   </li>
	*			<li>OWE_FEE		 </li>
	*			<li>DELAY_FEE	 </li>
	*			<li>SHOULD_PAY	 </li>
	*			<li>FAVOUR_FEE	 </li>
	*			<li>PAYED_FEE    </li>
	* 		</ul>
	* </ul>
	 */
	OutDTO init(final InDTO inParam);

}
