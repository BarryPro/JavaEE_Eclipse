<%
  /*
   * ����: ����ˮ�����ʼ�->ѡ���ʼ�ƻ�->��ʾ�����������ʼ�ƻ�
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: mixh
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

<%
  /*midify by guozw 20091114 ������ѯ�����滻*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

/*---------------��ȡ�ʼ�ƻ���ʼ-------------------*/
//��Ϊboss����
//String check_login_no = (String)session.getAttribute("kfWorkNo");
String check_login_no = (String)session.getAttribute("workNo");
//����SQL����Ѿ�������Ȩ��У��
String sqlStr = "select distinct t1.plan_id, t1.plan_name, t1.object_id, t1.content_id " +
                "from dqcplan t1, dqcloginplan t2, dqccheckloginplan t3 " +
                "where t1.plan_id = t2.plan_id and t1.plan_id = t3.plan_id and "  +
                "t3.check_login_no = :check_login_no and t1.check_kind = '0' and " +
                "sysdate >= t1.begin_date and sysdate<=t1.end_date order by t1.plan_id";
myParams = "check_login_no="+check_login_no ;

%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="6">
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
function showContentList(obj, plan_id){
		window.parent.frames['mainFrame'].location = "./K400_plan_content_list.jsp?plan_id="+plan_id;
		
		//added by tangsong 20100825
		var spans = document.getElementsByTagName("span");
		for (i=0;i<spans.length;i++) {
			spans[i].style.cssText = "";
		}
		obj.style.cssText = "text-decoration:underline;";
}
</script>

<style type="text/css">
 .linkSpan {
		cursor:hand;
 }
</style>
</head>

<body>
<div id="Operation_Table">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
<%
if(resultList.length > 0){
%>
<!-- ����ֵ��ʾ��ʾȫ��-->
<tr>
	<td class="blue">
  <span onclick="showContentList(this,'');" class="linkSpan">ȫ���Զ������ƻ�</span>
</td>
</tr>
<%
	for(int i = 0; i < resultList.length; i++){
%>
		<tr>
			<td class="blue">
				<span onclick="showContentList(this,'<%=resultList[i][0]%>');" class="linkSpan"><%=resultList[i][1]%></span>
			</td>
		
		</tr>
<%
	}
}else{
%>
 <tr>
	<td class="orange">��ǰ���Զ������ƻ�</td>
</tr>
<%
}
%>
</table>
</div>

</body>
</html>

