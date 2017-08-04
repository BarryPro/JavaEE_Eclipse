<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 问题反馈
　 * 版本: v1.0
　 * 日期: 2008年10月25日
　 * 作者: piaoyi
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%
	String opCode = WtcUtil.repNull(request.getParameter("pageOpCode"));	
	String opName = WtcUtil.repNull(request.getParameter("pageOpName"));	
	String memberNo = request.getParameter("memberNo")==null?"":request.getParameter("memberNo");
	String productId = request.getParameter("productId")==null?"":request.getParameter("productId");
	System.out.println("memberNo="+memberNo);
	System.out.println("productId="+productId);
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	String sqlStr = "select character_id,character_name,character_value from dproductSignOtherAdd where product_id = '?' and member_no = '?' ";

%>
<wtc:pubselect name="sPubSelect" outnum="3" routerKey="region" routerValue="<%=regionCode%>">
    <wtc:sql><%=sqlStr%></wtc:sql>
    <wtc:param value="<%=productId%>"/>
    <wtc:param value="<%=memberNo%>"/>
</wtc:pubselect>
<wtc:array id="rows"  scope="end" />
	
<html xmlns="http://www.w3.org/1999/xhtml">	
<head>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<title><%=opName%></title>
</head>

<body>
<%@ include file="/npage/include/header_pop.jsp" %>  
	<form name="form_sublist" method="POST">
		 <table cellspacing="0" border="0" cellpadding="0" >
			 <tr >
	        <td class="blue">订单编号</td>   
	        <td >
	        	<input type="text" name="productId" value="<%=productId%>" readonly >
	        </td>   
	        <td class="blue">成员号码</td>   
	        <td >
	          <input type="text" name="memberNo" value="<%=memberNo%>" readonly >
	        </td>   
	     </TR>
		 </table>
		
		 <div class="title" ><div id="title_zi">成员属性列表</div> </div>
     <table cellspacing="0" border="0" cellpadding="0" id="memberTab" >
		 	<tr>
		 		 <th>属性编码</th>
		 		 <th>属性名</th>
		 		 <th>属性值</th>
		 	</tr>	 
		 	<tr> 
		 	<% 
		 	  for(int i =0;i<rows.length;i++)
		 	  {
		 	%>
		  <td><input type="text" name="characterId" id="characterId" value="<%=rows[i][0]%>" readonly></td>
		  <td><input type="text" name="characterName" id="characterName" value="<%=rows[i][1]%>"  readonly></td>
		  <td><input type="text" name="characterValue" id="characterValue" value="<%=rows[i][2]%>" readonly></td>
		</tr>	   
		 <%}%> 
		</table>
		<table cellspacing="0" border="0" cellpadding="0" >
		 <tr>
		 	 <td colspan="5" align="center" id="footer" >
		 	 	 <input class="b_foot" type=button name=qryPage value="确认" onClick="window.close()">
		 	 	 <input class="b_foot" type=button name=back value="关闭" onClick="window.close()" >
		 	 </td>
		 </tr>	
	  </table>	
		
	</form>
<%@ include file="/npage/include/footer_pop.jsp" %> 
</body>
</html>
