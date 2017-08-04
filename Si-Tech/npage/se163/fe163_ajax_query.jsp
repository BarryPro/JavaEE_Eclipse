<%
  /*
   * 功能: 集团成员二次确认短信代码查询 e163
   * 版本: 1.0
   * 日期: 20110803
   * 作者: diling
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String startTime = WtcUtil.repStr(request.getParameter("startTime"), "");
	String endTime = WtcUtil.repStr(request.getParameter("endTime"), "");
	String phoneNo = WtcUtil.repStr(request.getParameter("phoneNo"), "");
	String unitNo = WtcUtil.repStr(request.getParameter("unitNo"), "");
	String operateNo = WtcUtil.repStr(request.getParameter("operateNo"), "");
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String regionCode = WtcUtil.repStr(request.getParameter("regionCode"), "");
%>

	<wtc:service name="s4869Qry" routerKey="regionCode" routerValue="<%=regionCode%>" 
		retcode="retCode" retmsg="retMsg" outnum="9">
		<wtc:param value="<%=startTime%>"/>
		<wtc:param value="<%=endTime%>"/>
		<wtc:param value="<%=operateNo%>"/>
		<wtc:param value="<%=unitNo%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=opCode%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
    if("000000".equals(retCode)){
    
%>

  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">集团成员二次确认短信代码查询结果</div>
			</div>
			<table cellspacing="0" name="t1" id="t1">
				<tr>
					<th>业务类型</th>
					<th>下行短信端口号</th>
					<th>手机号码</th>
					<th>品牌</th>
					<th>受理结果</th>
					<th>处理信息</th>
					<th>处理日期</th>
					<th>操作工号</th>
				</tr>
<%
				if(ret.length==0){
					out.println("<tr height='25' align='center'><td colspan='15'>");
					out.println("没有任何记录！");
					out.println("</td></tr>");
				}else if(ret.length>0){
					String tbclass = "";
					for(int i=0;i<ret.length;i++){
							tbclass = (i%2==0)?"Grey":"";
%>
					<tr align="center" id="row_<%=i%>">
						<td class="<%=tbclass%>"><%=ret[i][8]%></td>
						<td class="<%=tbclass%>"><%=ret[i][0]%></td>
						<td class="<%=tbclass%>"><%=ret[i][1]%></td>
						<td class="<%=tbclass%>"><%=ret[i][2]%></td>
						<td class="<%=tbclass%>"><%=ret[i][3]%></td>
						<td class="<%=tbclass%>"><%=ret[i][4]%></td>
						<td class="<%=tbclass%>"><%=ret[i][5]%></td>
						<td class="<%=tbclass%>"><%=ret[i][6]%></td>
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