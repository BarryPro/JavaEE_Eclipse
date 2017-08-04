<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.24
 模块: 到期资费代码配置
********************/
%>


<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%		
	String opCode = "5025";
	String opName = "到期资费代码配置";    
	    
	String loginNo = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String regionCode = (String)session.getAttribute("regCode");
  
%>
<%

	String error_msg="系统错误，请与系统管理员联系，谢谢!!";
	String error_code="444444";
	String[][] errCodeMsg = null;
	List al = null;
	boolean showFlag=false;	//showFlag表示是否有数据可供显示
  	int valid = 1;	//0:正确，1：系统错误，2：业务错误
  	
  	StringBuffer procSql = new StringBuffer();
	String opType="",mode_code="",next_mode_code="",new_next_mode_code="",use_flag="",op_code="",op_note="";

    opType = request.getParameter("opType");//操作类型
	mode_code = request.getParameter("mode_code");//当前资费
	next_mode_code = request.getParameter("next_mode_code");//到期资费
	new_next_mode_code = request.getParameter("new_next_mode_code");//新到期资费
	use_flag = request.getParameter("useFlag");//有效标志
    op_note = request.getParameter("op_note");//备注
	op_code = "5025";//操作代码
   
		
	 //在此处形成存储过程的串,这样可以调用一个函数就可以了。

	 procSql.append(" Prc_5025_cfm('" + opType+ "'");
	 procSql.append(",'" + regionCode+ "'");
	 procSql.append(",'" + mode_code+ "'");
	 procSql.append(",'" + next_mode_code+ "'");
	 procSql.append(",'" + new_next_mode_code+ "'");
	 procSql.append(",'" + use_flag+ "'");
	 procSql.append(",'" + op_code + "'");
	 procSql.append(",'" + ip_Addr + "'");
	 procSql.append(",'" + op_note + "'");
	 procSql.append(",'" + loginNo + "'");
 
     System.out.println("f5025Cfm.jsp:procSql="+procSql.toString());
 
     //al = s5010.get_spubproccfm( procSql.toString() );
%>
	<wtc:service name="sPubProcCfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="3">			
	<wtc:param value="<%=procSql.toString()%>"/>	
	</wtc:service>	
	<wtc:array id="result1"  scope="end"/>	
<%     
     if(result1.length==0){
 		// System.out.println("======jsp5025:array is null!!===");
		 valid = 1;
	 }else{
		  //errCodeMsg = (String[][])al.get(0);
	   	  error_code = retCode1;
		  
		  if(!error_code.equals("000000")){
			  valid = 2;
			  error_msg = retMsg1;
		  }else{
		  	  valid = 0;
		  }
	  }
%>

<%if( valid == 1){%>
<script language="JavaScript">
<!--
	rdShowMessageDialog("系统错误，请与系统管理员联系，谢谢!!",0);
	history.go(-1);
//-->
</script>

<%}else if( valid == 2){%>
<script language="JavaScript">
<!--
	rdShowMessageDialog("<br>业务错误代码:"+"<%=error_code %></br>"+"错误信息:"+"<%=error_msg %>",0);
	history.go(-1);
//-->
</script>

<%}else{%>
<script language="JavaScript">
<!--
	rdShowMessageDialog("操作成功!!",2);
	history.go(-1);
//-->
</script>
<%}%>








