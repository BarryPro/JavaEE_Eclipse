   
<%
/********************
 version v2.0
 ������ si-tech
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
<title>������VPMN���ײͲ�����ϸ��Ϣ</title>
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
					rdShowMessageDialog("������ʼ���ڲ�������,������������");
					return false;
				}else{
					if(start_time.length!=8){
						rdShowMessageDialog("������ʼ���ڵĸ�ʽΪ:YYYYMMDD,������������!");
					  return false;
					}
				}
		}
		
			if(end_time!=''){
				if(isNaN(end_time)){
					rdShowMessageDialog("�����������ڲ�������,������������");
					return false;
				}else{
					if(end_time.length!=8){
						rdShowMessageDialog("�����������ڵĸ�ʽΪ:YYYYMMDD,������������!");
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
		<div id="title_zi">������VPMN���ײͲ�����ѯ</div>
	</div>

		<table cellspacing="1" >
			<tr height="30">
				<td class="blue" width="20%" >
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<B>����ѡ���ѯ����:</B>
				</td>
				<td class="blue">
				<input type="radio" name="op_type"  onclick="setOPTime(this)" width=""  value="1"/><B>��ѯ�������ײ���ϸ���ò�����ʷ</B>
				</td>
				<td class="blue">
						<input type="radio" name="op_type" onclick="setOPTime(this)"  width=""  value="2"/><B>��ѯ������������ײ���ϸ���ò�����ʷ</B>
				</td class="blue">
				<td class="blue">
						<input type="radio" name="op_type" onclick="setOPTime(this)"  width=""  value="3"/><B>��ѯ�ۺ�V����ϸ���ò�����ʷ</B>
				</td class="blue">
				
			</tr>
		</table>
		
		
			
						
			<div id="divTwo" style="display:none">
								<table cellspacing="0" >
					<tr  height="22">
	  					<TD width="15%" class="blue">&nbsp;&nbsp;	&nbsp;��������</TD>
	  					<TD width="30%">
	  						<input type="text" name="work_no" />
	  					
	  					</TD>
					    <TD width="15%" class="blue">
					    	&nbsp;&nbsp;&nbsp;&nbsp;�ʷѱ���</TD>
				        <TD width="40%">
				       <input type="text" name="feeIndex_code"/>&nbsp;
				        </TD>
				    </tr>
				    
				    
				    	<tr  height="22">
				    		<TD width="15%" class="blue">
					    	&nbsp;&nbsp;&nbsp;&nbsp;������ʼ����</TD>
				        <TD width="30%">
				       <input type="text" name="start_time"/>&nbsp; <font class="orange">(��ʽΪYYYYMMDD)<font>
				        </TD>
				        
	  					<TD width="15%" class="blue">&nbsp;&nbsp;	&nbsp;������������</TD>
	  					<TD width="40%">
	  						<input type="text" name="end_time"/>&nbsp; <font class="orange">(��ʽΪYYYYMMDD)<font>
				      
				      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					    		<input  class="b_text" style="cursor:hand"type="button" value="��ѯ"  onclick="selectAll()"/>				  			 
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


