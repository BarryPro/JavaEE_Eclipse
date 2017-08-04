<%
   /*
   * 功能: 集团客户项目申请
　 * 版本: v1.0
　 * 日期: 2007/2/7
　 * 作者: wuln
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.10
 模块：合作伙伴业务申请、变更
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=gbk"%>

<%	

	//读取用户session信息	
	String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
    
	String op_name="合作伙伴业务申请";
%>	

<html  xmlns="http://www.w3.org/1999/xhtml">
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
		window.open("f2889_querydParterMsg.jsp?queryType="+queryType+"&queryInfo="+queryInfo,"","height=400,width=800,scrollbars=yes");
	}
	
	//显示业务信息页面
	function queryBusiInfo()
	{		
		if (document.form1.parterId.value == "")
		{
			rdShowMessageDialog("请先选择合作伙伴信息!");
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
	  		<td class="blue">查询类型</td>
     		<td> 
	             <select name="queryType">
              		<option value="0">合作伙伴编码</option> 
              		<option value="1">合作伙伴名称</option> 	
              		<option value="2">基本接入号</option>
              		<option value="3">集团编码</option> 
              		<option value="4">集团名称</option>  			
	             </select>
	             <input type="text" name="queryInfo"  v_type="0_9" onKeyDown="if (event.keyCode == 13) return false;">&nbsp;<font color="orange">*</font>
        	     <input name="qrydParterMsg" type="button" class="b_text" onClick="querydParterMsg()" style="cursor:hand" value="查 询">&nbsp;&nbsp
        	     <input name="closeButton" type="button" class="b_text" onClick="removeCurrentTab()" style="cursor:hand" value="关 闭">&nbsp;&nbsp
        	</td>        	
      	 </TR>	      	
     </TABLE>
    
	
      <TABLE id="tabEC" style="display:none" id="mainOne"  cellspacing="0">	
      	<TR><td colspan="5" class="blue" ><strong>EC/SI信息：</strong></td>	  
      	</TR>	
      	<TR>				
			<th align="center"><div>EC/SI代码</div></th>
			<th align="center"><div>EC/SI名称</div></th>
			<th align="center"><div>联系电话</div></th>
			<th align="center"><div>基本接入号</div></th>
			<th align="center"><div>操作方式</div></th>
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



