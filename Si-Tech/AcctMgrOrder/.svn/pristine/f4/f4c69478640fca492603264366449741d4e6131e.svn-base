package com.sitech.acctmgr.app.common;

/**
*
* <p>Title: 服务开通业务常量</p>
* <p>Description: 服务开通业务常量</p>
* <p>Copyright: Copyright (c) 2014</p>
* <p>Company: SI-TECH </p>
* @author konglj
* @version 1.0
*/
public final class InterBusiConst {
	
	/*接口表 BUSIID_TYPE 定义*/
	public static final String BUSIID_TYPE_PHONENO = "0";
	public static final String BUSIID_TYPE_IDNO = "1";
	public static final String BUSIID_TYPE_CONTRACTNO = "2";
	public static final String BUSIID_TYPE_OTHER = "3";	
	
	/*报文中标签字符*/
	
	/*
	 * crmToboss数据同步
	 */
	public static final String DATAODR_TOPIC  = "T101DataSyn";
	public static final String DATAODR_OPCODE = "C2B";//OP_CODE
	public static final int DATAODR_TRIGGER = 1;//触发小表标识
	
	/*json模板 格式串 Key值*/
	//Header
	public static final String DATAODR_DBID      = "DB_ID";
	public static final String DATAODR_CREATACPT = "CREATE_ACCEPT";//CREATE_ACCEPT
	public static final String DATAODR_ODRLINEID = "ORDER_LINE_ID";//ORDER_LINE_ID
	public static final String DATAODR_CREATTIME = "CREATE_TIME";  //CREATE_TIME
	//Body
	public static final String DATAODR_TABLES   = "TABLES";      //TABLES
	public static final String DATAODR_FEEINFO  = "BUSI_INFO";    //费用工单
	public static final String DATAODR_OPRINFO  = "OPR_INFO";    //费用工单
	public static final String DATAODR_TABNAME  = "TABLENAME";   //TABLENAME
	//public static final String DATAODR_SUFFIX   = "SUFFIX";      //SUFFIX
	public static final String DATAODR_DATARCDS = "DATARECORDS"; //DATARECORDS
	public static final String DATAODR_OP       = "OP";          //OP
	public static final String DATAODR_COLS     = "COLS";        //COLS
	public static final String DATAODR_ODR_ID   = "SERV_ORDER_ID";  //订单行号
	
