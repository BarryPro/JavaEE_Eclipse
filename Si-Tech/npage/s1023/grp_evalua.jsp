<%
  /*
   * ����: ���Žɷ���ʷ����ͼ
�� * �汾: v1.0
�� * ����: 2011��05��10��
�� * ����: zhoujf
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd>
<HTML xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib uri="weblogic-tags.tld" prefix="wl" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%

	String unit_id =  request.getParameter("unit_id")==null?"":request.getParameter("unit_id");
	String implRegion= (String)session.getAttribute("regCode");	
  String workName = (String)session.getAttribute("workName");
  String ipAddr = (String)session.getAttribute("ipAddr");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
  String opCode="";
  String opName="����������Ϣ";
  String  sqls = "SELECT cust_id FROM dGrpCustMsg WHERE unit_id="+unit_id;
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode1" retmsg="retMsg1" outnum="5">
			<wtc:sql><%=sqls%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="result" scope="end" />
			<%
			System.out.println("result=====1023 begin=============\n"+result.length); %>
		
		<wtc:service name="q_GrpCreditMsg"   retcode="retCodett" retmsg="retMsgtt" outnum="5" >
    	<wtc:param value="<%=result[0][0]%>"/>
    		 </wtc:service>
    	<wtc:array id="resultA" scope="end"/>
    	
		
	 
<HTML>
<HEAD>
<link href="s2002.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY>
<FORM name="form1" method="post">
<%@ include file="/npage/include/header.jsp" %>

	<div class="title"><div id="title_zi">����������Ϣ</div></div>
	<table cellSpacing=0>
	  <table id="tabList"  cellspacing=0 >			
				<tr align='center'>				
					<th>�ͻ����ö�</th>
					
				</tr>
			<%	
			for(int i = 0; i < resultA.length; i++)
			{		  
			%>			
				<tr>				
					<td nowrap align='center'><%=resultA[i][0].trim()%>&nbsp;</td>
					
					
					
				</tr>
			<%
			}
			%>			
				<%
			System.out.println("resultA=====1023 begin======111111111111111111111111111111111111111111=======\n"+resultA.length); %>	
	</table>
	<br>
</BODY>
</HTML>


