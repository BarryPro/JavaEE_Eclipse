<%
/********************
 version v2.0
������: si-tech
*
*update:wanghyd@2012-6-25
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%

    String rowNum = "16";
    String getAcceptFlag = "";
    
    String regionCode= (String)session.getAttribute("regCode");
    String workNo = (String)session.getAttribute("workNo");
    String workName = (String)session.getAttribute("workName");
    String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	  String opName = WtcUtil.repStr(request.getParameter("opName"), "");
	  String scounts="";
	   String[] inParamsss1 = new String[2];
		inParamsss1[0] = "SELECT count(1) FROM dservordermsg a, dcustmsg b WHERE a.order_status <> 140  and a.finish_flag <> 'Y' and a.id_no = b.id_no and b.SM_CODE not in ('kd','ke') and a.login_no =:loginno";
		inParamsss1[1] = "loginno="+workNo;
  %> 
		  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="1">			
				<wtc:param value="<%=inParamsss1[0]%>"/>
				<wtc:param value="<%=inParamsss1[1]%>"/>	
				</wtc:service>	
		  <wtc:array id="dcount" scope="end" /> 
		  	<%
				  	if(dcount.length>0) {
				  	scounts=dcount[0][0];
				  	}
				  	if(scounts.equals("0")) {
				    }else {
				  	%>
				  	<script language='JavaScript'>
		            rdShowMessageDialog("����δ�����������뿢������ٽ���ǩ��" ,1);		         
		        </script>
		        <%}%>
		  	
  		<wtc:service name="sGenRptTotal" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="6">
				<wtc:param value="<%=workNo%>"/>
				<wtc:param value="<%=dateStr%>"/>
				<wtc:param value="9999"/>
				<wtc:param value="<%=workName%>ǩ��"/>

		</wtc:service>
		<wtc:array id="temp" scope="end"  start="0"  length="4"/>
		<wtc:array id="temp1" scope="end"  start="4"  length="2"/> 
 <%   
   

	 if( !retCode.equals("000000"))
     {
%>
        <script language='JavaScript'>
            rdShowMessageDialog("<%=retCode%>" + "[" + "<%=retMsg%>" + "]" ,0);
            //removeCurrentTab();
        </script>
<%
    }
%>

<HTML><HEAD><TITLE>����ǩ��</TITLE>
</HEAD>
<body >


<FORM method=post name="f1500_custuser">
<%@ include file="/npage/include/header.jsp"%>
      <table >
      
          <TR >
            <TD class="blue" width="8%">��������</TD>
            <TD class="blue" colspan="3"><%=workName%></TD>

          </TR>
       
      </table>
<br>
           <TABLE >
             
                <TR > 			
                  <Th>��������</Th>
                  <Th>��������</Th>
                  <Th>���ױ���</Th>
                  <Th>���׽��</Th>
                </TR>
<%			for(int y=0;y<temp.length;y++)
			{
%>
			 <tr >
<%				for(int j=0;j<temp[y].length;j++)
			 {
%>
				 <td > <%= temp[y][j]%> </td>
<%			 }
%>
	        </tr>
<%	      }	   
%>
				<TR > 			
                  <TD width=12%>�ϼƣ�</TD>
                  <TD width=13%>--</TD>
                  <TD width=10%><%if(temp1.length>0){out.print(temp1[0][0]);}%></TD>
                  <TD width=20%><%if(temp1.length>0){out.print(temp1[0][1]);}%></TD>
                </TR>
              
            </TABLE>
		<table cellspacing="0">
			<tr>
				<td noWrap id="footer">
					<div align="center">
					<input class="b_foot" name=back onClick="removeCurrentTab();" type=button value=�ر�>
					</div></td>
			</tr>
		</table>
    </td>
  </tr>
</table>
<%@ include file="/npage/include/footer.jsp"%>
</FORM>
</BODY></HTML>