<%
   /*
   * 功能: 查询集团产品信息
　 * 版本: v1.0
　 * 日期: 2007/10/25
　 * 作者: sunzg
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
   * 2009-09-17    qidp        新版集团产品改造
 　*/
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@page contentType="text/html;charset=GBK"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
		Logger logger = Logger.getLogger("f4914Info.jsp");
		ArrayList retArray = new ArrayList();
		String[][] result = new String[][]{};	
			 
		String loginName = WtcUtil.repNull((String)session.getAttribute("workName"));
		String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
		String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
		String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
		String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
		String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));
		String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
	
		
		ArrayList retList = new ArrayList(); 
		
		String sqlStr="";	
	    String custID = request.getParameter("custID");
	    String queType = request.getParameter("queType");
	    String queCondition = request.getParameter("queCondition");
	    System.out.println("\n\ncustID"+custID);
	    System.out.println("queType"+queType);
	    System.out.println("queCondition\n\n"+queCondition);
	    
	    String opCode = "4914";
	  
	try {
	   
			//retList = impl.sPubSelect("7",sqlStr, "region", regionCode);		  	
			
			%>
                <wtc:service name="s4914EXC" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="7" >
                	<wtc:param value="<%=opCode%>"/>
                    <wtc:param value="<%=loginNo%>"/>
                	<wtc:param value="<%=queType%>"/>
                	<wtc:param value="<%=queCondition%>"/>
                	<wtc:param value="<%=custID%>"/>
                </wtc:service>
                <wtc:array id="retArr" scope="end"/>
            <%
           
                if("000000".equals(retCode.trim()) && retArr.length>0){
                    result = retArr; 
                }
                
                
                if(result==null || result.length == 0){
%>
				<script language="javascript">
				 	rdShowMessageDialog("没有查到相关记录！",0);
				 	//parent.location="f2893_1.jsp";		
				</script>
  <%						 			
		  }
			}
			catch(Exception e)
			{
			    e.printStackTrace();
		    %>
		        <script type=text/javascript>
		            rdShowMessageDialog("查询成员信息失败",0);
		        </script>
		    <%
				System.out.println("\n==================\n error1");
			}
	%>	

<script language="javascript">
	//显示某条业务信息
	function showInfo(v_id)
	{  
        var str = "?operId=" + document.form1["operId" +v_id].value ;
        var path="f4914_showInfo.jsp" + str;
		window.open(path,'','width='+(screen.availWidth*1-10)+',height='+(screen.availHeight*1-76) +',left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
	}		
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<head>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
</head>
<body>
<form name="form1" method="post" action="">	
	<div id="Operation_Table">	
		<table id="tabList" cellspacing=0>			
			<tr>								
                <th nowrap>集团用户编码</th>
			    <th nowrap>集团编码</th>
				<th nowrap>集团客户名称</th>
				<th nowrap>业务/产品代码</th>
				<th nowrap>业务/产品名称</th>
				<th nowrap>开户时间</th>
				
			</tr>
	<%	
		for(int i = 0; i < result.length; i++)
		{
	%>				
	    <tr id="tr<%=i+1%>">	    	
	    	<input type="hidden" name="operId<%=i+1%>" value="<%=result[i][0].trim()%>">
		        <td nowrap><a style="CURSOR: hand; TEXT-DECORATION: none" href="javascript:showInfo(<%=i+1%>)"><%=result[i][0].trim()%></a></td>							
			    <td nowrap><%=result[i][1].trim()%></td>
				<td nowrap><%=result[i][2].trim()%></td>
				<td nowrap><%=result[i][3].trim()%></td>
				<td nowrap><%=result[i][4].trim()%></td>
				<td nowrap><%=result[i][5].trim()%></td>
			</tr>
	<%
		}	%>				
		</table>
	</div>   
</form>
</body>
</html>