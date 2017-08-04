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
<%        
	
	String regionCode =  (String)session.getAttribute("regCode");
	String optypes  = request.getParameter("optypes");//用户类型
	String srv_no  = request.getParameter("srv_no");//手机号码
	String work_no=(String)session.getAttribute("workNo");
	String password = (String) session.getAttribute("password");
	String retCode2="";
	String retMsg2="";
	String[][] MarkExchArr = new String[][]{};
	%>
    <%if("2".equals(optypes)){
    %>
    <wtc:service name="sMktOrderQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode22" retmsg="retMsg22" outnum="13">
        <wtc:param value="<%=srv_no%>"/>
        <wtc:param value=""/>
        </wtc:service>
        <wtc:array id="MarkExchArr2" scope="end"/>
   <% retCode2=retCode22;
    	retMsg2=retMsg22;
    	MarkExchArr=MarkExchArr2;
   }else{%>
    	<wtc:service name="sm008Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode22" retmsg="retMsg22" outnum="16">
        <wtc:param value="0"/>
        <wtc:param value="01"/>
        <wtc:param value="m008"/>
        <wtc:param value="<%=work_no%>"/>
        <wtc:param value="<%=password%>"/>
        <wtc:param value="<%=srv_no%>"/>
        <wtc:param value=""/>
        <wtc:param value=""/>        
        <wtc:param value="<%=optypes%>"/>
        </wtc:service>
        <wtc:array id="MarkExchArr2" scope="end"/>
    <%retCode2=retCode22;
    	retMsg2=retMsg22;
    	MarkExchArr=MarkExchArr2;}
    %>
     
        	
<HTML><HEAD><TITLE></TITLE>
</HEAD>
<body>
    	
	
			<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi">查询信息</div>
			</div>
	    <table cellspacing="0" name="t1" id="t1">
	      <tr align="center"> 
	    <%if("1".equals(optypes)) {%>  	
	        <th>办理工号</th>
	        <th>办理时间</th>
	        <th>营销案名称</th>
	        <th>工号归属营业厅</th>
	        <th>专款代码</th> 
	        <th>备注</th>  
	     <%}else if("0".equals(optypes)) {%>  
	     		<th>办理工号</th>
	        <th>办理时间</th>
	        <th>品牌型号</th>
	        <th>营销案名称</th>
	        <th>工号归属营业厅</th> 
	        <th>专款代码</th> 
	     <%}else {%>  
	     		<th>办理工号</th>
	        <th>办理时间</th>
	        <th>工号归属营业厅</th>
	        <th>营销活动名称</th>
	        <th>营销方式名称</th>
	        <th>营销方式状态</th>
	        <th>营销方式开始时间</th>
					<th>营销方式结束时间</th>
					<th>资费代码</th>
					<th>资费名称</th>
					<th>主/附加资费</th>
					<th>资费开始时间</th>
					<th>资费结束时间</th>
	     <%}%>
	      </tr>
		<%
		if(retCode2.equals("000000")) {
		if(MarkExchArr.length>0) {
			String tbClass="";
			for(int y=0;y<MarkExchArr.length;y++){
				if(y%2==0){
					tbClass="Grey";
				}else{
					tbClass="";
				}
		%>
		
				<tr align="center">
					<%if("1".equals(optypes)) {%>
						<td class="<%=tbClass%>"><%=MarkExchArr[y][0]%>&nbsp;</td>
						<td class="<%=tbClass%>"><%=MarkExchArr[y][1]%>&nbsp;</td>
						<td class="<%=tbClass%>"><%=MarkExchArr[y][3]%>&nbsp;</td>
						<td class="<%=tbClass%>"><%=MarkExchArr[y][4]%>&nbsp;</td>
						<td class="<%=tbClass%>"><%=MarkExchArr[y][5]%>&nbsp;</td>
						<td class="<%=tbClass%>"><%=MarkExchArr[y][2]%>&nbsp;</td>
					<%}else if("0".equals(optypes)) {%> 
						<td class="<%=tbClass%>"><%=MarkExchArr[y][0]%>&nbsp;</td>
						<td class="<%=tbClass%>"><%=MarkExchArr[y][1]%>&nbsp;</td>
						<td class="<%=tbClass%>"><%=MarkExchArr[y][2]%>&nbsp;</td>
						<td class="<%=tbClass%>"><%=MarkExchArr[y][3]%>&nbsp;</td>
						<td class="<%=tbClass%>"><%=MarkExchArr[y][4]%>&nbsp;</td>
						<td class="<%=tbClass%>"><%=MarkExchArr[y][5]%>&nbsp;</td>						
					<%}else {%> 
						<td class="<%=tbClass%>"><%=MarkExchArr[y][0].equals("")?"-":MarkExchArr[y][0]%>&nbsp;</td>
						<td class="<%=tbClass%>"><%=MarkExchArr[y][1].equals("")?"-":MarkExchArr[y][1]%>&nbsp;</td>
						<td class="<%=tbClass%>"><%=MarkExchArr[y][2].equals("")?"-":MarkExchArr[y][2]%>&nbsp;</td>
						<td class="<%=tbClass%>"><%=MarkExchArr[y][3].equals("")?"-":MarkExchArr[y][3]%>&nbsp;</td>
						<td class="<%=tbClass%>"><%=MarkExchArr[y][4].equals("")?"-":MarkExchArr[y][4]%>&nbsp;</td>
						<td class="<%=tbClass%>"><%=MarkExchArr[y][12].equals("")?"-":MarkExchArr[y][12]%>&nbsp;</td>
						<td class="<%=tbClass%>"><%=MarkExchArr[y][5].equals("")?"-":MarkExchArr[y][5]%>&nbsp;</td>
						<td class="<%=tbClass%>"><%=MarkExchArr[y][6].equals("")?"-":MarkExchArr[y][6]%>&nbsp;</td>
						<td class="<%=tbClass%>"><%=MarkExchArr[y][7].equals("")?"-":MarkExchArr[y][7]%>&nbsp;</td>
						<td class="<%=tbClass%>"><%=MarkExchArr[y][8].equals("")?"-":MarkExchArr[y][8]%>&nbsp;</td>
						<td class="<%=tbClass%>"><%=MarkExchArr[y][9].equals("")?"-":MarkExchArr[y][9]%>&nbsp;</td>
						<td class="<%=tbClass%>"><%=MarkExchArr[y][10].equals("")?"-":MarkExchArr[y][10]%>&nbsp;</td>
						<td class="<%=tbClass%>"><%=MarkExchArr[y][11].equals("")?"-":MarkExchArr[y][11]%>&nbsp;</td>					
					<%}%> 

				</tr>
		<%
		    }
   
		  }else {
		%>
		<%if("2".equals(optypes)) {%>
			<tr height='25' align='center' ><td colspan='13'>查询信息为空！</td></tr>
		<%}else {%> 
			<tr height='25' align='center' ><td colspan='6'>查询信息为空！</td></tr>
		<%}%> 
<%}}else {%>
		<%if("2".equals(optypes)) {%>
			<tr height='25' align='center'><td colspan='13'>查询失败：<%=retCode2%>--<%=retMsg2%></td></tr>
		<%}else {%> 
			<tr height='25' align='center'><td colspan='6'>查询失败：<%=retCode2%>--<%=retMsg2%></td></tr>
		<%}%> 
		<%}%>
		</table>

      


	</BODY>
</HTML>

