<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
*
********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
   String contract_no = WtcUtil.repStr(request.getParameter("contract_no")," ");
   String qry_flag = WtcUtil.repStr(request.getParameter("qry_flag")," ");
   String phone_no = WtcUtil.repStr(request.getParameter("phone_no")," ");
   String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);      
	 String retResult = "";
	 String returnCode="";
	 String sqlStr = "";
	 String strIdNo = "";
	 String strSzxFlag = "";
	 String strIsMarketingFlag ="";
	
	/*���� 2006��8��29�� ���ӱ�׼�������ж�*/	
//	String strSqlText = "";
	String s_sm_code="";
	String[] strSqlText = new String[2];
	if(qry_flag=="1" ||qry_flag.equals("1"))
	{
		//��������sql �滻����dconusermsg��ѯ��
		strSqlText[0]="select b.sm_code from dConMsg a, dCustMsg b,  dConUserMsg d where a.contract_no = d.contract_no and d.id_no = b.id_no  and a.contract_no = :s_no ";
		//strSqlText[0]="select b.sm_code   from dconmsg a,dcustmsg b where a.con_cust_id = b.cust_id and a.contract_no=:s_no and rownum=1";
		strSqlText[1]="s_no="+contract_no;
		
	}
	else if(qry_flag=="2" ||qry_flag.equals("2"))
	{
		strSqlText[0]="select sm_code   from dcustmsg  where phone_no=:s_no";
		strSqlText[1]="s_no="+phone_no;
	}
	//strSqlText = "select a.id_no,sm_code from dCustMsg a where a.phone_no='" + phone_no + "'";
%>
	<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:param value="<%=strSqlText[0]%>"/>
		<wtc:param value="<%=strSqlText[1]%>"/>
	</wtc:service>
	<wtc:array id="strReturnArray" scope="end" />
<%
	if(strReturnArray!=null&&strReturnArray.length>0){//��ֹ�еĺ�����Ϊ���ݲ�ȫ��û��id_no
		retResult="0";//����ɹ� 
		s_sm_code= (strReturnArray[0][0]).trim();
	}
%>
 


var response = new AJAXPacket();
var retResult = "<%=retResult%>";
 
var s_sm_code = "<%=s_sm_code%>";
 
response.data.add("retResult",retResult);
 
response.data.add("s_sm_code",s_sm_code);
 
core.ajax.receivePacket(response);



 
