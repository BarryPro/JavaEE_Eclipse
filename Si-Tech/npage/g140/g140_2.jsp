<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-07
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.amd.viewbean.*" %>
 <%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>
 <%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>

<%@ page import="java.util.*"%>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>

<%
    String opCode = "g140";
    String opName = "集团客户欠费查询";
    String phoneNo = request.getParameter("userno");
	String count = request.getParameter("contract_no");
	String userType = request.getParameter("userType");
	
    String otherFlag = request.getParameter("otherFlag");	//查询方式 0产品id 1unit_id
	String beginTime = request.getParameter("beginTime");
	String endTime = request.getParameter("endTime");
    System.out.println("AAAAAAAAAAAAAAAAAAAAAAa userType："+userType+" and 查询方式 is "+otherFlag);
	
    String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String region_code = org_code.substring(0,2);
	String unid_id=request.getParameter("unit_id");
	String cust_id="";
    String inParas2[] = new String[2];
	inParas2[0]="6 ";
	inParas2[1]="unid_id="+unid_id;
	System.out.println("ccccccccccccccccccccccccccccccccc test otherFlag is "+otherFlag);
	if(otherFlag.equals("0"))
	{
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa 000000000000000000000000");
		%>
		<wtc:service name="sBossDefSqlSel" retcode="sConMoreQryCode" retmsg="sConMoreQryMsg" outnum="1">
			<wtc:param value="<%=inParas2[0]%>"/> 
			<wtc:param value="<%=inParas2[1]%>"/>
		 
		</wtc:service>
		<wtc:array id="ret_val" scope="end" />
	<%
		if((ret_val==null||ret_val.length==0)  )
		{
			%>
				<script language="javascript">rdShowMessageDialog("查询集团客户编码报错!");
					history.go(-1); 
				</script>
			<%
		}
		else
		{
			cust_id=ret_val[0][0];
		}
	}
	
	String op_code = "g140";
	String busy_name="集团客户欠费查询";
	// tianyang 修改 20090818
	//ArrayList arlist = new ArrayList();
	String inParas[] = new String[8];
	inParas[0] = cust_id;
	inParas[1] = count;
	inParas[2] = otherFlag ;
	inParas[3] = beginTime;
	inParas[4] = "region_code";
	inParas[5] = "sm_code";
	inParas[6] = opCode;       
	inParas[7] = workNo;
 
	
%>


<wtc:service name="sg140" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode" retmsg="retMsg" outnum="4">
    <wtc:param value="<%=inParas[0]%>"/> 
    <wtc:param value="<%=inParas[1]%>"/>
    <wtc:param value="<%=inParas[2]%>"/>
    <wtc:param value="<%=inParas[3]%>"/>
    <wtc:param value="<%=inParas[4]%>"/>
    <wtc:param value="<%=inParas[5]%>"/>
    <wtc:param value="<%=inParas[6]%>"/>
	<wtc:param value="<%=inParas[7]%>"/> 
</wtc:service>
<wtc:array id="sCon"  scope="end" />
 
<%
	String[][] result = new String[][]{};
	if(sCon==null||sCon.length==0)
	{
		%>
			<script language="javascript">rdShowMessageDialog("集团客户欠费查询失败!错误代码："+"<%=retCode%>");
				history.go(-1);
			</script>
		<%
	}
    else
	{
		result=sCon;
	 
		%>
			<script language="javascript">//alert("ok! "+"<%=retCode%>");
				//history.go(-1);
			</script>
			<html xmlns="http://www.w3.org/1999/xhtml">
				<HEAD>
				<META content=no-cache http-equiv=Pragma>
				<META content=no-cache http-equiv=Cache-Control>
				<title>集团客户欠费查询</title>
				<meta http-equiv="Content-Type" content="text/html; charset=GBK">
				</head>

				<BODY>
				<FORM action="PayCfm.jsp" method="post" name="form" onSubmit="return DoCheck()">
				<%@ include file="/npage/include/header.jsp" %>
				<div class="title">
					<div id="title_zi">集团客户欠费信息展示</div>
				</div>
				<table cellspacing="0" id="tabList">
					<tr>
						<th nowrap>产品名称</th>
						<th nowrap>产品账户ID</th>
						
						<th nowrap>欠费金额</th>
						<th nowrap>结清状态</th>
					<tr>
					<%
				  for(int y=0;y<sCon.length;y++)
				  { 
			%>
					<tr>
			<%    	    for(int j=0;j<sCon[0].length;j++)
						{
			%>
						  <td height="25" nowrap>&nbsp;<%= sCon[y][j]%></td>
			<%	        }
			%>			 
					</tr>
			<%	   }
			%>
			<td align="center" id="footer" colspan="4">
			 
			&nbsp; <input class="b_foot" name=back onClick="window.location='g140_1.jsp'" type="button" value="返回">
			&nbsp;  
			</td>
				</TABLE>
				<%@ include file="/npage/include/footer.jsp" %>
				</body>
			</html>
		<%
	}

%> 

	 
	  