<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%
	String opCode = "4100";
  String opName = "跨区入网";
%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html; charset=GBK" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%
        String workNo = (String)session.getAttribute("workNo");
        String Department = (String)session.getAttribute("orgCode");
        String belongCode = Department.substring(0,7);
        String regionCode = Department.substring(0,2);
        String districtCode = Department.substring(2,2);
        
		String oldmsisdn=request.getParameter("oldmsisdn");
		String Maxaccept=request.getParameter("Maxaccept");
		String optime=request.getParameter("optime");
		String Level=request.getParameter("Cust_Level");
		String phone_no=request.getParameter("phone_no");
		String sqlStr = "select old_phone_no,year,consume_point,award_point,converted_point,Convertible_point from pCrossMarkBack where login_accept = "+Maxaccept;
  
%>
<wtc:pubselect name="sPubSelect" outnum="6" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result" scope="end"/>
<html>
<head>
<title>跨区入网完成确认</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<script language=javascript>
    function confirm1(){
        var path="/npage/innet/f4200_Cfm.jsp?Maxaccept=<%=Maxaccept%>&phone_no=<%=phone_no%>";
 		var ret=window.showModalDialog(path,"","dialogWidth:150px;center:yes;");
    }
</SCRIPT>

<body  onMouseDown="hideEvent()" onKeyDown="hideEvent()">
<FORM method=post name="frm1903" action=""  onKeyUp="chgFocus(frm1903)">
  <%@ include file="/npage/include/header_pop.jsp" %>                         
	<div class="title">
		<div id="title_zi">跨区入网完成确认</div>
	</div>
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr>
          <td width="45%">
              <TABLE width=100% height=25 border=0 align="center" cellSpacing=1 >
                <TBODY>
                	<TR bgcolor="#649ECC">
                	    <TD width="16%"> 
                            <div align="left">客户号码：</div>
                        </TD>
                        <TD width="34%" nowrap> <font face="宋体"> </font> <font color="#FF0000">
                            <input name=oldmsisdn class="button" value=<%=oldmsisdn%> readonly>
                        </TD>
                        <TD width="16%"> 
                            <div align="left">客户级别：</div>
                        </TD>
                        <TD width="34%" nowrap> <font face="宋体"> </font> <font color="#FF0000">
                            <input name=level class="button" value=<%=Level%> readonly>
                        </TD>
                    </TR>
                    <TR bgcolor="#649ECC">
                        <TD width="16%"> 
                            <div align="left">新入网号码：</div>
                        </TD>
                        <TD width="34%" nowrap> <font face="宋体"> </font> <font color="#FF0000">
                            <input name=phone_no class="button" value=<%=phone_no%> readonly>
                        </TD>
                        <TD width="16%"> 
                            <div align="left">操作时间：</div>
                        </TD>
                        <TD width="34%" nowrap> <font face="宋体"> </font> <font color="#FF0000">
                            <input name=optime class="button" value=<%=optime%> readonly>
                        </TD>
                    </TR>
                    </TBODY>
              </TABLE>
            <TABLE width=100% height=25 border=0 align="center" cellSpacing=1 >
                <TBODY>
                    <TR bgcolor="#649ECC">
                        <TD height="30">年限</TD><TD>年消费积分</TD><TD>年奖励积分</TD><TD>年已兑换积分</TD><TD>年可兑换积分</TD>
                    </TR>
                    <%     
                      for(int i=0;i<result.length&&i<3;i++)
                      {%>
                        <TR bgcolor="#EEEEEE">
                  	 		<TD><%=result[i][1]%></TD>
                  	 		<TD><%=result[i][2]%></TD>
                  	 		<TD><%=result[i][3]%></TD>
                  	 		<TD><%=result[i][4]%></TD>
                  	 		<TD><%=result[i][5]%></TD>
                       </TR>
                    <%}%>
				</TBODY>
              </TABLE>

        <TABLE width="100%" border=0 align=center cellpadding="4" cellSpacing=1>
          <TBODY>
            <TR bgcolor="#EEEEEE">
                  <TD align=center bgcolor="#EEEEEE">
                    <input type=button class="button" name=load onClick="confirm1()" value=确认>
                    <input type="button" name="return" class="button" value="返回" onClick="window.history.go(-1)">
                    <input class="button" name=back type=button onclick="window.close()" value=关闭 index="41">
                  </TD>
            </TR>
          </TBODY>
        </TABLE>    
        </td>
  </tr>
</table>
 <%@ include file="/npage/include/footer_pop.jsp" %>
</form>

</body>
</html>
