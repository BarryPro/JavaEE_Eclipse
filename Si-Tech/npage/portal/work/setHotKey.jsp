<%
   /*
   * ����: ӪҵԱ��ݼ�ȷ��
�� * �汾: v1.0
�� * ����: 2008��4��17��
�� * ����: wuln
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%
     String workNo = (String)session.getAttribute("workNo");
     String org_code = (String)session.getAttribute("orgCode");
     String regionCode=org_code.substring(0,2);
     
     String ret_code="999999";
	   
	   int num=10;
	   
     //���Խ������봮
     String[]  key_value=new  String[num];
     String[]  op_code=new  String[num];
    
    for (int i = 0; i < num; i++)
		{
			key_value[i] ="Ctrl+"+i;	   
			op_code[i] =(String)request.getParameter("Ctrl"+i+"").trim();	   
		}
%>

<wtc:service name="s7012Cfm" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=workNo%>"/>
	<wtc:params value="<%=key_value%>"/>
	<wtc:params value="<%=op_code%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />

<%
if(retCode.equals("000000")){
       ret_code="000000";
 }
else
{
       ret_code="999999";
}
  out.print(ret_code);
%>	