<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-19
********************/
%>
              
<%
  String opCode = "5238";
  String opName = "���˲�Ʒ����";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
	
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.text.*"%>
<%
	//��ȡ�û�session��Ϣ
	String workNo   = (String)session.getAttribute("workNo");               //����
	String org_code = (String)session.getAttribute("orgCode");
	String ip_Addr  = (String)session.getAttribute("ipAddr");
	String nopass  = (String)session.getAttribute("password");                 	//��½����
	String regionCode= (String)session.getAttribute("regCode");
	
	//��ȡ����ҳ�õ�����Ϣ
	String login_accept = request.getParameter("login_accept");	
	String mode_code = request.getParameter("mode_code");
	String mode_name = request.getParameter("mode_name");	
	String region_code = request.getParameter("region_code");
	String sm_code = request.getParameter("sm_code");
	String begin_time = request.getParameter("begin_time");	
	String end_time = request.getParameter("end_time");	
	String op_note= "����Ա:"+workNo+"�Բ�Ʒ:"+mode_code+"���и��˲�Ʒ���ò���";  

	String errCode="";
    String errMsg="";
	String[] acceptList = null;
	
	String  paramsIn[] = new String[7];
	paramsIn[0]=workNo;
	paramsIn[1]=nopass;
	paramsIn[2]="5238";
	paramsIn[3]=login_accept;
	paramsIn[4]=org_code;
	paramsIn[5]=ip_Addr;
	paramsIn[6]=op_note;
	
	//acceptList = impl.callService("s5238_5Cfm",paramsIn,"10");
%>


    <wtc:service name="s5238_5Cfm" outnum="10" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />
			<wtc:param value="<%=paramsIn[3]%>" />
			<wtc:param value="<%=paramsIn[4]%>" />
			<wtc:param value="<%=paramsIn[5]%>" />				
			<wtc:param value="<%=paramsIn[6]%>" />					
		</wtc:service>
		<wtc:array id="result_t" scope="end"  />

<%	
	errCode=code;   
	errMsg=msg;
	
	if(!errCode.equals("000000"))
    {
%>
        <script language='javascript'>
        	rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
	        history.go(-1);
        </script>
<%	}     					 
%>
<%
  //�����ʷ�������Ϣ
  String[][] result1 = new String[][]{};
  String sqlStr1 = "select note from tMidBillModeCode where login_accept="+login_accept;
  %>
  
  		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr1%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t3" scope="end"/>
  
  <%
 // retArray1 = impl.sPubSelect("1", sqlStr1);
 
  if(result_t3.length>0&&code1.equals("000000"))
   result1 = result_t3;
  String vModeNote = result1[0][0];

%>
   

<html>
<head>
<base target="_self">
<title>���˲�Ʒ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript"> 

function showChange()
{
	var url = "f5238_showChange.jsp?login_accept=<%=login_accept%>&mode_code=<%=mode_code%>&mode_name=<%=mode_name%>&region_code=<%=region_code%>";
	escape(url);
	window.open(url,'','height=600,width=800,left=30,top=30,scrollbars=yes');
}

function showDepend()
{
	var url = "f5238_showDepend.jsp?login_accept=<%=login_accept%>&mode_code=<%=mode_code%>&mode_name=<%=mode_name%>&region_code=<%=region_code%>";
	escape(url);
	window.open(url,'','height=600,width=800,left=30,top=30,scrollbars=yes');
}

