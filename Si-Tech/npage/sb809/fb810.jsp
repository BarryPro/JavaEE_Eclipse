   
<%
/********************
 version v2.0
 开发商 si-tech
 update 
********************/
%>
              
<%
  String opCode = "b810";
  String opName = request.getParameter("opName");
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.text.*"%>


<html>
<head>
<base target="_self">
<title>智能网VPMN主套餐操作详细信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript"> 
	function selectAll(){
		var divBodyOne= document.getElementById("divBodyOne");
		var chk=0;
		var chkObjs=document.getElementsByName("op_type");
		for(var i=0;i<chkObjs.length;i++){
			if(chkObjs[i].checked){
				chk=chkObjs[i].value;
			}
		}
		//alert("1="+chk);
		divBodyOne.style.display="";
		var work_no = document.form1.work_no.value;
		var start_time = document.form1.start_time.value;
		var end_time = document.form1.end_time.value;
		var feeIndex_code = document.form1.feeIndex_code.value;		
		
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
			
		document.middle.location="fb810_main.jsp?work_no="+work_no+"&start_time="+start_time+"&end_time="+end_time+"&feeIndex_code="+feeIndex_code+"&chk="+chk;
	}
		

	
	function setOPTime(p){		

		document.form1.work_no.value = '';
		document.form1.start_time.value = '';
		document.form1.end_time.value ='';
		
		var str = p.value;
	
		var divTwo = document.getElementById("divTwo");
		var divBodyOne= document.getElementById("divBodyOne");
	
			divTwo.style.display="";
			divBodyOne.style.display="none";
		
	}
</script>
</head>

<body>

  <form name="form1"  method="post">     
	  	<%@ include file="/npage/include/header.jsp" %>                         
	<div class="title">
		<div id="title_zi">智能网VPMN主套餐操作查询</div>
	</div>

		<table cellspacing="1" >
			<tr height="30">
				<td class="blue" width="20%" >
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<B>请您选择查询类型:</B>
				</td>
				<td class="blue">
				<input type="radio" name="op_type"  onclick="setOPTime(this)" width=""  value="1"/><B>查询网内主套餐详细配置操作历史</B>
				</td>
				<td class="blue">
						<input type="radio" name="op_type" onclick="setOPTime(this)"  width=""  value="2"/><B>查询网外号码组主套餐详细配置操作历史</B>
				</td class="blue">
				<td class="blue">
						<input type="radio" name="op_type" onclick="setOPTime(this)"  width=""  value="3"/><B>查询综合V网详细配置操作历史</B>
				</td class="blue">
				
			</tr>
		</table>
		
		
			
						
			<div id="divTwo" style="display:none">
								<table cellspacing="0" >
					<tr  height="22">
	  					<TD width="15%" class="blue">&nbsp;&nbsp;	&nbsp;操作工号</TD>
	  					<TD width="30%">
	  						<input type="text" name="work_no" />
	  					
	  					</TD>
					    <TD width="15%" class="blue">
					    	&nbsp;&nbsp;&nbsp;&nbsp;资费编码</TD>
				        <TD width="40%">
				       <input type="text" name="feeIndex_code"/>&nbsp;
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


