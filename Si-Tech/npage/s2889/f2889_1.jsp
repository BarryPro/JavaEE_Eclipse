<%
   /*
   * ����: ���ſͻ���Ŀ����
�� * �汾: v1.0
�� * ����: 2007/2/7
�� * ����: wuln
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.02.10
 ģ�飺�������ҵ�����롢���
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=gbk"%>

<%	

	//��ȡ�û�session��Ϣ	
	String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
    
	String op_name="�������ҵ������";
%>	

<html  xmlns="http://www.w3.org/1999/xhtml">
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
		window.open("f2889_querydParterMsg.jsp?queryType="+queryType+"&queryInfo="+queryInfo,"","height=400,width=800,scrollbars=yes");
	}
	
	//��ʾҵ����Ϣҳ��
	function queryBusiInfo()
	{		
		if (document.form1.parterId.value == "")
		{
			rdShowMessageDialog("����ѡ����������Ϣ!");
			return false; 
		}
		var str = "?parterId=" + document.form1.parterId.value+"&oTypeCode=" + document.all.oTypeCode.value+"&parterName=" + document.all.parterName.value ;
		document.middle.location="f2889_qrydParterOperation.jsp"+str;
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

	<TABLE  id="mainOne" cellspacing="0">
		 <TR id="line_1"> 
	  		<td class="blue">��ѯ����</td>
     		<td> 
	             <select name="queryType">
              		<option value="0">����������</option> 
              		<option value="1">�����������</option> 	
              		<option value="2">���������</option>
              		<option value="3">���ű���</option> 
              		<option value="4">��������</option>  			
	             </select>
	             <input type="text" name="queryInfo"  v_type="0_9" onKeyDown="if (event.keyCode == 13) return false;">&nbsp;<font color="orange">*</font>
        	     <input name="qrydParterMsg" type="button" class="b_text" onClick="querydParterMsg()" style="cursor:hand" value="�� ѯ">&nbsp;&nbsp
        	     <input name="closeButton" type="button" class="b_text" onClick="removeCurrentTab()" style="cursor:hand" value="�� ��">&nbsp;&nbsp
        	</td>        	
      	 </TR>	      	
     </TABLE>
    
	
      <TABLE id="tabEC" style="display:none" id="mainOne"  cellspacing="0">	
      	<TR><td colspan="5" class="blue" ><strong>EC/SI��Ϣ��</strong></td>	  
      	</TR>	
      	<TR>				
			<th align="center"><div>EC/SI����</div></th>
			<th align="center"><div>EC/SI����</div></th>
			<th align="center"><div>��ϵ�绰</div></th>
			<th align="center"><div>���������</div></th>
			<th align="center"><div>������ʽ</div></th>
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



