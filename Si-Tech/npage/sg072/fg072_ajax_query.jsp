<%
    /*************************************
    * 功  能: 报停状态查询 g072
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-9-7
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String phoneNo = WtcUtil.repStr(request.getParameter("phoneNo"), "");
	String opCode=WtcUtil.repNull((String)request.getParameter("opCode"));
	String opName=WtcUtil.repNull((String)request.getParameter("opName"));
	String workNo=WtcUtil.repNull((String)session.getAttribute("workNo"));
	String password=WtcUtil.repNull((String)session.getAttribute("password"));
	String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
	String notes = opName;
%>
 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>

	<wtc:service name="sG072Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="7">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/> 
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/> 
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=notes%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
    if("000000".equals(retCode)){
%>

  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">报停状态查询结果</div>
			</div>
			<table cellspacing="0" name="t1" id="t1">
				<tr>
				 <!--  <th>运行状态</th>-->
					<th>欠费提醒号码</th> 
					<th>办理时间</th>
					<th>到期时间</th>
					<!-- <th>报停时间</th>-->
					<th>操作工号</th>
					<th>操作信息</th>
					<th>操作</th>
				</tr>
<%
				if(ret.length==0){
%>
					<script language="javascript">
					  rdShowMessageDialog("该用户未办理报停业务！",1);
            window.location.href="fg072_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
					</script>
<%
				}else if(ret.length>0){
					String tbclass = "";
					for(int i=0;i<ret.length;i++){
							tbclass = (i%2==0)?"Grey":"";
%>
					<tr align="center" id="row_<%=i%>">
						<td class="<%=tbclass%>">
						  <input type="text" id="qryPromptPhoneNo<%=i%>" name="qryPromptPhoneNo<%=i%>" value="<%=ret[i][1]%>" v_type="mobphone" size="13" class="InputGrey" readonly="true" /> 
						</td>
						<td class="<%=tbclass%>"><%=ret[i][2]%></td>
						<td class="<%=tbclass%>"><%=ret[i][4]%></td>
						
						<td class="<%=tbclass%>"><%=ret[i][5]%></td>
						<td class="<%=tbclass%>"><%=ret[i][6]%></td>
						<td class="<%=tbclass%>">
						  <input class="b_text" type="button" id="uptBtn<%=i%>" name="uptBtn<%=i%>" value="修改" onClick="chgMsg(this,'<%=phoneNo%>')" />
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