<%
   /******************************************
   * 功能: 参数代码配置提交
　 * 版本: v1.0
　 * 日期: 2007/03/12
　 * 作者: liubo
　 * 版权: sitech
     * 修改历史
     * 修改日期      修改人      修改目的
     2009/11/09		niuhr		集团配置改造
   *****************************************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>

<%			
	String  vLogin_NO     =request.getParameter("workNo");            //操作工号
	String  vPass_Word	  =request.getParameter("loginPass");        //工号密码
	String  vOp_Code	  ="5629" ;                                                             //操作代码
	String  vOp_Note	  =request.getParameter("opNote");              //操作备注
	String  vIp_Addr	  =request.getParameter("ipAddr");                //IP地址
	String  lLogin_Accept =request.getParameter("loginAccept");      //操作流水 
	
	String  param_code    = request.getParameter("param_code");                       //参数代码
	String  param_name    = request.getParameter("param_name")==null?"":request.getParameter("param_name");	                     //参数名称
	String  param_type	  =request.getParameter("param_type")==null?"":request.getParameter("param_type");                         // 参数类型
	String  param_length  =request.getParameter("param_length")==null?"":request.getParameter("param_length");                      //参数长度
	String  param_note	  =request.getParameter("param_note")==null?"":request.getParameter("param_note"); 
	
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfoSession = (String[][])arrSession.get(0);
	String OrgCode = baseInfoSession[0][16];                        // 参数备注
	String regionCode = OrgCode.substring(0,2);
	System.out.println("param_code: " + param_code);
	System.out.println("param_name: " + param_name);
	System.out.println("param_type: " + param_type);
	System.out.println("param_length: " + param_length);
	System.out.println("param_note: " + param_note);
	
	int num = Integer.parseInt(request.getParameter("num"));	  //为下拉列表时的配置项数量
	System.out.println("num: " + num);
     
     String config_code	  =request.getParameter("config_code")==null?"":request.getParameter("config_code");   //配置项代码
     String config_name	  =request.getParameter("config_name")==null?"":request.getParameter("config_name");	 //配置项名称
     String config_order	  =request.getParameter("config_order")==null?"":request.getParameter("config_order");  //配置项顺序		

	for (int i = 0; i < num; i++)
	{		
		config_code =config_code+ (String)request.getParameter("config_code"+(i+1)+"").trim()+"|";	
		config_name =config_name+ (String)request.getParameter("config_name"+(i+1)+"").trim()+"|";	
		config_order =config_order+ (String)request.getParameter("config_order"+(i+1)+"").trim()+"|";	
	}
	String  config_sql	  =request.getParameter("config_sql")==null?"":request.getParameter("config_sql");   //SQL语句
  
		System.out.println("config_code: " + config_code);
		System.out.println("config_name: " + config_name);
 
                                          
		ArrayList retArray = null;  
		int valid = 1;  //0:正确，1：系统错误，2：业务错误
		boolean showFlag=false; //showFlag表示是否有数据可供显示
		int GrpEndInx = 0, ProdEndInx = 0;
		int error_code = 0;
		String error_msg="系统错误，请与系统管理员联系";
   %>
<wtc:service name="s5629Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
	<wtc:param value="<%=vLogin_NO%>"/>
	<wtc:param value="<%=vPass_Word%>"/>
	<wtc:param value="<%=vOp_Code%>"/>
	<wtc:param value="<%=vOp_Note%>"/>
	<wtc:param value="<%=vIp_Addr%>"/>
	<wtc:param value="<%=lLogin_Accept%>"/>
	
	<wtc:param value="<%=param_code%>"/>
	<wtc:param value="<%=param_name%>"/>
	<wtc:param value="<%=param_type%>"/>
	<wtc:param value="<%=param_length%>"/>
	<wtc:param value="<%=param_note%>"/>
	<wtc:param value="<%=config_code%>"/>
	<wtc:param value="<%=config_name%>"/>
	<wtc:param value="<%=config_order%>"/>
	<wtc:param value="<%=config_sql%>"/>	
</wtc:service>

	 

    <!--error_code = callView.getErrCode();error_code = callView.getErrCode();

   error_msg  = callView.getErrMsg();

   // if( retArray == null ){

    //    valid = 1;

    //}else{

     //   if( error_code != 0){

     //       valid = 2;

     //   }else{

     //       valid = 0;

     //   }


  // }-->


<%

	if(retCode.equals("000000"))
	{ 
%>
		<script language="JavaScript">
			rdShowMessageDialog(" 参数集明细配置[<%=param_code%>]配置成功!",2);
			window.location="f2984.jsp";
		</script>
<%
 	}else{
%>
		<script language="JavaScript">
			rdShowMessageDialog("<%=retCode%>" + "[" + "<%=retCode%>" + "]" ,0);
			history.go(-1);
		</script>
<%
	}
%>   


