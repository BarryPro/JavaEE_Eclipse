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
	int errCode = 0;
	String errMsg = "";
System.out.println("------------------f5238opModeFlag_submit.jsp-------------");
	String login_accept = request.getParameter("login_accept");
	String region_code = request.getParameter("region_code");
	String mode_code = request.getParameter("mode_code");
    String flag_codes_list = request.getParameter("flag_codes_list") ;
	String op_codes_list = request.getParameter("op_codes_list") ; 

	String[] flag_codes_array = flag_codes_list.split(",");
	String[] op_codes_array = op_codes_list.split(",");

    PrdMgrSql ProductExcludeSql=new PrdMgrSql();
	String sqlStr = "",sqlStr2="";
	List sqlList=new ArrayList();

	sqlStr2="delete from tMidsModeFlagCode where login_accept="+login_accept;
	sqlList.add(sqlStr2);

    for(int i=0;i<flag_codes_array.length;i++)
	{
		sqlStr="";
	    sqlStr = "insert into tMidsModeFlagCode (LOGIN_ACCEPT, REGION_CODE, MODE_CODE, flag_code, op_code) values("+login_accept+
	       ",'"+region_code+"'"+ 
		   ",'"+mode_code+"'"+
		   ",'"+flag_codes_array[i]+"'"+
		   ",'"+op_codes_array[i]+"'"+
		   ")";
    
        sqlList.add(sqlStr);
	}
    
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