function showLimit()
{
	var url = "f5238_showLimit.jsp?login_accept=<%=login_accept%>&mode_code=<%=mode_code%>&mode_name=<%=mode_name%>&region_code=<%=region_code%>";
	escape(url);
	window.open(url,'','height=600,width=800,left=30,top=30,scrollbars=yes');
}
function showDetailCode(apply_flag,detail_type,detail_code,note,typeButtonNum,region_code)
{
	var apply_flag =apply_flag;
	var detail_type =detail_type;
	var detail_code =detail_code;
	var note =note;
	var typeButtonNum=typeButtonNum;
	var region_code=region_code;
	
	if(detail_type=='0')
	{
		var url = "f5238_showRateCode.jsp?login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&typeButtonNum="+typeButtonNum+"&region_code="+region_code;
		escape(url);
		window.open(url,'','height=600,width=900,left=60,top=60,scrollbars=yes');                                     
	}                                                             
	else if(detail_type=='1'||detail_type=='9')                                     
	{                                                             
		var url = "f5238_showMonthCode.jsp?login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&typeButtonNum="+typeButtonNum+"&region_code="+region_code;
		escape(url);
		window.open(url,'','height=600,width=900,left=60,top=60,scrollbars=yes');
	}
	else if(detail_type=='2'||detail_type=='b')
	{
		var url = "f5238_showTotCode.jsp?login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&typeButtonNum="+typeButtonNum+"&region_code="+region_code + "&totCode=0";
		escape(url);
		window.open(url,'','height=600,width=900,left=60,top=60,scrollbars=yes');
	}
	else if(detail_type=='4')
	{
		var url = "f5238_showFuncFav.jsp?login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&typeButtonNum="+typeButtonNum+"&region_code="+region_code+"&sm_code=<%=sm_code%>";
		escape(url);
		window.open(url,'','height=600,width=900,left=60,top=60,scrollbars=yes');
	}
	else if(detail_type=='3')
	{
		var url = "f5238_showBillFav.jsp?login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&typeButtonNum="+typeButtonNum+"&region_code="+region_code+"&sm_code=<%=sm_code%>";
		escape(url);
		window.open(url,'','height=600,width=900,left=60,top=60,scrollbars=yes');
	}else if(detail_type=='a')
	{
		var url = "f5238_showFuncBind.jsp?login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&typeButtonNum="+typeButtonNum+"&region_code="+region_code+"&sm_code=<%=sm_code%>";
		escape(url);
		window.open(url,'','height=600,width=900,left=60,top=60,scrollbars=yes');
	}
		
	
}
</script>
</head>

