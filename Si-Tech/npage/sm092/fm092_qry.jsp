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

  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
  
	String regionCode =  (String)session.getAttribute("regCode");
	String phoneNo  = request.getParameter("phoneNo");
	String work_no=(String)session.getAttribute("workNo");
	String work_name=request.getParameter("workName");
	
	String password = (String) session.getAttribute("password");
%>

        	
     <wtc:service name="sm092Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum=
"16">
        <wtc:param value="0"/>
        <wtc:param value="01"/>
        <wtc:param value="m092"/>
        <wtc:param value="<%=work_no%>"/>
        <wtc:param value="<%=password%>"/>
        <wtc:param value="<%=phoneNo%>"/>
        <wtc:param value=""/>
        </wtc:service>
        <wtc:array id="resultyhsc" scope="end"/>
	
<HTML><HEAD><TITLE></TITLE>
</HEAD>
<body>
    	
	
			<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi">信息查询</div>
			</div>
	    <table cellspacing="0">
	      <tr align="center"> 
	        <th>数据卡号码</th>
	        <th>提醒号码</th>
	        <th>联系人地址</th>
	        <th>操作工号</th>
	        <th>操作时间</th>
	        <th>操作</th>
	      </tr>
		<%
		if(retCode2.equals("000000")) {
		if(resultyhsc.length>0) {
			String tbClass="";
			for(int y=0;y<resultyhsc.length;y++){
				if(y%2==0){
					tbClass="Grey";
				}else{
					tbClass="";
				}
		%>
		
				<tr align="center">
					<td class="<%=tbClass%>"><%=phoneNo%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=resultyhsc[y][0]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=resultyhsc[y][3]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=resultyhsc[y][1]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=resultyhsc[y][2]%>&nbsp;</td>
					<td class="<%=tbClass%>" width="10%"><img src='/nresources/default/images/task-item-close1.gif' style='cursor:hand' alt='删除' onclick="deleteoffer('<%=phoneNo%>','<%=resultyhsc[y][0]%>')" /></td>
				</tr>
		<%
		    }
		  }else {
		%>
<tr height='25' align='center' ><td colspan='5'>查询信息为空！</td></tr>
<%}}else {
			%>
			<tr height='25' align='center'><td colspan='5'><%=retMsg2%></td></tr>

					<%
	}%>
		</table>

      


	</BODY>
</HTML>

