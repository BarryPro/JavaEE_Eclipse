<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>
<%
		HashMap map1 = new HashMap();
		map1.put("0","未接收");
		map1.put("1","已接收未处理");
		map1.put("2","已保存未提交");
		
		int wonoIndex = 0,statusIndex=7,wanoIndex=6,startTimeIndex=2,endTimeIndex=3;

		
		String totalPage = "";
		String totalRec = "";

//查询参数

		String currPage = request.getParameter("currPage")==null?"1":request.getParameter("currPage");

		String numsPerPage = request.getParameter("numsPerPage")==null?"10":request.getParameter("numsPerPage");
		String wo_code = request.getParameter("wo_code")==null?"":request.getParameter("wo_code");
		String begin_time = request.getParameter("begin_time")==null?"":request.getParameter("begin_time");
		String end_time = request.getParameter("end_time")==null?"":request.getParameter("end_time");
		String wo_status = request.getParameter("wo_status")==null?"":request.getParameter("wo_status");
		
		StringBuffer conditionTmp = new StringBuffer();//需要动态拼接
		if(!wo_code.equals(""))
		{
			conditionTmp.append("wo_code:").append(wo_code).append(",");
		}
		if(!begin_time.equals(""))
		{
			conditionTmp.append("begin_time:").append(begin_time.replaceAll("-","")).append(",");
		}
		if(!end_time.equals(""))
		{
			conditionTmp.append("end_time:").append(end_time.replaceAll("-","")).append(",");
		}
		if(!wo_status.equals(""))
		{
			conditionTmp.append("wo_status:").append(wo_status).append(",");
		}
		String condition = conditionTmp.length()>0?conditionTmp.substring(0,conditionTmp.length()-1):"";
		
%>

		<div align="right" id='mode3'>
			<font id='b31' style="color:green" onclick="changeit3(this)" >查询模式</font>|
			<font id='b32' style="color:red" onclick="changeit3(this)" >列表模式</font>
		</div>

  <div id="Operation_Table">
  	<div id='query3div' style='display:none'>
  	
	<form name='form31' method="post" action='f_wb_2_02_part3.jsp'>
			<input type='hidden' value='<%=currPage%>' name='currPage'>
			
		<table width="98%" align="center" id="mainOne" bgcolor="#FFFFFF" cellspacing="1" border="0" >
			<tr>
				
								<td height="20">
					订单状态：
				</td>
				<td height="20">
					
				<wtc:pubselect name="sPubSelect" outnum="2">
					<wtc:sql>select code,value from sworkflow where tablename = 'dwomsg' and column_name = 'wo_status'</wtc:sql>
				</wtc:pubselect>

				<wtc:array id="ret"  start="0" length="2" scope='end' /> 
				
			<select name="wo_status">
				<option value=''>.不限制.</option>
				<%
					for(int k=0;k<ret.length;k++)
						{
									if(ret[k][0].equals(wo_status))
									{
										out.println("<option selected value='"+ret[k][0]+"'>"+ret[k][1]+"</option>");
									}
									else
									{
										out.println("<option value='"+ret[k][0]+"'>"+ret[k][1]+"</option>");
									}
						}
						
				%>
			</select>
					
				</td>
					
				<td height="20">
					订单类型：
				</td>
				<td height="20">
				<wtc:pubselect name="sPubSelect" outnum="2">
					<wtc:sql>select wo_code,wo_name from swotype</wtc:sql>
				</wtc:pubselect>

				<wtc:array id="ret"  start="0" length="2" scope='end' /> 
				
				<select name="wo_code">
				<option value=''>.不限制.</option>
				<%
					for(int k=0;k<ret.length;k++)
						{
									if(ret[k][0].equals(wo_code))
									{
										out.println("<option selected value='"+ret[k][0]+"'>"+ret[k][1]+"</option>");
									}
									else
									{
										out.println("<option value='"+ret[k][0]+"'>"+ret[k][1]+"</option>");
									}
						}
						
				%>
				</select>					
					
					<!-- <input type='text' value='<%=wo_code%>' name='wo_code'>-->
				</td>
				<td height="20">
					工单开始时间(>=)：
				</td>
				<td height="20">
					<input type='text' value='<%=begin_time%>' readonly='true' name='begin_time' class="Wdate" onfocus='new WdatePicker(this)'>
	
				</td>
					
			</tr>			
			
						<tr>

				<td height="20">
					工单开始时间(<=)：
				</td>
				<td height="20">
	
					<input type='text' value='<%=end_time%>' readonly='true' name='end_time' class="Wdate" onfocus='new WdatePicker(this)'>
	
				</td>
				
				
				<td height="20">
					每页记录条数：
				</td>
				<td height="20">
					<select name='numsPerPage'>
						<option <%=numsPerPage.equals("1")?"selected":""%> value='1'>1</option>
						<option <%=numsPerPage.equals("10")?"selected":""%> value='10'>10</option>
						<option <%=numsPerPage.equals("20")?"selected":""%> value='20'>20</option>
						<option <%=numsPerPage.equals("50")?"selected":""%> value='50'>50</option>
						<option <%=numsPerPage.equals("100")?"selected":""%> value='100'>100</option>
					</select>
				</td>		
				
				<td height="20">
					<input type='button' onclick='condquery3()' value='查询'>
						&nbsp;&nbsp;&nbsp;
					
					<input type='button' onclick='clearquery3();' value='重置'>
				</td>
					
			</tr>		
			
		</table>
	</form>