	/*DATAORDER 配置信息语句*/
	public static final String DATAODR_DISTTAB = 
			"SELECT distinct SOURCE_TABLE FROM IN_CBTABLE_SYNC_RELATION WHERE 1 = 1 ";
	public static final String DATAODR_DESTTAB = 
			"SELECT SOURCE_TABLE,SOURCE_COLUMN,DEST_TABLE,DEST_COLUMN,DATA_TYPE,INDEX_FLAG," +
			" SYNC_FLAG,DEAL_FLAG,DEAL_VALUE,TRIGGER_FLAG,CHG_TABLE,OPER_FLAG " + 
			" FROM IN_CBTABLE_SYNC_RELATION" +
			" WHERE SOURCE_TABLE= ?";
	public static final String DATAODR_BOTHSYNC = "SELECT SYNC_FLAG, EXTEN_FLAG CHG_BOTH_FLAG from IN_CBTABLE_BOTHSYNC_DICT where SOURCE_TABLE = ?";
	/*DATAORDER 操作语句*/
	public static final String DATAODR_UPDT_BTC = "INSERT INTO UR_BOSSTOCRMSTATE_HIS (ID_NO, LOGIN_ACCEPT, OP_CODE, CRM_RUN_CODE, CRM_RUN_TIME, BOSS_RUN_CODE, BOSS_RUN_TIME, RUN_CODE, LOGIN_NO, OP_TIME, REMARK, IN_OP_TIME, IN_LOGIN_ACCEPT, IN_LOGIN_NO, IN_REMARK) " +
			" SELECT ID_NO, LOGIN_ACCEPT, OP_CODE, CRM_RUN_CODE, CRM_RUN_TIME, BOSS_RUN_CODE, BOSS_RUN_TIME, RUN_CODE, LOGIN_NO, OP_TIME, REMARK, sysdate, ?, ?, ? " +
			" FROM UR_BOSSTOCRMSTATE_INFO WHERE ID_NO=?";
	public static final String DATAODR_UPDT_DTE = "UPDATE CS_USERDETAIL_INFO SET OLD_RUN=RUN_CODE, OP_TIME=sysdate, RUN_CODE=?," +
			" RUN_TIME=TO_DATE(?, 'YYYYMMDDHH24MISS'), OP_CODE=?, LOGIN_NO=? WHERE ID_NO=?";
	public static final String DATAODR_INST_DTE_ACCHG = "insert into CS_USERDETAIL_INFO_ACCHG (GET_TIME,GET_NO, GET_TYPE, ID_NO, RUN_CODE, RUN_TIME, USER_GRADE_CODE, STOP_FLAG, OWED_FLAG, USER_PASSWD, PASSWD_TYPE, CARD_TYPE, VIP_CARD_NO, VIP_CREATE_TYPE, OLD_RUN, QUERY_CDRFLAG, LMT_ADJUST_TYPE, OP_TIME, LOGIN_NO, LOGIN_ACCEPT, OP_CODE, OP_NOTE, SYSTEM_NOTE, BAK1, BAK2) "+ 
			" SELECT SYSDATE,?, ?, ID_NO, RUN_CODE, RUN_TIME, USER_GRADE_CODE, STOP_FLAG, OWED_FLAG, USER_PASSWD, PASSWD_TYPE, CARD_TYPE, VIP_CARD_NO, VIP_CREATE_TYPE, OLD_RUN, QUERY_CDRFLAG, LMT_ADJUST_TYPE, OP_TIME, LOGIN_NO, LOGIN_ACCEPT, OP_CODE, OP_NOTE, SYSTEM_NOTE, BAK1, BAK2 FROM CS_USERDETAIL_INFO WHERE ID_NO=?"; 
	public static final String DATAODR_INST_DTE_BICHG = "insert into CS_USERDETAIL_INFO_BICHG (GET_TIME,GET_NO, GET_TYPE, ID_NO, RUN_CODE, RUN_TIME, USER_GRADE_CODE, STOP_FLAG, OWED_FLAG, USER_PASSWD, PASSWD_TYPE, CARD_TYPE, VIP_CARD_NO, VIP_CREATE_TYPE, OLD_RUN, QUERY_CDRFLAG, LMT_ADJUST_TYPE, OP_TIME, LOGIN_NO, LOGIN_ACCEPT, OP_CODE, OP_NOTE, SYSTEM_NOTE, BAK1, BAK2) "+ 
			" SELECT SYSDATE,?, ?, ID_NO, RUN_CODE, RUN_TIME, USER_GRADE_CODE, STOP_FLAG, OWED_FLAG, USER_PASSWD, PASSWD_TYPE, CARD_TYPE, VIP_CARD_NO, VIP_CREATE_TYPE, OLD_RUN, QUERY_CDRFLAG, LMT_ADJUST_TYPE, OP_TIME, LOGIN_NO, LOGIN_ACCEPT, OP_CODE, OP_NOTE, SYSTEM_NOTE, BAK1, BAK2 FROM CS_USERDETAIL_INFO WHERE ID_NO=?"; 
	public static final String DATAODR_INST_DEAD_CONUSER = "INSERT INTO ac_conuserrel_dead ( "+
			" SERV_ACCT_ID, CONTRACT_NO, ID_NO, PAY_TYPE, PAY_VALUE, CHKOUT_PRI, BILL_ORDER, EFF_DATE, EXP_DATE, DATE_CYCLE, RATE_FLAG, "+
			" CYCLE_TYPE, FINISH_FLAG, OP_CODE, OP_TIME, LOGIN_NO, LOGIN_ACCEPT, REMARK)"+
			" SELECT SERV_ACCT_ID, CONTRACT_NO, ID_NO, PAY_TYPE, PAY_VALUE, CHKOUT_PRI, BILL_ORDER, EFF_DATE, EXP_DATE, DATE_CYCLE, RATE_FLAG,"+ 
			" CYCLE_TYPE, FINISH_FLAG, ? OP_CODE, sysdate, ? LOGIN_NO, ? LOGIN_ACCEPT, ? REMARK"+
			" from cs_conuserrel_info where SERV_ACCT_ID = ?";
	public static final String DATAODR_QUERY_RUNCODE_BY_IDNO = "SELECT BOSS_RUN_CODE FROM UR_BOSSTOCRMSTATE_INFO WHERE ID_NO= ?";
	public static final String DATAODR_QUERY_RUNCODE = "SELECT RUN_CODE FROM CS_RUNCODE_COMPRULE_DICT "+
			"WHERE CRM_RUN_CODE=? AND BOSS_RUN_CODE=?";

