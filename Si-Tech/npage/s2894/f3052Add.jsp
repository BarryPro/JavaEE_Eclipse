 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-12 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*"%>
<%
	String opCode = "3052";		
	String opName = "业务代码与成员资费关系维护";	//header.jsp需要的参数 	
  	
  /* 接收输入参数 */ 
%>

<html>
<head>
<base target="_self">
<title>业务代码与成员资费关系维护</title>
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
	 		rdShowMessageDialog("请输入SI/EC编号！");
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
	 		rdShowMessageDialog("请输入SI/EC编号！");
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
		<div id="title_zi">查询条件</div>
	</div>	
          <TABLE width="100%"  id="mainOne"  cellspacing="0" border="0">
            	<TBODY>
	          <tr>	
			<TD width="20%" class="blue" nowrap>&nbsp;&nbsp;SI/EC企业代码</TD>
			<TD>
				<input type=text  name=spCode  v_must=1 v_type="string"  size=20 /> 
			  	<font class="orange">*</font>
			  	<input  type="button" name="qrySpCode" onclick="querySpCode()" class="b_text" value="查询">
			 </td>
			 <td class="blue" nowrap>&nbsp;&nbsp;企业名称 </td>
			 <td>	 
				 <input type=text name=spName readonly size=40 class="InputGrey"/>
                  	</TD>
              </tr>
              <tr>	
                <TD width="20%" class="blue" nowrap>&nbsp;&nbsp;业务代码</TD>
                <TD>
                  	<input type="hidden"  name="hidProdCode"/>
                  	<input type=text  name=bizCode  v_type="string" v_must=1 size=20 readonly class="InputGrey"/> 
                  	<font class="orange">*</font>
                  	<input  type="button" name="qryBizCode" onclick="queryBizCode()" class="b_text" value="查询">
                 </td>
                 <td class="blue" nowrap>&nbsp;&nbsp;业务名称</td>
                 <td>
                  	<input type=text name=bizName readonly size=40 class="InputGrey"/>
                </TD>
              </tr>        
              <tr>	
                <TD width="20%" class="blue" nowrap>&nbsp;&nbsp;资费代码</TD>
                <TD>
                  	<input type=text   v_must=1 v_type="string" name=prodCode  size=20 readonly class="InputGrey"/> 
		  	<font class="orange">*</font>
		     	<input  type="button" name="qryProdCode" onclick="queryProdCode()" class="b_text"  value="查询">
		 </td>
                 <td class="blue" nowrap>&nbsp;&nbsp;资费名称</td>
                 <td>                     	
                  	<input type=text name=prodName readonly size=40 class="InputGrey"/>
                </TD>
              </tr>
              <tr>	
                <TD width="20%" class="blue" nowrap>&nbsp;&nbsp;资费描述</TD>
                <TD colspan="3"> 
                  	<input type=text name=prodNote readonly size=60 class="InputGrey"/>
                </TD>
              </tr>						  
	        </TBODY>
	  </TABLE>
	      
	  <TABLE cellSpacing=0 >
            <TR>
              <TD id="footer">
                	<input name="nextButton" type="button" class="b_foot" value="确  定" onClick="doSubmit()" >
              	 	&nbsp;
                	<input name="" type="button" style="cursor:hand"  class="b_foot" value="重  置" onclick="javascript:location.reload();">
              	 	&nbsp;
                	<input name="reset" type="button"  class="b_foot" value="关  闭" onClick="javaScript:window.close();" >
              	 	&nbsp;
               </TD>
            </TR>
          </TABLE>
    	 <%@ include file="/npage/include/footer_pop.jsp" %>  
</form>
</body>
</html>

