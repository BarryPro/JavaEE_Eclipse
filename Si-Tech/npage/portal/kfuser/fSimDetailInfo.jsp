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
  String simCode = "";
  String imsiNum = "";
  String pn1Num = "";
  String pn2Num = "";
  String puk1Num = "";
  String puk2Num = "";
  
  String SQL1 = "select to_char(sysdate,'yyyymm') from dual";/*报表数据@年月表@libina@20090519*/
  String login_no = (String)session.getAttribute("workNo");
%>
<wtc:service name="sHW_SimQuery"  routerKey="phone" routerValue="<%=phoneNo%>" outnum="8">
	<wtc:param value="<%=phoneNo%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />
<%
  if(retCode.equals("0")&&result!=null&&result.length>0)
  {
    simCode = result[0][2];
    imsiNum = result[0][3];
    pn1Num = result[0][4];
    pn2Num = result[0][5];
    puk1Num = result[0][6];
    puk2Num = result[0][7];
  }
  System.out.println("报表记录开始@libina@20090519");
	System.out.println("服务调用结果："+retCode+"/"+retMsg);
	int successFlag = 1;
	if("0".equals(retCode)){
	   successFlag = 0;
	}
%>
<wtc:pubselect name="sPubSelect" outnum="1">
  	<wtc:sql><%=SQL1%></wtc:sql> 	
  </wtc:pubselect>
	<wtc:array id="result1" scope="end"/> 	
<%
  String SQL2 = "insert into DLOGMANOPR"+result1[0][0]+" values(sysdate,'"+phoneNo+"','"+login_no+"','01002',"+successFlag+",'01002','0','SIM卡详情查询')";
%>  
    <wtc:service name="sPubModify" outnum="3">
			<wtc:param value="<%=SQL2%>"/>
			<wtc:param value="dbcall"/>
		</wtc:service>
<%
  System.out.println("报表记录结束@libina@20090519");
%>    

<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
<HTML>
<HEAD>
<title>SIM 信息查询结果</title>
</head>
<body>
<form action="#" method="post" name="form1" >
	<div id="Main">
	<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
			<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
				<div id="Operation_Title"><B>SIM 信息查询结果</B></div>
				<DIV id="Operation_Table">
	
  
      <div class="title">SIM卡信息</div>
	     		
       
              <TABLE width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr > 
                  <td width="6%" class="blue">服务号码</td>
                  <td width="13%"> 
                    <input class="InputGrey" readonly name="phonenotemp"  value="<%=phoneNo%>"> 
                  </td>
                  <td width="6%" class="blue">SIM卡号</td>
                  <td width="8%"> 
                    <input type="text" size="20" Class="InputGrey" readonly name="simCode"  value="<%=simCode%>">
                  </td>
                  <td width="6%" class="blue">IMSI号</td>
                  <td width="13%"> 
                    <input type="text" Class="InputGrey" readonly name="imsiNum"  value="<%=imsiNum%>">
                  </td>
                </tr>
                <tr>
                  <td width="6%" class="blue">PN1码</td>
                  <td width="8%"> 
                    <input type="text" Class="InputGrey" size="10" readonly name="pn1Num"  value="<%=pn1Num%>">
                  </td>
                  <td width="6%" class="blue">PN2码</td>
                  <td width="8%"> 
                    <input type="text" Class="InputGrey" readonly name="pn2Num"  value="<%=pn2Num%>">
                  </td>                  
                  <td width="6%" class="blue">PUK1码</td>
                  <td width="13%"> 
                    <input type="text" Class="InputGrey" readonly name="puk1Num"  value="<%=puk1Num%>">
                  </td>
                </tr>
                <tr>
                  <td width="6%" class="blue">PUK2码</td>
                  <td width="8%" colspan="5"> 
                    <input type="text" Class="InputGrey" size="10" readonly name="puk2Num"  value="<%=puk2Num%>">
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
