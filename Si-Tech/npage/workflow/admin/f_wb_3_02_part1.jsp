	<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>
<%
HashMap map1 = new HashMap();
map1.put("0","�쳣");
map1.put("1","����");
int wonoIndex = 1,statusIndex=8,wanoIndex=0,startTimeIndex=5,endTimeIndex=6;
 
		
		
		String totalPage = "0";
		String totalRec = "0";

//��ѯ����

		String currPage = request.getParameter("currPage")==null?"1":request.getParameter("currPage");
		
		String numsPerPage = request.getParameter("numsPerPage")==null?"10":request.getParameter("numsPerPage");
		String wo_name = request.getParameter("wo_name")==null?"":request.getParameter("wo_name");
		String begin_time = request.getParameter("begin_time")==null?"":request.getParameter("begin_time");
		String end_time = request.getParameter("end_time")==null?"":request.getParameter("end_time");
		String op_login = request.getParameter("op_login")==null?"":request.getParameter("op_login");
		
		StringBuffer conditionTmp = new StringBuffer();//��Ҫ��̬ƴ��
		if(!wo_name.equals(""))
		{
			conditionTmp.append("wo_name:").append(wo_name).append(",");
		}
		if(!begin_time.equals(""))
		{
			conditionTmp.append("begin_time:").append(begin_time.replaceAll("-","")).append(",");
		}
		if(!end_time.equals(""))
		{
			conditionTmp.append("end_time:").append(end_time.replaceAll("-","")).append(",");
		}
		if(!op_login.equals(""))
		{
			conditionTmp.append("op_login:").append(op_login).append(",");
		}
		String condition = conditionTmp.length()>0?conditionTmp.substring(0,conditionTmp.length()-1):"";
%>

<SCRIPT LANGUAGE="JavaScript">

function trfunc1(node){

    nowrow = parseInt(node.id.substring(3,node.id.length));
	 	type  = node.type ;
	  wono  = node.wono ;
    
    if(oldrow != nowrow){
    	if(oldrow != -1) rowClick("row" + oldrow,0);
    	rowClick("row" + nowrow,1);
    	oldrow = nowrow;
    }

	updateStatus();
	}

function updateStatus()
{

	if(type==0)
	{
	with(document.forms['form12'])
	{
		transmit.disabled=false;
		query.disabled=false;
		recWA.disabled=false;
		rollBack.disabled=false;
	}
	
	
	}
	if(type==1)
	{
	document.form12.transmit.disabled=false;
	document.form12.query.disabled=false;
	document.form12.recWA.disabled=true;
	document.form12.rollBack.disabled=true;

	}
    
}

</SCRIPT>

	 	<!--ģʽ-->
		<div align="right" id='mode1'>
			<font id='b11' style="color:green" onclick="changeit1(this)" >��ѯģʽ</font>|
			<font id='b12' style="color:red" onclick="changeit1(this)" >�б�ģʽ</font>
		</div>

  <div id="Operation_Table">
	  	<div id='query1div' style='display:none'>
	<form name='form11' method="post" >
		<input type='hidden' value='<%=currPage%>' name='currPage'>

		<table width="98%" align="center" id="mainOne" bgcolor="#FFFFFF" cellspacing="1" border="0" >
			<tr>
				
								<td height="20">
					���������ˣ�
				</td>
				<td height="20">
					<input type='text' value='<%=op_login%>' name='op_login'>
				</td>
					
				<td height="20">
					�������ƣ�
				</td>
				<td height="20">
					<input type='text' value='<%=wo_name%>' name='wo_name'>
				</td>
				<td height="20">
					������ʼʱ��(>=)��
				</td>
				<td height="20">
					<input type='text' value='<%=begin_time%>' readonly='true' name='begin_time' class="Wdate" onfocus='new WdatePicker(this)'>
	

				</td>
					
			</tr>			
			
						<tr>

				<td height="20">
					������ʼʱ��(<=)��
				</td>
				<td height="20">
	
					<input type='text' value='<%=end_time%>' readonly='true' name='end_time' class="Wdate" onfocus='new WdatePicker(this)'>
	
				</td>

				
				
				<td height="20">
					ÿҳ��¼������
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
					<input type='button' onclick='condquery1();' value='��ѯ'>&nbsp;&nbsp;&nbsp;
					<input type='button' onclick='clearquery1();' value='����'>
				</td>
					
			</tr>		
			
		</table>
	</form>
