<%
   /*
   * ����: ������Ʒ���뵽�ò�Ʒ����Ļ����ϵ����
�� * �汾: v1.0
�� * ����: 2007/01/17
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
	String trans_type = request.getParameter("trans_type");	
	   					 
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
//------��ѯ��Ʒ����-------
function queryModeCode()
{
	document.form1.action="f5238_modeLimitFrame2.jsp";
	document.form1.target="middle";
	document.form1.submit();
}   
//-------�ύѡ��Ĳ�Ʒ����--------
function submitAdd()
{
	document.form1.conmit.disabled=true;
	top.window.document.middle.commit();
}

//--------ȫ��ѡ��---------
function selectAll()
{
	top.window.document.middle.selectAll();
}

//----ȫ��ȡ��------
function selectNone()
{
	top.window.document.middle.selectNone();
}
/**��ѯ�ʻ�����**/
function querySmCode()
{
    var pageTitle = "Ʒ�Ʋ�ѯ";
    var fieldName = "Ʒ�ƴ���|Ʒ������|";
    var sqlStr ="select sm_code,sm_name from sSmCode  where region_code='<%=region_code%>' order by sm_code ";
	
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1|";
    var retToField = "sm_code_new|smNameCond|";
    if(!PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)) return false;

	return true;
}
function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/page/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
    retInfo = window.showModalDialog(path);
    if(retInfo ==undefined)      
    { 
		return false;  
	}
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
        
    }
	return true;
}
//ѡ���ʷ����ʹ���
function queryModeType()
{
	if(document.all.sm_code_new.value=="")
	{
	    rdShowMessageDialog("����ѡ��Ʒ�ƴ��룡");
		return ;
	}

    var retToField = "modeTypeCond|modeTypeNameCond|";
    var url = "f5238_queryModeType.jsp?clear_mode_use=1&region_code=<%=region_code%>"+"&smCodeCond="+document.all.sm_code_new.value+"&retToField="+retToField;
	window.open(url,'','height=600,width=400,scrollbars=yes');
}

