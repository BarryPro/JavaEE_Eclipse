<%
   /*
   * 功能: 	合作伙伴业务暂停恢复
　 * 版本: v1.0
　 * 日期: 2007/2/7
　 * 作者: wuln
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
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
	//读取用户session信息	
	String regCode = (String)session.getAttribute("regCode");
	String workNo = (String)session.getAttribute("workNo");
	String workPwd = (String)session.getAttribute("password");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode=org_code.substring(0,2);	

	String opCode ="2896";
  String opName ="合作伙伴业务暂停恢复";    

	String op_name="合作伙伴业务暂停恢复";
%>	
	

<html   xmlns="http://www.w3.org/1999/xhtml">
<head>
<base target="_self">
<title><%=op_name%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">

<script language=javascript>

	//查询合作伙伴信息
	function querydParterMsg()
	{
		var queryType = document.form1.queryType.value;
		var queryInfo = document.form1.queryInfo.value;
		if (queryInfo == "")
		{
			rdShowMessageDialog("请输入“查询内容”！");
			return false;
		}
			if(((queryType == "2")||(queryType == "3"))&&(isNaN(queryInfo)==true))
		{	
			
				rdShowMessageDialog("集团编码或基本接入号的“查询内容”只能是数字！");
				return false;			
		}
		window.open("f2896_querydParterMsg.jsp?queryType="+queryType+"&queryInfo="+queryInfo,"","height=400,width=800,scrollbars=yes");
	}
	
	
	//查询EC/SI基本接入号信息
	function queryBasecodeInfo()

	{

		if (document.form1.parterId.value == "")

		{

			rdShowMessageDialog("请先选择合作伙伴信息!");

			return false; 

		}

		window.open("f2896_querydBaseCode.jsp?queryType="+document.form1.checkdocId.value+"&queryInfo="+document.form1.parterId.value,"","height=500,width=400,scrollbars=yes");

	}
	


	
	//显示业务信息页面
	function queryBusiInfo()
	{		
		if (document.form1.parterId.value == "")
		{
			rdShowMessageDialog("请先选择合作伙伴信息!");
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
		  			<td class="blue">查询类型</td>
	     		<td > 
		             <select name="queryType">
	              		<option value="0">合作伙伴编码</option> 
	              		<option value="1">合作伙伴名称</option> 	
	              		<option value="2">基本接入号</option>
	              		<option value="3">集团编码</option> 
	              		<option value="4">集团名称</option> 				
		             </select>
	        	</td>
	        	<td class="blue">查询内容：</td>
	     			<td > 
		             <input type="text" id="queryInfo" name="queryInfo" v_type="0_9" onKeyDown="if (event.keyCode == 13) return false;">&nbsp;<font color="#FF0000">*</font>		             
	        	</td>
	        	<td >		             
	        	  	 <input name="qrydParterMsg" type="button" class="b_text"  onClick="querydParterMsg()" style="cursor:hand" value="查询">&nbsp;&nbsp
	        	</td>	        	
	      	 </TR>	      	
	      	 <TR  id="line_1"> 
	  			<td colspan="5">&nbsp;</td>	     		
      		 </TR>	      		
	     </TABLE>
	      
	      <TABLE id="tabEC" style="display:none" width="98%" align="center" id="mainOne" bgcolor="#FFFFFF" cellspacing="0" border="0" >	
	      	<TR> 
		  		<td colspan="5" class="blue" ><strong>EC/SI信息：</strong></td>	     		
	      	 </TR>	
	      	<TR >				
				<td align='center' class="blue" ><div >EC/SI代码</div></td>

				<td align='center' class="blue" ><div >EC/SI名称</div></td>

				<td align='center' class="blue" ><div >联系电话</div></td>
				
				<td align='center' class="blue" ><div >基本接入号</div></td>

				<td align='center' class="blue" ><div >操作方式</div></td>
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

