<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * ����: ������ַ
�� * �汾: 1.0
�� * ����: 2010/10/29
�� * ����: wanghong
�� * ��Ȩ: sitech
 ��*/
 
    String opCode="";
    String opName="������ַ";
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*,java.text.SimpleDateFormat,com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>

<%
	List dataList = new ArrayList();
	Map pMap = new HashMap();
	dataList = (List) KFEjbClient.queryForList("query_K850_select",pMap);
%>
<html>
<head>
<title>������ַ</title>
</head>

<body>
	<%@ include file="/npage/include/header.jsp"%>
	<div id="Operation_Table">
		<div>
		<table wcellspacing="0">	
<tr >
<td colspan="2">
		<div class="title">
				<div id="title_zi">������ַ��ȫ</div>
		</div>
</td>
</tr>


<tr >
<td width="50%">
<%
	Map dataMap = new HashMap();
	dataMap = (HashMap) dataList.get(0);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>������ַ(12530)</a>&nbsp;&nbsp;��&nbsp;&nbsp;
<%
	dataMap = (HashMap) dataList.get(1);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>������ַ(chinamobile)</a>
</td>
<td width="50%">
<%
	dataMap = (HashMap) dataList.get(2);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>�ٱ�����ַ</a>
</td>
</tr>

<tr>
<td nowrap> 
<%
	dataMap = (HashMap) dataList.get(3);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>������ַ</a>
</td>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(4);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>������ַ</a>
</td>
</tr>


<tr>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(5);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>�ű��ܼ�</a>
</td>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(6);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>������ʡ��˾��ַ</a>
</td>
</tr>


<tr>
<td nowrap>
<%
 dataMap = (HashMap) dataList.get(7);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>���Ź�˾��ַ</a>
</td>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(8);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>���߿ͷ�</a>
</td>
</tr>


<tr>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(9);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>�й��ƶ�����ͳһ����ƽ̨</a>
</td>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(10);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>�ֻ�������ַ</a>
</td>
</tr>
<tr>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(11);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>���������ַ</a>
</td>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(12);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>���Ź�˾�ٱ�ƽ̨</a>
</td>
	</tr>
<tr>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(13);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>���Ų�����ƽ̨</a>
</td>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(14);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>PKƽ̨</a>
</td>
</tr>

<tr>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(15);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>ɧ�ŵ绰���ƽ̨</a>
</td>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(16);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>УѸͨ</a>
</td>
</tr>

<tr>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(17);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>����ƽ̨</a>
</td>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(18);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>���ж���</a>
</td>
</tr>

<tr>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(19);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>������</a>
</td>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(20);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>����Ӫҵ��</a>
</td>
</tr>

<tr>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(21);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>��Ϸҵ����Ӫ��������ƽ̨</a>
</td>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(22);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>�ֻ��Ķ�ҵ�����ƽ̨��ַ</a>
</td>
</tr>

<tr>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(23);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>�����Ż���ַ</a>
</td>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(24);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>���������ֻ�Ǯ��ƽ̨</a>
</td>
</tr>
	</table>	
		</div>
</div>

<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>

