<%
  /*
   * ����: �һ��ͷ���־��¼
�� * �汾: 1.0.0
�� * ����: 20090307
�� * ����: lijin
�� * ��Ȩ: sitech
   *update:
��*/
%>
<%
	//String opName = "�һ��ͷ���־��¼";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
		String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
   //ȡ��ϵͳ����
      String date[]=new String[6];    
      Calendar calendar = Calendar.getInstance();
      int year = calendar.get(Calendar.YEAR);
      int month = calendar.get((Calendar.MONTH))+1; 
      String _month = month<=9 ? "0"+month : ""+month;
      String contactMonth=year+_month;
   String contact_id = WtcUtil.repNull(request.getParameter("contact_id"));
   String totalTime = WtcUtil.repNull(request.getParameter("totalTime"));
   String sqr= "";
   if(!contact_id.equals("")&& !totalTime.equals("")){
   sqr="update dcallcall"+contactMonth+" t set t.accept_long=:v1 where t.contact_id=:v2";
   System.out.println("sqlbbbbbbbbbbbbbbbbbbbbb"+sqr); 
   }
%>

<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
<wtc:param value="<%=sqr%>"/>
<wtc:param value="dbchange"/>
<wtc:param value="<%=totalTime%>"/>
<wtc:param value="<%=contact_id%>"/>
</wtc:service>
<wtc:array id="rows"  scope="end"/>
var response = new AJAXPacket();
core.ajax.receivePacket(response);

