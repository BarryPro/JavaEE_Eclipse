<%
   /*
   * ����: ��ѯ�û���Ʒ��Ϣ
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
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page contentType= "text/html;charset=gb2312" %>

<%@ include file="/npage/common/portalInclude.jsp" %>

<%
     String org_code = (String)session.getAttribute("orgCode");
		 String regionCode=org_code.substring(0,2);
     //String phone_no = (String)session.getAttribute("activePhone");
     String phone_no = (String)request.getParameter("activePhone");
     Date date=new Date();
		 SimpleDateFormat myFmt=new SimpleDateFormat("yyyy");        
     String myDate=myFmt.format(date).substring(2,4);
%>

<wtc:service name="sIndexProduct" outnum="3" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=phone_no%>"/>
	<wtc:param value="<%=regionCode%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />

<div  id="form">
	<table width="100%" cellpadding="0" cellspacing="0">
	    <tr> 
	     	<th>�ʷѴ���</th>
	      <th>����</th> 
	      <th>��ʼ����ʱ��</th> 
	     </tr>
	    <tr>
<%
if(retCode.equals("000000")){
	if(result.length>0){
		for(int i=0;i<result.length;i++){
		    String tmp=result[i][2].trim().substring(9,11);
%>             
	       <td><%=result[i][0].trim()%></td>
	       <td><%=result[i][1].trim()%></td>
	       <td <%if(myDate.equals(tmp))out.print("class='orange'");%>><%=result[i][2].trim()%>
	       <%if(myDate.equals(tmp))out.print("<span class='orange'>�쵽�����ѣ�</span>");%></td>
	     </tr>
<%
	  }
	}
}
		%>
	</table>
</div>
 <script>
 $("#wait5").hide();		   
 </script>