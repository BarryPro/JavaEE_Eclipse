   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-8-31
********************/
%>
              
<%
  String opCode = "4518";
  String opName = request.getParameter("opName");
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.text.*"%>

<%
	
%>

<html>
<head>
<base target="_self">
<title>智能网VPMN资费操作详细信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript"> 
	function selectAll(){
		var divBodyOne= document.getElementById("divBodyOne");
		divBodyOne.style.display="";
		var work_no = document.form1.work_no.value;
		var start_time = document.form1.start_time.value;
		var end_time = document.form1.end_time.value;
		var pkg_code = document.form1.pkg_code.value;
		
		
		if(start_time!=''){
				if(isNaN(start_time)){
					rdShowMessageDialog("操作开始日期不是数字,请您重新输入");
					return false;
				}else{
					if(start_time.length!=8){
						rdShowMessageDialog("操作开始日期的格式为:YYYYMMDD,请您重新输入!");
					  return false;
					}
				}
		}
		
			if(end_time!=''){
				if(isNaN(end_time)){
					rdShowMessageDialog("操作结束日期不是数字,请您重新输入");
					return false;
				}else{
					if(end_time.length!=8){
						rdShowMessageDialog("操作结束日期的格式为:YYYYMMDD,请您重新输入!");
					  return false;
					}
				}
		}
		
		
		document.middle.location="f4518_main.jsp?work_no="+work_no+"&start_time="+start_time+"&end_time="+end_time+"&pkg_code="+pkg_code;
	}
	
	
		function selectOne(){
		var divBodyOne= document.getElementById("divBodyOne");
		divBodyOne.style.display="";
		var work_no = document.form1.work_no_one.value;
		var start_time = document.form1.start_time_one.value;
		var end_time = document.form1.end_time_one.value;
		var pkg_code = document.form1.pkg_code_one.value;
		
		if(start_time!=''){
				if(isNaN(start_time)){
					rdShowMessageDialog("操作开始日期不是数字,请您重新输入");
					return false;
				}else{
					if(start_time.length!=8){
						rdShowMessageDialog("操作开始日期的格式为:YYYYMMDD,请您重新输入!");
					  return false;
					}
				}
		}
		
			if(end_time!=''){
				if(isNaN(end_time)){
					rdShowMessageDialog("操作结束日期不是数字,请您重新输入");
					return false;
				}else{
					if(end_time.length!=8){
						rdShowMessageDialog("操作结束日期的格式为:YYYYMMDD,请您重新输入!");
					  return false;
					}
				}
		}
		
		
		document.middle.location="f4518_pkg.jsp?work_no="+work_no+"&start_time="+start_time+"&end_time="+end_time+"&pkg_code="+pkg_code;
	}
	
	function setOPTime(p){
		
		document.form1.work_no_one.value = '';
		document.form1.start_time_one.value = '';
		document.form1.end_time_one.value ='';
		document.form1.work_no.value = '';
		document.form1.start_time.value = '';
		document.form1.end_time.value ='';
		
		var str = p.value;
		var divOne = document.getElementById("divOne");
		var divTwo = document.getElementById("divTwo");
		var divBodyOne= document.getElementById("divBodyOne");
		
		if(str=='1'){
			divOne.style.display="";
			divTwo.style.display="none";
			divBodyOne.style.display="none";
		}else{
			divTwo.style.display="";
			divOne.style.display="none";
			divBodyOne.style.display="none";
		}
	}
</script>
</head>

<body>

  <form name="form1"  method="post">
     
	  	<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">智能网VPMN资费操作查询</div>
	</div>


		<table cellspacing="1" >
			

			<div id="divTwo" >
								<table cellspacing="0" >
					<tr  height="22">
	  					<TD width="15%" class="blue">&nbsp;&nbsp;	&nbsp;操作工号</TD>
	  					<TD width="30%">
	  						<input type="text" name="work_no" />
	  					
	  					</TD>
					    <TD width="15%" class="blue">
					    	&nbsp;&nbsp;&nbsp;&nbsp;资费编码</TD>
				        <TD width="40%">
				       <input type="text" name="pkg_code"/>&nbsp;
				        </TD>
				    </tr>
				    
				    
				    	<tr  height="22">
				    		<TD width="15%" class="blue">
					    	&nbsp;&nbsp;&nbsp;&nbsp;操作开始日期</TD>
				        <TD width="30%">
				       <input type="text" name="start_time"/>&nbsp; <font class="orange">(格式为YYYYMMDD)<font>
				        </TD>
				        
	  					<TD width="15%" class="blue">&nbsp;&nbsp;	&nbsp;操作结束日期</TD>
	  					<TD width="40%">
	  						<input type="text" name="end_time"/>&nbsp; <font class="orange">(格式为YYYYMMDD)<font>
				      
				      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					    		<input  class="b_text" style="cursor:hand"type="button" value="查询"  onclick="selectAll()"/>				  			 
	  					</TD>					   				  			 					    	
				    </tr>					
				</table>
			</div>
				
				
	  			
	  				
	  			
	  			
	 <div style="height:380px;overflow: auto" id="divBodyOne">
 	<IFRAME frameBorder=0 id=middle name=middle scrolling="yes"  
	 style="HEIGHT: 100%; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX:1">
	</IFRAME>
</div>

	 <%@ include file="/npage/include/footer.jsp" %>
	  </form>
 
</body>
</html>
</html>

