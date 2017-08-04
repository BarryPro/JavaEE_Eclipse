<%
  /*
   * 功能: 全国直管客户信息查询 1993
   * 版本: 1.0
   * 日期: 2014-10-28
   * 作者: diling
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String directManageCustNo = WtcUtil.repStr(request.getParameter("directManageCustNo"), "");
	String groupNo = WtcUtil.repStr(request.getParameter("groupNo"), "");
	String institutionName = WtcUtil.repStr(request.getParameter("institutionName"), "");
	String directManageCustName = WtcUtil.repStr(request.getParameter("directManageCustName"), "");
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	
	String regCode = (String)session.getAttribute("regCode");
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String password = WtcUtil.repNull((String)session.getAttribute("password"));
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>
		
	<wtc:service name="sDirCustMsgQry" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="6">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=directManageCustNo%>"/>
		<wtc:param value="<%=institutionName%>"/>
		<wtc:param value="<%=groupNo%>"/>
		<wtc:param value="<%=directManageCustName%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
    if("000000".equals(retCode)){
%>

  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">全国直管客户信息查询结果</div>
			</div>
			<table cellspacing="0" name="t1" id="t1">
				<tr>
					<th></th>
					<th>全国直管客户编码</th>
					<th>全国直管客户名称</th>
					<th>总部或分支机构名称</th>
					<th>所属省</th>
					<th>所属市</th>
					<th>组织机构代码</th>
				</tr>
<%
				if(ret.length==0){
					out.println("<tr height='25' align='center'><td colspan='7'>");
					out.println("没有任何记录！");
					out.println("</td></tr>");
				}else if(ret.length>0){
					String tbclass = "";
					for(int i=0;i<ret.length;i++){
							tbclass = (i%2==0)?"Grey":"";
%>
				<tr align="center" id="row_<%=i%>">
					<td class="<%=tbclass%>"><input type="radio" id="selDirMageCust<%=i%>" name="selDirMageCust" value="<%=ret[i][0]%>" v_directManageCustNo="<%=ret[i][0]%>" v_directManageCustName="<%=ret[i][1]%>" v_groupNo="<%=ret[i][5]%>" /></td>
					<td class="<%=tbclass%>"><%=ret[i][0]%></td>
					<td class="<%=tbclass%>"><%=ret[i][1]%></td>
					<td class="<%=tbclass%>"><%=ret[i][2]%></td>
					<td class="<%=tbclass%>"><%=ret[i][3]%></td>
					<td class="<%=tbclass%>"><%=ret[i][4]%></td>
					<td class="<%=tbclass%>"><%=ret[i][5]%></td>
				</tr>
<%
					}
				}
%>
				<tr>
				  <td colspan="7" align="center" id="footer">
				    <input type="button" id="submitBtn" name="submitBtn" class="b_foot" value="确认" onClick="saveToQryInfo()" />   
				    <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="关闭" onClick="window.close();" />
				  </td>
				</tr>
			</table>
	</div>
</div>

<%}%>
<input type="hidden" id="retCode" name="retCode" value="<%=retCode%>" />
<input type="hidden" id="retMsg" name="retMsg" value="<%=retMsg%>" />