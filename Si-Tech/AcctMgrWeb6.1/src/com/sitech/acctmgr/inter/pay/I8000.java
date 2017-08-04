package com.sitech.acctmgr.inter.pay;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by 2014年7月15日 09:31:31
 * @author zhangjp
 * @modify 修改dto 2014/10/14
 * I8000 普通缴费接口
 */
public interface I8000 {
	
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

	/**
	* 名称：缴费确认业务方法<br/>
	* 1.Dto参数校验<br/>
	* 2.取入账需要资料信息<br/>
	* 3.实时入账<br/>
	* 4、向其他系统同步数据（目前：CRM营业日报、BOSS报表、统一接触）<br/>
	* 5.记录营业员操作日志<br/>
	* 6.冲销<br/>
	* 7.缴费送费<br/>
	* 8、标准神州行用户缴费更新有效期<br/>
	* 9.实时开机<br/>
	* 10.重复缴费限制<br/>
	* 11.个性业务<br/>
	* 12.发送短信<br/>
	* 12.资金安全<br/>
	* 13.Dto参数出参校验<br/>
	* 
	* @param LOGIN_NO         : 工号，非空
	* @param GROUP_ID		  : 工号组织机构归属，可空
	* @param OP_CODE          : 模块编码，号码缴费传入8000 账户缴费传入8002
	* @param PHONE_NO         : 号码，可空
	* @param CONTRACT_NO      : 账户ID，可空
	* @param PAY_LIST         : 缴费金额List，PayInfoEntity -- PAY_TYPE PAY_MONEY END_TIME(可空)
	* @param PAY_PATH         : 缴费渠道，非空
	* @param PAY_METHOD       : 缴费方式，非空
	* @param DELAY_RATE       : 滞纳金优惠率，可空
	* @param PAY_NOTE         : 交费备注，可空
	* @param FOREIGN_SN       : 外部流水，可空，外部渠道调用接口缴费时传入
	* @param FOREIGN_TIME     : 外部缴费时间，可空，格式为YYYYMMDDHHMISS
	* @param BANK_CODE        : 银行代码[对支票交费]，可空
	* @param CHECK_NO         : 支票号码[对支票交费]，可空
	* @param CTRL_FLAG        : 控制标志，第1位：发送短信标志  0发送短信，1不发送，默认下发短信 ； 第2位：是否做开机  0 即不做开机， 1 要做开机
	* @return PAYSN_LIST      : 缴费流水PAY_SN  可以传出多个流水，放在list中<br/>
	* 		  TOTAL_DATE      : 缴费日期<br/>
	* @author qiaolin
	*/
	OutDTO cfm(final InDTO inParam);
	
	/**
	 * 功能：支持折扣率缴费
	 * @author qiaolin
	 * */
	OutDTO cfmDiscount(final InDTO inParam);
	
	/**
	 * 名称：外部缴费成功校验<br/>
	 * 功能：校验用户该笔缴费是否成功，根据外部流水校验
	 * @author qiaolin
	 * */
	OutDTO check(final InDTO inParam);

}
