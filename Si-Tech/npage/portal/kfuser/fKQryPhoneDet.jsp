<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode=org_code.substring(0,2);
  String phoneNo  = (String)session.getAttribute("activePhone");
  String phone_no = request.getParameter("phone_no").trim();
	String sqlStr = "select a.cust_name,a.id_address,a.id_iccid,a.contact_post from dcustdoc a,dcustmsg b where a.cust_id = b.cust_id and b.phone_no = '?'";
%>
<wtc:pubselect name="sPubSelect" outnum="4">
	 <wtc:sql><%=sqlStr%></wtc:sql>
	 <wtc:param value="<%=phone_no%>"/>
</wtc:pubselect>
<wtc:array id="result" scope="end" />
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
		    	   <td>客户姓名</td>
		    	   <td><%=result[0][0]%></td>
		    	   <td>客户地址</td>
		    	   <td><%=result[0][1]%></td>
		      </tr>     
		      <tr> 
		    	   <td>身份证号</td>
		    	   <td><%=result[0][2]%></td>
		    	   <td>邮政编码</td>
		    	   <td><%=result[0][3]%></td>
		      </tr>
					<tr align="center">
		      	<td align="center" colspan="4">
		      		<input class="b_foot" type="submit" name="sub" value="返回" onclick="javascript:history.go(-1);"/>
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
