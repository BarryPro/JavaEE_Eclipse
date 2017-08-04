<%
    /*************************************
    * 功  能: 一点支付成员清单查询 g087
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-9-13
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String opCode=WtcUtil.repNull((String)request.getParameter("opCode"));
	String opName=WtcUtil.repNull((String)request.getParameter("opName"));
	String ECCustNo = WtcUtil.repStr(request.getParameter("ECCustNo"), "");
	String unitId = WtcUtil.repStr(request.getParameter("unitId"), "");
	String custPhoneNo = WtcUtil.repStr(request.getParameter("custPhoneNo"), "");
	String regCode = (String)session.getAttribute("regCode");
  String loginNo = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
%>
 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>

	<wtc:service name="sg087Qry" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="5">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/> 
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=password%>"/> 
		<wtc:param value=""/>
		<wtc:param value=""/>
    <wtc:param value="<%=ECCustNo%>"/>
    <wtc:param value="<%=unitId%>"/>
    <wtc:param value="<%=custPhoneNo%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
    if("000000".equals(retCode)){
    	System.out.println("------g087----------ret.length="+ret.length);
%>

  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">一点支付成员清单查询结果</div>
			</div>
			<table cellspacing="0" name="t1" id="t1">
				<tr>
				  <th>EC集团客户编码</th>
					<th>集团编号</th>
					<th>产品账户</th>
					<th>成员手机号</th>
					<th>成员ID</th>
				</tr>
<%
				if(ret.length==0){
					out.println("<tr height='25' align='center'><td colspan='5'>");
					out.println("没有任何记录！");
					out.println("</td></tr>");
				}else if(ret.length>0){
					String tbclass = "";
					for(int i=0;i<ret.length;i++){
							tbclass = (i%2==0)?"Grey":"";
%>
					<tr align="center" id="row_<%=i%>">
						<td class="<%=tbclass%>"><%=ret[i][0].equals("")?"&nbsp;":ret[i][0]%></td>
						<td class="<%=tbclass%>"><%=ret[i][1]%></td>
						<td class="<%=tbclass%>"><%=ret[i][2]%></td>
						<td class="<%=tbclass%>">
						  <a  title="详细信息" style="cursor:hand;color:orange;" v_idNo="<%=ret[i][4]%>" v_accountNo="<%=ret[i][2]%>" v_qryPhoneNo="<%=ret[i][3]%>" onclick="showDetailInfo(this)" ><%=ret[i][3].equals("")?"&nbsp;":ret[i][3]%></a> 
						</td>
						<td class="<%=tbclass%>"><%=ret[i][4]%></td>
					</tr>
<%
					}
				}
%>
			</table>
	</div>
</div>
<%}%>
<input type="hidden" id="retCode" name="retCode" value="<%=retCode%>" />
<input type="hidden" id="retMsg" name="retMsg" value="<%=retMsg%>" />