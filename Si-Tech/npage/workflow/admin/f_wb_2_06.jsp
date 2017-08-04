<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">

<%@ include file="/npage/workflow/admin/pub/wb_include.jsp" %>

<%
	String opCode = "7453";
		   opName = "订单管理";
	String wono = (String)request.getParameter("wono");
	String wano = (String)request.getParameter("wano");
	
	System.out.println("---in view------wono is:"+wono);
	System.out.println("---in view------wano is:"+wano);
	
	int startTimeIndex=4,endTimeIndex=5;

%>

<SCRIPT LANGUAGE="JavaScript">
var oldrow = -1;
var nowrow = -1;
function trfunc1(node){
    nowrow = parseInt(node.id.substring(3,node.id.length));
	 type  = node.type ;
    
    if(oldrow != nowrow){
    	if(oldrow != -1) rowClick("row" + oldrow,0);
    	rowClick("row" + nowrow,1);
    	oldrow = nowrow;
    }
    
}

function rowClick(objname,flag){
	var o = eval(objname);
	if(flag == 0)
		o.style.color = " ";
	else
		o.style.color = "#ff0000";
}



</SCRIPT>
<html xmlns="http://www.w3.org/1999/xhtml">
<body>
  <%@ include file="/npage/include/header.jsp" %>	
	<script type="text/javascript" src="js/jquery.js"></script>
  <div class="title">
		<div id="title_zi">工单信息</div>
  </div>
    <table cellspacing="0">
      <tr align="center" >
        <th nowrap>工单号</th>
        <th nowrap>工单名称</th>
        <th nowrap>工单状态</th>
        <th nowrap>处理人</th>
        <th nowrap>工单开始时间</th>
        <th nowrap>工单结束时间</th>
        <th nowrap>工单操作结果</th>
        <th nowrap>操作人员归属</th>
       <!-- <th nowrap>操作</th> -->
      </tr>
	 
	<wtc:service name="sGetFlow" outnum="8"  >
  		<wtc:param value="<%=wono%>"/>
  		<wtc:param value="4"/>
  	</wtc:service> 
<% 
if(retCode.equals("000000"))
{
%>

<wtc:array id="ret"  start="0" length="8"> 
<%

							for (int j = 0; j < ret.length; j++) {
							%>
							 <TR bgcolor="#F5F5F5"  align="center" id="row<%=ret[j][0]%>"  type="<%=ret[j][7]%>" > 
							 <%
						for (int k = 0; k < ret[j].length; k++) {

							%>
							 <TD align="left">
							 <%
							 	if(k==startTimeIndex||k==endTimeIndex)
							 	{
									out.println(ret[j][k].equals("")?"&nbsp;":ParseParaxml.FormatDate(ret[j][k],"yyyyMMddHHmmss","yyyy-MM-dd HH:mm:ss"));
									System.out.println("---"+ret[j][k]+"---");
								}
								else
								{
									out.println(ret[j][k].equals("")?"&nbsp;":ret[j][k]);
								}
							%>
						</TD>
						<%
						}
						//out.println("<td><font color='red' style='cursor:hand' onClick=\"javascript:return viewit('"+ret[j][0]+"')\">查看</font></td>");
						%>
						</TR>
						<%
						}
%>
</wtc:array>

	<%
					
}
else
{
%>
     <TR bgcolor="#F5F5F5"  align="center"> 
	            <TD align="left">错误信息：</TD>
			  	
			  	<TD align="left"><%=retMsg%></TD>
				
				<TD align="left">错误编码</TD>
				
			  	<TD align="left"><%=retCode%></TD>
			  	
			  </TR>
			  
<%	
}

%>
    </table>
    
    <script>
	function viewit(obj)
	{
		var url="f_wb_2_05.jsp?wano="+obj;
		
			$.ajax({
    url: url,
    type: 'GET',
    dataType: 'html',
    timeout: 10000,
    error: function(){
        rdShowMessageDialog('操作错误',0);
    },
    success: function(html){
    	//alert(html.replace('/\n/g','').replace('/\r/g',''));
			var cdiv = document.getElementById("contenddiv");
			cdiv.innerHTML=html.replace('/\n/g','').replace('/\r/g','');
			//取消命令按钮的显示
			disablecommand();
    }
		});
	}
	
	//取消命令的显示
	function disablecommand()
	{
			var commanddiv = document.getElementById("commanddiv");
			if(commanddiv!='undefined'&&commanddiv!=null&&commanddiv!='')
			{
				commanddiv.style.display='none';
			}
	}

  	<%
//  		if(wano!=null&&!wano.equals("")&&!wano.equals("0"))
//  		{
//  			%>
//  			viewit('<%=wano%>');
//  			<%
//  		}
  	%>

</script>


  
  <br><font color=blue>
  		工单信息预览(默认当前工单):
	  </font>
  <br>
  <div id='contenddiv' >

		
	</div>
	
		<table width="98%" align="center" id="mainOne" bgcolor="#FFFFFF" cellspacing="0" border="0" >
			<TR bgcolor="#F5F5F5"  align="center">
        		<TD align="center"><input name="close" onClick="window.close();" type="button" class="b_foot" value="关 闭">
        		</TD>
			</TR>
		</table>
  </div>
  <%@ include file="/npage/include/footer.jsp" %>	
</BODY>
</HTML>
