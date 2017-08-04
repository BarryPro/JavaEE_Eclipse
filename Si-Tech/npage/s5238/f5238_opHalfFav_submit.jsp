<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-19
********************/
%>
 <%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.channelmng.PrdMgrSql" %>
<%@page contentType="text/html;charset=gb2312" %>
<%
	//读取用户session信息
			
	//错误信息，错误代码
	int errCode = 0;
	String errMsg = "";

	String login_accept = request.getParameter("login_accept");
	String region_code = request.getParameter("region_code");
	String mode_code = request.getParameter("mode_code");
	String mode_name = request.getParameter("mode_name");
	String favour_type = request.getParameter("favour_type");
	String half_rate = request.getParameter("half_rate");


    PrdMgrSql ProductExcludeSql=new PrdMgrSql();
	String sqlStr = "",sqlStr2="";
	List sqlList=new ArrayList();

	sqlStr2="delete from TMIDBILLHALFFAV where login_accept="+login_accept;

	sqlStr = "insert into TMIDBILLHALFFAV (LOGIN_ACCEPT, REGION_CODE, MODE_CODE, FAVOUR_TYPE, HALF_RATE,BILL_NAME) values("+login_accept+
	       ",'"+region_code+"'"+ 
		   ",'"+mode_code+"'"+
		   ",'"+favour_type+"'"+
		   ","+half_rate+""+
		   ",'"+mode_name+"'"+
		   ")";
    sqlList.add(sqlStr2);
    sqlList.add(sqlStr);
    
	errCode = ProductExcludeSql.updateTrsaction(sqlList);
	
	if(errCode == 0)
    {
%>
        <script language='javascript'>
        	rdShowMessageDialog("<%=errCode%>" + "[" + "增加失败" + "]" ,0);
	        history.go(-1);
        </script>
<%	}
	else
	{
%>
		<script language='javascript'>
			rdShowMessageDialog("配置成功" ,2);
			window.close();
        </script>
<%
	}
%>