</div>
	
  	    <table width="98%" align="center" id="mainOne" bgcolor="#FFFFFF" cellspacing="1" border="0" >
      <tr bgcolor="#F5F5F5" >
        <td height="20">订单号</td>
        <td height="20">订单名称</td>
        <td height="20">订单开始时间</td>
        <td height="20">订单结束时间</td>
        <td height="20">订单状态</td>
        <td height="20">订单运行状态</td>
        <td height="20">当前执行工单号</td>
        <td height="20">当前工单处理状态</td>
        <td height="20">当前工单处理人</td>
        <td height="20">操作</td>
      </tr>

    	    <wtc:service name="sGetMyWO" outnum="11"  >
 			 <wtc:param value="9"/>
 			 <wtc:param value="<%=loginNo%>"/>
 			 <wtc:param value="<%=currPage%>"/>
 			 <wtc:param value="<%=numsPerPage%>"/>
 			 <wtc:param value="<%=condition%>"/>
  		</wtc:service>

<% 
if(retCode.equals("000000"))
{
%>

<wtc:array id="ret"  start="0" length="9"> 
<%

							for (int j = 0; j < ret.length; j++) {
							%>
							 <TR bgcolor="#F5F5F5"  align="center" id="rowc<%=ret[j][wonoIndex]%>"  type="<%=ret[j][statusIndex]%>" wano="<%=ret[j][wanoIndex]%>" onClick="trfunc3(this)"> 
							 <%
						for (int k = 0; k < ret[j].length; k++) {

							%>
							 <TD align="left">
							 <%
							if(k==statusIndex)
							{
								out.println(ret[j][k].equals("")?"&nbsp;":map1.get(ret[j][k]));
							}
							else if(k==startTimeIndex)
							{
								out.println(ret[j][k].equals("")?"&nbsp;":ParseParaxml.FormatDate(ret[j][k],"yyyyMMddHHmmss","yyyy-MM-dd HH:mm:ss"));
							}
							else if(k==endTimeIndex)
							{
								out.println(ret[j][k].equals("")?"&nbsp;":ParseParaxml.FormatDate(ret[j][k],"yyyyMMddHHmmss","yyyy-MM-dd HH:mm:ss"));
							}
							else
							{
							out.println(ret[j][k].equals("")?"&nbsp;":ret[j][k]);
							}
							%>
						</TD>
						<%
						
						}
						out.println("<td><font color='red' style='cursor:hand' onClick=\"javascript:return viewit('"+ret[j][0]+"','"+ret[j][wanoIndex]+"')\">查看</font></td>");
						%>
						</TR>
						<%
						}
%>
    </table>
       </div>
</wtc:array>
  
  <wtc:array id="ret1"  start="9" length="2"> 
	<%
		totalRec = ret1[0][0];
		totalPage = ret1[0][1];
	%>
</wtc:array>


    	<div class='paging'>
    		总条数:<font style='color:red'><%=totalRec%></font>&nbsp;
    		总页数:<font style='color:red'><%=totalPage%></font>&nbsp;
    		当前页:<font style='color:red'><%=currPage%></font>&nbsp;
  		[<a class='paginglink' href='#' onclick='return gotopage3("first",<%=totalRec%>,<%=totalPage%>,<%=currPage%>,false);' >首页</a>]&nbsp;&nbsp;
  		[<a class='paginglink' href='#' onclick='return gotopage3("before",<%=totalRec%>,<%=totalPage%>,<%=currPage%>,false);' >上页</a>]&nbsp;&nbsp;  		
  		[<a class='paginglink' href='#' onclick='return gotopage3("next",<%=totalRec%>,<%=totalPage%>,<%=currPage%>,false);' >下页</a>]&nbsp;&nbsp;
  		[<a class='paginglink' href='#' onclick='return gotopage3("end",<%=totalRec%>,<%=totalPage%>,<%=currPage%>,false);' >尾页</a>]&nbsp;&nbsp;
  	</div>
  	
	<%
					
}
else
{
%>
		<table>
     <TR bgcolor="#F5F5F5"  align="center"> 
	            <TD align="left">错误信息：</TD>
			  	
			  	<TD align="left"><%=retMsg%></TD>
				
				<TD align="left">错误编码</TD>
				
			  	<TD align="left"><%=retCode%></TD>
			  	
			  </TR>
			</table>
			  
<%	
}

