<%
   /*
   * ����: 	�������ҵ����ͣ�ָ�
�� * �汾: v1.0
�� * ����: 2007/2/7
�� * ����: wuln
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=gbk"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.s1900.config.productCfg" %>
<%@ page import="com.sitech.boss.pub.util.*"%>

<%	
	//��ȡ�û�session��Ϣ	
	String regCode = (String)session.getAttribute("regCode");
	String workNo = (String)session.getAttribute("workNo");
	String workPwd = (String)session.getAttribute("password");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode=org_code.substring(0,2);	

	String opCode ="2896";
  String opName ="�������ҵ����ͣ�ָ�";    

	String op_name="�������ҵ����ͣ�ָ�";
%>	
	

<html   xmlns="http://www.w3.org/1999/xhtml">
<head>
<base target="_self">
<title><%=op_name%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">

<script language=javascript>

	//��ѯ���������Ϣ
	function querydParterMsg()
	{
		var queryType = document.form1.queryType.value;
		var queryInfo = document.form1.queryInfo.value;
		if (queryInfo == "")
		{
			rdShowMessageDialog("�����롰��ѯ���ݡ���");
			return false;
		}
			if(((queryType == "2")||(queryType == "3"))&&(isNaN(queryInfo)==true))
		{	
			
				rdShowMessageDialog("���ű�����������ŵġ���ѯ���ݡ�ֻ�������֣�");
				return false;			
		}
		window.open("f2896_querydParterMsg.jsp?queryType="+queryType+"&queryInfo="+queryInfo,"","height=400,width=800,scrollbars=yes");
	}
	
	
	//��ѯEC/SI�����������Ϣ
	function queryBasecodeInfo()

	{

		if (document.form1.parterId.value == "")

		{

			rdShowMessageDialog("����ѡ����������Ϣ!");

			return false; 

		}

		window.open("f2896_querydBaseCode.jsp?queryType="+document.form1.checkdocId.value+"&queryInfo="+document.form1.parterId.value,"","height=500,width=400,scrollbars=yes");

	}
	


	
	//��ʾҵ����Ϣҳ��
	function queryBusiInfo()
	{		
		if (document.form1.parterId.value == "")
		{
			rdShowMessageDialog("����ѡ����������Ϣ!");
			return false; 
		}
		var str = "?parterId=" + document.form1.parterId.value+"&oTypeCode="+document.form1.oTypeCode.value+"&parterName=" + document.all.parterName.value ;
		document.middle.location="f2896_qrydParterOperation.jsp"+str;
		tabBusi.style.display="";
	}	
	
</script>
</head>

<body>
	<form action="" name="form1"  method="post">
<%@ include file="/npage/include/header.jsp" %> 

		<div class="title">
		<div id="title_zi"><%=opName%></div>
	 </div>			
	 	
		<input type="hidden" name="parterId" value="">
		<input type="hidden" name="oTypeCode" value="">
		<input type="hidden" name="parterName" value="">
		<input type="hidden" name="spTel" value="">	
			
		<TABLE   id="mainOne"  cellspacing="0" >
 			 <TR  id="line_1"> 
		  			<td class="blue">��ѯ����</td>
	     		<td > 
		             <select name="queryType">
	              		<option value="0">����������</option> 
	              		<option value="1">�����������</option> 	
	              		<option value="2">���������</option>
	              		<option value="3">���ű���</option> 
	              		<option value="4">��������</option> 				
		             </select>
	        	</td>
	        	<td class="blue">��ѯ���ݣ�</td>
	     			<td > 
		             <input type="text" id="queryInfo" name="queryInfo" v_type="0_9" onKeyDown="if (event.keyCode == 13) return false;">&nbsp;<font color="#FF0000">*</font>		             
	        	</td>
	        	<td >		             
	        	  	 <input name="qrydParterMsg" type="button" class="b_text"  onClick="querydParterMsg()" style="cursor:hand" value="��ѯ">&nbsp;&nbsp
	        	</td>	        	
	      	 </TR>	      	
	      	 <TR  id="line_1"> 
	  			<td colspan="5">&nbsp;</td>	     		
      		 </TR>	      		
	     </TABLE>
	      
	      <TABLE id="tabEC" style="display:none" width="98%" align="center" id="mainOne" bgcolor="#FFFFFF" cellspacing="0" border="0" >	
	      	<TR> 
		  		<td colspan="5" class="blue" ><strong>EC/SI��Ϣ��</strong></td>	     		
	      	 </TR>	
	      	<TR >				
				<td align='center' class="blue" ><div >EC/SI����</div></td>

				<td align='center' class="blue" ><div >EC/SI����</div></td>

				<td align='center' class="blue" ><div >��ϵ�绰</div></td>
				
				<td align='center' class="blue" ><div >���������</div></td>

				<td align='center' class="blue" ><div >������ʽ</div></td>
			</TR>			    
	    </TABLE>
	    
	  <TABLE id="tabBusi" style="display:none" height="0px" id="mainOne" cellspacing="0">	
		<TR> 
			<td nowrap>
				<IFRAME frameBorder=0 id=middle name=middle scrolling="yes"  
				style="HEIGHT: 600px; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 1">
				</IFRAME>
			</td> 
		</TR>
	</TABLE>	    

 <%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>

