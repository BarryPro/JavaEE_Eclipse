   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-18
********************/
%>
              
<%
  String opCode = "5240";
  String opName = "��Ʒ����";
%>              
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="java.text.*"%>
<%
	//��ȡ�û�session��Ϣ
	String workNo   = (String)session.getAttribute("workNo");                //����
	String nopass  = (String)session.getAttribute("password");                     	//��½����
	String regionCode= (String)session.getAttribute("regCode");
	
	String login_accept = request.getParameter("login_accept");
	String mode_code = request.getParameter("mode_code");
	String detail_code = request.getParameter("detail_code");
	String note = request.getParameter("note");	
	String region_code = request.getParameter("region_code");
 	String typeButtonNum = request.getParameter("typeButtonNum");
 	String totCode = request.getParameter("totCode");
 	
 	String errCode="";
    String errMsg="";
     	String errCode1="";
    String errMsg1="";
 	//��ȡ���е��Ż���Ϣ
	String[] paramsIn=new String[7];
	paramsIn[0]=workNo;
	paramsIn[1]=nopass;
	paramsIn[2]="5238";
	paramsIn[3]=login_accept;
	paramsIn[4]=region_code;
	paramsIn[5]=detail_code;
	paramsIn[6]=totCode;
	
	
	 String[] paramsIns=new String[6];
				paramsIns[0]=workNo;
				paramsIns[1]=nopass;
				paramsIns[2]="5238";
				paramsIns[3]=login_accept;
				paramsIns[4]=region_code;
				paramsIns[5]=detail_code;
				
				
				
	String[][] retArr_impTotCode =new String[][]{};
	//retArray=callView.callFXService("s5238_TotShw",paramsIn,"15");	
	%>
	
    <wtc:service name="s5238_TotShw" outnum="15" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />
			<wtc:param value="<%=paramsIn[3]%>" />
			<wtc:param value="<%=paramsIn[4]%>" />
			<wtc:param value="<%=paramsIn[5]%>" />
			<wtc:param value="<%=paramsIn[6]%>" />
		</wtc:service>
		<wtc:array id="result_t1" scope="end"  />	
			
			
			<wtc:service name="s5238_TotConShw" outnum="10" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIns[0]%>" />
			<wtc:param value="<%=paramsIns[1]%>" />
			<wtc:param value="<%=paramsIns[2]%>" />
			<wtc:param value="<%=paramsIns[3]%>" />
			<wtc:param value="<%=paramsIns[4]%>" />
			<wtc:param value="<%=paramsIns[5]%>" />					
		</wtc:service>
		<wtc:array id="result_t" scope="end"  />	
					
	
	<%

	//��ѯ�Ѿ����õ��Ż���Ϣ
	String sql_impTotCode = "SELECT order_code FROM sBillTotCode WHERE region_code = '"+ region_code +"' and total_code = '" + detail_code + "' order by order_code";
	//ret_impTotCode = impTotCode.sPubSelect("1",sql_impTotCode,"region",regionCode);
%>

		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sql_impTotCode%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t2" scope="end"/>

<%	
		if(code2.equals("000000")&&result_t2.length>0)
	 retArr_impTotCode = result_t2;

%>  
    
<html>
<head>
<base target="_self">
<title>�ʵ��Ż�������Ϣ�鿴</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript"> 
    
function showThisTotOrder()
{
	
		var totOrder="";
	  for(var i=0;i<document.all.totOrder.length;i++)
	  {
		  if(document.all.totOrder[i].checked == true)
		  {
			  totOrder=document.all.totOrder[i].value;
		  }
	  }
	//alert(totOrder);
	document.form1.action = "f5238_showTotCode.jsp?login_accept=<%=login_accept%>&detail_code=<%=detail_code%>&note=<%=note%>&typeButtonNum=<%=typeButtonNum%>&region_code=<%=region_code%>&totCode=" + totOrder;
	document.form1.submit();
}

</script>
</head>

