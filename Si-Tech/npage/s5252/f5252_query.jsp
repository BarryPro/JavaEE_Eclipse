<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%
  /*
　 * 作者: wangwei
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
　*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@page contentType="text/html;charset=gb2312" errorPage=""%>
<%
//---------------------------------java代码区------------------------------------
//读取session信息
	    ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	    String[][] baseInfoSession = (String[][])arrSession.get(0);
	    String[][] otherInfoSession = (String[][])arrSession.get(2);
	    String loginNo = baseInfoSession[0][2];
	    String loginName = baseInfoSession[0][3];
	    String powerCode= otherInfoSession[0][4];
	    String orgCode = baseInfoSession[0][16];
	    String ip_Addr = request.getRemoteAddr();
	    
	    String regionCode = orgCode.substring(0,2);
	    String regionName = otherInfoSession[0][5];

//错误信息，错误代码
int errCode = 0;
String errMsg = "";

String agentCode = request.getParameter("agentCode");

SPubCallSvrImpl impl = new SPubCallSvrImpl();

ArrayList retList = new ArrayList();
String sqlStr = "select c.contract_no,c.bank_cust,c.status,c.status_time,c.contract_passwd from dconmsg c where c.account_type = '1'";
String outParaNums = "5";

retList = impl.sPubSelect(outParaNums,sqlStr,"region",regionCode);

errCode = impl.getErrCode(); //错误代码
System.out.println("errCode:"+Integer.toString(errCode));
errMsg = impl.getErrMsg(); //错误信息
System.out.println("errMsg:"+errMsg);

String[][] retListString = null;

if(errCode == 0){
	retListString = (String[][])retList.get(0);
	System.out.println(retListString.length+ "*****************************");
}
%>
<html>
<head>
<title>检查客户</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/css/jl.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/js/common/common_check.js"></script>
<script type="text/javascript" src="/js/common/common_util.js"></script>
<script type="text/javascript" src="/js/common/common_single.js"></script>
<script type="text/javascript" src="/js/rpc/src/core_c.js"></script>
<script type="text/javascript" src="/js/common/redialog/redialog.js"></script>
   
</head>
<script language="JavaScript">

	function saveTo(){
		for(i=0;i<document.form1.elements.length;i++){
			if (document.form1.elements[i].name=="List"){
				if (document.form1.elements[i].checked==true){     //判断是否被选中
        			var index = document.form1.elements[i].value;
					var contract_no = document.form1.elements[i + 1].value;
					var agt_phone = document.form1.elements[i + 2].value;
					var contract_passwd = document.form1.elements[i + 4].value;
					window.opener.document.form1.UserCode.value = contract_no;
					window.opener.document.form1.UserPassword1.value = contract_passwd;
					break;
				}
			}
		}
		if(index == undefined){
			rdShowMessageDialog("请选择其中1项!");
		}else{
			window.close();
		}
	}

</script>
<BODY bgColor=#FFFFFF leftmargin="0" topmargin="0" background="/images/jl_background_2.gif">
<FORM method=post name="form1" onMouseDown="hideEvent()" onKeyDown="hideEvent()">   
   <TABLE>
   <BODY>
    <TR>
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
          <td align="right" width="30%"> 
            <table width="400" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="42"><img src="/images/jl_ico_2.gif" width="42" height="41"></td>
                <td valign="bottom" width="400"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td background="/images/jl_background_4.gif"><font color="FFCC00"><b>集团客户查询</b></font></td>
                      <td><img src="/images/jl_ico_3.gif" width="250" height="30"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
          <td width="70%"> 
            <table border="0" cellspacing="0" cellpadding="1" align="right">
              <tr>
                <td><img src="/images/jl_ico_6.gif" width="60" height="50"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>

  <table  bgcolor="#FFFFFF" width="98%" border="0" align="center" cellpadding="0" cellspacing="1">
    <tr>
	
<TR bgcolor='649ECC' height=25><TD>&nbsp;&nbsp;账户号码</TD><TD>&nbsp;&nbsp;帐户名称</TD><TD>&nbsp;&nbsp;有效状态</TD></TR> 
	<%
			for(int i = 0;i < retListString.length;i++){
				out.println("<Label FOR='InputBox" + i + "'>");
				out.println("<TR bgcolor='#EEEEEE'>");
				out.println("<TD><input type='radio' ID='InputBox" + i + "' name='List' style='cursor:hand' value='" + i +"'><input type='hidden' name='contract_no" + i + "' class='button' value='" + 
          		            (retListString[i][0]).trim() + "'readonly/>" + retListString[i][0] + "</TD>");
				out.println("<TD><input type='hidden' name='agt_phone" + i + "' class='button' value='" + 
          		            (retListString[i][1]).trim() + "'readonly>" + retListString[i][1] + "</TD>");
				out.println("<TD><input type='hidden' name='status" + i + "' class='button' value='" + 
          		            (retListString[i][2]).trim() + "'readonly><input type='hidden' name='contract_passwd" + i + "' class='button' value='" + 
          		            retListString[i][4].trim() + "'readonly>" + retListString[i][2] + "</TD>");
				out.println("</TR>");
				out.println("</Label>");
			}
	%>

  </table>
<!------------------------------------------------------>
    <TABLE width="98%" border=0 align=center cellpadding="4" cellSpacing=1>
    <TBODY>
		
        <TR bgcolor="#EEEEEE"> 
            <TD align=center bgcolor="#EEEEEE">
				<%
					if(errCode == 0 && retListString.length > 0){
				%>
                <input class="button" name=commit onClick="saveTo()" style="cursor:hand" type=button value=确认>&nbsp;
				<%
					}
				%>
                <input class="button" name=back onClick="window.close()" style="cursor:hand" type=button value=返回>&nbsp;        
            </TD>
        </TR>
    </TBODY>
    </TABLE>
	
    <TR> 
    <BODY>
   <TABLE>
</FORM>
</BODY>
</html>

