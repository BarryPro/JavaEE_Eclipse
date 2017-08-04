<%
   /*
   * 功能: 提交包年信息配置
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
			

	String login_accept = request.getParameter("login_accept");
	String region_code = request.getParameter("region_code");
	String mode_code = request.getParameter("mode_code");
	String begin_time = request.getParameter("begin_time");
	String end_time = request.getParameter("end_time");
	String prepay_least = request.getParameter("prepay_least");
	String deposit_least = request.getParameter("deposit_least");
	String mark_least = request.getParameter("mark_least");
	String pay_type = request.getParameter("pay_type");
	
    int errCode=0;        
    String errMsg="";
	SPubCallSvrImpl impl = new SPubCallSvrImpl();

	String aaccount_types_array = request.getParameter("account_types_array");
    String afee_codes_array = request.getParameter("fee_codes_array");
    String apay_orders_array  = request.getParameter("pay_orders_array");
    String afee_rates_array    = request.getParameter("fee_rates_array");
    String adetail_codes_array   = request.getParameter("detail_codes_array");
    String[] account_types_array = aaccount_types_array.split(",");
    String[] fee_codes_array = afee_codes_array.split(",");
    String[] pay_orders_array  = apay_orders_array.split(","); 
    String[] fee_rates_array    = afee_rates_array.split(",");  
    String[] detail_codes_array   = adetail_codes_array.split(","); 
		
	String[] acceptList = null;
		
	ArrayList paramsIn = new ArrayList(16);
	paramsIn.add(workNo);
	paramsIn.add(nopass);
	paramsIn.add("5238");
	paramsIn.add(login_accept);
	paramsIn.add(mode_code);
	paramsIn.add(region_code);
	paramsIn.add(begin_time);
	paramsIn.add(end_time);
	paramsIn.add(prepay_least);
	paramsIn.add(deposit_least);
	paramsIn.add(mark_least);
	paramsIn.add(pay_type);
	paramsIn.add(account_types_array);
	paramsIn.add(fee_codes_array);
	paramsIn.add(pay_orders_array);
	paramsIn.add(fee_rates_array);
	paramsIn.add(detail_codes_array);
		
		
	acceptList = impl.callService("s5238_YearCfm",paramsIn,"10");
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
			window.opener.form1.yearInfoButt.disabled=false;
        	window.opener.form1.yearInfoButt.value="包年信息已配置";
			window.close();
        </script>
<%
	}
%>

