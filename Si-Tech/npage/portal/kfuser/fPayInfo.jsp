<%
   /*
   * ����: ������Ϣ
�� * �汾: v1.0
�� * ����: 2008/09/12
�� * ����: ranlf
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
     String password = (String)session.getAttribute("password");
     String phoneNo  = (String)session.getAttribute("activePhone");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode=org_code.substring(0,2);
%>
<wtc:service name="sKFPayInfo_new" outnum="6" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=phoneNo%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />
	<link href="../../../nresources/default/css/portalet.css" rel="stylesheet" type="text/css">
<link href="../../../nresources/default/css/font_color.css" rel="stylesheet" type="text/css">

<div  id="form">
	<div class="table_biaoge">
	<table width="100%" cellpadding="0" cellspacing="0">
  	<tr> 
    	<th>��������</th>
			<th>�������</th>
			<th>�ͻ�����</th>
			<th>������Ŀ</th>
			<th>���Ѷ��</th>
			<th>��Чʱ��</th>
	  </tr>
<%	  
if(retCode.equals("000000")){
	if(result.length>0){
		for(int i=0;i<result.length;i++){
%>             
	       <td><%=result[i][0]==null||result[i][0].equals("")?" ":result[i][0]%></td>
	       <td><%=result[i][1]==null||result[i][1].equals("")?" ":result[i][1]%></td>
	       <td><%=result[i][2]==null||result[i][2].equals("")?" ":result[i][2]%></td>
	       <td><%=result[i][3]==null||result[i][3].equals("")?" ":result[i][3]%></td>
	       <td><%=result[i][4]==null||result[i][4].equals("")?" ":result[i][4]%></td>
	       <td><%=result[i][5]==null||result[i][5].equals("")?" ":result[i][5]%></td>
	     </tr>
<%
	  	}
	}
}
%>	
     </table>
	 </div>
        </div>


