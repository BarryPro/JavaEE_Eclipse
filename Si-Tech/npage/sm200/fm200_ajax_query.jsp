<%
    /*************************************
    * 功  能: m200·IDC交换机端口信息维护 
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2014/11/22
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
	String loginNo= (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String opName = WtcUtil.repStr(request.getParameter("opName"), "");
	String portName = WtcUtil.repStr(request.getParameter("portName"), "");
	String unitCustName = WtcUtil.repStr(request.getParameter("unitCustName"), "");
%>
	<wtc:service name="sm200Qry" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="4">
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=opCode%>"/> 
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=password%>"/> 
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=portName%>"/>
		<wtc:param value="<%=unitCustName%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
    if("000000".equals(retCode)){
%>
  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi"><%=opName%>查询结果</div>
			</div>
			<table cellspacing="0" name="t1" id="t1" vColorTr='set'>
				<tr>
					<th>端口号ID</th>
					<th>设备端口号名称</th>
					<th>集团客户名称</th>
					<th>当前状态</th>
					<th>操作</th>
				</tr>
<%
				if(ret.length==0){
					out.println("<tr height='25' align='center'><td colspan='5'>");
					out.println("没有任何记录！");
					out.println("</td></tr>");
				}else if(ret.length>0){
					for(int i=0;i<ret.length;i++){
%>
					<tr align="center" id="qryTr<%=i%>" name="qryTr" v_portId="<%=ret[i][0]%>" v_portName="<%=ret[i][1]%>" v_unitCustName="<%=ret[i][2]%>" v_state="<%=ret[i][3]%>" >
						<td><%=ret[i][0]%></td>
						<td><input type="text" id="qryPortName<%=i%>" name="qryPortName" value="<%=ret[i][1]%>" class="InputGrey" readonly style="width:300px;" /></td>
						<td><input type="text" id="qryUnitCustName<%=i%>" name="qryUnitCustName" value="<%=ret[i][2]%>" class="InputGrey" readonly  style="width:300px;" /></td>
						<td><%if("0".equals(ret[i][3])){%>
										未占用
								<%}else{%>
										已占用
								<%}%>
						</td>
						<td>
							<input type="button" id="uptBtn" name="uptBtn" class="b_foot" value="修改" v_sum="<%=i%>" onClick="uptInfo(this)" />
							&nbsp;&nbsp;
							<input type="button" id="delBtn" name="delBtn" class="b_foot" value="删除" v_sum="<%=i%>" onClick="uptInfo(this)" />
						</td>
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
