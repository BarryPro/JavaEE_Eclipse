<%
   /*

 　*/
%>

<%@page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>

<%
	ArrayList retArray = new ArrayList();
	String[][] result = new String[][]{};
	String regCode = (String)session.getAttribute("regCode");
	String workNo = (String)session.getAttribute("workNo");
	String workPwd = (String)session.getAttribute("password");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode=org_code.substring(0,2);	
  String[][] colNameArr = new String[][]{};
  String opCode = "e715";	
	String opName = "基本接入号列表";	
	
	//-----------------------------------------------
	
	String queryType = request.getParameter("queryType");
	String queryInfo = request.getParameter("queryInfo");	
	String baseserve = request.getParameter("baseserve");
	String notype = request.getParameter("notype");	
	
%>
	 
	
	
		       



<html>
<head>
<title><%=opName%></title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<SCRIPT LANGUAGE=javascript FOR=document EVENT=onkeydown>
window.onkeydown(window.event) 
</SCRIPT>

</head>
<body>
<form name="frm" method="POST" >
<%@ include file="/npage/include/header.jsp" %>
<input type="hidden" name="notype" value="<%=notype%>">
<div id="productList" >
<div class="title"><div id="title_zi">基本接入号信息列表</div></div>
<table width="99%" border="0" align="center" cellpadding="1" cellspacing="1">		
   
	<tr align="center">
		    <th nowrap>选择</th>
        <th nowrap>基本接入号</th>
        <th nowrap>接入号属性</th>          
	</tr>
	<wtc:service name="se715Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2" >
            	<wtc:param value="<%=queryInfo%>"/>
            	<wtc:param value="<%=queryType%>"/>
              <wtc:param value="<%=notype%>"/>
              <wtc:param value="<%=baseserve%>"/>
              <wtc:param value="<%=workNo%>"/>
              <wtc:param value="<%=workPwd%>"/>
             
   </wtc:service>
   <wtc:array id="colNameArrTemp" scope="end" />
   	<%
    
	    
	  if (retCode.equals("000000")){
  		        colNameArr = colNameArrTemp;
  		    }else{
  		        %>
  		            <script type=text/javascript>
  		                rdShowMessageDialog("错误代码：<%=retCode%>，错误信息：<%=retMsg%>",0);
  		                window.close();
  		            </script>
  		        <%
  		    }  	
		 for(int i=0;i<colNameArr.length;i++){

       System.out.println(colNameArr[i][0]);
       System.out.println(colNameArr[i][1]);
     
%>     
		<tr align="center">
 			<td nowrap class="blue" > 
 				<input type="radio" name="num" value="<%=i%>">
        	<input type="hidden" name="BaseCode" value="<%=colNameArr[i][0]%>">	</td>
			<td nowrap class="blue"><%=colNameArr[i][0].trim()%></td>
      
<%      if("01".equals(colNameArr[i][1].trim()))
        {
%>
        <td nowrap class="blue">短信</td>
<%      }
        else if("02".equals(colNameArr[i][1].trim()))
        {
%>
				<td nowrap class="blue">彩信</td>
<%      }
   			else  {
%>
				<td nowrap class="blue">WAPPush</td>
<%      }  
  %>   
    </tr>
    <%
       }
    %>
	</TABLE>
    </DIV>
	</TD>
	</TR>
</table>
<table width="99%" border="0" align="center" cellpadding="1" cellspacing="1">
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td>
				<div align="center">
			      <input type="button" name="commit" class="b_text" style="cursor:hand" onClick="doCommit();" value=" 确定 ">
			      &nbsp;
			      <input type="button" name="back" class="b_text" style="cursor:hand" onClick="doClose();" value=" 关闭 ">
		    </div>
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

<script>
	  

	function doCommit()
	{		
		if("<%=colNameArr.length%>"=="0")
		{
			rdShowMessageDialog("没有可选择的记录！");
			return false;
		}
		else if("<%=colNameArr.length%>"=="1")
		{//值为一条时不需要用数组
			if(document.all.num.checked)
			{	
				var notype=document.all.notype.value;			
				if(notype=="0"){
			  window.opener.frm.OldBaseServCode.value = document.all.BaseCode.value;
			   }else{
			  window.opener.frm.NewBaseServCode.value = document.all.BaseCode.value; 	
			  }
			
				window.close();
			}
			else
			{
				rdShowMessageDialog("请选择记录！");
				return false;
			}
		}
		else
		{//值为多条时需要用数组
			var a=-1;
			for(i=0;i<document.all.num.length;i++)
			{
				if(document.all.num[i].checked)
				{
					a=i;
					break;
				}
			}
			if(a!=-1)
			{				
				var notype=document.all.notype.value;			
				if(notype=="0"){
			  window.opener.frm.OldBaseServCode.value = document.all.BaseCode[a].value;
			   }else{
			  window.opener.frm.NewBaseServCode.value = document.all.BaseCode[a].value; 	
			  }			
				window.close();
			}
			else
			{
				rdShowMessageDialog("请选择记录！");
				return false;
			}
		}
	}
	
	function onkeydown(event) 
	{
		if (event.srcElement.type!="button")
		{
			if (event.keyCode == 13)
			{
				doCommit();
			}
		}
	}
	function doClose()
	{
		window.close();
	}
</script>

