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
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
	  String phoneNo = request.getParameter("phoneNo");
		String[] inParas2 = new String[2];
		String[] inParam0 = new String[2];
		inParam0[0]="	SELECT to_char(count(phone_no)) FROM REMIND_WARN_USER_INFO where ID_NO = :phoneNo and warn_rule_id in ('100027','100028','100029') and EXP_DATE>sysdate";
		inParam0[1]="phoneNo="+phoneNo;
		String count="0";
		String checkresult="";
%>
	<wtc:service name="TlsPubSelBoss"  outnum="6" >
	<wtc:param value="<%=inParam0[0]%>"/>
	<wtc:param value="<%=inParam0[1]%>"/>
	</wtc:service>
	<wtc:array id="checkArr" scope="end" />
<%
		if(checkArr!=null&&checkArr.length>0){
			count=checkArr[0][0];
		}
		if(count.equals("0"))
		{
			checkresult="Y";//ͳ��Ϊ0��˵��û�����ù����ɽ�������
			System.out.println("test checkresult is "+checkresult);
		}
		else
		{
			checkresult="N";
		}
	%>
var response = new AJAXPacket();
var checkresult =   "<%=checkresult%>";
var phoneNo =   "<%=phoneNo%>";
response.data.add("checkresult",checkresult); 
response.data.add("phoneNo",phoneNo); 
core.ajax.receivePacket(response);



 
