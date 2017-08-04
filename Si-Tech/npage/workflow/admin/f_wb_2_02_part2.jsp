<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">

<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>
<%
		HashMap map1 = new HashMap();
		map1.put("0","未接收");
		map1.put("1","已接收未处理");
		map1.put("2","已保存未提交");
		int wonoIndex = 10,statusIndex=8,wanoIndex=0,startTimeIndex=3,endTimeIndex=4;
				
		String totalPage = "";
		String totalRec = "";

//查询参数
		String opCode = "7453";
		String currPage = request.getParameter("currPage")==null?"1":request.getParameter("currPage");
		
		String numsPerPage = request.getParameter("numsPerPage")==null?"10":request.getParameter("numsPerPage");
		String wo_code = request.getParameter("wo_code")==null?"":request.getParameter("wo_code");
		String begin_time = request.getParameter("begin_time")==null?"":request.getParameter("begin_time");
		String end_time = request.getParameter("end_time")==null?"":request.getParameter("end_time");
		String wa_code = request.getParameter("wa_code")==null?"":request.getParameter("wa_code");
		String unit_id2 = request.getParameter("unit_id2")==null?"":request.getParameter("unit_id2"); //集团编码
    String chance_name2 = request.getParameter("chance_name2")==null?"":request.getParameter("chance_name2"); //集团编码	
		
		StringBuffer conditionTmp = new StringBuffer();//需要动态拼接
		if(!wo_code.equals(""))
		{
			conditionTmp.append("wo_code:").append(wo_code).append(",");
		}
		if(!begin_time.equals(""))
		{
			conditionTmp.append("begin_time:").append(begin_time.replaceAll("[-: ]","")+"00").append(",");
		}
		if(!end_time.equals(""))
		{
			conditionTmp.append("end_time:").append(end_time.replaceAll("[-: ]","")+"00").append(",");
		}
		if(!wa_code.equals(""))
		{
			conditionTmp.append("wa_code:").append(wa_code).append(",");
		}
				if(!unit_id2.equals(""))
		{
			conditionTmp.append("unit_id:").append(unit_id2).append(",");
		}
		if(!chance_name2.equals(""))
		{
			conditionTmp.append("chance_name:").append(chance_name2).append(",");
		}
		String condition = conditionTmp.length()>0?conditionTmp.substring(0,conditionTmp.length()-1):"";