	public static final String DATAODR_USERSYNC_INST = "INSERT INTO BAL_USER_SYNC (ID_NO, PHONE_NO, CUST_ID, GROUP_ID, OPEN_TIME, BILL_START_TIME, INSERT_TIME, OWNER_TYPE) "+
			"select ID_NO, PHONE_NO, CUST_ID, GROUP_ID, OPEN_TIME, BILL_START_TIME, sysdate INSERT_TIME, OWNER_TYPE "+  
			"from ur_user_info where ID_NO = ?";
	public static final String DATAODR_USERCHG_INST = "insert into bal_userchg_recd"
			+ " (COMMAND_ID, TOTAL_DATE, PAY_SN, ID_NO, CONTRACT_NO, GROUP_ID, BRAND_ID, PHONE_NO,"
			+ " OLD_RUN, RUN_CODE, OP_TIME, OP_CODE, LOGIN_NO, LOGIN_GROUP, REMARK) "
			+ "select SEQ_COMMON_ID.nextval, to_number(to_char(run_time, 'YYYYMMDD')), ?, ?, ?, ?, ?, ?,"
			+ " old_run, run_code, sysdate, ?, ?, ?, ? "
			+ "from cs_userdetail_info where id_no = ?";

	public static final String DATAODR_INPUT_HIS = "INSERT INTO IN_MSGRCV_HIS (CREATE_ACCEPT, DATA_SOURCE, BUSIID_NO, BUSIID_TYPE, TOPIC_ID, " +
			"CONTENT, LOGIN_ACCEPT, OP_CODE, LOGIN_NO, OP_TIME) " +
			"VALUES (to_char(sysdate, 'YYMMDDHH24MISS')||SEQ_INTERFACE_SN.Nextval, " + 
			" ?, ?, ?, ?,  EMPTY_BLOB(), ?, ?, ?, SYSDATE)";
	public static final String DATAODR_INPUT_ERR = "INSERT INTO IN_MSGRCV_ERR (CREATE_ACCEPT, DATA_SOURCE, BUSIID_NO, BUSIID_TYPE, TOPIC_ID," + 
			"CONTENT, LOGIN_ACCEPT, OP_CODE, LOGIN_NO, OP_TIME, RCV_TIME, ERR_CODE, ERR_MSG)" +
			"VALUES (?, ?, ?, ?, ?, EMPTY_BLOB(), ?, ?, ?, SYSDATE, SYSDATE, ?, ?)";
	public static final String DATAODR_UPDTERR_BLOB = "SELECT CONTENT BLOB_DATA FROM IN_MSGRCV_ERR WHERE CREATE_ACCEPT = ? FOR UPDATE";
	
	public static final int DATA_TYPE_STRING    = 0; //字符串
	public static final int DATA_TYPE_LONG      = 1; //long
	public static final int DATA_TYPE_DATE      = 2; //日期
	public static final int DATA_TYPE_INTEGER   = 3; //int
	public static final int DATA_TYPE_DOUBLE    = 4; //double
	public static final int DATA_TYPE_TIMESTAMP = 5; 
	public static final int DATA_TYPE_TIME      = 6;
	public static final int CTB_TABLE_PKNUM = 10;
	public static final int CTB_ERRMSG_LENGTH = 1024;
	
	public static final String DATA_OPER_TYPE_INSERT  = "I";  //INSERT
	public static final String DATA_OPER_TYPE_UPDATE  = "U";  //UPDATE
	public static final String DATA_OPER_TYPE_DELETE  = "D";  //DELETE
	public static final String DATA_OPER_TYPE_SPECIAL = "X"; //special operation
	/*对应小表操作类型*/
	public static final String CHG_OPER_TYPE_INSERT  = "1";  //INSERT
	public static final String CHG_OPER_TYPE_UPDATE  = "2";  //UPDATE
	public static final String CHG_OPER_TYPE_DELETE  = "3";  //DELETE
	public static final String CHG_OPER_TYPE_SPECIAL = "2"; //special operation
	
	/*********
	 * crmToBoss业务工单常量定义
	 * JSON格式串
	 ********/
	public static final String BUSIODR_OPCODE = "BUSI"; //SUCCESS
	public static final String BUSIODR_SUCC = "SUCC"; //SUCCESS
	public static final String BUSIODR_FAIL = "FAIL"; //FAIL
	public static final String BUSIODR_DISTSQL = 
			"select distinct BUSI_CODE from In_Busiorder_Conf where TRIG_FLAG='Y' ";
	public static final String BUSIODR_CFGSQL = 
			"select BUSI_CODE, BEAN_NAME BEAN, FUNC_NAME FUNC, SEQ_NAME "
			+" from In_Busiorder_Conf where TRIG_FLAG= ? and BUSI_CODE= ? ";
	public static final String BUSIKEY_DISTSQL = 
			"select distinct BUSI_CODE from In_BusiKey_Dict where EFF_FLAG=? ";
	public static final String BUSIKEY_CFGSQL = 
			"SELECT ROOT_KEY, TRANS_LEVEL, TRANS_TYPE, SRC_KEY, DEST_KEY, VALUE_TYPE "
			+ "FROM IN_BUSIKEY_DICT WHERE BUSI_CODE = ? AND EFF_FLAG  = ? ORDER BY TRANS_LEVEL";
	
