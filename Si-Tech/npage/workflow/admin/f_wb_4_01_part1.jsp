<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>
<%

		HashMap map1 = new HashMap();
		map1.put("0","��");
		map1.put("1","��");
		int wonoIndex = 10,statusIndex=8,wanoIndex=0,startTimeIndex=3,endTimeIndex=4;

		
		String totalPage = "";
		String totalRec = "";

		//��ѯ����

		String currPage = request.getParameter("currPage")==null?"1":request.getParameter("currPage");
		
		String numsPerPage = request.getParameter("numsPerPage")==null?"10":request.getParameter("numsPerPage");
		String wo_begin_time = request.getParameter("wo_begin_time")==null?"":request.getParameter("wo_begin_time");
		String wo_end_time = request.getParameter("wo_end_time")==null?"":request.getParameter("wo_end_time");
		String wa_code = request.getParameter("wa_code")==null?"":request.getParameter("wa_code");
		
		StringBuffer conditionTmp = new StringBuffer();//��Ҫ��̬ƴ��
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

<SCRIPT LANGUAGE="JavaScript">

function trfunc1(node){
    nowrow = parseInt(node.id.substring(3,node.id.length));
	 	
    
    if(oldrow != nowrow){
    	if(oldrow != -1) rowClick("row" + oldrow,0);
    	rowClick("row" + nowrow,1);
    	oldrow = nowrow;
    }

	//updateStatus();
	}

function updateStatus()
{
	if(type==0)
	{
	//document.form12.transmit.disabled=false;
	//document.form12.query.disabled=false;
	document.form12.recWA.disabled=false;
	//document.form12.rollBack.disabled=true;
	//document.form12.upData.disabled=true;
	//document.form12.loadWA.disabled=true;
	
	
	}
	if(type==1)
	{
	//document.form12.transmit.disabled=false;
	//document.form12.query.disabled=false;
	document.form12.recWA.disabled=true;
	//document.form12.rollBack.disabled=false;
	//document.form12.upData.disabled=false;
	//document.form12.loadWA.disabled=true;

	}
	if(type==2)
	{
	//document.form12.transmit.disabled=true;
	//document.form12.query.disabled=false;
	document.form12.recWA.disabled=true;
	//document.form12.rollBack.disabled=true;
	//document.form12.upData.disabled=false;
	//document.form12.loadWA.disabled=false;

	}
    
}

</SCRIPT>

	 	<!--ģʽ-->
		<DIV id=mode1 align=right>
	     <INPUT class=button onclick=transmit1() type=button value=�������� name=transmit>
	     <INPUT id=b11 class=button onclick=changeit1(this) type=button value=��ѯģʽ>
	     <INPUT id=b12 class=button onclick=changeit1(this) type=button value=�б�ģʽ> 
       </DIV>

  <div class="Operation">
	  	<div id='query1div' style='display:none'>
	<form name='form11' method="post" >
		<input type='hidden' value='<%=currPage%>' name='currPage'>

		<table width="100%" align="center" id=mainOne cellpadding="0" cellspacing="0" border="0" >
			<tr>

				<td width="15%" class="Grey">
					������ʼʱ�䣺
				</td>
				<td width="35%" class="Grey">
	                <input type='text' value='<%=wo_begin_time%>' readonly='true' name='wo_begin_time' id='start1' >
					<img src='./js/cal/datePicker.gif' onclick="return showCalendar('start1', '%Y-%m-%d %H:%M', '24', true);">

				</td>
				
				<td class="Grey">
					��������ʱ�䣺
				</td>
				<td class="Grey">
	                <input type='text' value='<%=wo_end_time%>' readonly='true' name='wo_end_time' id='end1'>
					<img src='./js/cal/datePicker.gif' onclick="return showCalendar('end1', '%Y-%m-%d %H:%M', '24', true);">
				</td>
					
			</tr>			
			
			<tr>

				

				<td width="15%" class="Grey">
					�������ͣ�
				</td>
				<td width="35%" class="Grey">
				<wtc:pubselect name="sPubSelect" outnum="2">
					<wtc:sql>select distinct a.wa_code,wa_name from swatype a,swfrlt b where b.wo_code = 9 and a.wa_code = b.wa_code and a.business_rule in (select rule_code from srule where rule_type = any(0,3)) and a.wa_code <> 17</wtc:sql>
				</wtc:pubselect>

				<wtc:array id="ret"  start="0" length="2" scope='end' /> 
				
				<select name="wa_code">
				<option value=''>.������.</option>
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
					ÿҳ��¼������
				</td>
				<td class="Grey">
					<select name='numsPerPage'>
						<option <%=numsPerPage.equals("1")?"selected":""%> value='1'>1</option>
						<option <%=numsPerPage.equals("10")?"selected":""%> value='10'>10</option>
						<option <%=numsPerPage.equals("20")?"selected":""%> value='20'>20</option>
						<option <%=numsPerPage.equals("50")?"selected":""%> value='50'>50</option>
						<option <%=numsPerPage.equals("100")?"selected":""%> value='100'>100</option>
					</select>
				</td></tr>
        <tr>
          <td colspan="4" align="center"><INPUT class="button" onclick=condquery1(); type=button value=��ѯ>
			<INPUT class="button" onclick=clearquery1(); type=button value=����> 
      </td></tr>	
			
		</table>
	</form>