%>

	 	<!--模式-->
		<div align="right" id='mode2' style='display:none'>
			<font id='b21' style="color:green;cursor:hand" onclick="changeit2(this)" >查询模式</font>|
			<font id='b22' style="color:red;cursor:hand" onclick="changeit2(this)" >列表模式</font>
		</div>

 
		  	<div id='query2div' style='display:'>
	<form name='form21' method="post" >
		<input type='hidden' value='<%=currPage%>' name='currPage'>
	<div class="title">
		<div id="title_zi">工单查询</div>
	</div>
		<table cellspacing="0">
			<tr>
				<td  class="blue"> 订单类型 </td>
				<td>
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
				</td>
								
				<td class="blue"> 工单类型 </td>
				<td >
					<wtc:pubselect name="sPubSelect" outnum="2">
						<wtc:sql>select wa_code,wa_name from swatype where business_rule in (select rule_code from srule where rule_type = any(0,3) )</wtc:sql>
					</wtc:pubselect>
					<wtc:array id="ret"  start="0" length="2" scope='end' /> 
					
					<select name="wa_code">
						<option value=''>.不限制.</option>
						<%
							for(int k=0;k<ret.length;k++)
								{
											if(ret[k][0].equals(wa_code))
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
            </tr>
             <tr>
				<td class="blue"> 集团编码</td>
				<td>
					<input type='text' value='<%=unit_id2%>' name='unit_id2' id='unit_id2' v_type='0_9' />
				</td>
					

				<td class="blue"> 项目名称</td>
				<td>
					<input type='text' value='<%=chance_name2%>' name='chance_name2' id='chance_name2' v_type="string"  maxlength="50" />
				</td>
			</tr>
            <tr>
				<td  class="blue">工单开始时间(>=) </td>
				<td>
					<input type='text' value='<%=begin_time%>' readonly='true' name='begin_time' id='start2' >
					<img src='./js/cal/datePicker.gif' onclick="return showCalendar('start2', '%Y-%m-%d %H:%M', '24', true);">
				</td>

				<td class="blue">工单开始时间(<=) </td>
				<td>
					<input type='text' value='<%=end_time%>' readonly='true' name='end_time' id='end2'>
					<img src='./js/cal/datePicker.gif' onclick="return showCalendar('end2', '%Y-%m-%d %H:%M', '24', true);">
				</td>
			</tr>
		    <tr>
				<td  class="blue"> 每页记录条数 </td>
				<td height="20">
					<select name='numsPerPage'>
						<option <%=numsPerPage.equals("1")?"selected":""%> value='1'>1</option>
						<option <%=numsPerPage.equals("10")?"selected":""%> value='10'>10</option>
						<option <%=numsPerPage.equals("20")?"selected":""%> value='20'>20</option>
						<option <%=numsPerPage.equals("50")?"selected":""%> value='50'>50</option>
						<option <%=numsPerPage.equals("100")?"selected":""%> value='100'>100</option>
					</select>
				</td>		
				
				<td height="20" colspan="2">
					<input class="b_text" type='button' onclick='condquery2();' value='查询'>&nbsp;&nbsp;&nbsp;
					<input class="b_text" type='button' onclick='clearquery2();' value='重置'>&nbsp;&nbsp;&nbsp;
					<input class="b_text" type='button' onclick='ExportFunc();' value='导出'>
				</td>
					
			</tr>		
			
		</table>
	</form>
</div>

      <!------------------调用服务------------------>
 <%
      String condition2=condition+(condition.length()>0?",":"")+"deal_flag:t";
 %>
	    <wtc:service name="sGetTaskUrl" outnum="18"  >
 			 <wtc:param value="4"/>
 			 <wtc:param value="<%=loginNo%>"/>
 			 <wtc:param value="<%=currPage%>"/>
 			 <wtc:param value="<%=numsPerPage%>"/>
 			 <wtc:param value="<%=condition2%>"/>
  		</wtc:service>
  
<form name="form22" method="post">
    
  <div class="title">
			<div id="title_zi">工单信息</div>
		</div>	
    <table cellspacing="0">
      <TR align="center">
        <TD align="center">
          <input name="query" onClick="query1()" type="button" class="b_text" value="查 看">
          &nbsp;&nbsp;
          <input name="rollBack" onClick="rollBack1();" type="button" class="b_text" value="回 退">
		   &nbsp;&nbsp;
          <input name="upData" onClick="upData1()" type="button" class="b_text" value="修 改">
		
          <!--input name="loadWA" id="loadWA" onClick="loadWA1()" type="button" class="button" value="提 交"-->

        </TD>
      </TR>
    </table>
    
     <table cellspacing="0">
      <tr align="center">
        <th>商机名称</th>
        <th>工单名称</th>
        <th>订单名称</th>
        <th>工单开始时间</th>
        <th>工单处理时间</th>
        <th>工单状态</th>
        <th>订单创建人</th>
        <th>工单操作人</th>
        <th>处理状态</th>
        <th>优先级</th>
		<th>订单号</th>
		<th>个人标志</th>
      </tr>

<% 
if(retCode.equals("000000"))
{
%>

<wtc:array id="ret"  start="0" length="12"> 
<wtc:array id="ret2"  start="12" length="4" scope="end"/>
<%

							for (int j = 0; j < ret.length; j++) {
							String tdClass = ((j%2)==1)?"Grey":"";
							%>
							 <TR  class='blue' align="center" id="row<%=ret[j][wanoIndex]%>"  type="<%=ret[j][statusIndex]%>" wono="<%=ret[j][wonoIndex]%>" onClick="trfunc2(this)"  openUrl="<%=ret2[j][2]%>"> 
								<TD align="left" class='<%=tdClass%>'>
<%
									out.println(ret2[j][3].equals("")?"&nbsp;":ret2[j][3]);
%>
								</TD>
						
							 <%
						for (int k = 0; k < ret[j].length; k++) {
							if(k==wanoIndex)
							{
								continue;
							}

							%>
							 <TD align="left" class='<%=tdClass%>'>
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
						%>
						</TR>
						<%
						}
%>
    </table>
</wtc:array>

<wtc:array id="ret1"  start="16" length="2"> 
	<%
		totalRec = ret1[0][0];
		totalPage = ret1[0][1];
	%>
</wtc:array>


    	<div style="position:relative;font-size:12px" align="center">
    		总条数:<font style='color:red'><%=totalRec%></font>&nbsp;
    		总页数:<font style='color:red'><%=totalPage%></font>&nbsp;
    		当前页:<font style='color:red'><%=currPage%></font>&nbsp;
  		[<a  href='javascript:void(0)' onclick='return gotopage2("first",<%=totalRec%>,<%=totalPage%>,<%=currPage%>,false);' >首页</a>]&nbsp;&nbsp;
  		[<a  href='javascript:void(0)' onclick='return gotopage2("before",<%=totalRec%>,<%=totalPage%>,<%=currPage%>,false);' >上页</a>]&nbsp;&nbsp;  		
  		[<a  href='javascript:void(0)' onclick='return gotopage2("next",<%=totalRec%>,<%=totalPage%>,<%=currPage%>,false);' >下页</a>]&nbsp;&nbsp;
  		[<a  href='javascript:void(0)' onclick='return gotopage2("end",<%=totalRec%>,<%=totalPage%>,<%=currPage%>,false);' >尾页</a>]&nbsp;&nbsp;
  	</div>
  	
	<%
					
}
else
{
%>
		<table>
     <TR align="center"> 
	            <TD align="left" class="blue">错误信息</TD>
			  	
			  	<TD align="left"><%=retMsg%></TD>
				
				<TD align="left" class="blue">错误编码</TD>
				
			  	<TD align="left"><%=retCode%></TD>
			  	
			  </TR>
			</table>
			  
<%	
}

%>


</form>
<script type="text/javascript" src="/njs/si/core_sitech_pack.js"></script>	
<script>
	
//关于上报集团客户部2014年2月第一期系统需求的函-1-优化集团专线端到	hejwa add 2014年3月12日16:19:03 调用导出服务
function getcondition(){
	var conditionT = "";
		if(document.form21.wo_code.value!=""){
			conditionT += "wo_code:"+document.form21.wo_code.value+",";
		}
		if(document.form21.begin_time.value!=""){
			conditionT += "begin_time:"+document.form21.begin_time.value.replace(/[-: ]/g,"")+"00,";
		}		
		if(document.form21.end_time.value!=""){
			conditionT += "end_time:"+document.form21.end_time.value.replace(/[-: ]/g,"")+"00,";
		}	
		if(document.form21.wa_code.value!=""){
			conditionT += "wa_code:"+document.form21.wa_code.value+",";
		}	
		if(document.form21.unit_id2.value!=""){
			conditionT += "unit_id:"+document.form21.unit_id2.value+",";
		}	
		if(document.form21.chance_name2.value!=""){
			conditionT += "chance_name:"+document.form21.chance_name2.value+",";
		}	
		
			conditionT += "deal_flag:t"
			return conditionT;
}
function ExportFunc(){

		var senddata={};
				senddata["opCode"]     = "<%=opCode%>";
				senddata["condition1"] = getcondition();
		$.ajax({
		    url: "f_wb_2_02_sGetTaskUrl.jsp",
		    type: 'POST',
		    data: senddata,
				async: false,
		    timeout: 10000,
		    error: function(){
		        rdShowMessageDialog('操作错误',0);
		    },
		    success: function(msg){
		    	alert(msg.trim());
		    	//rdShowMessageDialog(msg.trim(),1);
		  	}
		});
}
 function gotoExportFunc(){
		//设置标志位
		document.getElementById('ExportFlag').value = "1";
	  gotopage2('first',<%=totalRec%>,<%=totalPage%>,<%=currPage%>,true);
}

function trfunc2(node){
    openUrl2 = node.openUrl;
    nowrow = parseInt(node.id.substring(3,node.id.length));
	 type  = node.type ;
	  wono  = node.wono ;
    
    if(oldrow != nowrow){
    	if(oldrow != -1) rowClick("row" + oldrow,0);
    	rowClick("row" + nowrow,1);
    	oldrow = nowrow;
    }
	updateStatus2();
}


function updateStatus2()
{
	if(type==0)
	{
	//document.form22.transmit.disabled=false;
	document.form22.query.disabled=false;
	//document.form22.recWA.disabled=false;
	document.form22.rollBack.disabled=true;
	document.form22.upData.disabled=true;
	//document.form22.loadWA.disabled=true;
	
	
	}
	if(type==1)
	{
	//document.form22.transmit.disabled=false;
	document.form22.query.disabled=false;
	//document.form22.recWA.disabled=true;
	document.form22.rollBack.disabled=false;
	document.form22.upData.disabled=false;
	//document.form22.loadWA.disabled=true;

	}
	if(type==2)
	{
	//document.form22.transmit.disabled=true;
	document.form22.query.disabled=false;
	//document.form22.recWA.disabled=true;
	document.form22.rollBack.disabled=true;
	document.form22.upData.disabled=false;
	//document.form22.loadWA.disabled=false;

	}
    
}
	
	function changeit2(obj)
	{
		var div2 = document.getElementById("query2div");
		if(obj.id=='b21')
		{
			//查询模式
			div2.style.display='block';
		} 
		else if(obj.id=='b22')
		{
			div2.style.display='none';
		}
	}
	
	function gotopage2(obj,totalrec,totalpage,currpage,isfresh)
{
  var result = checkpaging(obj,totalrec,totalpage,currpage);

  if(!isfresh)
	{
  if(result==-1) return;
  	form21.currPage.value=result;
  }
	else
	{
		form21.currPage.value=1;
	}
	
	var url='f_wb_2_02_part2.jsp';
	with(document.form21)
	{
		para='&wa_code='+wa_code.value+'&wo_code='+wo_code.value+'&begin_time='+begin_time.value+'&end_time='
		+end_time.value+'&numsPerPage='+numsPerPage.value+'&currPage='+currPage.value+'&unit_id2='+unit_id2.value+'&chance_name2='+chance_name2.value;
	}
			$.ajax({
    url: url,
    type: 'POST',
    dataType: 'html',
    data:para,
    timeout: 10000,
    error: function(){
        rdShowMessageDialog('操作错误',0);
    },
    success: function(html){
    	
    		var list2 = document.getElementById('listdiv2');
    		list2.innerHTML = html.replace('/\r/g','').replace('/\n/g','');
			 oldrow = -1;
		 nowrow = -1;
		 wono = -1;
    }
});
}

function condquery2() 
{
  if($("#unit_id2").val()!=""&&$("#unit_id2").val()!=null){
    if(!checkElement(document.form21.unit_id2)){
      return false;
    }else{
      hiddenTip(document.form21.unit_id2);
    }
  }
  if($("#chance_name2").val()!=""&&$("#chance_name2").val()!=null){
    if(!checkElement(document.form21.chance_name2)){
      return false;
    }else{
      hiddenTip(document.form21.chance_name2);
    }
  }
	gotopage2('first',<%=totalRec%>,<%=totalPage%>,<%=currPage%>,true);
}

function clearquery2()
{
	with(document.form21)
	{
	  for (var i=0;i<elements.length;i++){
	  	if(elements[i].type!='button')
	   	elements[i].value='';
	   	
	  }
	  elements['numsPerPage'].value='10';
  }
}
</script>
