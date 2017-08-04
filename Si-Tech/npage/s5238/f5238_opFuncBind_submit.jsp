<%
   /*
   * 功能: 提交优惠绑定配置
　 * 版本: v1.0
　 * 日期: 2007/01/16
　 * 作者: shibo
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
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
	System.out.println("@@@@@@@@@@@");
	String qryType = request.getParameter("qryType");
	String login_accept = request.getParameter("login_accept");
	String region_code = request.getParameter("region_code");
	String sm_code = request.getParameter("sm_code");
	String off_flag = request.getParameter("off_flag");
	String func_code = request.getParameter("func_code");
	String detail_code = request.getParameter("detail_code");
	String month_flag = request.getParameter("month_flag");
	String month_fee = request.getParameter("month_fee");
	String day_flag = request.getParameter("day_flag");
	String day_fee = request.getParameter("day_fee");
	String acc_detail = request.getParameter("acc_detail_sec");
	String note = request.getParameter("note");
	String typeButtonNum = request.getParameter("typeButtonNum");
	
	System.out.println("day_flag="+day_flag);
	
	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	String[] acceptList = null;
		
		String paramsIn[] = new String[7];
    paramsIn[0] = "9001";							
    paramsIn[1] = login_accept;							
    paramsIn[2] = detail_code;				//绑定代码
    paramsIn[3] = region_code;				
    paramsIn[4] = sm_code;						
    paramsIn[5] = func_code;						
    paramsIn[6] = off_flag;						
	
		acceptList = impl.callService("sDynSqlCfm",paramsIn,"0");
	
	errCode=impl.getErrCode();   
	errMsg=impl.getErrMsg();
	
	if(errCode != 0)
    {
%>
        <script language='javascript'>
        	rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
	        history.go(-1);
        </script>
<%	}
	else
	{
%>
		<script language='javascript'>
			window.opener.form1.typeButton<%=typeButtonNum%>.disabled=false;
      window.opener.form1.typeButton<%=typeButtonNum%>.value="已配置";
			window.close();
        </script>
<%
	}
%>

