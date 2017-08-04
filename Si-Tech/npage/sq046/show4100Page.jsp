<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-12-27 :16:35
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
    String regionCode = (String)session.getAttribute("regCode");    
    String oldMSISDN  = WtcUtil.repNull(request.getParameter("oldMSISDN"));  //4100原手机号 查询使用
    String phone_no = WtcUtil.repNull(request.getParameter("servPhoneNo"));  //4100原手机号 查询使用
    String sqlStr = "";
    if(oldMSISDN==null||oldMSISDN.equals("")) 
    {
        System.out.println("mylog--------111111-----");
        oldMSISDN = "";
        sqlStr ="select distinct login_accept,old_phone_no,Cust_Level,to_char(optime,'yyyymmddhh24miss') from pCrossMarkBack where dealflag = '0' and optime > sysdate - 1"; 
    }
    else{
        System.out.println("mylog--------222222-----");
        sqlStr ="select distinct login_accept,old_phone_no,Cust_Level,to_char(optime,'yyyymmddhh24miss') from pCrossMarkBack where dealflag = '0' and optime > sysdate - 1 and old_phone_no = '"+oldMSISDN+"'"; 
    }
    System.out.println("mylog-------------"+sqlStr);
%>
   <wtc:pubselect name="sPubSelect" outnum="8" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result" scope="end"/>
 

<html>
<head>
<title>跨区入网列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript">
function goToRev(vMaxaccept,voldmsisdn,vCust_Level,voptime,vphone_no)
{
        var path="/npage/innet/f4100_1002.jsp?Maxaccept="+vMaxaccept+"&oldmsisdn="+voldmsisdn+"&Cust_Level="+vCust_Level+"&optime="+voptime+"&phone_no="+vphone_no;
 		var ret=window.showModalDialog(path,"","dialogWidth:750px;center:yes;");
 }    
</script>
</head>


<body  onMouseDown="hideEvent()" onKeyDown="hideEvent()">
<FORM method=post name="frm1902" action=""  onKeyUp="chgFocus(frm1902)">
  <%@ include file="/npage/include/header_pop.jsp" %>                         
	<div class="title">
		<div id="title_zi">跨区入网列表</div>
	</div>
              <TABLe cellSpacing=0 >
                <TBODY>
                	<TR>
                  <Th height="30">操作流水</Th><Th>手机号码</Th><Th>客户级别</Th><Th>操作时间</Th><Th>操作</Th>
                </TR>
             <%     
                      for(int i=0;i<result.length;i++)
                        {%>
                        <TR>
                   	 		<TD><%=result[i][0]%></TD>
                  	 		<TD><%=result[i][1]%></TD>
                  	 		<TD><%=result[i][2]%></TD>
                  	 		<TD><%=result[i][3]%></TD>
                  	 		<TD><input class="b_foot_long" name=confirm  type=button index="8" value="确认" onclick="goToRev(<%=result[i][0]%>,<%=result[i][1]%>,<%=result[i][2]%>,<%=result[i][3]%>,<%=phone_no%>)"></TD>
                       </TR>
             <%}%>   
                
        

                
				</TBODY>
              </TABLE>

        <TABLE  cellSpacing=0>
          <TBODY>
            <TR >
                  <TD align=center id="footer">
                  <input class="b_foot" name=back type=button onclick="window.close()" value=关闭 index="41">
                  </TD>
            </TR>
          </TBODY>
        </TABLE>  
  
 <%@ include file="/npage/include/footer_pop.jsp" %>
</form>

</body>
</html>
