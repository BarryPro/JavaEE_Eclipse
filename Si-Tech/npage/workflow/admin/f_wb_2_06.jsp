<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">

<%@ include file="/npage/workflow/admin/pub/wb_include.jsp" %>

<%
	String opCode = "7453";
		   opName = "��������";
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
		<div id="title_zi">������Ϣ</div>
  </div>
    <table cellspacing="0">
      <tr align="center" >
        <th nowrap>������</th>
        <th nowrap>��������</th>
        <th nowrap>����״̬</th>
        <th nowrap>������</th>
        <th nowrap>������ʼʱ��</th>
        <th nowrap>��������ʱ��</th>
        <th nowrap>�����������</th>
        <th nowrap>������Ա����</th>
       <!-- <th nowrap>����</th> -->
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
						//out.println("<td><font color='red' style='cursor:hand' onClick=\"javascript:return viewit('"+ret[j][0]+"')\">�鿴</font></td>");
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
	            <TD align="left">������Ϣ��</TD>
			  	
			  	<TD align="left"><%=retMsg%></TD>
				
				<TD align="left">�������</TD>
				
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
        rdShowMessageDialog('��������',0);
    },
    success: function(html){
    	//alert(html.replace('/\n/g','').replace('/\r/g',''));
			var cdiv = document.getElementById("contenddiv");
			cdiv.innerHTML=html.replace('/\n/g','').replace('/\r/g','');
			//ȡ�����ť����ʾ
			disablecommand();
    }
		});
	}
	
	//ȡ���������ʾ
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
  		������ϢԤ��(Ĭ�ϵ�ǰ����):
	  </font>
  <br>
  <div id='contenddiv' >

		
	</div>
	
		<table width="98%" align="center" id="mainOne" bgcolor="#FFFFFF" cellspacing="0" border="0" >
			<TR bgcolor="#F5F5F5"  align="center">
        		<TD align="center"><input name="close" onClick="window.close();" type="button" class="b_foot" value="�� ��">
        		</TD>
			</TR>
		</table>
  </div>
  <%@ include file="/npage/include/footer.jsp" %>	
</BODY>
</HTML>
