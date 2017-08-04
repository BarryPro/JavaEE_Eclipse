<%
   /*名称：SI订购关系查询 - EC个人用户查询
　 * 版本: v1.0
　 * 日期: 2007/2/9
　 * 作者: wuln
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	ArrayList retArray = new ArrayList();
	String[][] result = new String[][]{};
	 
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));
	
	String op_name = "EC个人用户查询";
	
	String strDate = new SimpleDateFormat("yyyyMMdd").format(new Date());

%>

<%
	boolean nextFlag = false;
	
	String idno = request.getParameter("idno");
	
	System.out.println("idno = " + idno);

	/********************* 输出参数 *************************/
	String[][] phoneNo     	= new String[][]{};   //个人成员号码
	String[][] custName   	= new String[][]{};   //个人客户名称
	String[][] vBeginTime  	= new String[][]{};   //定购时间    
	String[][] vRunCode    	= new String[][]{};   //当前状态    
	String[][] vRunName  		= new String[][]{};   // 运行名称    
	String[][] vIdNum       = new String[][]{};   // 证件号码    
	/******************************************************/
		
%>
    <wtc:service name="sQryECMebEXC" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg" outnum="6" >
    	<wtc:param value="<%=idno%>"/>
    </wtc:service>
	<wtc:array id="phoneNo"    start="0" length="1" scope="end"/>
	<wtc:array id="custName"   start="1" length="1" scope="end"/>
	<wtc:array id="vBeginTime" start="2" length="1" scope="end"/>
	<wtc:array id="vRunCode"   start="3" length="1" scope="end"/>
	<wtc:array id="vRunName"   start="4" length="1" scope="end"/>
	<wtc:array id="vIdNum"     start="5" length="1" scope="end"/>
    						 
<%	
  if("000000".equals(errCode))
 	{
 		nextFlag = true;
		    
		if(phoneNo.length == 0)
		{			
		nextFlag = false;
%>
			<script language='jscript'>
				rdShowMessageDialog("没有查到相关记录！");
				window.close();
			</script>
<%  
		}	 	
	}else
    {
%>        
		  <script language='jscript'>
	          rdShowMessageDialog("错误信息：<%=errMsg%>",0);
	          window.close();
	    </script>         
<%            
    }
%>

<head>
<title><%=op_name%></title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
</head> 
<%if(nextFlag)
{	
%>
<body >

<form name="form1" method="post" action="">	
<input type="hidden" name="OprCode" value="05" >
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">SI订购关系查询</div>
</div>
        
		<TABLE cellSpacing=0>
	         </TR> 	         
             <TR id="line_1">
             	<TD >个人成员号码</TD>
				<TD >个人客户名称</TD>
	            <TD >定购时间    	</TD> 	         								    		            	              
	            <TD >当前状态    	</TD> 	         								    		            	              
	            <TD >运行名称    	</TD> 	         								    		            	              
	            <TD >证件号码    	</TD> 	         								    		            	              
	         </TR>
	         
	         <%
	         for(int i=0;i<phoneNo.length;i++)
	         {
	         %>
	          <TR id="line_1"> 
	          	<TD ><%=phoneNo[i][0]%></TD>
	          	<TD ><%=custName[i][0]%></TD>
	          	<TD ><%=vBeginTime[i][0]%></TD>
	          	<TD ><%=vRunCode[i][0]%></TD>
	          	<TD ><%=vRunName[i][0]%></TD>
	          	<TD ><%=vIdNum[i][0]%></TD>
	         </TR>
	        <%}%>
	         
		</TABLE>	       
		
 
		<TABLE cellSpacing=0>
			 <TR> 
	         	<TD id="footer"> 		      
	         	    <input name="backBtn" style="cursor:hand" type="button" class="b_foot" value="返回" onClick="javascript:window.close()">	         	    	         	     		         	     	         	   
			 	</TD>
	       </TR>
	    </TABLE>	   	
	   	
	</div>	 
</form>
</body>
<%}%>
</html>

