<%
   /*
   * ����: SI������ϵ��ѯ
�� * �汾: v1.0
�� * ����: 2007/2/9
�� * ����: wuln
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
   * 2009-09-23    qidp        �°漯�Ų�Ʒ����
 ��*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>

<%	
	//��ȡ�û�session��Ϣ	
	String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));                 //����
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));              //��������
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String ip_Addr  = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));                     //��½����	
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));

	String op_name="SI������ϵ��ѯ";
	
	String opCode = "5648";
	String opName = "SI������ϵ��ѯ";
%>	
	

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base target="_self">
<title><%=op_name%></title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
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
		window.open("f5648_querydParterMsg.jsp?queryType="+queryType+"&queryInfo="+queryInfo,"","height=500,width=400,scrollbars=yes");
	}
		
	//��ʾҵ����Ϣҳ��
	function queryBusiInfo()
	{		
		if (document.form1.parterId.value == "")
		{
			rdShowMessageDialog("����ѡ����������Ϣ!");
			return false; 
		}
		var str = "?parterId=" + document.form1.parterId.value+"&checkdocId="+document.form1.checkdocId.value;
		document.middle.location="f5648_qrydParterOperation.jsp"+str;
		tabBusi.style.display="";
		
	}
	
</script>
</head>

<body>
	<form action="" name="form1"  method="post">
		<input type="hidden" name="parterId" value="">
		<input type="hidden" name="checkdocId" value="">
		<input type="hidden" name="parterName" value="">
		<input type="hidden" name="spTel" value="">		
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">SI������ϵ��ѯ</div>
</div>
		<TABLE id="mainOne" cellspacing="0">
 			 <TR id="line_1"> 
		  		<td nowrap class='blue'>��ѯ����</td>
	     		<td nowrap> 
		             <select name="queryType">
	              		<option value="0">����������</option> 
	              		<option value="1">�����������</option> 	
	              		<option value="2">���������</option> 		
		             </select>
	        	</td>
	        	<td nowrap class='blue'>��ѯ����</td>
	     			<td nowrap> 
		             <input type="text" name="queryInfo" onKeyDown="if (event.keyCode == 13) return false;">&nbsp;<font class='orange'>*</font>
	        	</td>
	        	<td nowrap>		             
	        	  	 <input name="qrydParterMsg" type="button" class="b_text" onClick="querydParterMsg()" style="cursor:hand" value="��ѯ���������Ϣ">&nbsp;&nbsp
	        	</td>	        	
	      	 </TR>
	     </TABLE>
	      
</div>
<div id="Operation_Table">
<div id="tabNext" style="display:none">
<div class="title">
    <div id="title_zi">���������Ϣ</div>
</div>

	      <TABLE cellspacing="0" id="tabEC" style="display:none" >	
	      	
	      	<TR cellspacing="0">				
				<TH class="blue" align="center"><div>����������</div></th>
				<TH class="blue" align="center"><div>���������</div></th>
				<TH class="blue" align="center"><div>�����������</div></th>
				<TH class="blue" align="center"><div>�ͷ��绰</div></th>
				<TH class="blue" align="center"><div style=''>������ʽ</div></th>
						
			</TR>			    
	    </TABLE>

	    <TABLE id="tabBlank" style="display:none" id="mainOne" cellspacing="0">	
	    	<TR>	      	 	 
	  			<TD colspan="5">&nbsp;	  				
	  			</TD>	     		
      		 </TR>	
	    </TABLE>

		<TABLE id="tabBusi" style="display:none" width="100%" height="290px" align="center" id="mainOne" cellspacing="0">	
			<TR> 
				<td nowrap>
					<IFRAME frameBorder=0 id=middle name=middle scrolling="auto" 
					style="HEIGHT: 290px; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 1">
					</IFRAME>
				</td> 
			</TR>
		</TABLE>
		
		<!--<IFRAME frameBorder=0 id=middle name=middle scrolling="auto"  
		style="HEIGHT: 590px; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 1">
		</IFRAME>-->
		
</div>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

