<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="import com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.*;"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%

String regionCode = request.getParameter("regionCode");
String work_flow_no = request.getParameter("work_flow_no");

System.out.println("regionCode === "+ regionCode);
System.out.println("work_flow_no === "+ work_flow_no);

	String  inputParsm [] = new String[2];
	inputParsm[0] = "QryInnet";
	inputParsm[1] = work_flow_no;
	
String qreySql = "  select WORK_FLOW_DIRECTION,CONFIRM_FLAG,CUST_NAME,CUST_SEX,CUST_BIRTHDAY,ID_TYPE,ID_ICCID,MARK_TRANS_VALUE,CUST_TYPE,VIP_NO,OLD_INNET_TIME,LIMIT_OWE,FUNC_LIST,DATA_LIST,TOTAL_MARK,TOTAL_MARK_BEGIN_TIME,MONTH_CONSUME,MARRY_STATUS,EDUCATION_GRADE,OLD_WORK_ADDRESS,OLD_WORK_HEADSHIP,PERSON_LOVING,FAMILY_MEMBER from wInnetDataAccept where WORK_FLOW_NO='"+work_flow_no+"'";
%>
 		<wtc:pubselect name="sPubSelect" outnum="24" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=qreySql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>
<%

		
		
String retCode= code;
String retMsg = msg;

System.out.println("retCode === "+ retCode);
System.out.println("retMsg === "+ retMsg);




String WORK_FLOW_DIRECTION1   = "";
String WORK_FLOW_DIRECTION   = "";
String CONFIRM_FLAG          = "";
String CUST_NAME             = "";
String CUST_SEX              = "";
String CUST_BIRTHDAY         = "";
String ID_TYPE               = "";
String ID_ICCID              = "";
String MARK_TRANS_VALUE      = "";
String CUST_TYPE             = "";
String VIP_NO                = "";
String OLD_INNET_TIME        = "";
String LIMIT_OWE             = "";
String FUNC_LIST             = "";
String DATA_LIST             = "";
String TOTAL_MARK            = "";
String TOTAL_MARK_BEGIN_TIME = "";
String MONTH_CONSUME         = "";
String MARRY_STATUS          = "";
String EDUCATION_GRADE       = "";
String OLD_WORK_ADDRESS      = "";
String OLD_WORK_HEADSHIP     = "";
String PERSON_LOVING         = "";
String FAMILY_MEMBER         = "";
String CUST_LEVEL						 ="";

String rpcPage = "4100chgSim";

if(retCode.equals("000000")&&result_t.length>0)
{
	WORK_FLOW_DIRECTION1 = "";
	WORK_FLOW_DIRECTION = result_t[0][0];
	CONFIRM_FLAG = result_t[0][1];
	CUST_NAME = result_t[0][2];
	CUST_SEX = result_t[0][3];
	CUST_BIRTHDAY = result_t[0][4];
	ID_TYPE = result_t[0][5];
	ID_ICCID = result_t[0][6];
	MARK_TRANS_VALUE =result_t[0][7];
	CUST_TYPE = result_t[0][8];
	VIP_NO = result_t[0][9];
	OLD_INNET_TIME = result_t[0][10];
	LIMIT_OWE = result_t[0][11];
	FUNC_LIST = result_t[0][12];
	DATA_LIST = result_t[0][13];
	TOTAL_MARK = result_t[0][14];
	TOTAL_MARK_BEGIN_TIME = result_t[0][15];
	MONTH_CONSUME = result_t[0][16];
	MARRY_STATUS = result_t[0][17];
	EDUCATION_GRADE = result_t[0][18];
	OLD_WORK_ADDRESS = result_t[0][19];
	OLD_WORK_HEADSHIP = result_t[0][20];
	PERSON_LOVING = result_t[0][21];
	FAMILY_MEMBER= result_t[0][22];
	
	CUST_TYPE="01";
 
	if(result_t[0][8]!=null && result_t[0][8].trim().length()>0){
		switch(Integer.parseInt(result_t[0][8].trim())){
			case 100:
			   CUST_LEVEL="普通客户";
			   break;
			case 300:
			   CUST_LEVEL="普通大客户";
			   break;   
			case 301:
			   CUST_LEVEL="钻石卡大客户";
			   break;
			case 302:
			   CUST_LEVEL="金卡大客户";
			   break;
			case 303:
			   CUST_LEVEL="银卡大客户";
			   break;
			case 304:
			   CUST_LEVEL="贵宾卡大客户";
			   break;         
			default:
			   CUST_LEVEL="普通客户";    
		}
	}
	
	ID_TYPE = result_t[0][5].trim();
	CUST_SEX = result_t[0][3].trim();
	EDUCATION_GRADE =result_t[0][18].trim(); 
		//if(result_t[0][6].trim().equals("00")){ID_TYPE="身份证";}else if(result_t[0][6].trim().equals("01")){ID_TYPE="VIP卡号";}else{ID_TYPE="其他";}
    //if(result_t[0][4].trim().equals("01")){CUST_SEX="男性";}else if(result_t[0][4].trim().equals("02")){CUST_SEX="女性";}else{CUST_SEX="未知";}
    //if(result_t[0][19].trim().equals("0")){EDUCATION_GRADE="未知";}else if(result_t[0][19].trim().equals("1")){EDUCATION_GRADE="大本";}else if(result_t[0][19].trim().equals("2")){EDUCATION_GRADE="大专";}else if(result_t[0][19].trim().equals("3")){EDUCATION_GRADE="中专、高中";}else if(result_t[0][19].trim().equals("4")){EDUCATION_GRADE="高中以下";}else{EDUCATION_GRADE="研究生以上";}

}

