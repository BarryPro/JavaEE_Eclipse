<%@ page contentType="text/html;charset=GB2312"%>
<%@ page errorPage="../common/errorpage.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.s1210.viewBean.S1210Impl"%>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="com.sitech.boss.pub.util.ErrorMsg"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<%
	 ArrayList arr = (ArrayList)session.getAttribute("allArr");
    String[][] baseInfo = (String[][])arr.get(0);
    String[][] agentInfo = (String[][])arr.get(2);
    String[][] favInfo = (String[][])arr.get(3);
    String[][] pass = (String[][])arr.get(4);
    
    String ip_Addr = agentInfo[0][2];
    String workno = baseInfo[0][2];
    String workname = baseInfo[0][3];
    String org_code = baseInfo[0][16].substring(0,7);
    String nopass  = pass[0][0];
    
  String iccid=request.getParameter("iccid");//证件号码，用于返回时赋值。
	String op_type = request.getParameter("op_type"); //账号	
	String month = request.getParameter("month");	  //查询年月
	String cust_id = request.getParameter("cust_id");	 
	
	String title="";
	
	if(op_type.equals("2"))
	{
		title="MC详单查询";
	}
else
	{
	title="代付清单";
	}
	SPubCallSvrImpl callView = new SPubCallSvrImpl();  //调用wtc服务
	
	String paramsIn1[] = new String[9];
	paramsIn1[0]=workno;
	paramsIn1[1]=nopass;
	paramsIn1[2]=org_code;
	paramsIn1[3]="2735";
	paramsIn1[4]=op_type;
	paramsIn1[5]="";
	paramsIn1[6]="";
	paramsIn1[7]=month;
	paramsIn1[8]=cust_id;
	
	ArrayList acceptList = new ArrayList();
	
	acceptList = callView.callFXService("sQryIagwDetail", paramsIn1, "3");	
	 callView.printRetValue();
	int errCode = callView.getErrCode();
	String errMsg = callView.getErrMsg();
	
	String[][] code     = new String[][]{};
	String[][] name     = new String[][]{}; 
	String[][] data     = new String[][]{};
	
	if(errCode!=0)
	{
	%>
	<script>
		rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
	  history.go(-1);
	</script>
		<%
	}else{
            
		code          = (String[][])acceptList.get(0);  
		name        = (String[][])acceptList.get(1); 
		data           = (String[][])acceptList.get(2); 
		}
	%>              
                
<html>          
<head>          
<title><%=title%></title>
</head>
<BODY bgColor=#FFFFFF leftmargin="0" topmargin="0" background="<%=request.getContextPath()%>/images/jl_background_2.gif">
<FORM method=post name="fPubSimpSel">   
   <TABLE>
   <BODY>
    <TR>
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
          <td align="right" width="30%"> 
            <table width="400" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="42"><img src="<%=request.getContextPath()%>/images/jl_ico_2.gif" width="42" height="41"></td>
                <td valign="bottom" width="400"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td background="<%=request.getContextPath()%>/images/jl_background_4.gif"><font color="FFCC00"><b><%=title%></b></font></td>
                      <td><img src="<%=request.getContextPath()%>/images/jl_ico_3.gif" width="250" height="30"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
          <td width="70%"> 
            <table border="0" cellspacing="0" cellpadding="1" align="right">
              <tr>
                <td><img src="<%=request.getContextPath()%>/images/jl_ico_6.gif" width="60" height="50"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>

  <table  bgcolor="#FFFFFF" width="98%" border="0" align="center" cellpadding="0" cellspacing="1">
      <TR bgcolor="E8E8E8">
            <TD>代码：</TD><TD><%=code[0][0]%></TD>
            <TD>名称：</TD>
            <TD><%=name[0][0]%></TD>
     </TR>
 <% 
	 for (int i = 0;i < data.length; i++) {
					  %>
           <tr bgcolor="#E8E8E8"> 
             <td width="8%" nowrap align="center" colspan=8 >
             	<%=data[i][0]%>
             </td>
					 </tr>
	<% } %>
   </tr>
  </table>

<!------------------------------------------------------>
    <TABLE width="98%" border=0 align=center cellpadding="4" cellSpacing=1>
    <TBODY>
        <TR bgcolor="#EEEEEE"> 
            <TD align=center bgcolor="#EEEEEE">
                <input class="button" name=commit onClick="window.close()" style="cursor:hand" type=button value=关闭>&nbsp;
            </TD>
        </TR>
    </TBODY>
    </TABLE>
	
    <TR> 
    <BODY>
</FORM>
</BODY>
</HTML>    
