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
	
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "1526";
  String opName = "用户帐单明细信息";
	
	String idNo = request.getParameter("idNo");//查询条件
	String phoneNo = request.getParameter("phoneNo");//查询条件
	String contractNo = request.getParameter("contractNo");//查询条件	
	String billBegin = request.getParameter("billBegin");
	String billEnd = request.getParameter("billEnd");
	String statusName = request.getParameter("statusName");//查询条件
	String yearMonth = request.getParameter("yearMonth");//查询年月
	String payType="3";
	
	String dateStr1 = "";
	if(billBegin.length()>=18){
		dateStr1 = billBegin.substring(0,4)+billBegin.substring(5,7)
		+billBegin.substring(8,10)+billBegin.substring(11,13) + billBegin.substring(14,16)+billBegin.substring(17,19);
	}
	
	String dateStr2 = "";
	if(billEnd.length()>=18){
		 dateStr2 = billEnd.substring(0,4)+billEnd.substring(5,7)
		+billEnd.substring(8,10)+billEnd.substring(11,13) + billEnd.substring(14,16)+billEnd.substring(17,19);
	}
%>
	<wtc:service name="s1526FeeQry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="10" >
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=idNo%>"/>
	<wtc:param value="<%=contractNo%>"/>
	<wtc:param value="<%=dateStr1%>"/>
	<wtc:param value="<%=dateStr2%>"/>
	<wtc:param value="<%=statusName%>"/>
	<wtc:param value="<%=yearMonth%>"/>
	<wtc:param value="<%=payType%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	if(result==null||result.length==0){
%>
	<script language="javascript">
		rdShowMessageDialog("用户明细帐单信息不存在!");
		window.close();
	</script>
<%
		return;	
	}

	String return_code =result[0][0];
	String return_message =result[0][1];
	if (result.length<1) {
%>
		<script language="JavaScript">
			rdShowMessageDialog("没有查询到相关数据！");
			window.close();
		</script>
<%
	}else{
%>
</HEAD>

<body>

<FORM method=post name="frm1526">
<input type="hidden" name="opCode"  value="1526">
<input type="hidden" name="phoneNo"  value="<%=phoneNo%>">
<input type="hidden" name="billBegin"  value="<%=dateStr1%>">
<input type="hidden" name="billEnd"  value="<%=dateStr2%>">
<input type="hidden" name="ipPort"  value="<%=result[0][9]%>">
<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">用户信息</div>
		</div>
		
	<table id=contentList cellspacing="0">
    <TR>
	   	<td class="blue">服务号码 <%=phoneNo%></td>
			<td class="blue">用户ID <%=idNo%> </td>
			<td class="blue">帐户号 <%=contractNo%> </td>
			<td class="blue">开始时间 <%=billBegin%> </td>
			<td class="blue">结束时间 <%=billEnd%> </td>
	   </TR>
	</table> 

		</div>
		<div id="Operation_Table"> 
		<div class="title">
			<div id="title_zi">账单明细</div>
		</div>

    <table cellspacing="0">
      <tr align="center">
        <th>费用名称</th>
        <th>费用状态</th>
        <th>欠费金额</th>
        <th>应收金额</th>
        <th>优惠金额</th>
        <th>预存划拨</th>
        <th>新交款</th>  
      </tr>
	<%
		String tbClass="";
		for(int y=0;y<result.length;y++){
			if(y%2==0){
	  		tbClass="Grey";
	  	}else{
	  		tbClass="";	
	  	}
	%>
			<tr align="center">
	<%    
			for(int j=2;j<result[0].length-1;j++){
	%>
				<td class="<%=tbClass%>"><%=result[y][j]%>&nbsp;</td>
	<%
			}
	%>
			</tr>
	<%
	    }
	%>
			</table>

		<table cellspacing="0">
		  <tr> 
		    <td id="footer"> 
		      &nbsp; <input class="b_foot" name=back onClick="window.close()" type=button value=" 关 闭 ">
		      &nbsp; 
		    </td>
		  </tr>
		</table>
	<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
<%
}
%>
