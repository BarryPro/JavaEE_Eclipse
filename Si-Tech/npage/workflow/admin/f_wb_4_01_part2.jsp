<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>
<%
		HashMap map1 = new HashMap();
		map1.put("0","否");
		map1.put("1","是");
		int wonoIndex = 10,statusIndex=8,wanoIndex=0,startTimeIndex=3,endTimeIndex=4;
				
		String totalPage = "";
		String totalRec = "";

//查询参数

		String currPage = request.getParameter("currPage")==null?"1":request.getParameter("currPage");
		
		String numsPerPage = request.getParameter("numsPerPage")==null?"10":request.getParameter("numsPerPage");
	
		String wo_begin_time = request.getParameter("wo_begin_time")==null?"":request.getParameter("wo_begin_time");
		String wo_end_time = request.getParameter("wo_end_time")==null?"":request.getParameter("wo_end_time");
		String wa_code = request.getParameter("wa_code")==null?"":request.getParameter("wa_code");
		
		StringBuffer conditionTmp = new StringBuffer();//需要动态拼接
		
		if(!wo_begin_time.equals(""))
		{
			conditionTmp.append("wo_begin_time:").append(wo_begin_time.replaceAll("[-: ]","")+"00").append(",");
		}
		if(!wo_end_time.equals(""))
		{
			conditionTmp.append("wo_end_time:").append(wo_end_time.replaceAll("[-: ]","")+"00").append(",");
		}
		if(!wa_code.equals(""))
		{
			conditionTmp.append("wa_code:").append(wa_code).append(",");
		}
		String condition = conditionTmp.length()>0?conditionTmp.substring(0,conditionTmp.length()-1):"";
%>

	 	<!--模式-->
		
		
		<DIV id=mode2 align=right>
	     <INPUT id=b21 class=button onclick=changeit2(this) type=button value=查询模式>
	     <INPUT id=b22 class=button onclick=changeit2(this) type=button value=列表模式> 
       </DIV>

 <div class="Operation">
		  	<div id='query2div' style='display:none'>
	<form name='form21' method="post" >
		<input type='hidden' value='<%=currPage%>' name='currPage'>
		<table width="100%" align="center" id=mainOne cellpadding="0" cellspacing="0" border="0" >
			<tr>
					
				
			
				<td width="15%" class="Grey">
					工单开始时间：
				</td>
				<td width="35%" class="Grey">
					<input type='text' value='<%=wo_begin_time%>' readonly='true' name='wo_begin_time' id='start2' >
					<img src='./js/cal/datePicker.gif' onclick="return showCalendar('start2', '%Y-%m-%d %H:%M', '24', true);">
	

				</td>
				
				<td class="Grey">
					工单结束时间：
				</td>
				<td class="Grey">
	
					<input type='text' value='<%=wo_end_time%>' readonly='true' name='wo_end_time' id='end2'>
					<img src='./js/cal/datePicker.gif' onclick="return showCalendar('end2', '%Y-%m-%d %H:%M', '24', true);">
	
				</td>
					
			</tr>			
			
						<tr>

				
                 <td width="15%" class="Grey">
					工单类型：
				</td>
				<td width="35%" class="Grey">
				<wtc:pubselect name="sPubSelect" outnum="2">
					<wtc:sql>select distinct a.wa_code,wa_name from swatype a,swfrlt b where b.wo_code = 9 and a.wa_code = b.wa_code and a.business_rule in (select rule_code from srule where rule_type = any(0,3)) and a.wa_code <> 17</wtc:sql>
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
					<!--- <input type='text' value='<%=wa_code%>' name='wa_code'> -->
				</td>
				
				
				<td class="Grey">
					每页记录条数：
				</td>
				<td class="Grey">
					<select name='numsPerPage'>
						<option <%=numsPerPage.equals("1")?"selected":""%> value='1'>1</option>
						<option <%=numsPerPage.equals("10")?"selected":""%> value='10'>10</option>
						<option <%=numsPerPage.equals("20")?"selected":""%> value='20'>20</option>
						<option <%=numsPerPage.equals("50")?"selected":""%> value='50'>50</option>
						<option <%=numsPerPage.equals("100")?"selected":""%> value='100'>100</option>
					</select>
				</td>		
				
				
					
			</tr>	
			 <tr>
          <td colspan="4" align="center"><INPUT class="button" onclick=condquery2(); type=button value=查询>
			                             <INPUT class="button" onclick=clearquery2(); type=button value=重置> 
      </td></tr>	
			
		</table>
	</form>
