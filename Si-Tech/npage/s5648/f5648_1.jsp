<%
   /*
   * 功能: SI订购关系查询
　 * 版本: v1.0
　 * 日期: 2007/2/9
　 * 作者: wuln
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
   * 2009-09-23    qidp        新版集团产品改造
 　*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>

<%	
	//读取用户session信息	
	String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));                 //工号
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));              //工号姓名
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String ip_Addr  = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));                     //登陆密码	
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));

	String op_name="SI订购关系查询";
	
	String opCode = "5648";
	String opName = "SI定购关系查询";
%>	
	

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base target="_self">
<title><%=op_name%></title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
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
		window.open("f5648_querydParterMsg.jsp?queryType="+queryType+"&queryInfo="+queryInfo,"","height=500,width=400,scrollbars=yes");
	}
		
	//显示业务信息页面
	function queryBusiInfo()
	{		
		if (document.form1.parterId.value == "")
		{
			rdShowMessageDialog("请先选择合作伙伴信息!");
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
	<div id="title_zi">SI定购关系查询</div>
</div>
		<TABLE id="mainOne" cellspacing="0">
 			 <TR id="line_1"> 
		  		<td nowrap class='blue'>查询类型</td>
	     		<td nowrap> 
		             <select name="queryType">
	              		<option value="0">合作伙伴编码</option> 
	              		<option value="1">合作伙伴名称</option> 	
	              		<option value="2">基本接入号</option> 		
		             </select>
	        	</td>
	        	<td nowrap class='blue'>查询内容</td>
	     			<td nowrap> 
		             <input type="text" name="queryInfo" onKeyDown="if (event.keyCode == 13) return false;">&nbsp;<font class='orange'>*</font>
	        	</td>
	        	<td nowrap>		             
	        	  	 <input name="qrydParterMsg" type="button" class="b_text" onClick="querydParterMsg()" style="cursor:hand" value="查询合作伙伴信息">&nbsp;&nbsp
	        	</td>	        	
	      	 </TR>
	     </TABLE>
	      
</div>
<div id="Operation_Table">
<div id="tabNext" style="display:none">
<div class="title">
    <div id="title_zi">合作伙伴信息</div>
</div>

	      <TABLE cellspacing="0" id="tabEC" style="display:none" >	
	      	
	      	<TR cellspacing="0">				
				<TH class="blue" align="center"><div>合作伙伴代码</div></th>
				<TH class="blue" align="center"><div>基本接入号</div></th>
				<TH class="blue" align="center"><div>合作伙伴名称</div></th>
				<TH class="blue" align="center"><div>客服电话</div></th>
				<TH class="blue" align="center"><div style=''>操作方式</div></th>
						
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