<body    onMouseDown="hideEvent()" onKeyDown="hideEvent()">
		  <form name="form1"  method="post">
		  	<%@ include file="/npage/include/header_pop.jsp" %>                         

	  <input type="hidden" name="login_accept" value="<%=login_accept%>">
	  <input type="hidden" name="detail_code" value="<%=detail_code%>">
	  <input type="hidden" name="note" value="<%=note%>">
	  <input type="hidden" name="region_code" value="<%=region_code%>">
	  <input type="hidden" name="typeButtonNum" value="<%=typeButtonNum%>">


	<div class="title">
		<div id="title_zi">�ʵ��Ż�������Ϣ�鿴</div>
	</div>
  
	  		  	<TABLE  id="mainOne"   cellspacing="0" >
	            <TBODY>
	  				<tr >
	  					<TD height="22" class="blue">&nbsp;&nbsp;�Żݴ���</TD>
	  					<TD>
	  						<%=detail_code%>
	  					</TD>
	  					<TD height="22" class="blue">&nbsp;&nbsp;�Ż�����</TD>
	  					<TD>
	  						<%=note%>
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;�Ż�˳��</TD>
	  					<TD colspan="3" height="22">
	  						<% for(int i=0; i<retArr_impTotCode.length; i++){%> 
	  						<input type="radio" name="totOrder" <% if(retArr_impTotCode[i][0].equals(totCode))out.println("checked");%> value="<%=retArr_impTotCode[i][0]%>" onClick="showThisTotOrder()">���(<%=retArr_impTotCode[i][0]%>)</input>
	  						<% } %>
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD valign="top" height="25" class="blue">&nbsp;&nbsp;�Ż���Ŀ��</TD>
	  					<TD colspan="3">
	  						<input type="checkbox" name="favour_object" value="*" <%=result_t1[0][1].equals("*")==true?"checked":""%>>ȫ��<br>
	  						һ����Ŀ��<input type=text v_type="string" v_must="0" v_minlength=0 v_maxlength=246 v_name="һ����Ŀ��" name=first_favour_object maxlength=246 size="80" readonly Class="InputGrey"></input><br>
	  						������Ŀ��<input type=text  v_type="string" v_must="0" v_minlength=0 v_maxlength=246 v_name="������Ŀ��" name=second_favour_object maxlength=246 size="80" readonly  Class="InputGrey" value=<%=result_t1[0][1].equals("*")==true?"":result_t1[0][1]%>></input>
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;�Żݷ�ʽ</TD>
	  					<TD colspan="3">
	  						<input type="radio" name="favour_type" value="0" <%=result_t1[0][2].equals("0")?"checked":""%>>�ͷ�
	  						<input type="radio" name="favour_type" value="1" <%=result_t1[0][2].equals("1")?"checked":""%>>����
	  						<input type="radio" name="favour_type" value="3" <%=result_t1[0][2].equals("3")?"checked":""%>>����
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;�ͷѷ�ʽ</TD>
	  					<TD colspan="3">
	  						<input type="radio" name="type_mode" value="0" <%=result_t1[0][3].equals("0")?"checked":""%>>����ͷ�
	  						<input type="radio" name="type_mode" value="1" <%=result_t1[0][3].equals("1")?"checked":""%>>�����ͷ�
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;�Ż�����</TD>
	  					<TD colspan="3" height="22">
	  						<%=result_t1[0][4].equals("")?"1":result_t1[0][4]%> 
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;���ڵ�λ</TD>
	  					<TD colspan="3">
	  						<input type="radio" name="cycle_unit" value="2" <%=result_t1[0][5].equals("2")?"checked":""%>>������
	  						<input type="radio" name="cycle_unit" value="3" <%=result_t1[0][5].equals("3")?"checked":""%>>��
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD width="15%" height="22" class="blue">&nbsp;&nbsp;STEP_VAL1</TD>
	  					<TD width="35%">
	  						<%=result_t1[0][6].equals("")?"0":result_t1[0][6]%>
	  					</TD>
	  					<TD width="15%"  class="blue">&nbsp;&nbsp;FAVOUR1</TD>
	  					<TD width="35%">
	  						<%=result_t1[0][7].equals("")?"0":result_t1[0][7]%>
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD width="15%" height="22" class="blue">&nbsp;&nbsp;STEP_VAL2</TD>
	  					<TD width="35%">
	  						<%=result_t1[0][8].equals("")?"0":result_t1[0][8]%>
	  					</TD>
	  					<TD width="15%" class="blue">&nbsp;&nbsp;FAVOUR2</TD>
	  					<TD width="35%">
	  						<%=result_t1[0][9].equals("")?"0":result_t1[0][9]%>
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD width="15%" height="22" class="blue">&nbsp;&nbsp;STEP_VAL3</TD>
	  					<TD width="35%">
	  						<%=result_t1[0][10].equals("")?"0":result_t1[0][10]%>
	  					</TD>
	  					<TD width="15%" class="blue">&nbsp;&nbsp;FAVOUR3</TD>
	  					<TD width="35%">
	  						<%=result_t1[0][11].equals("")?"0":result_t1[0][11]%>
	  					</TD>
	  				</tr>
	            </TBODY>
	          	</TABLE>
	  			<table id="mainThree" cellspacing="0">
	  				<tr  height="25">
	  					<Th align="center" width="12%">�Ż���������</th>
	  					<Th align="center" width="8%">�Ż�˳��</th>
	  					<Th align="center" width="12%">�Ż�����˳��</th>
	  					<Th align="center" width="8%">������ϵ</th>
	  					<Th align="center" width="27%">�Ż�����</th>
	  					<Th align="center" width="15%">��������</th>
	  					<Th align="center" width="10%">��ϵ���ʽ</th>
	  					<Th align="center" width="8%">��ֵ</th>
	  				</tr>
				<%
				errCode1 = code;
				errMsg1 = msg;
				if(errCode1.equals("000000"))
				{
					String sOut_favcond_type_name="";
					for(int i=0;i<result_t.length;i++)
					{
						if(result_t[i][4].equals("0"))
						{
							sOut_favcond_type_name="0-���»���";
						}
						else if(result_t[i][4].equals("9"))
						{
							sOut_favcond_type_name="9-�����Ż�";
						}
						else if(result_t[i][4].equals("3"))
						{
							sOut_favcond_type_name="3-�û�����";
						}
						else if(result_t[i][4].equals("2"))
						{
							sOut_favcond_type_name="2-������Ϣ";
						}
						else if(result_t[i][4].equals("5"))
						{
							sOut_favcond_type_name="5-�µ��Ż�";
						}
							if(i%2==0){
				%> 
					<tr  height="20">
                		<td align="center" width="89" height="20" Class="Grey"><%=sOut_favcond_type_name%></td>
                		<td align="center" width="59" height="20" Class="Grey"><%=result_t[i][2]%></td>
                		<td align="center" width="90" height="20" Class="Grey"><%=result_t[i][3]%></td>
                		<td align="center" width="59" height="20" Class="Grey"><%=result_t[i][9]%></td>
                		<td align="left" width="199" height="20" Class="Grey"><%=result_t[i][5]%></td>
                		<td align="left" width="110" height="20" Class="Grey"><%=result_t[i][6]%></td>
                		<td align="center" width="76" height="20" Class="Grey"><%=result_t[i][7]%></td>
                		<td align="center" width="41" height="20"  Class="Grey"><%=result_t[i][8]%></td>
			    	</tr>
			    	<%
			    	}
			    	
			    else{
			    	%>
			    						<tr  height="20">
                		<td align="center" width="89" height="20" Class=""><%=sOut_favcond_type_name%></td>
                		<td align="center" width="59" height="20" Class="" ><%=result_t[i][2]%></td>
                		<td align="center" width="90" height="20"  Class=""><%=result_t[i][3]%></td>
                		<td align="center" width="59" height="20" Class="" ><%=result_t[i][9]%></td>
                		<td align="left" width="199" height="20" Class=""><%=result_t[i][5]%></td>
                		<td align="left" width="110" height="20" Class=""><%=result_t[i][6]%></td>
                		<td align="center" width="76" height="20" Class="" ><%=result_t[i][7]%></td>
                		<td align="center" width="41" height="20"  Class=""><%=result_t[i][8]%></td>
			    	</tr>
			    	
			    	<%
			    	}
					}	
				}
				else
				{	
				%>        
					<script language="javascript">
						rdShowMessageDialog("������룺<%=errCode%>,������Ϣ��<%=errMsg%>",0);
					</script>       
				<%            
				}
			
				%>               	
	          	</TABLE>
	          	<TABLE  cellSpacing="0">
	  			  <TR >
	  				<TD height="30" align="center" id="footer">
	          	 	    <input name="reset" type="button" class="b_foot" value="����" onClick="window.close()" >
	  				</TD>
	  			  </TR>
	  	    	</TABLE>
	  
	  	<%@ include file="/npage/include/footer_pop.jsp" %>
	  </form>
 
</body>
</html>

