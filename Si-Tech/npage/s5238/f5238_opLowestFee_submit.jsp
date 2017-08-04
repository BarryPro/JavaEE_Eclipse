<%
   /*
   * 功能: 提交底线半月收配置
　 * 版本: v1.0
　 * 日期: 2007/01/25
　 * 作者: shibo
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="com.sitech.channelmng.PrdMgrSql" %>
<%@page contentType="text/html;charset=gb2312" %>
<%@ page errorPage="/page/common/errorpage.jsp" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<%
	//读取用户session信息
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arrSession.get(0);
	String workNo   = baseInfo[0][2];                 //工号
	String workName = baseInfo[0][3];               	//工号姓名
	String org_code = baseInfo[0][16];
	String ip_Addr  = request.getRemoteAddr();
	String[][] pass = (String[][])arrSession.get(4);   
	String nopass  = pass[0][0];                     //登陆密码
	String regionCode=org_code.substring(0,2);
			
	//错误信息，错误代码
	int errCode = 0;
	String errMsg = "";

	String login_accept = request.getParameter("login_accept");
	String region_code = request.getParameter("region_code");
	String total_code = request.getParameter("total_code");
	String tot_order = request.getParameter("tot_order");
	String new_feeCode = request.getParameter("new_feeCode");
	String new_detCode = request.getParameter("new_detCode");


    PrdMgrSql ProductExcludeSql=new PrdMgrSql();
	String sqlStr = "",sqlStr2="";
	List sqlList=new ArrayList();

	sqlStr2="delete from tMidLowestFeeCode where login_accept="+login_accept+" and region_code='"+region_code+"' and total_code='"+total_code+"' and tot_order="+tot_order;

	sqlStr = "insert into tMidLowestFeeCode (LOGIN_ACCEPT, REGION_CODE, total_code, tot_order, favour_object,new_feeCode,new_detCode) values("+login_accept+
	       ",'"+region_code+"'"+ 
		   ",'"+total_code+"'"+
		   ",'"+tot_order+"'"+
		   ",'"+"*"+"'"+
		   ",'"+new_feeCode+"'"+
		   ",'"+new_detCode+"'"+
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
	        rdShowMessageDialog("提交成功!");
			window.close();
        </script>
<%
	}
%>