function doReset()
{
    document.form1.sm_code_new.value="";
	document.form1.smNameCond.value="";
	document.form1.mode_code_new.value="";
	document.form1.modeTypeCond.value="";
	document.form1.modeTypeNameCond.value="";
	document.form1.mode_name_new.value="";
	document.form1.whereSql.value="";
	document.form1.defSendFlag.value="";
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
	  <table align="center" width="98%"  bgcolor="#ffffff">
        <tr>
          <td align="right" width="73%">
            <table width="535" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="42"><img src="/images/jl_ico_2.gif" width="42" height="41"></td>
                <td valign="bottom" width="493">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td background="/images/jl_background_4.gif"><font color="FFCC00"><strong>������Ʒ���뵽�ò�Ʒ����Ļ����ϵ����</strong></font></td>
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
	  	<input type="hidden" name="login_accept" value="<%=login_accept%>">
	  	<input type="hidden" name="mode_code" value="<%=mode_code%>">
	  	<input type="hidden" name="mode_name" value="<%=mode_name%>">
	  	<input type="hidden" name="region_code" value="<%=region_code%>">
	  	<input type="hidden" name="select_type" value="1">
	  	<input type="hidden" name="trans_type" value="<%=trans_type%>">
	  	<TR >
	  		<TD >
	  		  	<TABLE width="100%"  id="mainOne" bgcolor="#FFFFFF" cellspacing="1" border="0">
	  				<tr bgcolor="#F5F5F5" height="23">
	  					<TD colspan="4"><font color="blue">��ѡ����Ҫ����Ĳ�Ʒ���룡</font></td>
	  				</tr>
	  				<tr bgcolor="#F5F5F5" height="22">
	  					<TD width="16%" >ҵ��Ʒ�ƣ�</TD>
	  					<TD width="34%" colspan=3>
	  						<input type=text  v_type="string"  v_must=0 v_minlength=1 v_maxlength=8 v_name="ҵ��Ʒ��"  size="8" name=sm_code_new maxlength=8 readonly ></input>
							<input type=text  v_type="string"  v_must=0 v_minlength=1 v_maxlength=20 v_name="Ʒ�ƴ���"  name=smNameCond value="" maxlength=20 readonly>
		                    <input class="button" type="button" name="query_smcode" onclick="querySmCode()" value="ѡ��">
	  					</TD>
	  				</tr>
					<tr bgcolor="#F5F5F5" height="22">
	  					<TD width="16%" >��Ʒ���ࣺ</TD>
	  					<TD width="34%" colspan=3>
	  						<input type=text  v_type="string" size=8 v_must=0 v_minlength=1 v_maxlength=8 v_name="��Ʒ����"  name=modeTypeCond maxlength=8 readonly ></input>
							<input type=text  v_type="string"  v_must=0 v_minlength=1 v_maxlength=20 v_name="��Ʒ����"  name=modeTypeNameCond value="" maxlength=20 readonly>
		                    <input class="button" type="button" name="query_modeType" onclick="queryModeType()" value="ѡ��">
	  					</TD>
	  				</tr>
					<tr bgcolor="#F5F5F5" height="22">
	  					<TD width="16%" >��Ʒ���룺</TD>
	  					<TD width="34%" >
	  						<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=8 v_name="��Ʒ����"  name=mode_code_new maxlength=8 ></input>
	  					</TD>
						<TD width="16%" >��Ʒ���ƣ�</TD>
	  					<TD width="34%" >
	  						<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=30 v_name="��Ʒ����"  name=mode_name_new maxlength=30 ></input>
	  					</TD>
	  				</tr>
					<tr bgcolor="#F5F5F5" height="22">
	  					<TD width="16%" >SQL������<font color = "red">( SQL���������� AND �� and ��ͷ�����﷨��ȷ��)</font></TD>
	  					<TD width="34%" colspan=3 >
	  						<textarea name="whereSql" rows="10" cols="75"></textarea>
	  					</TD>
	  				</tr>
					<tr>
		                <td colspan=4 align="center">
		                   <input class="button" type="button" name="query_smcode" onclick="queryModeCode()" value="��ѯ">
						   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		                   <input class="button" type="button" name="do_reset" onclick="doReset()" value="����">
		                </td>
	                </tr>
	  			</table>
	  			<table width="100%" align="center" id="mainThree" bgcolor="#FFFFFF" cellspacing="1" border="0">
	  				<tr height="24" bgcolor="#649ECC">
      		    	 	<TD width="10%" >ѡ��</TD>
	  					<TD width="25%">��Ʒ����</TD>
	  					<TD width="55%">��Ʒ����</TD>
	  					<TD width="10%">��Ч��ʽ</TD>
      		  		</tr>
	  				<tr bgcolor="#F5F5F5" height="22">
	  					<td colspan="4">
	  						<IFRAME src="f5238_modeLimitFrame2.jsp?login_accept=<%=login_accept%>&mode_code=<%=mode_code%>&mode_name=<%=mode_name%>&region_code=<%=region_code%>&trans_type=<%=trans_type%>" frameBorder=0 id=middle name=middle scrolling="yes" style="HEIGHT: 300; VISIBILITY: inherit; WIDTH: 747; Z-INDEX: 1">
      		  	  			</IFRAME>
      		  	  		</td>
	  				</tr>
	          	</TABLE>
	          	<TABLE width="100%" border=0 align="center" cellSpacing=1 bgcolor="#FFFFFF">
	  			  <TR bgcolor="#F5F5F5">
	  				<TD height="30" align="center">
	  					<input name="selectall" type="button" class="button" value="ȫ��ѡ��" onClick="selectAll();">
	          	 	    &nbsp;
	          	 	    <input name="selectnone" type="button" class="button" value="ȫ��ȡ��" onClick="selectNone();">
	          	 	    &nbsp;
	          	 	    <input name="conmit" type="button" class="button" value="ȷ��" onClick="submitAdd();">
	          	 	    &nbsp;
	          	 	    <input name="cancel" type="button" class="button" value="ȡ��" onClick="window.opener.document.form1.otherTransModeButton.disabled=false;window.close();">
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