<body  onMouseDown="hideEvent()" onKeyDown="hideEvent()">

	  <form name="form1"  method="post">
	  		<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">���˲�Ʒ����-���</div>
	</div>
 
	  		  	<TABLE  id="mainOne"  cellspacing="0"  >
	            <TBODY>
	            	<!--TR  height="20">
	  					<TD colspan="2" align="center">��Ʒ���õ���</b></TD>
	  	        	</TR-->
	  	        	<TR >
	  					<TD width="23%" valign="top">
	  						<table width="100%"  id="mainTwo"  cellspacing="0" >
	  							<tr  height="25">
	  								<TD >&nbsp;&nbsp;&nbsp;&nbsp;��Ʒ���ò���</b></TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD>&nbsp;&nbsp;&nbsp;&nbsp;1.���ò�Ʒ����</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD>&nbsp;&nbsp;&nbsp;&nbsp;2.���ò�Ʒ��ϸ</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD>&nbsp;&nbsp;&nbsp;&nbsp;3.�ʷѹ�������</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD>&nbsp;&nbsp;&nbsp;&nbsp;4.���ػ�����</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD>&nbsp;&nbsp;&nbsp;&nbsp;5.��Ʒ��ϵ����</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD>&nbsp;&nbsp;&nbsp;&nbsp;<font class="orange">6.���</font></TD>
	  							</tr>
	  						</table>
	  					</TD>
	  					<TD width="77%" valign="top">
	  						<table id="mainThree" cellspacing="0" >
	  							<tr  height="22">
	  								<TD width="25%" class="blue">&nbsp;&nbsp;��ǰ������ˮ��</TD>
	  								<TD width="75%" colspan="4"><font class="orange"><%=login_accept%></font></TD>
	  							</tr>
	  						</table>
	  						<table  id="mainThree"  cellspacing="0">
	  							<tr  height="22">
	  								<TD colspan="4" class="blue">����Ʒ������Ϣ��</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD width="15%" class="blue">&nbsp;&nbsp;��Ʒ����</TD>
	  								<TD width="35%">
	  									<%=mode_code%>
	  								</TD>
	  								<TD width="15%" class="blue">&nbsp;&nbsp;��Ʒ����</TD>
	  								<TD width="35%">
	  									<%=mode_name%>
	  								</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD class="blue">&nbsp;&nbsp;��ʼʱ��</TD>
	  								<TD>
	  									<%=begin_time%>
	  								</TD>
	  								<TD class="blue">&nbsp;&nbsp;����ʱ��</TD>
	  								<TD>
	  									<%=end_time%>
	  								</TD>
	  							</tr>
								<tr  height="22">
	  								<TD class="blue">&nbsp;&nbsp;��Ʒ����</TD>
	  								<TD colspan=3>
	  									<%=vModeNote%>
	  								</TD>
	  							</tr>
	  						</table>
	  						<table  id="mainThree" cellspacing="0" >
	  							<tr  height="22">
	  								<TD colspan="6">����Ʒ�����Ϣ��</TD>
	  							</tr>
	  							<tr  height="22">
	  								<Th align="center" width="12%">�Żݴ���</Th>
	  								<Th align="center" width="12%">�Ż�����</Th>
	  								<Th align="center" width="12%">��ʼʱ��</Th>
	  								<Th align="center" width="12%">����ʱ��</Th>
	  								<Th align="center" width="36%">�Ż�����</Th>
	  								<Th align="center" width="16%">�ʷѹ���</Th>
	  							</tr>
	  							<%
	  							 String	sqlStrs1 ="SELECT detail_code,a.detail_type,fav_order,mode_time,time_flag,time_cycle,time_unit,note,to_char(sysdate,'yyyymmdd'),to_char(sysdate,'yyyymmdd'),b.type_name,a.region_code FROM sBillModedetail a ,sbilldetname b WHERE a.detail_type=b.detail_type and a.region_code='"+region_code+"' and a.mode_code='"+mode_code+"' order by a.detail_code asc";

	  							%>
	  							
 <wtc:pubselect name="sPubSelect" outnum="12" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStrs1%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>
 	<%  
 						String retListString1[][] = new String[][]{};
 						if(code1.equals("000000")&&result_t.length>0)
 						retListString1 = result_t;
	  				for(int i=0;i < retListString1.length;i ++)
					{
	  			%>
	  					<tr   height="22" >
	  						<TD width="71" align="center"><%=retListString1[i][0]%></TD>
	  						<TD width="76" align="center"><%=retListString1[i][10]%></TD>
	  						<TD width="70" align="center"><%=retListString1[i][8]%></TD>
	  						<TD width="70" align="center"><%=retListString1[i][9]%></TD>
	  						<TD width="202"><%=retListString1[i][7]%></TD>
	  						<TD width="52"><input type="button" name="typeButton<%=i%>" value="�ʷ���Ϣ" class="b_text" onclick="showDetailCode('<%=retListString1[i][10]%>','<%=retListString1[i][1]%>','<%=retListString1[i][0]%>','<%=retListString1[i][7]%>','<%=i%>','<%=retListString1[i][11]%>')"></TD>
	  					</tr>
	  			<%
	  				}
	  			%>        
	  						</table>
	  						<table   id="mainThree"  cellspacing="0"  >
	  							<tr  height="22">
	  								<TD colspan="2" class="blue">�����ػ���Ϣ��</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD width="50%" class="blue">&nbsp;&nbsp;HLE���ػ�</TD>
	  								<TD width="50%" class="blue">&nbsp;&nbsp;���������ػ�</TD>
	  							</tr>
	  						</table>
	  						<table  id="mainThree"  cellspacing="0" >
	  							<tr  height="22">
	  								<TD colspan="3" class="blue">����Ʒ��ϵ��Ϣ��</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD>
	  									<input name="lastButton" type="button" class="b_text" value="���ò�Ʒ�������" onClick="showChange();">
	  								</TD>
	  								<TD>
	  									<input name="lastButton" type="button" class="b_text"  value="���ò�Ʒ��������" onClick="showDepend();">
	  								</TD>
	  								<TD>
	  									<input name="lastButton" type="button" class="b_text"  value="���ò�Ʒ�������" onClick="showLimit();">
	  								</TD>
	  							</tr>
	  						</table>
	  						<TABLE  cellSpacing="0">
	  						  <TR >
	  							<TD height="28">
	          				 	    &nbsp;&nbsp;<font class="orange">��ʾ��Ʒ������ɣ����μ���ˮ��<%=login_accept%></font>
	  							</TD>
	  						  </TR>
	  	    				</TABLE>
	  					</TD>
	  	        	</TR> 
	            </TBODY>
	          	</TABLE>
	          	<TABLE  cellSpacing="">
	  			  	<TR >
	  					<TD height="30" align="center" id="footer">
	          	 		    <input name="lastButton" type="button" class="b_foot" value="���" onClick="removeCurrentTab()">
	  					</TD>
	  			  	</TR>
	  	    	</TABLE>
	  	<%@ include file="/npage/include/footer.jsp" %>
	  </form>
</body>
</html>

