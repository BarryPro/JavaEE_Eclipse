 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-06 ҳ�����,�޸���ʽ
	********************/
%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
	<head>
		<title>"����ũ��ͨ"����Ӫ���</title>
<%
	String opCode = "7176";	
	String opName = "����ũ��ͨ����Ӫ���" ;	
	
    	String workNoFromSession=(String)session.getAttribute("workNo");
	String userPhoneNo=(String)session.getAttribute("userPhoneNo");
	boolean workNoFlag=false;
	if(workNoFromSession.substring(0,1).equals("k"))
	  workNoFlag=true;

%>

	<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
	<script language=javascript>
		  onload=function()
		  {
		    document.all.srv_no.focus();
		  }

		//----------------��֤���ύ����-----------------
		function doCfm(subButton)
		{
		 
		       controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
		        if(!check(frm)) return false; 			        	
			frm.action="f7164_1.jsp?opCode=7176&opName=<%=opName%>";
		  	document.all.opcode.value="7176";
		  	frm.submit();	
		  	return true;
		}	
	</script>
</head>
<body>	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
 <%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">"����ũ��ͨ"����Ӫ��� </div>
		</div>
		 <input type="hidden" name="opcode" >
		<table  cellspacing="0">		
		         <tr> 
		            <td nowrap class="blue"> 
		              	�ֻ�����
		            </td>
		            <td nowrap>              
		                <input   type="text" size="12" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1   maxlength="11" index="0" value =<%=activePhone%>  readonly class="InputGrey">
		                <font class="orange">*</font>
		            </td>          
		         </tr>		    
         	</table>
         <table cellspacing="0">       
	         <tr> 
	            <td id="footer"> 	              
	              	<input  type=button name="confirm" class="b_foot" value="ȷ��" onClick="doCfm(this)" index="2">    
	              	<input  type=button name=back class="b_foot" value="���" onClick="frm.reset()">
		      	<input  type=button name=qryP class="b_foot" value="�ر�" onClick="removeCurrentTab();">	            
	           </td>
	        </tr>
      </table>
    <%@ include file="/npage/include/footer_simple.jsp" %>   
   </form>
</body>
</html>