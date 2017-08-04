<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>

<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%

String regionCode = request.getParameter("regionCode");
String work_flow_no = request.getParameter("work_flow_no");

    String loginNo = (String)session.getAttribute("workNo");

String  inputParsm [] = new String[2];
	inputParsm[0] = work_flow_no;
	inputParsm[1] = loginNo;
	
	System.out.println("----------------inputParsm[0]-----------------"+inputParsm[0]);
	System.out.println("----------------inputParsm[1]-----------------"+inputParsm[1]);
	

%>
    <wtc:service name="s4603Chk" outnum="18" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=inputParsm[0]%>" />
			<wtc:param value="<%=inputParsm[1]%>" />	
		</wtc:service>
		<wtc:array id="QryBack" scope="end" />

<%
String retCode= code;
String retMsg = msg;

System.out.println("retCode === "+ retCode);
System.out.println("retMsg === "+ retMsg);

		for(int iii=0;iii<QryBack.length;iii++){
				for(int jjj=0;jjj<QryBack[iii].length;jjj++){
					System.out.println("---------------------QryBack["+iii+"]["+jjj+"]=-----------------"+QryBack[iii][jjj]);
				}
		}
		
		
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
String out_flag="";
String jf_flag="";
String contactPerson="";
String contactPhone="";
String contactFax="";
String contactMail="";
String idAddr="";
String contactAddr="";
String contactPost="";
String zyjf="";
String zyxyd="";
String old_phone="";
String vip_grade="";

String rpcPage = "4603chgSim";



if(QryBack.length>0&&QryBack!=null)
{
	retCode=QryBack[0][0];
	retMsg=QryBack[0][1];
	out_flag=QryBack[0][2];
	jf_flag=QryBack[0][3];
	contactPerson=QryBack[0][4];
	contactPhone=QryBack[0][5];
	contactFax=QryBack[0][6];
	contactMail = QryBack[0][7];
	CUST_NAME = QryBack[0][8];
	ID_TYPE = QryBack[0][9];
	ID_ICCID = QryBack[0][10];
	idAddr = QryBack[0][11];
	contactAddr=QryBack[0][12];
	contactPost= QryBack[0][13];
	zyjf=QryBack[0][14];
	zyxyd=QryBack[0][15];
	System.out.println("mylog---------------zyjf--------------"+zyjf);
	System.out.println("mylog---------------zyxyd--------------"+zyxyd);
	old_phone=QryBack[0][16];
	vip_grade= QryBack[0][17];
	
	if(vip_grade!=null){
		vip_grade = vip_grade.trim();
	
	if(vip_grade.equals("非大客户")){
	 	vip_grade = "00";
	}else	if(vip_grade.equals("钻石卡")){
	 	vip_grade = "01";
	}else	if(vip_grade.equals("金卡")){
	 	vip_grade = "02";
	}else if(vip_grade.equals("银卡")){
	 	vip_grade = "03";
	}else	if(vip_grade.equals("贵宾卡")){
	 	vip_grade = "04";
	}else	if(vip_grade.equals("特批钻石卡")){
		vip_grade = "05";
	}else	if(vip_grade.equals("特批金卡")){
	 	vip_grade = "06";
	}else	if(vip_grade.equals("特批银卡")){
	 	vip_grade = "07";
	}else if(vip_grade.equals("卡挂失")){
	 	vip_grade = "41";
	}else if(vip_grade.equals("离网用户")){
	 	vip_grade = "42";
	}else	if(vip_grade.equals("无卡")){
	 	vip_grade = "99";
  }
 }
 System.out.println("--------------mylog-----------vip_grade------------"+vip_grade);
}

String cussidStr="";
%>

var response = new AJAXPacket();

var retCode = "<%=retCode%>";
var retMsg = "<%=retMsg%>";

var retCode = "<%=retCode%>";
var retMsg = "<%=retMsg	%>";
var out_flag= "<%=out_flag%>";
var jf_flag="<%=jf_flag%>";
var contactPerson="<%=contactPerson%>";
var contactPhone="<%=contactPhone%>";
var contactFax="<%=contactFax%>";
var contactMail = "<%=contactMail%>";
var CUST_NAME = "<%=CUST_NAME%>";
var ID_TYPE = "<%=ID_TYPE%>";
var ID_ICCID = "<%=ID_ICCID%>";
var idAddr = "<%=idAddr%>";
var contactAddr="<%=contactAddr%>";
var contactPost= "<%=contactPost%>";
var zyjf="<%=zyjf%>";
var zyxyd="<%=zyxyd%>";
var old_phone="<%=old_phone%>";
var vip_grade="<%=vip_grade%>";


var rpcPage = "<%=rpcPage%>";

response.data.add("retType",rpcPage); 
response.data.add("retCode",retCode); 
response.data.add("retMessage",retMsg); 
response.data.add("out_flag",out_flag); 
response.data.add("jf_flag",jf_flag); 
response.data.add("contactPerson",contactPerson);
response.data.add("contactPhone",contactPhone);
response.data.add("contactFax",contactFax);
response.data.add("contactMail",contactMail);
response.data.add("CUST_NAME",CUST_NAME);
response.data.add("ID_TYPE",ID_TYPE);
response.data.add("ID_ICCID",ID_ICCID);
response.data.add("idAddr",idAddr);
response.data.add("contactAddr",contactAddr);
response.data.add("contactPost",contactPost);
response.data.add("zyjf",zyjf);
response.data.add("zyxyd",zyxyd);
response.data.add("old_phone",old_phone);
response.data.add("vip_grade",vip_grade);


core.ajax.receivePacket(response);
