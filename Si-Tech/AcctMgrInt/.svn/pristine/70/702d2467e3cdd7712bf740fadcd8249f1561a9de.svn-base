package com.sitech.acctmgrint.common.constant;

/**
*
* <p>Title: 服务开通业务常量</p>
* <p>Description: 服务开通-统一接口业务常量</p>
* <p>Copyright: Copyright (c) 2014</p>
* <p>Company: SI-TECH </p>
* @author konglj
* @version 1.0
*/
public final class InterBusiConst {
	
	public static final int LENGTH_IDNO = 18;
	public static final int LENGTH_PHONENO = 11;
	public static final int LEN_MIDMSG = 64999;//涉及Json和Map格式问题，不能改更大值！
	public static final String FWKT_CLS_NAME = "\"_CLASS_NAME_\":\"java.util.HashMap\"";
	
	/**
	 * 服务开通 常量定义
	 */
	public static final String FWKT_TOPIC_ID = "T109Smsp";
	public static final String FWKT_DATA_SRC  = "FWKT";
	public static final String FWKT_BOSSRUN_STR = "A,B,C,F,M,J,b,Z,X";
	
	/*服务开通 JSON模板服务KEY值*/
	public static final String FWKT_ODR_SUBKEY  = "OssOrder.Svc";
	public static final String FWKT_ODR_MSVCID  = "mainSvcId";
	public static final String FWKT_ODR_MSVCACT = "mainSvcAct";
	public static final String FWKT_ODR_MSVCPTY = "mainSvcPrptys";
	public static final String FWKT_ODR_OSVCID  = "SvcId";
	public static final String FWKT_ODR_OSVCACT = "SvcAct";
	public static final String FWKT_ODR_OSVCPTY = "SvcPrptys";
	public static final String FWKT_ODR_ID      = "Id";
	public static final String FWKT_ODR_NAME    = "Name";
	public static final String FWKT_ODR_NEWVAL  = "NewVal";
	public static final String FWKT_ODR_OLDVAL  = "OldVal";
	
	
	/*无主停机 参数常量*/
	public static final long   WZ_ID_NO = 123456789012345678L;
	public static final String WZ_ORDER_ID       = "10023";
	public static final String WZ_MAIN_SVC_ID    = "BSM0000000";
	public static final String WZ_SUB_SVC_ID     = "BSO0000065";
	public static final int WZ_MAIN_ACTION_ID = 8905;
	public static final int WZ_DT_ACTION_ID   = 8907;
	/*接口表 BUSIID_TYPE 定义*/
	public static final String BUSIID_TYPE_PHONENO    = "0";
	public static final String BUSIID_TYPE_IDNO       = "1";
	public static final String BUSIID_TYPE_CONTRACTNO = "2";
	public static final String BUSIID_TYPE_OTHER      = "3";	
	/*报文中标签字符*/
	
	//根据开发管理手册报错配置：inter
	public static class ErrInfo {
		public static final String OP_CODE = "0000";  
		public static final String USERCHG = "71"; //用户变更接口，如：71001
		public static final String BUSISYN = "72"; //工单同步接口，如：72001
		public static final String MSGSEND = "73"; //短信发送接口，如：73001
		public static final String DATASYN = "74"; //数据同步接口，如：74001
	}

	//短信发送消息中间件配置信息
	public static class ShtMsg {
		public static final boolean INHIS_FLAG = true;

		public static final String TEMPLATE = "{\"ROOT\":{\"HEADER\":{\"TRACE_ID\":\"\",\"PARENT_CALL_ID\":\"\"},\"BODY\":{\"SYSID\":\"\",\"SEQ\":\"\",\"TEMPLATEID\":\"\",\"PARAMS\":{\"msg\":\"\",\"title\":\"\"},\"SERVICENO\":\"\",\"PHONENO\":\"\",\"LOGINNO\":\"billing\",\"SERVNO\":\"\",\"SERVNAME\":\"\",\"SUBPHONESEQ\":\"\",\"SENDTIME\":\"\",\"HOLD1\":\"0\",\"HOLD2\":\"\",\"HOLD3\":\"\",\"HOLD4\":\"\",\"HOLD5\":\"\"}}}"; 
		public static final String DEFUT_TOPIC = "TSmsMiddle";/*默认主题*/
		public static final int DEFUT_PRIORI = 600;/*默认优先级*/
		public static final String HIGH_TOPIC  = "TSmsHigh";
		public static final int HIGH_PRIORI = 1000;
		public static final String MIDD_TOPIC  = "TSmsMiddle";
		public static final int MIDD_PRIORI = 800;
		public static final String LOW_TOPIC   = "TSmsLow";
		public static final int LOW_PRIORI = 600;
		public static final String GROUP_TOPIC = "TSmsgroup";
		public static final int GROUP_PRIORI = 600;
		public static final String BAK_TOPIC   = "TSmsBak";/*测试用发送主题*/
		public static final int BAK_PRIORI = 400;
		
	}
	
}
