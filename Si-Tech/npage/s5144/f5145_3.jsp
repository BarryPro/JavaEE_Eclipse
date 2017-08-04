<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.*" %>
<%@ page import="java.util.*" %>

<%
    Logger logger = Logger.getLogger("f4523_main.jsp");
     
    //读取用户session信息   
    ArrayList arrSession = (ArrayList)session.getAttribute("allArr");   
    String[][] baseInfo = (String[][])arrSession.get(0);
    String workNo   = baseInfo[0][2];               //工号
    String workName = baseInfo[0][3];               //工号姓名
    String org_code = baseInfo[0][16];
    String ip_Addr  = request.getRemoteAddr();  
    String[][] pass = (String[][])arrSession.get(4);
    String nopass  = pass[0][0];                    //登陆密码 
    String regionCode = baseInfo[0][16].substring(0,2);
    
    String op_name = "新增资费FAQ-导入问题答案";
    
    String mode_code = request.getParameter("mode_code");                                  
    String mode_name = request.getParameter("mode_name");
    String show_type = request.getParameter("show_type");
    String request_privs = request.getParameter("request_privs");
    String show_index = request.getParameter("show_index");
    String begin_time = request.getParameter("begin_time");
    String end_time = request.getParameter("end_time");
    String manage_region = request.getParameter("manage_region");
    String faq_bit_region = request.getParameter("faq_bit_region");
    
    String paraArray[] = new String[10];
    paraArray[0] = mode_code ;
    paraArray[1] = mode_name ;
	paraArray[2] = show_type ;
	paraArray[3] = request_privs ;
	paraArray[4] = show_index ;
	paraArray[5] = begin_time ;
	paraArray[6] = end_time ;
	paraArray[7] = manage_region ;
	paraArray[8] = faq_bit_region ;
	paraArray[9] = workNo ;
	
	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	
	String []result = impl.callService("s5144Add",paraArray,"3","region",org_code.substring(0,2));
	
	int errCode = impl.getErrCode();
	String errMsg = impl.getErrMsg();
	
	System.out.println("errCode="+errCode);
	System.out.println("errMsg="+errMsg);

%>

<html>
<head>
<title><%=op_name%></title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">

<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<script type="text/javascript"  src="<%=request.getContextPath()%>/js/rpc/src/core_c.js"></script>
<link href="<%=request.getContextPath()%>/css/jl.css"  rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/tablabel.css">
</head> 
<body bgcolor="#FFFFFF" text="#000000" background="<%=request.getContextPath()%>/images/jl_background_2.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
    
    <table width="767" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td background="<%=request.getContextPath()%>/images/jl_background_1.gif">
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
          <td align="right" width="45%"> 
            <p><img src="<%=request.getContextPath()%>/images/jl_chinamobile.gif" width="226" height="26"></p>
            </td>
          <td width="55%" align="right"><img src="<%=request.getContextPath()%>/images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">工号：<%=workNo%><img src="<%=request.getContextPath()%>/images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">操作员：<%=workName%>
          	</td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
          <td align="right" background="<%=request.getContextPath()%>/images/jl_background_3.gif" height="69"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td><img src="<%=request.getContextPath()%>/images/jl_logo.gif"></td>
                <td align="right"><img src="<%=request.getContextPath()%>/images/jl_head_1.gif"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
          <td align="right" width="73%"> 
            <table width="535" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="42"><img src="<%=request.getContextPath()%>/images/jl_ico_2.gif" width="42" height="41"></td>
                <td valign="bottom" width="493"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td background="<%=request.getContextPath()%>/images/jl_background_4.gif"><font color="FFCC00"><b><%=op_name%></b></font></td>
                      <td><img src="<%=request.getContextPath()%>/images/jl_ico_3.gif" width="289" height="30"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
          <td width="27%"> 
            <table border="0" cellspacing="0" cellpadding="2" align="right">
              <tr>
                <td><img src="<%=request.getContextPath()%>/images/jl_ico_4.gif" width="60" height="50"></td>
                <td><img src="<%=request.getContextPath()%>/images/jl_ico_5.gif" width="60" height="50"></td>
                <td><img src="<%=request.getContextPath()%>/images/jl_ico_6.gif" width="60" height="50"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>  
    <form name="frm" action="f5145_4.jsp" method="post" enctype="multipart/form-data">
	<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
   	 <tr><td>
      <table border="0" cellspacing="2" cellpadding="2" align="center" width="100%">
      	<tr bgcolor="#E8E8E8"> 
      		<td width="15%">返回代码：</td>
      		<td width="25%">&nbsp;<%=errCode%></td>
      		<td width="15%">返回信息：</td>
      		<td width="45%">&nbsp;<%=errMsg%></td>
      	</tr>
      	<tr bgcolor="#E8E8E8" height="10" /> 
<%
		if(errCode == 0)
		{
%>
      	<tr bgcolor="#E8E8E8"> 
      		<td>问题文件：
      		</td>
      		<td colspan="2">
      			<input type="file" size="50" name="spreadsheet" />
      		</td>
      		<td>
      			<input type="button" value="下一步" onclick="doNext('<%=result[2]%>')"/>
      		</td>
      	</tr>
<%
		}
%>
      </table>
    </td></tr>
	</table>
    </form>
    
  </body>
</html>

<script language="javascript" >
	function doNext(faq_id)
	{
		if(document.frm.spreadsheet.value == '')
		{
			rdShowMessageDialog("请选择问题文件");
			return false;
		}
		document.frm.action="f5145_4.jsp?faq_id="+faq_id;
		document.frm.submit();
	}
</script>
