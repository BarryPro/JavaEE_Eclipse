<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * 功能: 常用网址
　 * 版本: 1.0
　 * 日期: 2010/10/29
　 * 作者: wanghong
　 * 版权: sitech
 　*/
 
    String opCode="";
    String opName="常用网址";
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
<title>常用网址</title>
</head>

<body>
	<%@ include file="/npage/include/header.jsp"%>
	<div id="Operation_Table">
		<div>
		<table wcellspacing="0">	
<tr >
<td colspan="2">
		<div class="title">
				<div id="title_zi">常用网址大全</div>
		</div>
</td>
</tr>


<tr >
<td width="50%">
<%
	Map dataMap = new HashMap();
	dataMap = (HashMap) dataList.get(0);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>彩铃网址(12530)</a>&nbsp;&nbsp;或&nbsp;&nbsp;
<%
	dataMap = (HashMap) dataList.get(1);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>彩铃网址(chinamobile)</a>
</td>
<td width="50%">
<%
	dataMap = (HashMap) dataList.get(2);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>百宝箱网址</a>
</td>
</tr>

<tr>
<td nowrap> 
<%
	dataMap = (HashMap) dataList.get(3);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>梦网网址</a>
</td>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(4);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>飞信网址</a>
</td>
</tr>


<tr>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(5);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>号薄管家</a>
</td>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(6);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>黑龙江省公司网址</a>
</td>
</tr>


<tr>
<td nowrap>
<%
 dataMap = (HashMap) dataList.get(7);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>集团公司网址</a>
</td>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(8);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>在线客服</a>
</td>
</tr>


<tr>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(9);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>中国移动积分统一管理平台</a>
</td>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(10);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>手机邮箱网址</a>
</td>
</tr>
<tr>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(11);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>彩信相册网址</a>
</td>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(12);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>集团公司举报平台</a>
</td>
	</tr>
<tr>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(13);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>工信部网间平台</a>
</td>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(14);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>PK平台</a>
</td>
</tr>

<tr>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(15);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>骚扰电话监控平台</a>
</td>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(16);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>校迅通</a>
</td>
</tr>

<tr>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(17);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>彩铃平台</a>
</td>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(18);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>动感短信</a>
</td>
</tr>

<tr>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(19);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>智能网</a>
</td>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(20);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>短信营业厅</a>
</td>
</tr>

<tr>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(21);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>游戏业务运营辅助管理平台</a>
</td>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(22);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>手机阅读业务管理平台地址</a>
</td>
</tr>

<tr>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(23);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>彩铃门户网址</a>
</td>
<td nowrap>
<%
	dataMap = (HashMap) dataList.get(24);
%>
<a href='<%=dataMap.get("ADRESS_URL")%>'>联动优势手机钱包平台</a>
</td>
</tr>
	</table>	
		</div>
</div>

<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>

