<%
  /*
   * 功能: 显示呼叫轨迹
　 * 版本: 1.0
　 * 日期: 2008/11/05
　 * 作者: hanjc
　 * 版权: sitech
   *  
 　*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>

<%
    String opCode="k170";
    String opName="综合查询-显示呼叫轨迹";
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
    String contact_id   = request.getParameter("contact_id");
	
%>

<html>
<head>
<title>显示呼叫轨迹</title>
<script language=javascript>
	$(document).ready(
		function()
		{
	    $("td").not("[input]").addClass("blue");
			$("#footer input:button").addClass("b_foot");
			$("td:not(#footer) input:button").addClass("b_text");
			$("input:text[@v_type]").blur(checkElement2);	
		
			$("a").hover(function() {
				$(this).css("color", "orange");
			}, function() {
				$(this).css("color", "blue");
			});
		}
	);

	function checkElement2() { 
				checkElement(this); 
		}	
		
 function winClose(){
   window.close();	
 }

</script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
</head>

<body >
<form id=sitechform name=sitechform>
<%@ include file="/npage/include/header.jsp"%>
		<table cellspacing="0" border ="0"> 
		    <!-- THE FIRST LINE OF THE CONTENT -->
      <tr >
	     <th > 流水号</th>
	     <th > 轨迹路线 </th>
	   </tr>
	   <!-- THE SECOND LINE OF THE CONTENT -->
	   <tr >
	     <td > 2008102500000265 </td>
	     <td > 轨迹路线 </td>
	    </tr>
	    
	    	   <!-- THE THIRD LINE OF THE CONTENT -->
	   <tr >
	     <td > 2008102500000266 </td>
	     <td > 轨迹路线 </td>
	    </tr>
	    
	    	   <!-- THE FOURTH LINE OF THE CONTENT -->
	  	<tr >
	     <td > 2008102500000266 </td>
	     <td > 轨迹路线 </td>
	    </tr>
	    
	    	   <!-- THE FIFTH LINE OF THE CONTENT -->
	   	<tr >
	     <td > 2008102500000266 </td>
	     <td > 轨迹路线 </td>
	    </tr>
    	
    	<tr >
	     <td > 2008102500000266 </td>
	     <td > 轨迹路线 </td>
	    </tr>

    	<tr >
	     <td > 2008102500000266 </td>
	     <td > 轨迹路线 </td>
      </tr>
      
      <tr >
      <td colspan="6" align="right" id="footer" style="width:420px">
       <input name="ok" type="button"  value="确定" onClick="winClose()"> 
       <input name="cancle" type="button" value="取消" onClick="winClose()">
      </td>
    </tr>
		</table>
		
		<br>
</form>
<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>