	/**
	 * 消息发送系统常量
	 */
	public static final int DEFLT_THRD_NUM = 8; //消息中间件默认线程数
	public static final String MSGSND_CHARSET = "UTF-8";
	public static final int MSGSND_MAXSIZE = 64999;//65K
	public static final String MSGSND_TABNAME="IN_MSGSEND_CFG";
	public static final String MSGSND_CFGSQL = 
			"SELECT DATA_SOURCE, TOPIC_ID, THREAD_NUM FROM IN_MSGSEND_CFG WHERE TRIGGER_FLAG = 'Y'";
	public static final String MSGSND_INHIS = "INSERT INTO IN_MSGSEND_HIS (TOPIC_ID, CONTENT, LOGIN_ACCEPT, OP_TIME,"
			+ "OP_CODE, LOGIN_NO, CREATE_ACCEPT, DATA_SOURCE, BUSIID_TYPE, BUSIID_NO, SEND_TIME, DSP_STATUS, DSP_UPDATE_TIME, DSP_ACCEPT, DSP_POSITION, MSG_ID) "
			+ "SELECT TOPIC_ID, CONTENT, LOGIN_ACCEPT, OP_TIME, OP_CODE,LOGIN_NO, CREATE_ACCEPT, DATA_SOURCE, BUSIID_TYPE, BUSIID_NO, SYSDATE, "
            + " '2', DSP_UPDATE_TIME, DSP_ACCEPT, DSP_POSITION , ? MSG_ID "
			+ "FROM IN_MSGSEND_INFO WHERE TOPIC_ID=? AND CREATE_ACCEPT=?";
	public static final String MSGSND_DELETE = "DELETE FROM IN_MSGSEND_INFO "
			+ "WHERE TOPIC_ID=? AND CREATE_ACCEPT=?";
	public static final String MSGSND_INSTERR = "INSERT INTO IN_MSGSEND_ERR (TOPIC_ID, CONTENT, LOGIN_ACCEPT, OP_TIME, OP_CODE, LOGIN_NO, CREATE_ACCEPT,"
			+ " DATA_SOURCE, BUSIID_TYPE, BUSIID_NO, SEND_TIME, ERR_MSG, ERR_CODE, DSP_STATUS, DSP_UPDATE_TIME, DSP_ACCEPT, DSP_POSITION) "
			+ "SELECT TOPIC_ID, CONTENT, LOGIN_ACCEPT, OP_TIME, OP_CODE, LOGIN_NO, CREATE_ACCEPT, DATA_SOURCE, BUSIID_TYPE, BUSIID_NO,"
			+ "SYSDATE, ?, ?, DSP_STATUS, DSP_UPDATE_TIME, DSP_ACCEPT, DSP_POSITION "
            + " FROM IN_MSGSEND_INFO WHERE TOPIC_ID=? AND CREATE_ACCEPT=?";
	public static final String MSGSND_DELERR = "DELETE FROM IN_MSGSEND_ERR "
			+ "WHERE TOPIC_ID=? AND CREATE_ACCEPT=?";
	
	//错误工单处理
	public static final String MSGSND_ERR_INHIS = "INSERT INTO IN_MSGSEND_HIS (TOPIC_ID, CONTENT, LOGIN_ACCEPT, OP_TIME,"
			+ "OP_CODE, LOGIN_NO, CREATE_ACCEPT, DATA_SOURCE, BUSIID_TYPE, BUSIID_NO, SEND_TIME, DSP_STATUS, DSP_UPDATE_TIME, DSP_ACCEPT, DSP_POSITION, MSG_ID) "
			+ "SELECT TOPIC_ID, CONTENT, LOGIN_ACCEPT, OP_TIME, OP_CODE,LOGIN_NO, CREATE_ACCEPT, DATA_SOURCE, BUSIID_TYPE, BUSIID_NO, SYSDATE, "
            + " '2', DSP_UPDATE_TIME, DSP_ACCEPT, DSP_POSITION , ? MSG_ID "
			+ "FROM IN_MSGSEND_ERR WHERE TOPIC_ID=? AND CREATE_ACCEPT=?";
	
	public static final String MSGSND_HISFLAG="Y";//是否入历史，Y:入历史；N:不入历史。
	public static final String MSGSND_ERRFLAG="Y";
}