String cussidStr="";
%>

var response = new AJAXPacket();

var retCode = "<%=retCode%>";
var retMsg = "<%=retMsg%>";

var retCode = "<%=retCode%>";
var retMsg = "<%=retMsg	%>";
var WORK_FLOW_DIRECTION = "<%=WORK_FLOW_DIRECTION%>";
var CONFIRM_FLAG = "<%=CONFIRM_FLAG%>";
var CUST_NAME = "<%=CUST_NAME%>";
var CUST_SEX = "<%=CUST_SEX %>";
var CUST_BIRTHDAY = "<%=CUST_BIRTHDAY%>";
var ID_TYPE = "<%=ID_TYPE%>";
var ID_ICCID = "<%=ID_ICCID%>";
var MARK_TRANS_VALUE = "<%=MARK_TRANS_VALUE%>";
var CUST_TYPE = "<%=CUST_TYPE%>";
var VIP_NO = "<%=VIP_NO%>";
var OLD_INNET_TIME = "<%=OLD_INNET_TIME%>";
var LIMIT_OWE = "<%=LIMIT_OWE%>";
var FUNC_LIST = "<%=FUNC_LIST%>";
var DATA_LIST = "<%=DATA_LIST%>";
var TOTAL_MARK = "<%=TOTAL_MARK%>";
var TOTAL_MARK_BEGIN_TIME = "<%=TOTAL_MARK_BEGIN_TIME%>";
var MONTH_CONSUME = "<%=MONTH_CONSUME%>";
var MARRY_STATUS = "<%=MARRY_STATUS%>";
var EDUCATION_GRADE = "<%=EDUCATION_GRADE%>";
var OLD_WORK_ADDRESS = "<%=OLD_WORK_ADDRESS%>";
var OLD_WORK_HEADSHIP  = "<%=OLD_WORK_HEADSHIP%>";
var PERSON_LOVING = "<%=PERSON_LOVING%>";
var FAMILY_MEMBER = "<%=FAMILY_MEMBER%>";
var CUST_LEVEL="<%=CUST_LEVEL%>";


var rpcPage = "<%=rpcPage%>";

response.guid = '<%= request.getParameter("guid") %>';
response.data.add("retType",rpcPage); 
response.data.add("retCode",retCode); 
response.data.add("retMsg",retMsg); 
response.data.add("WORK_FLOW_DIRECTION",WORK_FLOW_DIRECTION); 
response.data.add("CONFIRM_FLAG",CONFIRM_FLAG); 
response.data.add("CUST_NAME",CUST_NAME);
response.data.add("CUST_SEX",CUST_SEX);
response.data.add("CUST_BIRTHDAY",CUST_BIRTHDAY);
response.data.add("ID_TYPE",ID_TYPE);
response.data.add("ID_ICCID",ID_ICCID);
response.data.add("MARK_TRANS_VALUE",MARK_TRANS_VALUE);
response.data.add("CUST_TYPE",CUST_TYPE);
response.data.add("VIP_NO",VIP_NO);
response.data.add("OLD_INNET_TIME",OLD_INNET_TIME);
response.data.add("LIMIT_OWE",LIMIT_OWE);
response.data.add("FUNC_LIST",FUNC_LIST);
response.data.add("DATA_LIST",DATA_LIST);
response.data.add("TOTAL_MARK",TOTAL_MARK);
response.data.add("TOTAL_MARK_BEGIN_TIME",TOTAL_MARK_BEGIN_TIME);
response.data.add("MONTH_CONSUME",MONTH_CONSUME);
response.data.add("MARRY_STATUS",MARRY_STATUS);
response.data.add("EDUCATION_GRADE",EDUCATION_GRADE);
response.data.add("OLD_WORK_ADDRESS",OLD_WORK_ADDRESS);
response.data.add("OLD_WORK_HEADSHIP",OLD_WORK_HEADSHIP);
response.data.add("PERSON_LOVING",PERSON_LOVING);
response.data.add("FAMILY_MEMBER",FAMILY_MEMBER);
response.data.add("CUST_LEVEL",CUST_LEVEL);
core.ajax.receivePacket(response);
