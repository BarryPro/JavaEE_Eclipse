<%
  /*
   * ����: ��ʾ������Ϣ
�� * �汾: 1.0.0
�� * ����: 2008/12/09
�� * ����: hanjc
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%
	//String opCode = "K084";
	//String opName = "��ʾ������Ϣ";
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>



<%
  /*midify by guozw 20091114 ������ѯ�����滻*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

/*---------------��ȡ������Ϣ��ʼ-------------------*/
String sqlStr = "select class_id, class_name from scallclass order by class_id";
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
<wtc:param value="<%=sqlStr%>"/>
</wtc:service>
<wtc:array id="resultList" scope="end"/>
<%
/*---------------��ȡ������Ϣ����-------------------*/
%>



<html>
<head>
	<script>
		function showContentList(class_id){
			alert(class_id);
			window.parent.frames['mainFrame'].ischeckBoxSelect(class_id);
		}
	</script>
</head> 

<body>
<div id="Operation_Table">	     
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
<%
if(resultList.length > 0){%>
  <%
	for(int i = 0; i < resultList.length; i++){
%>
<tr>
	<td class="Grey">
		<a href="#" onclick="showContentList('<%=resultList[i][0]%>');"><%=resultList[i][1]%></a>
	</td>
  	
</tr>
<%
	}
}
%>
</table>
</div>

</body>        
</html>

