<%
  /*
   * ����: ����ˮ�����ʼ�->ѡ���ʼ�ƻ�->��ʾ�����������ʼ�ƻ�
�� * �汾: 1.0.0
�� * ����: 2009/01/07
�� * ����: hanjc
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%
	//String opCode = "K218";
	//String opName = "��ʾ�����������ʼ�ƻ�";
%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>



<%
/*---------------��ȡ�ʼ�ƻ���ʼ-------------------*/
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String myParams="";
//String login_no  = (String)request.getParameter("staffno");
String serialnum = (String)request.getParameter("serialnum");
String contact_id     = request.getParameter("contact_id");//ͨ����ˮ
/**
String sqlStr = "select plan_id, plan_name, object_id, content_id "+
                "from dqcplan where sysdate >= begin_date and sysdate<=end_date order by plan_id";

 */
//����SQL����Ѿ�������Ȩ��У�� check_kind = '1'��ʶΪ���Զ������ƻ�
String login_no = (String)request.getParameter("staffno");
//String  check_login_no = (String)session.getAttribute("kfWorkNo");
String  check_login_no = (String)session.getAttribute("workNo");   //������ԭ�����滻Ϊkf��ͷ�Ĺ���

String sqlStr = "select t1.plan_id, t1.plan_name, t1.object_id, t1.content_id " +
                "from dqcplan t1, dqcloginplan t2, dqccheckloginplan t3 " +
                "where t1.plan_id = t2.plan_id and t1.plan_id = t3.plan_id and t1.check_kind = '1' and t2.login_no = :login_no and " +
                "t3.check_login_no =:check_login_no and " +
                "sysdate >= t1.begin_date and sysdate<=t1.end_date order by t1.plan_id";
myParams = "login_no="  +login_no + ",check_login_no=" + check_login_no;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="6">
<wtc:param value="<%=sqlStr%>"/>
<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="resultList" scope="end"/>
<%
/*---------------��ȡ�ʼ�ƻ�����-------------------*/
%>



<html>
<head>
	<script>
		function showContentList(plan_id){
			window.parent.frames['mainFrame'].location = "./K219_plan_content_list.jsp?plan_id=" + plan_id + "&serialnum=<%=serialnum%>&staffno=<%=login_no%>&contact_id=<%=contact_id%>";
		}
	</script>
</head>

<body>
<div id="Operation_Table">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
<%
if(resultList.length > 0){%>
<!-- ����ֵ��ʾ��ʾȫ��-->
<tr>
	<td class="blue">
  <a href="#" onclick="showContentList('');">ȫ���ʼ�ƻ�</a>
</td>
</tr>
  <%
	for(int i = 0; i < resultList.length; i++){
%>
<tr>
	<td class="blue">
		<a href="#" onclick="showContentList('<%=resultList[i][0]%>');"><%=resultList[i][1]%></a>
	</td>

</tr>
<%
	}
}else{%>
 <tr>
	<td class="orange">��ǰ���ʼ�ƻ�</td>
</tr>
<%}%>
</table>
</div>

</body>
</html>

