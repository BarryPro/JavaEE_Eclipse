<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
		/*------查看手机用户是否是实名制用户*/
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		String opCode = request.getParameter("opCode");
		String PhoneNo = request.getParameter("PhoneNo");
		String operType = request.getParameter("operType");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String isBlackList = "";
%>
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="printAccept"/>

	<wtc:service name="se885Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="7">
	  <wtc:param value="<%=printAccept%>"/>
	  <wtc:param value="01"/>
	  <wtc:param value="<%=opCode%>"/>
	  <wtc:param value="<%=workNo%>"/>
	  <wtc:param value="<%=password%>"/>
	  <wtc:param value="<%=PhoneNo%>"/>
	  <wtc:param value=""/>
	  <wtc:param value=""/>
	  <wtc:param value="<%=startTime%>"/>
	  <wtc:param value="<%=endTime%>"/>
	  <wtc:param value="<%=operType%>"/>
	</wtc:service>
	<wtc:array id="dcust2" scope="end" />
<%
	if(retCode2.equals("000000")){
    if(dcust2.length>0){
    	if("".equals(operType)){ //处理方式为“全部”，才显示@2015/4/17 
    		if("Y".equals(dcust2[0][6])){
	    		isBlackList = "(黑名单：是)";
		    }else{
		    	isBlackList = "(黑名单：否)";
		    }
    	}
    }
  }
%>
	<div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">查询信息<font class='red'><%=isBlackList%></font></div>
			</div>
			<table>
				<tr>
					<th>手机号码</th>						
					<th>数据来源</th>
					<th>不良信息类型</th>
					<th>黑名单状态</th>
					<th>加解黑名单原因描述</th>
					<th>处理方式</th>
					<th>操作工号</th>
					<th>操作时间</th>
				</tr>
	 	<%if(retCode2.equals("000000")){
		    if(dcust2.length>0){
			    for(int i=0;i<dcust2.length; i++){
				    if(dcust2[i][0].trim().equals("")){
				    }else{
		%>
				<tr> 
					<td width="6%"><%=PhoneNo%></td>
					<td width="7%"><%if(dcust2[i][0].equals("01")){out.print("全网监控平台");}if(dcust2[i][0].equals("02")){out.print("省内监控");}if(dcust2[i][0].equals("03")){out.print("举报处理");}if(dcust2[i][0].equals("04")){out.print("用户投诉");}%></td>
					<td width="6%"><%if(dcust2[i][1].equals("01")){out.print("垃圾短信");}if(dcust2[i][1].equals("02")){out.print("骚扰电话");}%></td>
					<td width="6%"><%if(dcust2[i][6].equals("Y")){out.print("是");}if(dcust2[i][6].equals("N")){out.print("否");}%></td>
					<td width="20%"><%=dcust2[i][3]%></td>
					<td width="10%"><%if(dcust2[i][2].trim().equals("01")){out.print("停短信");}if(dcust2[i][2].trim().equals("02")){out.print("恢复短信");}if(dcust2[i][2].trim().equals("03")){out.print("停语音");}if(dcust2[i][2].trim().equals("04")){out.print("恢复语音");}%></td>
					<td width="6%"><%=dcust2[i][4]%></td>
					<td width="10%"><%=dcust2[i][5]%></td>
			  </tr>
			  <%
 				   } 
				 }
			 }else{%>
			 <tr height='25' align='center'> 
					<td colspan='8'>没有查询记录！</td>
			 </tr>
		 <%}
		 }%>
		  </table>
		</div>
	</div>
<input type="hidden" id="retCode" name="retCode" value="<%=retCode2%>" />
<input type="hidden" id="retMsg" name="retMsg" value="<%=retMsg2%>" />