</div>
</div>


      <!------------------���÷���------------------>
      <%
      String condition1=condition+(condition.length()>0?",":"")+"deal_flag:f";
      %>
	    <wtc:service name="sGetCaseTask" outnum="17"  >
 			 <wtc:param value="0125"/>
 			 <wtc:param value="<%=loginNo%>"/>
 			 <wtc:param value="<%=currPage%>"/>
 			 <wtc:param value="<%=numsPerPage%>"/>
 			 <wtc:param value="<%=condition1%>"/>
  		</wtc:service>
  
<form name="form12" method="post">
	
	 <DIV class="Operation">
      <TABLE width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <TR align="center">
          <TD align="center">
		  
		 <INPUT class=button onclick=viewRec() type=button value='��  ��' name=recWA> 
	     <INPUT class=button onclick=recWA1() type=button value=���մ��� name=recWA>
	    </TD></TR>	 
      </TABLE>
	  </DIV>

    <div class="Operation">  
    <table width="100%" align="center" id="mainOne" cellpadding="0" cellspacing="0" border="0" >
      <tr>
	    <th nowrap="nowrap">��ܰ����</th>
        <th nowrap="nowrap">��������</th>
        <th nowrap="nowrap">�������</th>
        <th nowrap="nowrap">�û�����</th>
        <th nowrap="nowrap">Ͷ�ߵ���</th>
        <th nowrap="nowrap">�û�Ʒ��</th>
        <th nowrap="nowrap">Ͷ�߷���</th>
        <th nowrap="nowrap">Ͷ�߼���</th>
        <th nowrap="nowrap">������</th>
        <th nowrap="nowrap">����ʱ��</th>
        <th nowrap="nowrap">Ҫ�����ʱ��</th>
		<th nowrap="nowrap">���˱�־</th>
      </tr>

