<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
  String workNo = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
  String org_code = (String)session.getAttribute("orgCode");
	String regionCode=org_code.substring(0,2);
  String cust_name = request.getParameter("cust_name").trim();
	String queryType = "3";
%>
	<wtc:service name="s1500PhoneQry"  outnum="9">
			<wtc:param value="<%=queryType%>"/>
			<wtc:param value="<%=cust_name%>"/>
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="<%=password%>"/>
			<wtc:param value="<%=regionCode%>"/>
			<wtc:param value="1500"/>
	</wtc:service>
<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
<HTML>
<HEAD>
<title>根据姓名查号码</title>
</head>
<body>
<form action="" method="post" name="form1" >
	<div id="Main">
	<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
			<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
				<div id="Operation_Title"><B>根据姓名查号码</B></div>
				<DIV id="Operation_Table">
	
  
      <div class="title">根据姓名查号码</div>
	     		
       
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
		      <tr> 
		    	   <th>服务号码</th>
		    	   <th>客户姓名</th>
		         <th>运行状态</th>
		         <th>入网时间</th>
		      </tr>
		      
		      
				  <wtc:iter id="rows" indexId="i" >        
				  <tr align="center">
						<td title="<%=rows[2]%>"><a href="fKQryPhoneDet.jsp?phone_no=<%=rows[2]%>"><%=rows[2]%></a></td>
						<td title="<%=rows[4]%>"><%=rows[4]%></td>
						<td title="<%=rows[6]%>"><%=rows[6]%></td>
						<td title="<%=rows[8]%>"><%=rows[8]%></td>
					</tr>
			   </wtc:iter>		      
		      
		      <tr align="center">
		      	<td align="center" colspan="4">
		      		<input class="b_foot" type="submit" name="sub" value="返回" onclick="history.go(-1);"/>
              <input class="b_foot" type="button" name="sub" value="关闭" onclick="window.close();"/>
		      	</td>
		    	</tr>
				</table>
			
	      </div>
            
  		
</DIV>
            <br />          
		  </td>
          <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="RightFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRight.jpg" width="20" height="45" /></td>
        </tr>
        <tr>
          <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeftDown.gif" width="20" height="20" /></td>
          <td valign="bottom"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#D8D8D8">
            <tr>
              <td height="1"></td>
            </tr>
          </table></td>
          <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRightDown.gif" width="20" height="20" /></td>
        </tr>
  </table>
</DIV>

			</FORM>
		</body>
</html>
