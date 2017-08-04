<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-13 页面改造,修改样式
*
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%
       
	
	String regionCode =  (String)session.getAttribute("regCode");		
	String work_no = (String)session.getAttribute("workNo");	
	String xiaoqudaima  = request.getParameter("xiaoqudaima");
	String oprtypes  = request.getParameter("oprtypes");
	String offeridss  = request.getParameter("offeridss");
	String statess  = request.getParameter("statess");
	String propertyUnitVal  = request.getParameter("propertyUnitVal");
	
	String opflag = (String)request.getParameter("opflag") == null ? "" : (String)request.getParameter("opflag") ;
	
	
	//add by diling for 安全加固修改服务列表
	String password = (String) session.getAttribute("password");	
	String  inputParsm [] = new String[17];
			inputParsm[0] = "0";
			inputParsm[1] = "01";
			inputParsm[2] = "m337";
			inputParsm[3] = work_no;
			inputParsm[4] = password;
			inputParsm[5] = "";
			inputParsm[6] = "";	
			inputParsm[7] = propertyUnitVal;	
			
			String beizhuss =work_no+"进行小区对应资费信息查询";
%>
     	
	<wtc:service name="sM337Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="15">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>
			<wtc:param value="<%=beizhuss%>"/>
			<wtc:param value="<%=oprtypes%>"/>
			<wtc:param value="<%=xiaoqudaima%>"/>
			<wtc:param value="<%=offeridss%>"/>
			<wtc:param value="<%=statess%>"/>
				
		<%if("".equals(opflag)) {%>
			<wtc:param value="<%=inputParsm[3]%>"/>
		<%}else{%>
		  <wtc:param value=""/>
		<%}%>
			<wtc:param value="<%=inputParsm[7]%>"/>
	</wtc:service>
		<wtc:array id="result2" scope="end"  />

	
