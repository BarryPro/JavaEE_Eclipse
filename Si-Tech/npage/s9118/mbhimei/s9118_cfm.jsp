<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-02-05
 ********************/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.*;"%>
<%
String workNo = (String)session.getAttribute("workNo");
String workName = (String)session.getAttribute("workName");
String regionCode=(String)session.getAttribute("regCode");
String op_name =  "�����б��/���ո���";
//ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
//String[][] baseInfoSession = (String[][])arrSession.get(0);
//String[][] fiveInfoSession = (String[][])arrSession.get(4);
String org_code = (String)session.getAttribute("orgCode");//��������
String login_passwd = (String)session.getAttribute("password");//��������
String region_code = org_code.substring(0,2);

String idType="01";
String loginAccept = request.getParameter("loginAccept");
String phoneno  = request.getParameter("phoneno");
String optype  = request.getParameter("optype");
String opcode    = request.getParameter("opCode");//������
String opnote = request.getParameter("opnote");
String thirdNo = WtcUtil.repNull(request.getParameter("thirdNo"));
String oprSource = WtcUtil.repNull(request.getParameter("oprSource"));
String selfIp = (String)session.getAttribute("ipAddr");

String spCode=request.getParameter("spCode");
if(spCode!=null){
	spCode=spCode.trim();
}
String spBizCode=request.getParameter("spBizCode");
if(spBizCode!=null){
	spBizCode=spBizCode.trim();
}


//ԭ������ID
String value302 = request.getParameter("value302")+"|"+request.getParameter("value311");

//�»�����ID
String value306 = request.getParameter("value306")+"|"+request.getParameter("value312");

String oldLoginAccept = request.getParameter("value313");
System.out.println("loginAccept === "+loginAccept);
String saleAccept = oldLoginAccept+"|"+loginAccept;
//������ҵ��
String strspid = request.getParameter("strspid");
String strbizcode = request.getParameter("strbizcode");
String strbillingtype = request.getParameter("strbillingtype");

String[] strspid_array = strspid.split(";");
String[] strbizcode_array = strbizcode.split(";");
String[] strbillingtype_array = strbillingtype.split(";");

String value307 = request.getParameter("value307");

//ԭ��ҵ��
String stroldspid = request.getParameter("stroldspid");
String stroldbizcode = request.getParameter("stroldbizcode");

String[] stroldspid_array = stroldspid.split(";");
String[] stroldbizcode_array = stroldbizcode.split(";");


//��ʼ����������Ҫ�Ĳ���
String[][] paraArray = new String[22][1];


paraArray[12] = new String[strspid_array.length];
paraArray[13] = new String[strspid_array.length];
paraArray[14] = new String[strspid_array.length];
paraArray[15] = new String[strspid_array.length];

paraArray[16] = new String[stroldspid_array.length];
paraArray[17] = new String[stroldspid_array.length];


paraArray[0][0] = "BIP2B413";
paraArray[1][0] = "T2040082";
paraArray[2][0] = workNo;
paraArray[3][0] = org_code;
paraArray[4][0] = "01";
paraArray[5][0] = phoneno;
paraArray[6][0] = "";
paraArray[7][0] = optype;
paraArray[8][0] = value306;
paraArray[9][0] = value302;
paraArray[10][0] = "51";
paraArray[11][0] = "08";

for(int i=0;i<strspid_array.length;i++){
	paraArray[12][i] = strbillingtype_array[i];
	paraArray[13][i] = "";
	paraArray[14][i] =strspid_array[i];
	paraArray[15][i] = strbizcode_array[i];
}

for(int i=0;i<stroldspid_array.length;i++){
	paraArray[16][i] = stroldspid_array[i];
	paraArray[17][i] = stroldbizcode_array[i];
}
paraArray[18][0] = "�����и���/��������";
paraArray[19][0] = "9118";
paraArray[20][0] = saleAccept;
paraArray[21][0] = value307;


for(int i=0;i<18;i++){
    System.out.println("paraArray["+i+"]="+paraArray[i]);
}
%>
<wtc:service  name="sTSNPubSnd"  routerKey="phone" routerValue="<%=phoneno%>" retcode="retCode" retmsg="retMsg" outnum="10">

	<%for(int i=0;i<paraArray.length;i++){ 
	%>
    <wtc:params  value="<%=paraArray[i]%>"/>
    <%} %>	
</wtc:service>
<%
System.out.println("===========retCode===="+retCode);
//----------------------------
 System.out.println("%%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
    String url = "/npage/contact/onceCnttInfo.jsp?opCode="+"9113"+"&retCodeForCntt="+retCode+"&retMsgForCntt="+retMsg
    +"&opName="+"�û���Ϣ����������"+"&workNo="+workNo+"&loginAccept="+loginAccept+"&pageActivePhone="+phoneno+"&opBeginTime="+opBeginTime+"&contactId="+phoneno+"&contactType=user";
%>
    <jsp:include page="<%=url%>" flush="true" />
<%
    System.out.println("%%%%%%%%����ͳһ�Ӵ�����%%%%%%%%");
//----------------------------

if(!retCode.equals("000000")){%>
	<script language="JavaScript">
	    rdShowMessageDialog("ҵ������ʧ�ܣ�ԭ��<%=retMsg%>!",0);
	    history.go(-1);
	</script>
<%
}
else{
%>
	<script language="JavaScript">
	   	rdShowMessageDialog("<%=retMsg%>!",2);
	   	removeCurrentTab();
	</script>
<%
}
%>