</div>
</div>


      <!------------------调用服务------------------>
      <%
      String condition2=condition+(condition.length()>0?",":"")+"deal_flag:t";
	  System.out.println("condition2==="+condition2);
      %>
	    <wtc:service name="sGetCaseTask" outnum="17"  >
 			 <wtc:param value="0125"/>
 			 <wtc:param value="<%=loginNo%>"/>
 			 <wtc:param value="<%=currPage%>"/>
 			 <wtc:param value="<%=numsPerPage%>"/>
 			 <wtc:param value="<%=condition2%>"/>
  		</wtc:service>
  
<form name="form22" method="post">


	
	 <DIV class="Operation">
      <TABLE width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <TR align="center">
          <TD align="center">
		<INPUT class=button onclick=rollBack1() type=button value='返  回' name=recWA>
	    <INPUT class=button onclick=upData1() type=button value='处  理' name=recWA>
	    </TD></TR>	 
      </TABLE>
	  </DIV>
    
    <table class="Operation"width="100%" align="center" id="mainOne" cellpadding="0" cellspacing="0" border="0" >
	  <tr>
	    <th nowrap="nowrap">温馨提醒</th>
        <th nowrap="nowrap">工单名称</th>
        <th nowrap="nowrap">工单编号</th>
        <th nowrap="nowrap">用户号码</th>
        <th nowrap="nowrap">投诉地区</th>
        <th nowrap="nowrap">用户品牌</th>
        <th nowrap="nowrap">投诉分类</th>
        <th nowrap="nowrap">投诉级别</th>
        <th nowrap="nowrap">受理工号</th>
        <th nowrap="nowrap">受理时间</th>
        <th nowrap="nowrap">要求完成时间</th>
		<th nowrap="nowrap">个人标志</th>
      </tr>

