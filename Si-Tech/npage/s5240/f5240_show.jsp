   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-17
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
<%@ page import = "java.util.*" %>
<%@ page import="java.text.*"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<%
	//��ȡ�û�session��Ϣ
	
	//��ȡ����ҳ�õ�����Ϣ
	String login_accept = request.getParameter("login_accept");	
	String mode_code = request.getParameter("mode_code");
	String mode_name = request.getParameter("mode_name");	
	String region_code = request.getParameter("region_code");
	String sm_code = request.getParameter("sm_code");
	String begin_time = request.getParameter("begin_time");	
	String end_time = request.getParameter("end_time");	 
  String regionCode = (String)session.getAttribute("regCode");
  String retListString1[][] = new String[][]{};
  String sqlStr1 ="SELECT detail_code,a.detail_type,fav_order,mode_time,time_flag,time_cycle,time_unit,note,to_char(sysdate,'yyyymmdd'),'20500101',b.type_name,a.region_code FROM sBillModedetail a ,sbilldetname b WHERE a.detail_type=b.detail_type and a.region_code='"+region_code+"' and a.mode_code='"+mode_code+"' order by a.detail_code asc";   					 
%>

		<wtc:pubselect name="sPubSelect" outnum="12" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr1%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t2" scope="end"/>

<% 	
	if(result_t2.length>0&&code.equals("000000"))
 	retListString1 = result_t2;

%>
<html>
<head>
<base target="_self">
<title>���˲�Ʒ�������</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript"> 
	
	
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
		var url = "<%=request.getContextPath()%>/npage/s5238/f5238_showRateCode.jsp?login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&typeButtonNum="+typeButtonNum+"&region_code="+region_code;
		window.open(url,'','height=600,width=500,left=60,top=60,scrollbars=yes');                                     
	}                                                             
	else if(detail_type=='1'||detail_type=='9')                                     
	{                                                             
		var url = "<%=request.getContextPath()%>/npage/s5238/f5238_showMonthCode.jsp?login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&typeButtonNum="+typeButtonNum+"&region_code="+region_code;
		window.open(url,'','height=600,width=500,left=60,top=60,scrollbars=yes');
	}
	else if(detail_type=='2'||detail_type=='b')
	{
		var url = "<%=request.getContextPath()%>/npage/s5238/f5238_showTotCode.jsp?login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&typeButtonNum="+typeButtonNum+"&region_code="+region_code+"&totCode=0";
		window.open(url,'','height=600,width=888,left=60,top=60,scrollbars=yes');
	}
	else if(detail_type=='4')
	{
		var url = "<%=request.getContextPath()%>/npage/s5238/f5238_showFuncFav.jsp?login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&typeButtonNum="+typeButtonNum+"&region_code="+region_code+"&sm_code=<%=sm_code%>";
		window.open(url,'','height=600,width=500,left=60,top=60,scrollbars=yes');
	}else if(detail_type=='3')
	{
		var url = "<%=request.getContextPath()%>/npage/s5238/f5238_showBillFav.jsp?login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&typeButtonNum="+typeButtonNum+"&region_code="+region_code+"&sm_code=<%=sm_code%>";
		escape(url);
		window.open(url,'','height=600,width=1500,left=60,top=60,scrollbars=yes');
	}	
	else if(detail_type=='a')
	{
		var url = "<%=request.getContextPath()%>/npage/s5238/f5238_showFuncBind.jsp?login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&typeButtonNum="+typeButtonNum+"&region_code="+region_code+"&sm_code=<%=sm_code%>";
		window.open(url,'','height=600,width=488,left=60,top=60,scrollbars=yes');
	}	
}


function showChange()
{
	var url = "<%=request.getContextPath()%>/npage/s5238/f5238_showChange.jsp?login_accept=<%=login_accept%>&mode_code=<%=mode_code%>&mode_name=<%=mode_name%>&region_code=<%=region_code%>";
	escape(url);
	window.open(url,'','height=600,width=800,left=30,top=30,scrollbars=yes');
}

function showDepend()
{
	var url = "<%=request.getContextPath()%>/npage/s5238/f5238_showDepend.jsp?login_accept=<%=login_accept%>&mode_code=<%=mode_code%>&mode_name=<%=mode_name%>&region_code=<%=region_code%>";
	escape(url);
	window.open(url,'','height=600,width=800,left=30,top=30,scrollbars=yes');
}

function showLimit()
{
	var url = "<%=request.getContextPath()%>/npage/s5238/f5238_showLimit.jsp?login_accept=<%=login_accept%>&mode_code=<%=mode_code%>&mode_name=<%=mode_name%>&region_code=<%=region_code%>";
	escape(url);
	window.open(url,'','height=600,width=800,left=30,top=30,scrollbars=yes');
}

</script>
</head>

