 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-12 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>


<%
	//取得工号,操作员
   	String opCode = (String)request.getParameter("opCode");
	String opName = (String)request.getParameter("opName");
	String regionCode= (String)session.getAttribute("regCode");
	
    	String workno = (String)session.getAttribute("workNo");    

	String in_phoneNo = request.getParameter("phoneno");
	String in_qianyuemode = request.getParameter("qianyuemode");
	System.out.println(workno);
	System.out.println(in_phoneNo);
	System.out.println(in_qianyuemode);
	String[] inParas = new String[3];
	inParas[0] = workno;
	inParas[1] = in_phoneNo;
	inParas[2] = in_qianyuemode;
	//ScallSvrViewBean viewBean = null;
	//CallRemoteResultValue value = null;
	String iErrorNo = "0";
    	String sErrorMessage = ""; 
	String result[][] = null;

	try {
		 //viewBean = new ScallSvrViewBean();//实例化viewBean
		 //value = viewBean.callService("0",null,"s1445Info","16", inParas);
		 %>
		 	<wtc:service name="s1445Info" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="16" >
				<wtc:param value="<%=inParas[0]%>"/>
				<wtc:param value="<%=inParas[1]%>"/>
				<wtc:param value="<%=inParas[2]%>"/>				
			</wtc:service>
			<wtc:array id="result1" scope="end"/>
		 <%
		iErrorNo = retCode1;
 		sErrorMessage = retMsg1;
		
		if (iErrorNo.equals("000000")) {
			result  = result1;
		}

	} catch  (Exception e)
	{	
		iErrorNo = "9";
		sErrorMessage = "Error : callService s1445Info!";
		System.out.println("Error : callService s1445Info!");
	}

	System.out.println(iErrorNo);
	System.out.println(sErrorMessage);
	
%>

<%if (!iErrorNo.equals("000000")) { %>
   <SCRIPT LANGUAGE="JavaScript">
    <!--
        window.returnValue = "<%=iErrorNo + "|" + sErrorMessage%>"; 
        window.close();
    //-->
   </SCRIPT>  
<% } else if(result==null||result.length==0) { %>
   <SCRIPT LANGUAGE="JavaScript">
      <!--
       	 window.close();
      //-->
   </SCRIPT>
<% } else  if ( result.length==1 ){ %>      
 		<SCRIPT LANGUAGE="JavaScript">
 		<!--
			window.returnValue="<%=result[0][0].trim()+"|" + result[0][1].trim()+"|" + result[0][2].trim()+"|" + result[0][3].trim()+"|" + result[0][4].trim()+"|" + result[0][5].trim()+"|" + result[0][6].trim()+"|" + result[0][7].trim()+"|" + result[0][8].trim()+"|" + result[0][9].trim()+"|" + result[0][10].trim()+"|" + result[0][11].trim()+"|" + result[0][12].trim() + "|" + result[0][13].trim() + "|" + result[0][14].trim()+"|"+ result[0][15].trim()%>";
			window.close(); 		
 		//-->
 		</SCRIPT>
<% } else { %>
<HTML>
<HEAD>
<TITLE>黑龙江BOSS-方案代码查询</TITLE>
	<script language="JavaScript">
		window.returnValue='';
		function selAccount() {
		     for(i=0;i<document.frm.account.length;i++) {		    
			      if (document.frm.account[i].checked==true) {
		 			 window.returnValue=document.frm.account[i].value;     
					 break;
			      }
		     }
		   
		     window.close(); 
		}
	</script>
</head>
<BODY>
<form name="frm" method="post" action="">  
	
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">查询结果</div>
		</div>
  <table cellspacing="0">
    <tr>   
    	<th>选择</th>    
      	<th> 方案名称  </th>
    	<th>  月底线  </th>
    	<th> 活动预存  </th>
    	<th> 奖品名称或机器名称  </th>
    	<th> 赠送积分  </th>
    	<th> 积分消费期限  </th>
    </tr>
    <% for(int i=0; i < result.length  ; i++)
	{
		String tdClass = (i%2==0)?"Grey":"";
		%>
			<tr> 
			  <td class="<%=tdClass%>"> 				
				  <input type="radio" name="account" value="<%=result[i][0].trim()+"|" + result[i][1].trim()+"|" + result[i][2].trim()+"|" + result[i][3].trim()+"|" + result[i][4].trim()+"|" + result[i][5].trim()+"|" + result[i][6].trim()+"|" + result[i][7].trim()+"|" + result[i][8].trim()+"|" + result[i][9].trim()+"|" + result[i][10].trim()+"|" + result[i][11].trim()+"|" + result[i][12].trim()+"|" + result[i][13].trim() + "|"+ result[i][14].trim() + "|" + result[i][15].trim()%>"  <%if (i==0) {%>checked<%}%>>
				
			  </td>
			  <td class="<%=tdClass%>"> 
				<%=result[i][1]%>
			  </td>
              
			  <td class="<%=tdClass%>"> 
				<%=result[i][3]%>
			  </td>
			  
			  <td class="<%=tdClass%>"> 
				<%=result[i][4]%>
			  </td>

			  <td class="<%=tdClass%>"> 
				<%=result[i][7]%>
			  </td>
			   <td class="<%=tdClass%>"> 
				<%=result[i][10]%>
			  </td>
			   <td class="<%=tdClass%>"> 
				<%=result[i][11]%>
			  </td>
			</tr>
    <%}%> 
    </table>
    <table cellspacing="0">
      <td id="footer">         
          <input class="b_foot" type="button" name="Button" value="确定" onClick="selAccount()">
          <input  class="b_foot" type="button" name="return" value="返回" onClick="window.close()">
        
      </td>
    </tr>
  </table>
<%@ include file="/npage/include/footer_simple.jsp" %>   
</form>
</body>
</html>
<%}%>
