<%
    /*************************************
    * 功  能: 促销品统一付奖  2266
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-2-21
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String strPhoneNo = WtcUtil.repStr(request.getParameter("phone_no"), "");
	String loginNo = (String)session.getAttribute("workNo");
	String loginNoPass = (String)session.getAttribute("password");  
	String strAwardCode = request.getParameter("v_awardcode");
  String strAwardDetailCode = request.getParameter("detailcode");
  String strUserPasswd = "";
  
  System.out.println("--2266---strPhoneNo="+strPhoneNo);
  
  String retFlag="",f2266QueryHistoryRetMsg="";//用于判断页面刚进入时的正确性
  
  String[] paraAray1 = new String[8];
  paraAray1[0] = loginNo; 			/* 操作工号   */
  paraAray1[1] = loginNoPass; 	/* 操作工号   */
  paraAray1[2] = "2253"; 				/* 操作代码*/
  paraAray1[3] = strPhoneNo;		/* 手机号码   */ 
  paraAray1[4] = strAwardCode;
  paraAray1[5] = strAwardDetailCode;
  paraAray1[6] = "2";
  paraAray1[7] = strUserPasswd;
  
  for(int i=0; i<paraAray1.length; i++)
  {		
		if( paraAray1[i] == null )
		{
	  	paraAray1[i] = "";
		}
  }

%>
	<wtc:service name="s2266Init" routerKey="phone" routerValue="<%=strPhoneNo%>" outnum="13" retcode="retCode" retmsg="retMsg">
	<wtc:param value="<%=paraAray1[0]%>"/>
	<wtc:param value="<%=paraAray1[1]%>"/>
	<wtc:param value="<%=paraAray1[2]%>"/>
	<wtc:param value="<%=paraAray1[3]%>"/>
	<wtc:param value="<%=paraAray1[4]%>"/>
	<wtc:param value="<%=paraAray1[5]%>"/>
	<wtc:param value="<%=paraAray1[6]%>"/>
	<wtc:param value="<%=paraAray1[7]%>"/>
	</wtc:service>
	<wtc:array id="s2266InitArr" scope="end"/>

  <div id="Main">
		<div id="Operation_Table">
      <div class="title">
        <div id="title_zi">付奖明细</div>
      </div>
			<TABLE cellSpacing="0">
   	<TBODY> 

<%
System.out.println("===============2266=============retCode="+retCode);
if("000000".equals(retCode)){
  if(s2266InitArr.length==0){
		out.println("<tr height='25' align='center'><td colspan='11'>");
		out.println("s2266Init查询号码基本信息为空!<br>retCode:"+retCode);
		out.println("</td></tr>");
	}else if(s2266InitArr.length>0){
%>
		  <tr align="center">
	  		<th>选择</td>
			  <th>奖品类别</th>
			  <th>营销案名称</th>
			  <th>数量</th>
			  <th>奖品名称</th>
			  <th>领取标志</th>
			  <th>中奖日期</th>
			  <th>操作流水</th>
			  <th>领奖工号</th>
			  <th>领奖日期</th>
			  <th>备注</th>
		  </tr>
  <% 
  		String tbclass="";
		  for(int j=0;j<s2266InitArr.length;j++){
		  	if(j%2==0){
		  		tbclass="Grey";
		  	}else{
		  		tbclass="";	
		  	}
	%>
			<tr align="center">		
				<td class="<%=tbclass%>"><%=s2266InitArr[j][0]%></td>
				<td class="<%=tbclass%>"><%=s2266InitArr[j][1]%></td>
				<td class="<%=tbclass%>"><%=s2266InitArr[j][2]%></td>
				<td class="<%=tbclass%>"><%=s2266InitArr[j][3]%></td>
				<td class="<%=tbclass%>"><%=s2266InitArr[j][4]%></td>
				<td class="<%=tbclass%>"><%=s2266InitArr[j][5]%></td>
				<td class="<%=tbclass%>"><%=s2266InitArr[j][6]%></td>
				<td class="<%=tbclass%>"><%=s2266InitArr[j][7]%></td>
				<td class="<%=tbclass%>"><%=s2266InitArr[j][8]%></td>
				<td class="<%=tbclass%>"><%=s2266InitArr[j][9]%></td>
				<td class="<%=tbclass%>"><%=s2266InitArr[j][12]%></td>
			</tr>				
			<%}%>  		
 		</TBODY>
<%
	}
%>
	</TABLE>		
	</div>
</div>
<%
}
%>
<input type="hidden" id="retCodeQueryHistory" name="retCodeQueryHistory" value="<%=retCode%>" />
<input type="hidden" id="retMsgQueryHistory" name="retMsgQueryHistory" value="<%=retMsg%>" />
<input type="hidden" id="queryHistoryPhoneNo" name="queryHistoryPhoneNo" value="<%=strPhoneNo%>">
