<%
   /*
   * ����: ��Ʒ�����������
�� * �汾: v1.0
�� * ����: 2007/01/25
�� * ����: shibo
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>

<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page errorPage="/page/common/errorpage.jsp" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.text.*"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<%
	//��ȡ�û�session��Ϣ
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arrSession.get(0);
	String workNo   = baseInfo[0][2];                 //����
	String workName = baseInfo[0][3];               	//��������
	String org_code = baseInfo[0][16];
	String ip_Addr  = request.getRemoteAddr();
	String[][] pass = (String[][])arrSession.get(4);   
	String nopass  = pass[0][0];                     	//��½����
	String regionCode=org_code.substring(0,2);
	
	//��ȡ����ҳ�õ�����Ϣ
	String login_accept = request.getParameter("login_accept");	
	String mode_code = request.getParameter("mode_code");
	String mode_name = request.getParameter("mode_name");	
	String region_code = request.getParameter("region_code");	
	   					 
%>

<html>
<head>
<base target="_self">
<title>��Ʒ�����������</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/css/jl.css"  rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>
<script language="JavaScript"> 

function modeLimitOther()
{
	document.form1.modeTransOtherButton.disabled=true;
	var url = "f5238_modeLimit.jsp?login_accept=<%=login_accept%>&mode_code=<%=mode_code%>&mode_name=<%=mode_name%>&region_code=<%=region_code%>&trans_type=0";
	window.open(url,'','height=700,width=800,left=60,top=60,scrollbars=yes');
}

function otherLimitMode()
{
	document.form1.otherTransModeButton.disabled=true;
	var url = "f5238_modeLimit2.jsp?login_accept=<%=login_accept%>&mode_code=<%=mode_code%>&mode_name=<%=mode_name%>&region_code=<%=region_code%>&trans_type=1";
	window.open(url,'','height=700,width=800,left=60,top=60,scrollbars=yes');
}

//�رմ�ҳ�沢����f5238_5.jspҳ���е�queryRelationFlag()�����ѯ��ϵ�����״̬
function closewindow()
{
    window.opener.document.form1.limitButton.disabled=false;
    window.opener.queryRelationFlag();
	window.close();
}
</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" background="/images/jl_background_2.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  onMouseDown="hideEvent()" onKeyDown="hideEvent()">
<table width="767" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td background="../../images/jl_background_1.gif">
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
          <td align="right" width="45%"> 
            <p><img src="../../images/jl_chinamobile.gif" width="226" height="26"></p>
            </td>
             
          <td width="55%" align="right"><img src="../../images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">���ţ�<%=baseInfo[0][2]%>
          <img src="../../images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">����Ա��<%=baseInfo[0][3]%> 
          </td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
          <td align="right" background="../../images/jl_background_3.gif" height="69"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td><img src="../../images/jl_logo.gif"></td>
                <td align="right"><img src="../../images/jl_head_1.gif"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
	  <table align="center" width="98%"  bgcolor="#ffffff">
        <tr>
          <td align="right" width="73%">
            <table width="535" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="42"><img src="/images/jl_ico_2.gif" width="42" height="41"></td>
                <td valign="bottom" width="493">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td background="/images/jl_background_4.gif"><font color="FFCC00"><strong>��Ʒ�����������</strong></font></td>
                      <td><img src="/images/jl_ico_3.gif" width="240" height="30"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
          <td width="27%">
            <table border="0" cellspacing="0" cellpadding="4" align="right">
              <tr>
                <td><img src="/images/jl_ico_4.gif" width="60" height="50"></td>
                <td><img src="/images/jl_ico_5.gif" width="60" height="50"></td>
                <td><img src="/images/jl_ico_6.gif" width="60" height="50"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
	  <TABLE width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
	  <form name="form1"  method="post">
	  	<TR >
	  		<TD >
	  		  	<TABLE width="100%"  id="mainOne" bgcolor="#FFFFFF" cellspacing="1" border="0">
	  				<tr bgcolor="#F5F5F5" height="22">
	  					<TD width="15%">&nbsp;&nbsp;��Ʒ���룺</TD>
	  					<TD width="35%">
	  						<%=mode_code%>
	  					</TD>
	  					<TD width="15%">&nbsp;&nbsp;��ǰ������ˮ�ţ�</TD>
	  					<TD width="35%"><font color="red"><%=login_accept%></font></TD>
	  				</tr>
	  				<tr bgcolor="#F5F5F5" height="22">
	  					<TD>&nbsp;&nbsp;��Ʒ���ƣ�</TD>
	  					<TD colspan="3">
	  						<%=mode_name%>
	  					</TD>
	  				</tr>
	  				<tr bgcolor="#F5F5F5" height="22">
	  					<TD colspan="4">
	  						&nbsp;&nbsp;���ò�Ʒ��<%=mode_code%>����������Ʒ�Ļ����ϵ����
	  						<input name="modeTransOtherButton" type="button" class="button" value="����" onClick="modeLimitOther();">
	  					</TD>
	  				</tr>
	  				<tr bgcolor="#F5F5F5" height="22">
	  					<TD colspan="4">
	  						&nbsp;&nbsp;����������Ʒ����Ʒ��<%=mode_code%>���Ļ����ϵ����
	  						<input name="otherTransModeButton" type="button" class="button" value="����" onClick="otherLimitMode();">
	  					</TD>
	  				</tr>
	  			</table>
	  			<table width="100%" align="center" id="mainThree" bgcolor="#FFFFFF" cellspacing="1" border="0">
	  				<tr height="24" bgcolor="#649ECC">
      		    		<TD width="10%" align="center">��Ʒ����</TD>
	  					<TD width="30%" align="center">��Ʒ����</TD>
	  					<TD width="10%" align="center">��ϵ</TD>
	  					<TD width="10%" align="center">��Ʒ����</TD>
	  					<TD width="30%" align="center">��Ʒ����</TD>
	  					<TD width="10%" align="center">��Ч��ʽ</TD>
      		  		</tr>
	  				<tr bgcolor="#F5F5F5" height="22">
	  					<td colspan="6">
	  						<IFRAME src="f5238_deployLimitFrame.jsp?login_accept=<%=login_accept%>&mode_code=<%=mode_code%>&mode_name=<%=mode_name%>&region_code=<%=region_code%>" frameBorder=0 id=middle2 name=middle2 scrolling="yes" style="HEIGHT: 280; VISIBILITY: inherit; WIDTH: 747; Z-INDEX: 1">
      		  	  			</IFRAME>
      		  	  		</td>
	  				</tr>
	          	</TABLE>
	          	<TABLE width="100%" border=0 align="center" cellSpacing=1 bgcolor="#FFFFFF">
	  			  <TR bgcolor="#F5F5F5">
	  				<TD height="30" align="center">
	          	 	    <input name="lastButton" type="button" class="button12" value="����" onClick="closewindow();">
	          	 	    &nbsp;
	  				</TD>
	  			  </TR>
	  	    	</TABLE>
	  			<BR>
	  			<BR>		
	  		</TD>
	  	</TR>
	  </form>
	  </TABLE>
	</TD>
  </TR>
</TABLE>
</body>
</html>

