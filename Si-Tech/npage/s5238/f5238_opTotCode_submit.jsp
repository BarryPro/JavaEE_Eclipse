<%
   /*
   * 功能: 提交帐单优惠条件设置
　 * 版本: v1.0
　 * 日期: 2007/01/24
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
	String typeButtonNum = request.getParameter("typeButtonNum");
	String login_accept = request.getParameter("login_accept");
	String region_code  = request.getParameter("region_code");
	String total_code   = request.getParameter("detail_code");   
	String order_code   = request.getParameter("order_code");
	String favour_object= request.getParameter("favour_object");
	String favour_type  = request.getParameter("favour_type");
	String type_mode    = request.getParameter("type_mode");
	String favour_cycle = request.getParameter("favour_cycle");
	String cycle_unit   = request.getParameter("cycle_unit");
	String step_val1    = request.getParameter("step_val1");
	String favour1      = request.getParameter("favour1");
	String step_val2    = request.getParameter("step_val2");
	String favour2      = request.getParameter("favour2");
	String step_val3    = request.getParameter("step_val3");
	String favour3      = request.getParameter("favour3");
	String code_name    = request.getParameter("note");
	String time_flag    = "1";
	String begin_time   = "20050101";
	String end_time     = "20500101";                                          
	String first_favour_object = request.getParameter("first_favour_object")==null?"":request.getParameter("first_favour_object");
	String second_favour_object = request.getParameter("second_favour_object")==null?"":request.getParameter("second_favour_object");
	
	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	String[] acceptList = null;
		
	ArrayList paramsIn = new ArrayList(24);
	paramsIn.add(workNo);
	paramsIn.add(nopass);
	paramsIn.add("5238");
	paramsIn.add(login_accept);            //流水                         
	paramsIn.add(region_code);             //地区代码                         
	paramsIn.add(total_code);             //优惠代码                     
	paramsIn.add(order_code);             //优惠顺序    
	paramsIn.add(favour_object);          //优惠的帐目项
	paramsIn.add(favour_type);            //优惠方式    
	paramsIn.add(type_mode);              //送费方式    
	paramsIn.add(favour_cycle);           //优惠周期    
	paramsIn.add(cycle_unit);             //周期单位    
	paramsIn.add(step_val1);                           
	paramsIn.add(favour1);                             
	paramsIn.add(step_val2);                           
	paramsIn.add(favour2);                             
	paramsIn.add(step_val3);                           
	paramsIn.add(favour3);                             
	paramsIn.add(code_name);               //优惠名称    
	paramsIn.add(time_flag);                           
	paramsIn.add(begin_time);              //开始时间    
	paramsIn.add(end_time);                //结束时间    
	paramsIn.add(first_favour_object);     //一级帐目项  
	paramsIn.add(second_favour_object);    //二级帐目项  
	     	
	acceptList = impl.callService("s5238_TotCfm",paramsIn,"2");
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

