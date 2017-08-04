<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa)2015-8-19 13:35:58------------------
 关于7月下旬集团客户部CRM、BOSS系统需求的函--2、BOSS系统根据地市添加、删除成员的需求
 
 
 -------------------------后台人员：haoyy--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = "选择资费";
  String workNo    = (String)session.getAttribute("workNo");
  String password  = (String)session.getAttribute("password");
  String workName  = (String)session.getAttribute("workName");
  String orgCode   = (String)session.getAttribute("orgCode");
  String ipAddrss  = (String)session.getAttribute("ipAddr");
  String regionCode = (String)session.getAttribute("regCode");
  
  String p_id = WtcUtil.repNull(request.getParameter("p_id"));
  
%>
	<wtc:service name="sGetAddProduct" outnum="4" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="" />                       
		<wtc:param value="<%=p_id%>" />
		<wtc:param value="" />
		<wtc:param value="" />
		<wtc:param value="<%=regionCode%>" />
		<wtc:param value="JT" />
		<wtc:param value="" />	
		<wtc:param value="<%=opCode%>" />	
		<wtc:param value="" />	
		<wtc:param value="" />	
		<wtc:param value="" />				
		<wtc:param value="<%=workNo%>" />		
		<wtc:param value="" />	
		<wtc:param value="" />	
		<wtc:param value="" />	
	</wtc:service>
	<wtc:array id="result_t" scope="end" />
		

<%
	if("000000".equals(code1)){
		 
	}else{
%>
<SCRIPT language=JavaScript>
	rdShowMessageDialog("sGetAddProduct错误：<%=code1%>，<%=msg1%>");
	window.close();
</SCRIPT>		
<%		
	}
	
%>
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE></TITLE>
<SCRIPT language=JavaScript>
	function save(){
		var radio_obj   = $("input[name='list_radio']:checked");
		var td_obj      = radio_obj.parent();
		var offer_id    = td_obj.next().text().trim();
		var offer_name  = td_obj.next().next().text().trim();
		if(offer_id==""){
			rdShowMessageDialog("请选择资费");
			return;
		}
		opener.getmebProdCode(offer_id,offer_name);
		window.close(); 
	}
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">资费列表</div></div>


<table cellSpacing="0">
	<tr>
		<tr>
			<th>选择</th>
			<th>资费代码</th>
			<th>资费名称</th>
		</tr>
<%
for(int i=0;i<result_t.length;i++){
%>
<tr>
	<td><input type="radio" name="list_radio" ></td>
	<td><%=result_t[i][2]%></td>
	<td><%=result_t[i][3]%></td>
</tr>	
<%
}
%>
 	</tr>
</table>
 
<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="确定" onclick="save()"           />
			<input type="button" class="b_foot" value="关闭" onclick="window.close()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>