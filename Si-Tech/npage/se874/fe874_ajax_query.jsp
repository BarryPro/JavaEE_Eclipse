<%
    /*************************************
    * 功  能: 智能网管控查询 e874
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-6-7
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  String regCode = (String)session.getAttribute("regCode");
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String startTime = WtcUtil.repStr(request.getParameter("startTime"), "");
	String endTime = WtcUtil.repStr(request.getParameter("endTime"), "");
	String region_code = WtcUtil.repStr(request.getParameter("region_code"), "");
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>

	<wtc:service name="se874Qry" routerKey="region" routerValue="<%=regCode%>" 
		retcode="retCode" retmsg="retMsg" outnum="11">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=region_code%>"/> 
		<wtc:param value="<%=startTime%>"/>
		<wtc:param value="<%=endTime%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
System.out.println("---e874------diling------------region_code="+region_code);
System.out.println("---e874------diling------------retCode="+retCode);
    if("000000".equals(retCode)){
%>
  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">智能网管控查询结果</div>
			</div>
			<table cellspacing="0" name="t1" id="t1">
				<tr>
					<th>地市代码</th>
					<th>地市名称</th>
					<th>通讯客户数</th>
					<th>智能网用户数</th>
					<th>目前占比</th>
					<th>上限占比</th>
					<th>可添加智能网成员数</th>
					<%
					  if(!"00".equals(region_code)){
					%>
    					<th>操作时间</th>
    				  <th>操作工号</th>
    				  <th>操作代码</th>
    				  <th>操作说明</th>
					<%  
					 }else{
					%>
					    <th>操作</th>
					<%
					 }
					%>
					
				</tr>
<%
				if(ret.length==0){
					out.println("<tr height='25' align='center'><td colspan='11'>");
					out.println("没有任何记录！");
					out.println("</td></tr>");
				}else if(ret.length>0){
					String tbclass = "";
					for(int i=0;i<ret.length;i++){
							tbclass = (i%2==0)?"Grey":"";
%>
					<tr align="center" id="row_<%=i%>">
						<td class="<%=tbclass%>"><%=ret[i][0]%></td>
						<td class="<%=tbclass%>"><%=ret[i][1]%></td>
						<td class="<%=tbclass%>"><%=ret[i][2]%></td>
						<td class="<%=tbclass%>"><%=ret[i][3]%></td>
						<td class="<%=tbclass%>"><%=ret[i][4]%>%</td>
						
						<%
						  if("00".equals(region_code)){/*diling update for 如果选择区域为黑龙江，则上限占比可修改@2012/8/27*/
						%>
						    <td class="<%=tbclass%>">
						      <input type="text" id="limitRatio<%=i%>" name="limitRatio<%=i%>" value="<%=ret[i][5]%>%" size="7" class="InputGrey" readonly="true" />  
						    </td>
						<%
						  }else{
						%>
						    <td class="<%=tbclass%>"><%=ret[i][5]%>%</td>
						<%
						  }
						%>
						<td class="<%=tbclass%>"><%=ret[i][6]%></td>
						<%
					  if(!"00".equals(region_code)){/*diling update for 如果选择区域为黑龙江，则不展示此内容@2012/8/27*/
					  %>
  						<td class="<%=tbclass%>"><%=ret[i][7]%></td>
  						<td class="<%=tbclass%>"><%=ret[i][8]%></td>
  						<td class="<%=tbclass%>"><%=ret[i][9]%></td>
  						<td class="<%=tbclass%>"><%=ret[i][10]%></td>
						<%
					  }else{/*diling update for 如果选择区域为黑龙江，可对上限占比进行修改@2012/8/27*/
					  %>
					    <td class="<%=tbclass%>"><input class="b_text" type="button" id="uptBtn<%=i%>" name="uptBtn<%=i%>" value="修改" onClick="chgMsg(this,'<%=ret[i][0]%>')" /></td>
					  <%
					  }
						%>
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