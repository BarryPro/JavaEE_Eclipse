 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-01-20 ҳ�����,�޸���ʽ
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.nio.*%>
<%@ page import="java.nio.MappedByteBuffer%>
<%   
	 /*try{
		DataOutputStream out2 = 
		new DataOutputStream(
		new BufferedOutputStream(
		new FileOutputStream("data.txt")));		
		out2.writeChars("\naaa\n");		
		out2.close();
	}catch(EOFException e){
		System.out.println("End of stream");
	}*/

%>

		<%		      
			//String opCode = "9913";	
			//String opName = "�ֻ���������ȡ��";	//header.jsp��Ҫ�Ĳ���   
      String opCode = request.getParameter("opCode");
      String opName = request.getParameter("opName");
		%>
		<html>
	<head>
		<title><%=opName%></title>
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
		  	frm.action="f9913_2.jsp";
		  	frm.submit();			 
		}
	
	</script>
</head>
<body>	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>  
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>	
	<input type="hidden" name="opCode" value="<%=opCode%>" />
	<input type="hidden" name="opName" value="<%=opName%>" />
 	<input type="hidden" name="opcode" value="<%=opCode%>" />
      <table cellspacing="0">      
	         <tr> 
		            <td width="16%" nowrap class="blue"> 
		              		�ֻ�����
		            </td>		            
		            <td>
		                <input  type="text" size="12" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1   maxlength="11" index="0" value =<%=activePhone%>  readonly class="InputGrey">
		                <font class="orange">*</font>
		            </td>           
	         </tr>
      </table>
     	<table cellSpacing=0>
	         <tr> 
		            <td id="footer" > 	            
		              		<input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">    
		              		<input class="b_foot" type=button name=back value="���" onClick="frm.reset()">
				      	<input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">		             
		           </td>
	        </tr>
      </table>
      <%@ include file="/npage/include/footer_simple.jsp" %>		
   </form>
</body>
</html>