<HTML><HEAD><TITLE></TITLE>
</HEAD>
<body>
    	
	<%if("".equals(opflag)) {%>
	
			<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi">小区对应资费信息&nbsp;&nbsp;<input type="button" name="toexcel" class="b_foot" value="导出" onclick="printTable(t1);" /></div>
			</div>
	    <table cellspacing="0" name="t1" id="t1">
	      <tr align="center"> 
	        <th><input type="checkbox"   id="ssd" onclick="if(this.checked==true) { checkAll(); } else { clearAll(); }"/></th>
	        <th width="80px">小区代码</th>
	        <th>小区名称</th>
	        <th>资费代码</th>
	        <th>资费名称</th>
	        <th>初装费</th>
	      <!--  <th>审批状态</th>
	        <th>审批原因</th>
	    <th>营销活动</th>
	        <th>备注信息</th>
	        <th>营销审批状态</th>
	        <th>营销审批原因</th>
	        <th>删除类型</th>-->
	      </tr>
		<%
		if(retCode.equals("000000")) {
		System.out.println(result2.length);

		if(result2.length>0) {
			String tbClass="";
			for(int y=0;y<result2.length;y++){
				if(y%2==0){
					tbClass="Grey";
				}else{
					tbClass="";
				}
		%>
						<tr align="center">
						<td class="<%=tbClass%>" ><input type="checkbox"  value="<%=result2[y][0]%>#$#<%=result2[y][2]%>" id="ckbox" /></td>
						<td width="80px" class="<%=tbClass%>"><%=result2[y][0]%></td>
						<td class="<%=tbClass%>"><%=result2[y][1]%></td>
						<td class="<%=tbClass%>"><%=result2[y][2]%></td>					
						<td class="<%=tbClass%>"><%=result2[y][3]%></td>
						<td class="<%=tbClass%>">
							<input type="hidden" id="zfzt" value="<%=result2[y][4]%>"/>
							<input type="hidden" id="yxzt" value="<%=result2[y][13]%>"/>
							<input type="hidden" id="delType" value="Y-N"/>
							<%=result2[y][9]%>
						</td>
						<!--<td class="<%=tbClass%>"><% if("Y".equals(result2[y][4])){out.print("审批通过");}
																   else if("N".equals(result2[y][4])){out.print("审批不通过");}
																   else if("A".equals(result2[y][4])){out.print("待审批");}%></td>
						<td class="<%=tbClass%>"><%=result2[y][5]%></td>
						<td class="<%=tbClass%>"><%=result2[y][11]%></td>
						<td class="<%=tbClass%>"><%=result2[y][12]%></td>
						<td class="<%=tbClass%>"><% if("Y".equals(result2[y][13])){out.print("审批通过");}
																   else if("N".equals(result2[y][13])){out.print("审批不通过");}
																   else if("A".equals(result2[y][13])){out.print("待审批");}%></td>
						<td class="<%=tbClass%>"><%=result2[y][14]%></td>
						<td class="<%=tbClass%>">
							<input type="hidden" id="zfzt" value="<%=result2[y][4]%>"/>
							<input type="hidden" id="yxzt" value="<%=result2[y][13]%>"/>
							<input type="hidden" id="delType" value="Y-N"/>
							<!-- <select id="delType">
								<option value="N-N">-请选择-</option>								
								<option value="Y-N">删除小区对应资费</option>
								<option value="N-Y">删除营销活动和备注</option>
								<option value="Y-Y">两个都删除</option>
							</select> -->
						</td>
		</tr>
		<%
		    }
		  }else {
		%>
<tr height='25' align='center' ><td colspan='13'>查询小区对应资费信息为空！</td></tr>
<%}}else {
			%>
			<tr height='25' align='center'><td colspan='13'>查询小区对应信息失败：<%=retCode%>--<%=retMsg%></td></tr>

					<%
	}%>
		</table>
		</div>

 
<%}else {%> 
			<div class="title">
				<div id="title_zi">小区对应资费信息</div>
			</div>
	    <table cellspacing="0" name="t1" id="t1">
	      <tr align="center"> 
	        <th width=5%>资费代码</th>
	        <th width=16%>资费名称</th>
	        <th width=5%>带宽</th>
	        <th width=5%>价格</th>
	        <th width=8%>周期</th>
	        <th width=8%>初装费</th>
	      </tr>
		<%
		if(retCode.equals("000000")) {
		System.out.println(result2.length);

		if(result2.length>0) {
			String tbClass="";
			for(int y=0;y<result2.length;y++){
				if(y%2==0){
					tbClass="Grey";
				}else{
					tbClass="";
				}
		%>
		<% if(!"".equals(result2[y][2])){%>
					<tr align="center"  >
						<td class="<%=tbClass%>"><%=result2[y][2]%></td>					
						<td class="<%=tbClass%>"><%=result2[y][3]%></td>
						<td class="<%=tbClass%>"><%=result2[y][6]%></td>
						<td class="<%=tbClass%>"><%=result2[y][7]%>元</td>
						<td class="<%=tbClass%>"><%=result2[y][8]%>月</td>
						<td class="<%=tbClass%>"><%=result2[y][9]%></td>
					</tr>
		<%
		    }
		    }
		    %>
		  
		    <%
		  }else {
		%>
<tr height='25' align='center' ><td colspan='8' >查询小区对应资费信息为空！</td></tr>
<%}}else {
			%>
			<tr height='25' align='center'><td colspan='8'>查询小区对应信息失败：<%=retCode%>--<%=retMsg%></td></tr>

					<%
	}
	
	
	%>
	
		</table>
		<div class="title">
			<div id="title_zi">营销活动备注信息</div>
		</div>
    <table cellspacing="0" name="t1" id="t1">
      <tr align="center"> 
        <th width=8%>营销活动</th>
	      <th width=8%>备注信息</th>
      </tr>
      <% if(result2.length>0){ %>
	      <tr align="center"> 
	        <td><%=result2[0][11]%></td>
					<td><%=result2[0][12]%></td>
	      </tr>
      <%}else{%>
      	<tr height='25' align='center' ><td colspan='2' >查询营销活动备注信息为空！</td></tr>
      	<%}%>
     </table>
<%}%>    


	</BODY>
</HTML>