</div>
</div>


      <!------------------���÷���------------------>
      <%
      //String condition1=condition+(condition.length()>0?",":"")+"deal_flag:f";
      %>
	    <wtc:service name="sGetWA" outnum="14"  >
 			 <wtc:param value="4"/>
 			 <wtc:param value="<%=loginNo%>"/>
 			 <wtc:param value="<%=currPage%>"/>
 			 <wtc:param value="<%=numsPerPage%>"/>
 			 <wtc:param value="<%=condition%>"/>
  		</wtc:service>
  
<form name="form12" method="post">
    
  <div id="Operation_Table">
    <table width="98%" align="center" id="mainOne" bgcolor="#FFFFFF" cellspacing="1" border="0" >
      <TR bgcolor="#F5F5F5"  align="center">
        <TD align="center">
           <input name="transmit" onClick="transmit1()" type="button" class="button" value="�� ��">
          &nbsp;&nbsp;
          <input name="query" onClick="query1()" type="button" class="button" value="�� ��">
          &nbsp;&nbsp;
          <input name="recWA" onClick="recWA1()" type="button" class="button" value="�� ֹ">
          &nbsp;&nbsp;
          <input name="rollBack" onClick="rollBack1();" type="button" class="button" value="�� ��">

        </TD>
      </TR>
    </table>

      
    <table width="98%" align="center" id="mainOne" bgcolor="#FFFFFF" cellspacing="1" border="0" >
      <tr bgcolor="#F5F5F5" >
       <td height="20">������</td>
        <td height="20">������</td>
        <td height="20">����״̬</td>
        <td height="20">����ֵ</td>
        <td height="20">������ʼʱ��</td>
        <td height="20">��������ʱ��</td>
        <td height="20">������Ա</td>
        <td height="20">������Ա</td>
        <td height="20">�Ƿ��쳣</td>
      </tr>

<% 
if(retCode.equals("000000"))
{
%>

<wtc:array id="ret"  start="0" length="9"> 
<%

							for (int j = 0; j < ret.length; j++) {
							%>
							 <TR bgcolor="#F5F5F5"  align="center" id="row<%=ret[j][wanoIndex]%>"  type="<%=ret[j][statusIndex]%>" wono="<%=ret[j][wonoIndex]%>" onClick="trfunc1(this)"> 
							 <%
						for (int k = 0; k < ret[j].length; k++) {

							%>
							 <TD align="left" >
							 <%
							 if(k==statusIndex)
							{
								out.println(ret[j][k].equals("")?"&nbsp;":map1.get(ret[j][k]));
							}
							 else if(k==startTimeIndex)
							{
								out.println(ret[j][k].equals("")?"&nbsp;":ParseParaxml.FormatDate(ret[j][k],"yyyyMMddhhmmss","yyyy-MM-dd hh:mm:ss"));
							}
							else if(k==endTimeIndex)
							{
								out.println(ret[j][k].equals("")?"&nbsp;":ParseParaxml.FormatDate(ret[j][k],"yyyyMMddhhmmss","yyyy-MM-dd hh:mm:ss"));
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
       </div>
</wtc:array>

<wtc:array id="ret1"  start="9" length="2"> 
	<%
		totalRec = ret1[0][0];
		totalPage = ret1[0][1];
	%>
</wtc:array>


    	<div class='paging'>
    		������:<font style='color:red'><%=totalRec%></font>&nbsp;
    		��ҳ��:<font style='color:red'><%=totalPage%></font>&nbsp;
    		��ǰҳ:<font style='color:red'><%=currPage%></font>&nbsp;
  		[<a onclick='return gotopage1("first",<%=totalRec%>,<%=totalPage%>,<%=currPage%>,false);' >��ҳ</a>]&nbsp;&nbsp;
  		[<a onclick='return gotopage1("before",<%=totalRec%>,<%=totalPage%>,<%=currPage%>,false);' >��ҳ</a>]&nbsp;&nbsp;  		
  		[<a onclick='return gotopage1("next",<%=totalRec%>,<%=totalPage%>,<%=currPage%>,false);' >��ҳ</a>]&nbsp;&nbsp;
  		[<a onclick='return gotopage1("end",<%=totalRec%>,<%=totalPage%>,<%=currPage%>,false);' >βҳ</a>]&nbsp;&nbsp;
  	</div>
  	
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
	
	var url='f_wb_3_02_part1.jsp';
	with(document.form11)
	{
		para='&op_login='+op_login.value+'&wo_name='+wo_name.value+'&begin_time='+begin_time.value+'&end_time='
		+end_time.value+'&numsPerPage='+numsPerPage.value+'&currPage='+currPage.value;;
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
