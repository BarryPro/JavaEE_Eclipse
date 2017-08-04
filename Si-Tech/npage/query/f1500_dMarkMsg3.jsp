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

	String opCode = "1500";
  String opName = "综合信息查询之用户积分查询";
	
	String regionCode =  (String)session.getAttribute("regCode");
	String id_no  = request.getParameter("idNo");
	String phoneNo  = request.getParameter("phoneNo");
	String cust_name  = request.getParameter("custName");
	String work_no=(String)session.getAttribute("workNo");
	String work_name=request.getParameter("workName");
	String btime=request.getParameter("btime");
	String etime=request.getParameter("etime");
	
	//add by diling for 安全加固修改服务列表
	String password = (String) session.getAttribute("password");
%>

        	
     <wtc:service name="sMarkExchQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum=
"16">
        <wtc:param value="0"/>
        <wtc:param value="01"/>
        <wtc:param value="<%=opCode%>"/>
        <wtc:param value="<%=work_no%>"/>
        <wtc:param value="<%=password%>"/>
        <wtc:param value="<%=phoneNo%>"/>
        <wtc:param value=""/>
        <wtc:param value="<%=btime%>"/>
        <wtc:param value="<%=etime%>"/>
        </wtc:service>
        <wtc:array id="MarkExchArr" scope="end"/>
	
	



<HTML><HEAD><TITLE>用户积分查询</TITLE>
</HEAD>
<body>
    	
	
			<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi">已兑换积分信息</div>
			</div>
	    <table cellspacing="0">
	      <tr align="center"> 
	        <th>操作时间</th>
	        <th>优惠名称</th>
	        <th>优惠数量</th>
	        <th>消费积分</th>
	        <th>操作模块</th>  
	        <th>操作工号</th>
	        <th>操作备注</th>  
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
					<td class="<%=tbClass%>"><%=MarkExchArr[y][8]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=MarkExchArr[y][1]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=MarkExchArr[y][3]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=MarkExchArr[y][2]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=MarkExchArr[y][5]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=MarkExchArr[y][6]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=MarkExchArr[y][9]%>&nbsp;</td>
				</tr>
		<%
		    }
		  }else {
		%>
<tr height='25' align='center' ><td colspan='7'>查询信息为空！</td></tr>
<%}}else {
			%>
			<tr height='25' align='center'><td colspan='7'><%=retMsg2%></td></tr>

					<%
	}%>
		</table>

      


	</BODY>
</HTML>

