<%
	String opName =request.getParameter("opName");
	String opCode =request.getParameter("opCode");

%>
<%@ page contentType="text/html;charset=GB2312"%>
<%System.out.println("----------------------------getContractNo.jsp------------------------------------");  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>	
<%
	String gCustId = WtcUtil.repNull(request.getParameter("gCustId"));	
	String userName = WtcUtil.repNull(request.getParameter("userName"));
	
	String retCode = ""; 
	String strArray="var arrMsg;";  //must  
%>
<!--取客户账户信息-->
<wtc:utype name="sQryCustCons" id="retVal" scope="end">
     <wtc:uparam value="<%=gCustId%>" type="LONG"/>
</wtc:utype>
<%
retCode = String.valueOf(retVal.getValue(0));
if(!retCode.equals("0") || retVal.getSize(2) == 0){
%>
<script type="text/javascript">
	var h=250;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="height:"+h+",width:"+w+",left:"+l+"px, top:"+t+"px,toolbar:no, menubar:no,scrollbars:yes,resizable:no,location:no,status:no,help:no";
	window.opener.open("newContractNo.jsp?userName="+"<%=userName%>"+"&gCustId="+"<%=gCustId%>","",prop);
	self.close();	
</script>	
<%
}
strArray = CreatePlanerArray.createArray("arrMsg",retVal.getSize(2));
%>
<html>
<SCRIPT type=text/javascript>
	
<%=strArray%>
<%
if(retCode.equals("0")){	
	for(int i=0;i<retVal.getUtype("2").getSize();i++)
	 {
	 	for(int j=0;j<retVal.getUtype("2."+i).getSize();j++)
	 	{
	 	
%>
			arrMsg[<%=i%>][<%=j%>] = "<%=retVal.getUtype("2."+i).getValue(j)%>";	
<%
		}
	}
}	
%>	
function saveTo()
{		
		var loc = $(":checked").val();
		if(typeof(loc)!="undefined"){
			window.opener.$("input[name='contractNo']").val(arrMsg[loc][0]);
			window.opener.$("input[name='contractName']").val(arrMsg[loc][1]);
			window.opener.$("input[name='contractType']").val(arrMsg[loc][3]);
			window.close();
			//retValue = arrMsg[loc][0]+","+arrMsg[loc][1]+","+arrMsg[loc][3];
		}
		else{
			rdShowMessageDialog("请选择客户信息！",0);
		}
}

function newContractNo(){
	var h=250;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="height:"+h+",width:"+w+",left:"+l+"px, top:"+t+"px,toolbar:no, menubar:no, scrollbars:yes, resizable:no,location:no,status:no,help:no";
	window.opener.open("newContractNo.jsp?userName="+"<%=userName%>"+"&gCustId="+"<%=gCustId%>","",prop);
	self.close();	
}
</SCRIPT>	
<body>
	<FORM method=post name="getcontractNo" action="">
<%@ include file="/npage/include/header.jsp" %>
<div id="operation">
<div id="operation_table">	
<div class="title"><div id="title_zi">账户信息</div></div>
<div class="list" >
	<div id="listInfo"> 	
	<div  style="overflow-y:scroll;height:300px;width:98%;">	   	
	  <table cellSpacing=0>
		<tr>
			<th>请选择</th>
			<th>ID</th>
			<th>名称</th>
			<th>类型名称</th>
		</tr>
		<%
	
	if(retCode.equals("0"))
	{
		int xsize = retVal.getSize("2");
		for(int i=0; i<xsize ;i++)		
    {
%>
		<tr>
			<td><input type="radio" name="radio_con" id="" value="<%=i%>"></td>
			<td><%=retVal.getValue("2."+i+".0")%></td>
			<td><%=retVal.getValue("2."+i+".1")%></td>
			<td><%=retVal.getValue("2."+i+".3")%></td>
		</tr>
	<%
		}
	}
%>	
<tr>
	<td id="footer" colspan=4> 
		<div id="operation_button">
		<input class="b_foot" name=query  type=button onClick="saveTo()" value="确认">
  	&nbsp; 
  	<input class="b_foot" name=back onClick="window.close()" type=button value="返回">
  	&nbsp; 
  	<input class="b_foot" name=back onClick="newContractNo()" type=button value="新建账号">
	</div>
	</td>
</tr>
</table>
</div>
</div>
</div>
</div>
	
<%@ include file="/npage/include/footer.jsp" %>
</div>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>