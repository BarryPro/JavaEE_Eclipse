<%
  /*
   * ����: ��ʾ���й켣
�� * �汾: 1.0
�� * ����: 2008/11/05
�� * ����: hanjc
�� * ��Ȩ: sitech
   *  
 ��*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>

<%
    String opCode="k170";
    String opName="�ۺϲ�ѯ-��ʾ���й켣";
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
    String contact_id   = request.getParameter("contact_id");
	
%>

<html>
<head>
<title>��ʾ���й켣</title>
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
	     <th > ��ˮ��</th>
	     <th > �켣·�� </th>
	   </tr>
	   <!-- THE SECOND LINE OF THE CONTENT -->
	   <tr >
	     <td > 2008102500000265 </td>
	     <td > �켣·�� </td>
	    </tr>
	    
	    	   <!-- THE THIRD LINE OF THE CONTENT -->
	   <tr >
	     <td > 2008102500000266 </td>
	     <td > �켣·�� </td>
	    </tr>
	    
	    	   <!-- THE FOURTH LINE OF THE CONTENT -->
	  	<tr >
	     <td > 2008102500000266 </td>
	     <td > �켣·�� </td>
	    </tr>
	    
	    	   <!-- THE FIFTH LINE OF THE CONTENT -->
	   	<tr >
	     <td > 2008102500000266 </td>
	     <td > �켣·�� </td>
	    </tr>
    	
    	<tr >
	     <td > 2008102500000266 </td>
	     <td > �켣·�� </td>
	    </tr>

    	<tr >
	     <td > 2008102500000266 </td>
	     <td > �켣·�� </td>
      </tr>
      
      <tr >
      <td colspan="6" align="right" id="footer" style="width:420px">
       <input name="ok" type="button"  value="ȷ��" onClick="winClose()"> 
       <input name="cancle" type="button" value="ȡ��" onClick="winClose()">
      </td>
    </tr>
		</table>
		
		<br>
</form>
<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>

