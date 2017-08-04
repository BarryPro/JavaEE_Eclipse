   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-23
********************/
%>
              
<%
  String opCode = "1414";
  String opName = "数据业务付奖";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%@ page contentType="text/html;charset=GB2312"%>
 
<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
    response.setDateHeader("Expires", 0); 
%>
<%
	String phone_no = request.getParameter("phone_no");
	System.out.println("phone_no: "+phone_no);
String regionCode = (String)session.getAttribute("regCode");
	String inParas="select a.login_accept,c.cust_name,a.award_info,to_char(a.op_time,'YYYYMMDD HH24:MI:SS'),a.op_note,to_char(award_sum) from wdataawardmsg a, dcustmsg b,dcustdoc c where a.phone_no = b.phone_no and b.cust_id = c.cust_id and a.phone_no = '"+phone_no+"' and back_flag = '0' and op_time >= to_date(to_char(sysdate,'YYYYMM')||'01 00:00:00','YYYYMMDD HH24:MI:SS') order by a.op_time";

//  CallRemoteResultValue value=  viewBean.callService("0",null,"sPubSelect",outNum, inParas); 
	%>
	
		<wtc:pubselect name="sPubSelect" outnum="6" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=inParas%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>	
	
	<%

 	String result[][]  = result_t;
 	System.out.println("result.length="+result.length);
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
		
	}	else if ( result.length==1 )
	{ 
 %>      	       
           <SCRIPT LANGUAGE="JavaScript">
             <!--
              window.returnValue="<%=result[0][0].trim()%>|<%=result[0][1].trim()%>|<%=result[0][2].trim()%>|<%=result[0][4].trim()%>|<%=result[0][5].trim()%>|";	
			  window.close(); 

             //-->
             </SCRIPT>  
<%   
    }
   else
   {
   %>
<html>
<head>
<title>查询数据业务付奖信息</title>
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

<BODY >
<form name="frm" method="post" action="">
	<%@ include file="/npage/include/header_pop.jsp" %>                         


	<div class="title">
		<div id="title_zi">数据业务付奖信息查询</div>
	</div>
  
  <table width="100%" border="0">
  	<%if (result.length>6) { %>
  	<tr> 
      <td  colspan="5" id="footer"> 
        <div align="center"> 
          <input class="b_foot" type="button" name="Button" value="确定" onClick="selWater()">
          <input class="b_foot" type="button" name="return" value="返回" onClick="window.close()">
        </div>
      </td>
    </tr>
    <%}%>
    <tr > 
      <th height="25" width="5%"> 选择
        <div align="center"> </div>
      </td>
      <th height="25" width="25%"> 
        <div align="center">操作流水</div>
      </th>
      <th height="25" width="30%"> 
        <div align="center">付奖信息</div>
      </th>
      <th height="25" width="25%"> 
        <div align="center">操作时间</div>
      </th>
      <th height="25" width="15%"> 
        <div align="center">付奖数量</div>
      </th>

    </tr>
    <% for(int i=0; i < result.length; i++)
	     {
     %>
    <tr > 
      <td height="25" width="5%"> 
        <div align="center"> 
          <input type="radio" name="water" value="<%=result[i][0].trim()%>|<%=result[i][1].trim()%>|<%=result[i][2].trim()%>|<%=result[i][4].trim()%>|<%=result[i][5].trim()%>|"  <%if (i==0) {%>checked<%}%>>
        </div>
      </td>
      <td height="25" width="15%"> 
        <div align="center"><%=result[i][0]%></div>
      </td>
      <td height="25" width="25%"> 
        <div align="center"><%=result[i][2]%></div>
      </td>
      <td height="25" width="25%"> 
        <div align="center"><%=result[i][3]%></div>
      </td>
      <td height="25" width="15%"> 
        <div align="center"><%=result[i][5]%></div>
      </td>

    </tr>
    <%}%>

 
    <tr> 
      <td  colspan="5" id="footer"> 
        <div align="center"> 
          <input class="b_foot" type="button" name="Button" value="确定" onClick="selWater()">
          <input class="b_foot" type="button" name="return" value="返回" onClick="window.close()">
        </div>
      </td>
    </tr>
  </table>
 <%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>
<%}%>

