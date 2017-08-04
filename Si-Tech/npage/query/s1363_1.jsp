<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

 
<%@ page import="com.sitech.boss.amd.viewbean.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
 
 <%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
	String opCode = "1363";
	String opName = "预存明细查询";	
	ArrayList arr = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arr.get(0);
	String workno = baseInfo[0][2];
	String workname = baseInfo[0][3];
	String org_code = baseInfo[0][16];
	String belongName = baseInfo[0][16];
	String[][] password = (String[][])arr.get(4);//读取工号密码 
	String pass = password[0][0];
	String[][] info1 = (String[][])arr.get(1);
    
  String[][] temfavStr=(String[][])arr.get(3);
  String[] favStr=new String[temfavStr.length];
  for(int i=0;i<favStr.length;i++)
   	favStr[i]=temfavStr[i][0].trim();
  boolean pwrf=false;
  	if(Pub_lxd.haveStr(favStr,"a272"))
			pwrf=true;
			
	String sAuthJspName="../s3780/fAuth.jsp?op_code=1363";
	String in_phoneno = request.getParameter("CustId");
	//String in_phoneno = request.getParameter("phoneno");
	//String custPasswd = Pub_lxd.repNull(request.getParameter("password"));//用户密码
	String rtnPage = "./s1363.jsp";
	String error_msg = "用户密码错误！";
	
	/*
	String sql = "select count(*) from dcustmsg where phone_no = '"+in_phoneno+"' and user_passwd = '"+Encrypt.encrypt(custPasswd)+"'";
	comImpl co = new comImpl();
	ArrayList agentCodeArr = co.spubqry32("1",sql);
	String[][] agentCodeStr = (String[][])agentCodeArr.get(0);

	if(("0".equals(agentCodeStr[0][0])) && !pwrf)
		{
%>
	<script language="JavaScript" src="../../js/common/redialog/redialog.js"></script>
	<script>
		
		rdShowMessageDialog('<%=error_msg%>',0);
		document.location.replace('<%=rtnPage%>');
	</script>
<%
	}
	  */ 
	String inParas[] = new String[1];
    inParas[0] = in_phoneno;

	int [] lens ={3,13};
    
	String[][] result1  = null;
	String[][] result2  = null;

	ScallSvrViewBean viewBean = new ScallSvrViewBean();//实例化viewBean
 	CallRemoteResultValue value = viewBean.callService("2",in_phoneno,"s1363Query","16",lens,inParas);
 	ArrayList list  = value.getList(); 
if (list==null)
{
	System.out.println("@@@@@@");
}
	result1 = (String[][])list.get(0);
    String return_code = result1[0][0];
   error_msg = result1[0][1];
	String cust_name = result1[0][2];
	
	if (return_code.equals("000000")) {
	   result2 = (String[][])list.get(1);
	}
%>

<script language="JavaScript" src="/js/common/redialog/redialog.js"></script>
<% if (!return_code.equals("000000")) {%>
  <script language="JavaScript">
    rdShowMessageDialog("预存明细查询失败! ");
    window.location="<%=sAuthJspName%>";
  </script>
<% } else { %>
<HTML>
<HEAD>
<TITLE>黑龙江BOSS-无优惠送费查询</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control> 
</HEAD>
<%@ include file="/npage/include/header.jsp" %>
<BODY leftmargin="0" topmargin="0">
<FORM action="s1321_3print.jsp" method=post name=form>
 
      <table width="100%" border="0" cellspacing="0" cellpadding="5">
            <tr> 
              <td nowrap align="left">客户名称:<%=cust_name%></td>
            </tr>

			 <tr>
               <td>
                  <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0"  >
                    <tr> 
                     <td> 
                     <table width="100%" border="0" cellspacing="1" cellpadding="4"  >
                      <tr bgcolor="#E1EAFF"> 
                        <td nowrap bgcolor="#99ccff"> 
                          <div align="center"> <b>帐号</b></div>
                        </td>
                           <td nowrap bgcolor="#99ccff"> 
                          <div align="center"> <b>账户划拨顺序</b></div>
                        </td>
                        <td nowrap bgcolor="#99ccff"> 
                          <div align="center"> <b>预存名称</b></div>
                        </td>
                           <td nowrap bgcolor="#99ccff"> 
                          <div align="center"> <b>预存冲销优先级</b></div>
                        </td>
                        <td nowrap bgcolor="#99ccff"> 
                          <div align="center"><b>预存金额</b></div>
                        </td>
						<td nowrap bgcolor="#99ccff"> 
                          <div align="center"><b>容许划拨额度</b></div>
                        </td>
						<td nowrap bgcolor="#99ccff"> 
                          <div align="center"><b>容许划拨开始</b></div>
                        </td>
						<td nowrap bgcolor="#99ccff"> 
                          <div align="center"><b>容许划拨结束</b></div>
                        </td>
						<td nowrap bgcolor="#99ccff"> 
                          <div align="center"><b>禁退开始</b></div>
                        </td>
						<td nowrap bgcolor="#99ccff"> 
                          <div align="center"><b>禁退结束</b></div>
                        </td>
						<td nowrap bgcolor="#99ccff"> 
                          <div align="center"><b>是否可退</b></div>
                        </td>
						<td nowrap bgcolor="#99ccff"> 
                          <div align="center"><b>是否专款</b></div>
                        </td>
                      </tr>

                      <% 
					      for (int i = 0;i < result2.length; i++) {
					  %>
                        <tr bgcolor="#FFFFFF"> 
                          <td width="22%" nowrap><%=result2[i][0]%>
                          </td>
              <td width="22%" nowrap><%=result2[i][11]%>
                          </td>
						  <td width="22%" nowrap><%=result2[i][1]%>
                          </td>
              <td width="22%" nowrap><%=result2[i][12]%>
                          </td>
						  <td width="22%" nowrap><%=result2[i][2]%>
                          </td>
						  <td width="22%" nowrap><%=result2[i][3]%>
                          </td>
						  <td width="22%" nowrap><%=result2[i][4]%>
                          </td>
						  <td width="22%" nowrap><%=result2[i][5]%>
                          </td>
						  <td width="22%" nowrap><%=result2[i][6]%>
                          </td>
						  <td width="22%" nowrap><%=result2[i][7]%>
                          </td>
						  <td width="22%" nowrap><%=result2[i][8]%>
                          </td>
						  <td width="22%" nowrap><%=result2[i][9]%>
                          </td>
					  </tr>
					  <% } %>
					  
                    </table>
                  </td>
                </tr>
               </table> 
			   </td>
			</tr>

        </table>
        </div>
        <p align="center"> 
        <input  class="b_foot" name=reset type=reset value=返回 onclick="JavaScript:document.location.href='<%=sAuthJspName%>';">
        &nbsp;
        <input  class="b_foot" name=sure type=button value=关闭 onclick="window.close();">
		</p>
 
</FORM>
</BODY>
</HTML>
<% }

 %>