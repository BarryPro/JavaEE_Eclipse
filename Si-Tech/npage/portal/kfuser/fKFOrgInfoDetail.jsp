<%
  /*
　 * 修改历史
   * 修改日期 2009-05-19     修改人  libina     修改目的  增加业务点击统计（报表）
 　*/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
  String phoneNo  = (String)session.getAttribute("activePhone");

  String SQL1 = "select to_char(sysdate,'yyyymm') from dual";/*报表数据@年月表@libina@20090519*/
  String login_no = request.getParameter("workNo").trim();
  System.out.println("***************************"+login_no);
%>
<wtc:service name="sKFOrgInfo_new" outnum="14" routerKey="phone" routerValue="<%=phoneNo%>">
	<wtc:param value="<%=phoneNo%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />
<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
<HTML>
<HEAD>
<title>归属集团资料</title>
</head>
<body>
<form action="#" method="post" name="form1" >
	<div id="Main">
	<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
			<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
				<div id="Operation_Title"><B>归属集团资料</B></div>
				<DIV id="Operation_Table">
	
  
      <div class="title">归属集团资料</div>
	     		
       <%
         if(result!=null && result.length>0){
       %>
              <TABLE width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr > 
                  <td width="6%" class="blue">集团名称</td>
                  <td width="13%"> 
                    <%=result[0][0]==null||result[0][0].trim().equals("")?"&nbsp;&nbsp;":result[0][0].trim()%>
                  </td>
                  <td width="6%" class="blue">集团联系人</td>
                  <td width="8%"> 
                    <%=result[0][1]==null||result[0][1].trim().equals("")?"&nbsp;&nbsp;":result[0][1].trim()%>
                  </td>
                  <td width="6%" class="blue">加入集团时间</td>
                  <td width="13%"> 
                    <%=result[0][2]==null||result[0][2].trim().equals("")?"&nbsp;&nbsp;":result[0][2].trim()%>
                  </td>
                </tr>
                <tr>
                  <td width="6%" class="blue">集团签约时间</td>
                  <td width="8%"> 
                    <%=result[0][3]==null||result[0][3].trim().equals("")?"&nbsp;&nbsp;":result[0][3].trim()%>
                  </td>
                  <td width="6%" class="blue">集团联系电话</td>
                  <td width="8%"> 
                    <%=result[0][4]==null||result[0][4].trim().equals("")?"&nbsp;&nbsp;":result[0][4].trim()%>
                  </td>                  
                  <td width="6%" class="blue">企业类型</td>
                  <td width="13%"> 
                    <%=result[0][5]==null||result[0][5].trim().equals("")?"&nbsp;&nbsp;":result[0][5].trim()%>
                  </td>
                </tr>
                <tr>
                  <td width="6%" class="blue">企业类型名称</td>
                  <td width="8%"> 
                    <%=result[0][6]==null||result[0][6].trim().equals("")?"&nbsp;&nbsp;":result[0][6].trim()%>
                  </td>
                  <td width="6%" class="blue">区域类型</td>
                  <td width="8%"> 
                    <%=result[0][7]==null||result[0][7].trim().equals("")?"&nbsp;&nbsp;":result[0][7].trim()%>
                  </td>                  
                  <td width="6%" class="blue">区域类型名称</td>
                  <td width="13%"> 
                    <%=result[0][8]==null||result[0][8].trim().equals("")?"&nbsp;&nbsp;":result[0][8].trim()%>
                  </td>
                </tr>
                <tr>
                  <td width="6%" class="blue">行业代码</td>
                  <td width="8%"> 
                    <%=result[0][9]==null||result[0][9].trim().equals("")?"&nbsp;&nbsp;":result[0][9].trim()%>
                  </td>
                  <td width="6%" class="blue">行业名称</td>
                  <td width="8%"> 
                    <%=result[0][10]==null||result[0][10].trim().equals("")?"&nbsp;&nbsp;":result[0][10].trim()%>
                  </td>                  
                  <td width="6%" class="blue">区域代码</td>
                  <td width="13%"> 
                    <%=result[0][11]==null||result[0][11].trim().equals("")?"&nbsp;&nbsp;":result[0][11].trim()%>
                  </td>
                </tr>
     						<tr>
                  <td width="6%" class="blue">区域名称</td>
                  <td width="8%"> 
                    <%=result[0][12]==null||result[0][12].trim().equals("")?"&nbsp;&nbsp;":result[0][12].trim()%>
                  </td>
                  <td width="6%" class="blue">法人</td>
                  <td width="8%" colspan="3"> 
                    <%=result[0][13]==null||result[0][13].trim().equals("")?"&nbsp;&nbsp;":result[0][13].trim()%>
                  </td>
                </tr>
              </table>
			<%
			  }
			%>
	      </div>
<%
  System.out.println("报表记录开始@libina@20090519");
	System.out.println("服务调用结果："+retCode+"/"+retMsg);
	int successFlag = 1;
	if("000000".equals(retCode)){
	   successFlag = 0;
	}
%>
<wtc:pubselect name="sPubSelect" outnum="1">
  	<wtc:sql><%=SQL1%></wtc:sql> 	
  </wtc:pubselect>
	<wtc:array id="result1" scope="end"/> 	
<%
  String SQL2 = "insert into DLOGMANOPR"+result1[0][0]+" values(sysdate,'"+phoneNo+"','"+login_no+"','01003',"+successFlag+",'01003','0','归属集团详细资料查询')";
%>  
    <wtc:service name="sPubModify" outnum="3">
			<wtc:param value="<%=SQL2%>"/>
			<wtc:param value="dbcall"/>
		</wtc:service>
<%
  System.out.println("报表记录结束@libina@20090519");
%>    
  		
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
