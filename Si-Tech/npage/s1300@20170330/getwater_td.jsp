<%
/********************
 version v2.0
������: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
 
<%
    String opCode = "b302";
    String opName = "�ɷѳ���";
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
    response.setDateHeader("Expires", 0); 
%>
<%
    String contractno = request.getParameter("contractno");
	String billmonth = request.getParameter("billmonth");
	
	
   System.out.println("huhx getparameter: "+contractno);
   System.out.println("huhx getparameter: "+billmonth);
/*
	String  outNum = "4";
	String inParas[]={ "select login_accept,"+
		"decode(op_code,'1302','����ɷ�','1300','�ʺŽɷ�','1304','���յ��ɷ�','1306',"+
		"'��Ԥ��������','2327','�����û��ɷ�','3459','POS���ɷ�','5255','���г�ֵ�ʻ��ɷ�'),"+
		"to_char(sum(pay_money),'9999999990.00'),to_char(op_time,'YYYY-MM-DD HH24:MI:SS') from wPay"+billmonth+
		" where contract_no="+contractno+" and back_flag ='0' "+
		"and op_code in('1300','1302','1304','1306','2327','3459','5255') "+
		"group by login_accept,op_code,op_time order by op_time desc"};
	
  	ScallSvrViewBean viewBean = new ScallSvrViewBean();//ʵ����viewBean
  	CallRemoteResultValue value=  viewBean.callService("0",null,"TlsPubSelCrm",outNum, inParas); 
*/
	String sql = "select to_char(login_accept),decode(op_code,'1302','����ɷ�','1300','�ʺŽɷ�','1304','���յ��ɷ�','1306','��Ԥ��������','2327','�����û��ɷ�','3459','POS���ɷ�','5255','���г�ֵ�ʻ��ɷ�','b301','TD����̻�����ͳ��') as opName,to_char(sum(pay_money),'9999999990.00') as sumPayMoney,to_char(op_time,'YYYY-MM-DD HH24:MI:SS') as opTime from wPay? where contract_no=? and back_flag ='0' and op_code =('b301') group by login_accept,op_code,op_time order by op_time desc";
	System.out.println("sql==="+sql);
	
%>
<wtc:pubselect name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="4">
	<wtc:sql><%=sql%></wtc:sql>
	<wtc:param value="<%=billmonth%>"/>
	<wtc:param value="<%=contractno%>"/>
	</wtc:pubselect>
	<wtc:array id="result" scope="end" />
<%
 	//String result[][]  = value.getData();
%>
	<%
	 if(result==null||result.length==0)
	{   
	 %>
 	    <SCRIPT LANGUAGE="JavaScript">
	    <!--
	         window.close();
	    //-->
	    </SCRIPT>
	<%
		
	}
	else if ( result.length==1 )
	{ 
 %>      	       
           <SCRIPT LANGUAGE="JavaScript">
             <!--
              window.returnValue="<%=result[0][0].trim()%>";	
			  window.close(); 

             //-->
             </SCRIPT>  
<%   
    }
   else
   {
   %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>��ѯ�ɷ���ˮ</title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">

<script language="JavaScript">
window.returnValue='';
function selWater()
{	
        for(i=0;i<document.frm.water.length;i++) 
	  {		    
		      if (document.frm.water[i].checked==true)
		     {
 					 window.returnValue=document.frm.water[i].value;     
					 break;
			  }
	   } 
 		window.close(); 
}
</script>

</head>

<BODY>
<form name="frm" method="post" action="">
    <%@ include file="/npage/include/header_pop.jsp" %>     	
		<div class="title">
			<div id="title_zi">�ɷ���ˮ��ѯ</div>
		</div>

  <table border="0">
  	<%if (result.length>6) { %>
    <tr> 
      <td colspan="6" id="footer"> 
          <input class="b_foot" type="button" name="Button" value="ȷ��" onClick="selWater()">
          <input class="b_foot" type="button" name="return" value="����" onClick="window.close()">
      </td>
    </tr>
    <%}%>
    <tr> 
      <th> 
        <div align="center">&nbsp;</div>
      </th>
      <th> 
        <div align="center">�ɷ�����</div>
      </th>
      <th> 
        <div align="center">�ɷѽ��</div>
      </th>
      <th> 
        <div align="center">�ɷ�ʱ��</div>
      </th>
    </tr>
    <% for(int i=0; i < result.length; i++)
	     {
     %>
    <tr> 
      <td> 
        <div align="center"> 
          <input type="radio" name="water" value="<%=result[i][0].trim()%>"  <%if (i==0) {%>checked<%}%>>
        </div>
      </td>
      <td> 
        <div align="center"><%=result[i][1]%></div>
      </td>
      <td> 
        <div align="center"><%=result[i][2]%></div>
      </td>
      <td> 
        <div align="center"><%=result[i][3]%></div>
      </td>
    </tr>
    <%}%>

    
    <tr> 
      <td colspan="6" id="footer"> 
          <input class="b_foot" type="button" name="Button" value="ȷ��" onClick="selWater()">
          <input class="b_foot" type="button" name="return" value="����" onClick="window.close()">
      </td>
    </tr>
  </table>
  <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
<%}%>

