<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>

<%

String wono = (String)request.getParameter("wono");
String wano = (String)request.getParameter("wano");

System.out.println("---------wono is:"+wono);

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
		o.style.background = " ";
	else
		o.style.background = "#CBEEFC";
}



</SCRIPT>

  <%@ include file="pub/head_view_wf.jsp" %>
	<script type="text/javascript" src="js/jquery.js"></script>
  <div id="Operation_Table">
  	<br>
  	���̲��裺
  	<br>
    <table width="98%" align="center" id="mainOne" bgcolor="#FFFFFF" cellspacing="1" border="0" >
      <tr bgcolor="#F5F5F5" >
        <td height="20">������</td>
        <td height="20">��������</td>
        <td height="20">����״̬</td>
        <td height="20">������</td>
        <td height="20">������ʼʱ��</td>
        <td height="20">��������ʱ��</td>
        <td height="20">�����������</td>
        <td height="20">������Ա����</td>
        <td height="20">����</td>
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
							 <TR bgcolor="#F5F5F5"  align="center" id="row<%=ret[j][0]%>"  type="<%=ret[j][7]%>" onClick="trfunc1(this)"> 
							 <%
						for (int k = 0; k < ret[j].length; k++) {

							%>
							 <TD align="left">
							 <%
							 	if(k==startTimeIndex||k==endTimeIndex)
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
						
						out.println("<td><font color='red' style='cursor:hand' onClick=\"javascript:return viewit('"+ret[j][0]+"')\">�鿴</font></td>");
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
  <br>
  ��������Ϣ(Ĭ�ϵ�ǰ����):
  <br>
  <div id='contenddiv' >
		<jsp:include page="f_wb_2_05.jsp" flush="true" />
	</div>
    <table width="98%" align="center" id="mainOne" bgcolor="#FFFFFF" cellspacing="1" border="0" >
      <TR bgcolor="#F5F5F5"  align="center">
        <TD align="center"><input name="close" onClick="window.close();" type="button" class="button" value="�� ��">
        </TD>
      </TR>
    </table>
  </div>
  
  <%@ include file="../../public/foot_view.jsp" %>
</BODY>
</HTML>
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
        alert('��������');
    },
    success: function(html){
    	//alert(html.replace('/\n/g','').replace('/\r/g',''));
			var cdiv = document.getElementById("contenddiv");
			cdiv.innerHTML=html.replace('/\n/g','').replace('/\r/g','');
    }
		});
	}
</script>