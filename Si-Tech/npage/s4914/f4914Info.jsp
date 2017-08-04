<%
   /*
   * 功能: 查询集团产品信息
　 * 版本: v1.0
　 * 日期: 2007/10/25
　 * 作者: sunzg
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
   * 2009-09-15    qidp        新版集团产品改造
 　*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
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
	
		
		//SPubCallSvrImpl impl = new SPubCallSvrImpl();
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
	   
			//retList = impl.sPubSelect("12",sqlStr, "region", regionCode);		  	  
			
			%>
                <wtc:service name="s4914EXC" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="13" >
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
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
</head>

<body>
	<div id="Operation_Table">	
		<table id="tabList" cellspacing=0>			
			<tr>				
				<th nowrap>手机号码</th>
				<th nowrap>客户名称</th>
				<th nowrap>运行状态</th>
			    <th nowrap>集团编码</th>
				<th nowrap>集团客户名称</th>
				<th nowrap>业务/产品代码</th>
				<th nowrap>业务/产品名称</th>
				<th nowrap>开始时间</th>
				<th nowrap>结束时间</th>
			</tr>
	<%	
		for(int i = 0; i < result.length; i++)
		{
		    String tdClass = "";
            if (i%2==0){
                tdClass = "Grey";
            }
	%>			
			<tr>				
				<td nowrap class='<%=tdClass%>'><%=result[i][0].trim()%></td>
				<td nowrap class='<%=tdClass%>'><%=result[i][1].trim()%></td>
				<td nowrap class='<%=tdClass%>'><%=result[i][3].trim()%></td>
			    <td nowrap class='<%=tdClass%>'><%=result[i][11].trim()%></td>
				<td nowrap class='<%=tdClass%>'><%=result[i][6].trim()%></td>
				<td nowrap class='<%=tdClass%>'><%=result[i][7].trim()%></td>
				<td nowrap class='<%=tdClass%>'><%=result[i][8].trim()%></td>
				<td nowrap class='<%=tdClass%>'><%=result[i][9].trim()%></td>
				<td nowrap class='<%=tdClass%>'><%=result[i][10].trim()%></td>
			
			</tr>
	<%
		}	%>		
			
		</table>
				
	</div>   

</body>
</html>