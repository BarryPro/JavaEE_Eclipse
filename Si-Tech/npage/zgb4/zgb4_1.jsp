<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-07
 ********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="java.util.*"%>
<%@ include file="../../npage/common/pwd_comm.jsp" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
 <%
	ArrayList arr = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arr.get(0);
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String nopass = (String)session.getAttribute("password");	
	String orgCode = (String)session.getAttribute("orgCode");
    String opCode = "zgb4";   
    String opName = "微信支付交费状态查询";
    //activePhone = request.getParameter("activePhone"); 
    String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String[] mon = new String[6] ;

    Calendar cal = Calendar.getInstance(Locale.getDefault());
	cal.set(Integer.parseInt(dateStr.substring(0,4)),
                      (Integer.parseInt(dateStr.substring(4,6)) - 1),Integer.parseInt(dateStr.substring(6,8)));
	for(int i=0;i<=5;i++)
      {
              if(i!=5)
              {
                mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
                cal.add(Calendar.MONTH,-1);
              }
              else
                mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
      }        
      // xl add for zlc
	boolean pwrf = false;

	//String pubOpCode =opCode; //"1231";//
	String pubOpCode ="zgb4";
%>
	  <%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
<%
    //end add by xl for zlc                                        
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>交费信息查询</TITLE>
</HEAD>

<body >
<SCRIPT language="JavaScript">
 
  

function query()
{
	var s_phone_no=document.frm1527.phoneNo.value;
	if(s_phone_no=="")
	{
		rdShowMessageDialog("请输入查询的手机号码!");
		document.frm1527.phoneNo.focus();
		return false;
	}
	else
	{
		document.frm1527.action="zgb4_2.jsp";
		frm1527.submit();
	}	
	
}
 
</SCRIPT>

<FORM method=post name="frm1527" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">微信支付交费状态查询</div>
</div>
<input type="hidden" name="opCode"  value="zgb4">
 
<TABLE cellSpacing=0>
    
    <TR> 
        <TD class=blue>服务号码</TD>
        <TD colspan=3>
            <input type="text" name="phoneNo" size="20" maxlength="11" >
            
        </TD>
    </TR>
    <!--
	<TR> 
        <TD class=blue>开始时间</TD>
        <TD>
            <input v_type=int type="text"  name="beginTime" size="20" maxlength="6" value=<%=mon[3]%>>
        </TD>
        <TD class=blue>结束时间 
            <input v_type=int type="text" name="endTime" size="20" maxlength="6" value=<%=dateStr.substring(0,6)%>>
        </TD>
    </TR>
    -->
    <tr id="footer" > 
        <td colspan=4>
            <input class="b_foot" name=Button2 id="doQuery"  type="button" onClick="query()" value="  查询  "  >
            <input class="b_foot" name=reset  type=reset onClick="" value="  清除  ">
            <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value="  关 闭  ">
        </td>
    </tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>

</BODY></HTML>
<!--***********************************************************************-->

