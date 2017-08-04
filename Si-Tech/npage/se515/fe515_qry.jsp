<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%        

		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
	  String regionCode =  (String)session.getAttribute("regCode");
	  String phoneNo  = request.getParameter("PhoneNo");
	  String work_no=(String)session.getAttribute("workNo");

%>

        	
     <wtc:service name="sE515ZnQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum=
"7">
        <wtc:param value="0"/>
        <wtc:param value="01"/>
        <wtc:param value="<%=opCode%>"/>
        <wtc:param value="<%=work_no%>"/>
        <wtc:param value=""/>
        <wtc:param value="<%=phoneNo%>"/>
        <wtc:param value=""/>
        </wtc:service>
        <wtc:array id="MarkExchArr" scope="end"/>
	
	



<HTML><HEAD><TITLE>实名制转换积分查询</TITLE>
</HEAD>
<body>
    	
	
			<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi">查询信息列表</div>
			</div>
	    <table cellspacing="0">
	      <tr align="center"> 
	        <th>年月</th>
	        <th>消费积分</th>
	        <th>品牌奖励积分</th>
	        <th>网龄奖励积分</th>
	        <th>专项转移积分</th>  
	        <th>处理标识</th>
	        <th>处理原因</th>  
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
					<td class="<%=tbClass%>"><%=MarkExchArr[y][0]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=MarkExchArr[y][1]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=MarkExchArr[y][2]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=MarkExchArr[y][3]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=MarkExchArr[y][4]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=MarkExchArr[y][5]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=MarkExchArr[y][6]%>&nbsp;</td>
		
				</tr>
		<%
		    }
		  }else {
		%>
<tr height='25' align='center'><td colspan='7'>查询信息为空！</td></tr>
<%}}else {
			%>
			<script language="JavaScript">
					    rdShowMessageDialog("<%=retCode2%>"+"<%=retMsg2%>",0);	
					</script>
					<%
	}%>
		</table>

      


	</BODY>
</HTML>