<% 
if(retCode.equals("000000"))
{
%>

<wtc:array id="ret"  start="0" length="15"> 
<%

							for (int j = 0; j < ret.length; j++) {
							%>
						
							<TR  align="middle" id="row<%=ret[j][wanoIndex]%>"  onClick="trfunc1(this)"> 
						 
							
						
						<TD width="4%" align="center">
							 <% 
            			   if(ret[j][13].equals("-1")||ret[j][13].equals("0"))
  							{
						%>
               				 
								 <% 
            			   if(ret[j][14].equals("")||ret[j][14].equals("1")||ret[j][14].equals("0"))
  							{
						%>
               				 
							 &nbsp;
							 	<%
					
								}
							else
								{
						%>
							<img src="../../../callcenter/images/bc_flag.gif"  >
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
</div>
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
		 ������:<span class="F_blue"><%=totalRec%></span>
	     ��ҳ��:<span class="F_blue"><%=totalPage%></span>
		 ��ǰҳ:<span class="F_orange"><%=currPage%></span>
	     <a class=paginglink 
      onclick='return gotopage1("first",<%=totalRec%>,<%=totalPage%>,<%=currPage%>,false);' 
      href="#">��ҳ</a>
	     <a onclick='return gotopage1("before",<%=totalRec%>,<%=totalPage%>,<%=currPage%>,false);' 
      href="#" class="disabled">��һҳ</a>
	     <a class=paginglink onclick='return gotopage1("next",<%=totalRec%>,<%=totalPage%>,<%=currPage%>,false);' 
      href="#">��һҳ</a>
	     <a class=paginglink onclick='return gotopage1("end",<%=totalRec%>,<%=totalPage%>,<%=currPage%>,false);' 
      href="#">βҳ</a>
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
	            <TD align="left">������Ϣ��</TD>
			  	
			  	<TD align="left"><%=retMsg%></TD>
				
				<TD align="left">�������</TD>
				
			  	<TD align="left"><%=retCode%></TD>
			  	
			  </TR>
			</table>
			  
<%	
}

%>

<div class="tag"><span class="F_blue"><b>�ظ����ͼ����</b></span> 
  <%
 	String reply_type_desc_list[][] = {{"0","�������ظ�"},
		{"1","�ݰ��У����ظ�"},
		{"2","�ݰ��У�δ���ջظ�"},
		{"3","�ݰ���������ظ�"},
		{"10","���������ظ�"}
		}; 	
 	
 	for(int i = 1; i < reply_type_desc_list.length; i++)
 	{
  %>
    <img src="../../../callcenter/images/reply_type_<%= reply_type_desc_list[i][0] %>.gif" align="absmiddle"><%= reply_type_desc_list[i][1] %>; 
  <%
   	}
  %>
    <img src="../../../callcenter/images/dj_3.gif" align="absmiddle">��ʱ����; 
 </div> 
  

</form>
<script>

		
	function changeit1(obj)
	{
	var div1 = document.getElementById("query1div");
		if(obj.id=='b11')
		{
			//��ѯģʽ
			div1.style.display='block';
		}
		else if(obj.id=='b12')
		{
			div1.style.display='none';
		}
	}
	
	// obj �������ͣ�first--��ҳ next--��ҳ before--��ҳ end-βҳ
	//isfresh �Ƿ�ǿ��ˢ�� true--ǿ��ˢ�� false--��ǿ��
	function gotopage1(obj,totalrec,totalpage,currpage,isfresh)
{

  var result = checkpaging(obj,totalrec,totalpage,currpage);
  if(!isfresh)
	{
  if(result==-1) return;
  	form11.currPage.value=result;
  }
	else
	{
		form11.currPage.value=1;
	}
	
	var url='f_wb_4_01_part1.jsp';
	with(document.form11)
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
        alert('��������');
    },
    success: function(html){
    
    		var list1 = document.getElementById('listdiv1');
    		list1.innerHTML = html.replace('/\r/g','').replace('/\n/g','');
			 oldrow = -1;
		 nowrow = -1;
		 wono = -1;

    }
});

}

function condquery1()
{
//alert('in condquery1');
	gotopage1('first',<%=totalRec%>,<%=totalPage%>,<%=currPage%>,true);
}

function clearquery1()
{
	with(document.form11)
	{
	  for (var i=0;i<elements.length;i++){
	  	if(elements[i].type!='button')
	   	elements[i].value='';
	  }
	  elements['numsPerPage'].value='10';
  }
}
</script>
