 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-12 ҳ�����,�޸���ʽ
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*"%>
<%
	String opCode = "3052";		
	String opName = "ҵ��������Ա�ʷѹ�ϵά��";	//header.jsp��Ҫ�Ĳ��� 	
  	
  /* ����������� */ 
%>

<html>
<head>
<base target="_self">
<title>ҵ��������Ա�ʷѹ�ϵά��</title>
<script language="JavaScript"> 
	function doSubmit()
	{	
		if(!check(document.form1))
		{
			return false;
		} 
		if(!checkElement(document.form1.bizCode)) return false;		
		if(!checkElement(document.form1.prodCode)) return false;		
		document.form1.action="f3052Cfm.jsp";
		document.form1.submit();
	}

	function querySpCode()
	{
		if(document.all.spCode.value == "")
	 	{
	 		rdShowMessageDialog("������SI/EC��ţ�");
	 		document.all.spCode.focus();
	 		return;
	 	}
	 	var spCode = document.all.spCode.value;
		window.open("s2894_qrySpCode.jsp?spCode="+spCode+"","","height=600,width=400,scrollbars=yes");
	}

	function queryBizCode()
	{
		if(document.all.spCode.value == "")
	 	{
	 		rdShowMessageDialog("������SI/EC��ţ�");
	 		document.all.spCode.focus();
	 		return;
	 	}
	 	var spCode = document.all.spCode.value;
	 	var bizCode = document.all.bizCode.value;
		window.open("s2894_qryBizCode.jsp?spCode="+spCode+"&bizCode="+bizCode+"","","height=600,width=400,scrollbars=yes");
	}

	function queryProdCode()
	{
	 	var mode_type="ADCA";
	 	var prodCode = document.all.prodCode.value;
		window.open("f3052_qryModeCode.jsp?prodCode="+prodCode+"&mode_type="+mode_type+"","","height=600,width=400,scrollbars=yes");
	}


</script>
</head>
<body>
<form name="form1"  method="post">
	<%@ include file="/npage/include/header_pop.jsp" %>     	
	<div class="title">
		<div id="title_zi">��ѯ����</div>
	</div>	
          <TABLE width="100%"  id="mainOne"  cellspacing="0" border="0">
            	<TBODY>
	          <tr>	
			<TD width="20%" class="blue" nowrap>&nbsp;&nbsp;SI/EC��ҵ����</TD>
			<TD>
				<input type=text  name=spCode  v_must=1 v_type="string"  size=20 /> 
			  	<font class="orange">*</font>
			  	<input  type="button" name="qrySpCode" onclick="querySpCode()" class="b_text" value="��ѯ">
			 </td>
			 <td class="blue" nowrap>&nbsp;&nbsp;��ҵ���� </td>
			 <td>	 
				 <input type=text name=spName readonly size=40 class="InputGrey"/>
                  	</TD>
              </tr>
              <tr>	
                <TD width="20%" class="blue" nowrap>&nbsp;&nbsp;ҵ�����</TD>
                <TD>
                  	<input type="hidden"  name="hidProdCode"/>
                  	<input type=text  name=bizCode  v_type="string" v_must=1 size=20 readonly class="InputGrey"/> 
                  	<font class="orange">*</font>
                  	<input  type="button" name="qryBizCode" onclick="queryBizCode()" class="b_text" value="��ѯ">
                 </td>
                 <td class="blue" nowrap>&nbsp;&nbsp;ҵ������</td>
                 <td>
                  	<input type=text name=bizName readonly size=40 class="InputGrey"/>
                </TD>
              </tr>        
              <tr>	
                <TD width="20%" class="blue" nowrap>&nbsp;&nbsp;�ʷѴ���</TD>
                <TD>
                  	<input type=text   v_must=1 v_type="string" name=prodCode  size=20 readonly class="InputGrey"/> 
		  	<font class="orange">*</font>
		     	<input  type="button" name="qryProdCode" onclick="queryProdCode()" class="b_text"  value="��ѯ">
		 </td>
                 <td class="blue" nowrap>&nbsp;&nbsp;�ʷ�����</td>
                 <td>                     	
                  	<input type=text name=prodName readonly size=40 class="InputGrey"/>
                </TD>
              </tr>
              <tr>	
                <TD width="20%" class="blue" nowrap>&nbsp;&nbsp;�ʷ�����</TD>
                <TD colspan="3"> 
                  	<input type=text name=prodNote readonly size=60 class="InputGrey"/>
                </TD>
              </tr>						  
	        </TBODY>
	  </TABLE>
	      
	  <TABLE cellSpacing=0 >
            <TR>
              <TD id="footer">
                	<input name="nextButton" type="button" class="b_foot" value="ȷ  ��" onClick="doSubmit()" >
              	 	&nbsp;
                	<input name="" type="button" style="cursor:hand"  class="b_foot" value="��  ��" onclick="javascript:location.reload();">
              	 	&nbsp;
                	<input name="reset" type="button"  class="b_foot" value="��  ��" onClick="javaScript:window.close();" >
              	 	&nbsp;
               </TD>
            </TR>
          </TABLE>
    	 <%@ include file="/npage/include/footer_pop.jsp" %>  
</form>
</body>
</html>