<body  onMouseDown="hideEvent()" onKeyDown="hideEvent()">

      	  <form name="form1"  method="post">
      	  	<%@ include file="/npage/include/header_pop.jsp" %>                         


	<div class="title">
		<div id="title_zi">���˲�Ʒ�������</div>
	</div>


	  						<table  id="mainThree"  cellSpacing="0">
	  							<tr  height="22">
	  								<TD width="15%" class="blue">&nbsp;&nbsp;��ǰ������ˮ��&nbsp;&nbsp; <font class="orange"><%=login_accept%></font></TD>
	  							</tr>
	  						</table>
	  						<table  id="mainThree"  cellSpacing="0">
	  							<tr  height="22">
	  								<TD colspan="4" class="blue">����Ʒ������Ϣ��</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD width="15%" class="blue">&nbsp;&nbsp;��Ʒ����</TD>
	  								<TD width="35%">
	  									&nbsp;<%=mode_code%>
	  								</TD>
	  								<TD width="15%" class="blue">&nbsp;&nbsp;��Ʒ����</TD>
	  								<TD width="35%">
	  									&nbsp;<%=mode_name%>
	  								</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD class="blue">&nbsp;&nbsp;��ʼʱ��</TD>
	  								<TD>
	  									&nbsp;<%=begin_time%>
	  								</TD>
	  								<TD  class="blue">&nbsp;&nbsp;����ʱ��</TD>
	  								<TD>
	  									&nbsp;<%=end_time%>
	  								</TD>
	  							</tr>
	  						</table>
	  						<table id="mainThree" cellSpacing="0">
	  							<tr  height="22">
	  								<TD colspan="6" class="blue">����Ʒ�����Ϣ��</TD>
	  							</tr>
	  							<tr  height="22">
	  								<th>�Żݴ���</th>
	  								<th>�Ż�����</th>
	  								<th>��ʼʱ��</th>
	  								<th>����ʱ��</th>
	  								<th>�Ż�����</th>
	  								<th>�ʷѹ���</th>
	  							</tr>
	  								<%  
	  				for(int i=0;i < retListString1.length;i ++)
					{
						if(i%2==0){
	  			%>
	  					<tr  height="22" >
	  						<TD width="89" align="center" Class="Grey"><%=retListString1[i][0]%></TD>
	  						<TD width="92" align="center" Class="Grey"><%=retListString1[i][10]%></TD>
	  						<TD width="89" align="center" Class="Grey"><%=retListString1[i][8]%></TD>
	  						<TD width="89" align="center" Class="Grey"><%=retListString1[i][9]%></TD>
	  						<TD width="269" Class="Grey"><%=retListString1[i][7]%></TD>
	  						<TD width="97" Class="Grey"><input type="button" name="typeButton<%=i%>" value="�ʷ���Ϣ" class="b_text" onclick="showDetailCode('<%=retListString1[i][10]%>','<%=retListString1[i][1]%>','<%=retListString1[i][0]%>','<%=retListString1[i][7]%>','<%=i%>','<%=retListString1[i][11]%>')"></TD>
	  					</tr>
	  			<%
	  				}
	  			else{%>
	  				
	  			<tr  height="22" >
	  						<TD width="89" align="center" Class=""><%=retListString1[i][0]%></TD>
	  						<TD width="92" align="center" Class=""><%=retListString1[i][10]%></TD>
	  						<TD width="89" align="center" Class=""><%=retListString1[i][8]%></TD>
	  						<TD width="89" align="center" Class=""><%=retListString1[i][9]%></TD>
	  						<TD width="269" Class=""><%=retListString1[i][7]%></TD>
	  						<TD width="97" Class=""><input type="button" name="typeButton<%=i%>" value="�ʷ���Ϣ" class="b_text" onclick="showDetailCode('<%=retListString1[i][10]%>','<%=retListString1[i][1]%>','<%=retListString1[i][0]%>','<%=retListString1[i][7]%>','<%=i%>','<%=retListString1[i][11]%>')"></TD>
	  					</tr>	
	  			
	  			<%	
	  				}
	  				}
	  			%>         
	  							
	  						</table>
	  						<table  id="mainThree" cellSpacing="0">
	  							<tr  height="22">
	  								<TD colspan="2" class="blue">�����ػ���Ϣ��</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD width="50%" class="blue">&nbsp;&nbsp;HLE���ػ�</TD>
	  								<TD width="50%" class="blue">&nbsp;&nbsp;���������ػ�</TD>
	  							</tr>
	  						</table>
	  						<table id="mainThree"   cellSpacing="0">
	  							<tr  height="22">
	  								<TD colspan="3" class="blue">����Ʒ��ϵ��Ϣ��</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD>
	  									<input name="lastButton" type="button" class="b_text" value="���ò�Ʒ�������" onClick="showChange();">
	  								</TD>
	  								<TD>
	  									<input name="lastButton" type="button" class="b_text" value="���ò�Ʒ��������" onClick="showDepend();">
	  								</TD>
	  								<TD>
	  									<input name="lastButton" type="button" class="b_text" value="���ò�Ʒ�������" onClick="showLimit();">
	  								</TD>
	  							</tr>
	  						</table>
 
	          	<TABLE  cellSpacing="0">
	  			  	<TR >
	  					<TD height="30" align="center" id="footer">
	          	 		    <input name="lastButton" type="button" class="b_foot" value="�ر�" onClick="window.close()">
	  					</TD>
	  			  	</TR>
	  	    	</TABLE>
 
	  	<%@ include file="/npage/include/footer_pop.jsp" %>
	  </form>
 
</body>
</html>