%>

<script>

	 currWano3 = -1;
	 currWono3 = -1;
	 oldWono3 = -1;
	 
		function changeit3(obj)
	{
		var div1 = document.getElementById("query3div");
		if(obj.id=='b31')
		{
			//查询模式
			div1.style.display='block';
		}
		else if(obj.id=='b32')
		{
			div1.style.display='none';
		}
	}
	function gotopage3(obj,totalrec,totalpage,currpage,isfresh)
{
  var result = checkpaging(obj,totalrec,totalpage,currpage);
  if(!isfresh)
	{
  if(result==-1) return;
  	form31.currPage.value=result;
  }
	else
	{
		form31.currPage.value=1;
	}
	
	var url='f_wb_2_02_part3.jsp';
	with(document.form31)
	{
		para='&wo_status='+wo_status.value+'&wo_code='+wo_code.value+'&begin_time='+begin_time.value+'&end_time='
		+end_time.value+'&numsPerPage='+numsPerPage.value+'&currPage='+currPage.value;
	}
			$.ajax({
    url: url,
    type: 'POST',
    dataType: 'html',
    data:para,
    timeout: 10000,
    error: function(){
        alert('操作错误');
    },
    success: function(html){
    
    		var list3 = document.getElementById('listdiv3');
    		list3.innerHTML = html.replace('/\r/g','').replace('/\n/g','');
				currWano3 = -1;
				 currWono3 = -1;
				 oldWono3 = -1;
				
    		//$('#listdiv3').html(html.replace('/\r/g','').replace('/\n/g',''));
    		
    }
});

	}
	
	function condquery3()
	{
		gotopage3('first',<%=totalRec%>,<%=totalPage%>,<%=currPage%>,true);
	}
	
	function trfunc3(node){
    currWono3 = parseInt(node.id.substring(4,node.id.length));
    currWano3 = node.wano;
    //alert(currWono3+':'+oldWono3);
    if(currWono3 != oldWono3){
    	if(oldWono3 != -1) rowClick2("rowc" + oldWono3,0);
    	rowClick2("rowc" + currWono3,1);
    	oldWono3 = currWono3;
    }
}

function rowClick2(objname,flag){

	var o2 = document.getElementById(objname);
	if(flag == 0)
		o2.style.background = "#F5F5F5";
	else
		o2.style.background = "#CBEEFC";
}

function viewit(obj,obj2)
{

    var url = "f_wb_2_06.jsp?wono="+obj+"&wano="+obj2;
	  window.showModalDialog(url,window,"scroll:yes;status:no;resizable:yes;unadorne:yes;dialogWidth:750px");

}
	
	function clearquery3()
{
	with(document.form31)
	{
	  for (var i=0;i<elements.length;i++){
	  	if(elements[i].type!='button')
	   	elements[i].value='';
	   	
	  }
	  elements['numsPerPage'].value='10';
  }
}
</script>