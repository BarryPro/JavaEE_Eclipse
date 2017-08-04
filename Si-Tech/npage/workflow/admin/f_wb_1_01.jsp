<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>

<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="/css/common.css">
<script type="text/javascript" src="/js/rpc/src/core_c.js"></script>
<script type="text/javascript" src="/js/common/common.js"></script>
<script type="text/javascript" src="/js/common/common1.js"></script>
<script type="text/javascript" src="/js/common/errmsg.js"></script>
<script type="text/javascript" src="/js/common/common_check.js"></script>
<script type="text/javascript" src="/js/common/common_util.js"></script>
<script language="JavaScript" src="/js/common/redialog/redialog.js"></script>
<script type="text/javascript" src="/js/common/common_single.js"></script>

<head>
<title><%=opName%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../../css/style.css" type="text/css">
</head>
<SCRIPT LANGUAGE="JavaScript">
<!--
function submitCfm()
{
    //document.form1.action="f_wb_1_02.jsp";
    //document.form1.submit();
	  var order_type = document.form1.order_type.options[document.form1.order_type.selectedIndex].value;
	  var order_priority = document.form1.order_priority.options[document.form1.order_priority.selectedIndex].value;
	 //alert (order_type+"======"+order_priority)
   window.open("f_wb_1_02.jsp?order_type="+order_type+"&order_priority="+order_priority);
}
//-->
</SCRIPT>
<body bgcolor="#FFFFFF" text="#000000" background="/images/jl_background_2.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
<form name="form1" method="post">
<%@ include file="../../public/head_view_wf.jsp" %>
<div id="Operation_Table">
	
	<table id=tbs9 width=100% height=25 border=0 align="center" >
	<tbody>
		<tr bgcolor="E8E8E8"> 
			<td width="14%" bgcolor="E8E8E8" nowrap >流程类型：</td>
			<td width="15%" bgcolor="E8E8E8" align=left > 
				
				<wtc:pubselect name="sPubSelect" outnum="2">
					<wtc:sql>SELECT c.wo_code,c.wo_name  FROM sWFRlt a,sWAType b,swotype c WHERE a.Wo_Code = c.wo_code AND a.Wa_Code = b.Wa_Code AND b.Action_Code = 0 and (b.assignexpr = '?' or b.assignexpr in (select role_code from dwsrolememb where login_no = '?'))</wtc:sql>
				      <wtc:param value='<%=loginNo%>'/>
					  <wtc:param value='<%=loginNo%>'/>
				</wtc:pubselect>

				<wtc:array id="ret"  start="0" length="2" scope='end' /> 
				
			<select name="order_type">
				<%
					for(int k=0;k<ret.length;k++)
						{
									out.println("<option value='"+ret[k][0]+"'>"+ret[k][1]+"</option>");
						}
						
				%>
			</select>
			</td>	
				<td width="13%" nowrap>优先级： </td>
				<td>
					   <select name="order_priority" onChange="">
							<option value="0">一般</option>
				      <option value="1">高</option>
				      <option value="2">紧急</option>
				     </select>
				</td>						        
			</tr>
	
              
	</TBODY> 
	</TABLE>
        
  <TABLE width="100%" border=0 align=center cellpadding="4" cellSpacing=1>
     <TBODY>
        <TR bgcolor="#eeeeee">
            <TD align=middle bgcolor="#eeeeee"><input class="button"   index="3" type=button value="确认" onClick="submitCfm()" onKeyUp="if(event.keyCode==13){submitCfm()}">
               &nbsp;&nbsp; 
               &nbsp;&nbsp; 
              <input class="button" name=back  type=button value="关闭" onClick="window.close()">
            </TD>
        </TR>
     </TBODY>
  </TABLE>
       <input type='hidden' name='work_No' value='1'>
  
 </div>
<%@ include file="../../public/foot.jsp" %>
</FORM>
</BODY>
</HTML>