<% 
if(retCode.equals("000000"))
{
%>

<wtc:array id="ret"  start="0" length="15"> 
<%

							for (int j = 0; j < ret.length; j++) {
							%>
						
               			
							<TR bgcolor="#F5F5F5"  align="center" id="row<%=ret[j][wanoIndex]%>" onClick="trfunc2(this)"> 
						
							<TD width="4%" align="center" >
						     <% 
            			   if(ret[j][13].equals("-1")||ret[j][13].equals("0"))
  							{
						%>
               				 
								 <% 
            			   if(ret[j][14].equals("")||ret[j][14].equals("0")||ret[j][14].equals("1"))
  							{
						%>
               				 
							 &nbsp;
							 	<%
					
								}
							else
								{
						%>
							<img src="../../../callcenter/images/bc_flag.gif" >
						<%	
							}

						%>	 
							 	<%
					
								}
							else
								{
						%>
							<img src="../../../callcenter/images/reply_type_<%=ret[j][13]%>.gif" >
						<%	
							}

						%>	 
						
							 <% 
            			 if(ret[j][12].equals("1"))
  							{
						%>
               				 
							<img src="../../../callcenter/images/dj_3.gif"  >
							 	<%
					
								}
							else
								{
						%>
							 &nbsp;
						<%	
							}

						%>	 
						
						    </TD>
						
						<TD align="left">
							<%
						    out.println(ret[j][1].equals("")?"&nbsp;":ret[j][1]);
							%>
						</TD>
						<TD align="left">
							<%
						    out.println(ret[j][2].equals("")?"&nbsp;":ret[j][2]);
							%>
						</TD>
						<TD align="left">
							<%
						    out.println(ret[j][3].equals("")?"&nbsp;":ret[j][3]);
							%>
						</TD>
						<TD align="left">
							<%
						    out.println(ret[j][4].equals("")?"&nbsp;":ret[j][4]);
							%>
						</TD>
						<TD align="left">
							<%
						    out.println(ret[j][5].equals("")?"&nbsp;":ret[j][5]);
							%>
						</TD>
						<TD align="left">
							<%
						    out.println(ret[j][6].equals("")?"&nbsp;":ret[j][6]);
							%>
						</TD>
						<TD align="left">
							<%
						    out.println(ret[j][7].equals("")?"&nbsp;":ret[j][7]);
							%>
						</TD>
						<TD align="left">
							<%
						    out.println(ret[j][8].equals("")?"&nbsp;":ret[j][8]);
							%>
						</TD>
						<TD align="left">
							<%
						    out.println(ret[j][9].equals("")?"&nbsp;":ret[j][9]);
							%>
						</TD>
						<TD align="left">
							<%
						    out.println(ret[j][10].equals("")?"&nbsp;":ret[j][10]);
							%>
						</TD>
						<TD align="left">
							<%
						    out.println(ret[j][11].equals("")?"&nbsp;":map1.get(ret[j][11]));
							%>
						</TD>
						</TR>
						<%
						}
%>
    </table>
      
</wtc:array>

<wtc:array id="ret1"  start="15" length="2"> 
	<%
		totalRec = ret1[0][0];
		totalPage = ret1[0][1];
	%>
</wtc:array>


    	<DIV class="Operation">
      <TABLE width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <TR>
          <TD>
	     <DIV class="NextPages">
		 总条数:<span class="F_blue"><%=totalRec%></span>
	     总页数:<span class="F_blue"><%=totalPage%></span>
		 当前页:<span class="F_orange"><%=currPage%></span>
	     <a class=paginglink 
      onclick='return gotopage2("first",<%=totalRec%>,<%=totalPage%>,<%=currPage%>,false);' 
      href="#">首页</a>
	     <a onclick='return gotopage2("before",<%=totalRec%>,<%=totalPage%>,<%=currPage%>,false);' 
      href="#" class="disabled">上一页</a>
	     <a class=paginglink onclick='return gotopage2("next",<%=totalRec%>,<%=totalPage%>,<%=currPage%>,false);' 
      href="#">下一页</a>
	     <a class=paginglink onclick='return gotopage2("end",<%=totalRec%>,<%=totalPage%>,<%=currPage%>,false);' 
      href="#">尾页</a>
	</DIV>
	    </TD></TR>	 
      </TABLE>
	  </DIV>
  	
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
<div class="tag"><span class="F_blue"><b>回复类别图例：</b></span> 
  <%
 	String reply_type_desc_list[][] = {{"0","正常待回复"},
		{"1","暂办中，待回复"},
		{"2","暂办中，未最终回复"},
		{"3","暂办结束，待回复"},
		{"10","返单，待回复"}
		}; 	
 	
 	for(int i = 1; i < reply_type_desc_list.length; i++)
 	{
  %>
    <img src="../../../callcenter/images/reply_type_<%= reply_type_desc_list[i][0] %>.gif" align="absmiddle"><%= reply_type_desc_list[i][1] %>; 
	
	
  <%
   	}
  %>
    <img src="../../../callcenter/images/dj_3.gif" align="absmiddle">超时提醒; 
 </div> 


</form>
<script>
	



function trfunc2(node){
    nowrow = parseInt(node.id.substring(3,node.id.length));
    
    if(oldrow != nowrow){
    	if(oldrow != -1) rowClick("row" + oldrow,0);
    	rowClick("row" + nowrow,1);
    	oldrow = nowrow;
    }
	//updateStatus2();
}


function updateStatus2()
{
	if(type==0)
	{
	//document.form22.transmit.disabled=false;
	//document.form22.query.disabled=false;
	//document.form22.recWA.disabled=false;
	//document.form22.rollBack.disabled=true;
	document.form22.upData.disabled=true;
	//document.form22.loadWA.disabled=true;
	
	
	}
	if(type==1)
	{
	//document.form22.transmit.disabled=false;
	//document.form22.query.disabled=false;
	//document.form22.recWA.disabled=true;
	//document.form22.rollBack.disabled=false;
	document.form22.upData.disabled=false;
	//document.form22.loadWA.disabled=true;

	}
	if(type==2)
	{
	//document.form22.transmit.disabled=true;
	//document.form22.query.disabled=false;
	//document.form22.recWA.disabled=true;
	//document.form22.rollBack.disabled=true;
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
	
	var url='f_wb_4_01_part2.jsp';
	with(document.form21)
	{
		para='&wa_code='+wa_code.value+'&wo_begin_time='+wo_begin_time.value+'&wo_end_time='
		+wo_end_time.value+'&numsPerPage='+numsPerPage.value+'&currPage='+currPage.value;;
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