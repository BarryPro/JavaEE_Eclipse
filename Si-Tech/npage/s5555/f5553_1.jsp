<%
  /*
   * 功能: 清理记录
   * 版本: 1.0
   * 日期: 2009/04/04
   * 作者: yanpx
   * 版权: si-tech
   * update:
   */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
 	String opCode = request.getParameter("opCode");
 	String opName = request.getParameter("opName");

 
	String orgCode    = (String)session.getAttribute("orgCode");
	String workNo     = (String)session.getAttribute("workNo"); 
	String password   = (String)session.getAttribute("password");
	String regionCode = orgCode.substring(0,2);
	String table_name       =WtcUtil.repNull(request.getParameter("table_name")); 																																											
	String owner_name       =WtcUtil.repNull(request.getParameter("owner_name")); 																																											
	String app_belong       =WtcUtil.repNull(request.getParameter("app_belong")); 																																											
	String table_space      =WtcUtil.repNull(request.getParameter("table_space")); 																																											
	String table_type       =WtcUtil.repNull(request.getParameter("table_type")); 																																											
	String create_login     =WtcUtil.repNull(request.getParameter("create_login")); 																																											
	String busi_login       =WtcUtil.repNull(request.getParameter("busi_login")); 																																											
	String busi_desc        =WtcUtil.repNull(request.getParameter("busi_desc")); 																																											
	String key_info         =WtcUtil.repNull(request.getParameter("key_info")); 																																											
	String struc_main_type  =WtcUtil.repNull(request.getParameter("struc_main_type")); 																																											
	String busi_crtime      =WtcUtil.repNull(request.getParameter("busi_crtime")); 																																											
	String space_msize      =WtcUtil.repNull(request.getParameter("space_msize")); 																																											
	String use_type         =WtcUtil.repNull(request.getParameter("use_type")); 
	String offline_use_flag =WtcUtil.repNull(request.getParameter("offline_use_flag")); 
	String data_bus_time    =WtcUtil.repNull(request.getParameter("data_bus_time")); 
	String need_clean       =WtcUtil.repNull(request.getParameter("need_clean")); 
	String back_use_target  =WtcUtil.repNull(request.getParameter("back_use_target")); 
	String back_use_demand  =WtcUtil.repNull(request.getParameter("back_use_demand")); 
	String back_use_support =WtcUtil.repNull(request.getParameter("back_use_support")); 
	String back_use_mathod  =WtcUtil.repNull(request.getParameter("back_use_mathod")); 
	String flag = WtcUtil.repNull(request.getParameter("flag"));
	String paraAray[] = new String[21];	
	System.out.println(table_name      );
	System.out.println(owner_name      );
	System.out.println(app_belong      );
	System.out.println(table_space     );
	System.out.println(table_type      );
	System.out.println(create_login    );
	System.out.println(busi_login      );
	System.out.println(busi_desc       );
	System.out.println(key_info        );
	System.out.println(struc_main_type );
	System.out.println(busi_crtime     );
	System.out.println(space_msize     );
	System.out.println(use_type        );
	System.out.println(offline_use_flag);
	System.out.println(data_bus_time   );
	System.out.println(need_clean      );
	System.out.println(back_use_target );
	System.out.println(back_use_demand );
    System.out.println(back_use_support);
    System.out.println(back_use_mathod );
    System.out.println("flag="+flag);
  paraAray[0]  = table_name.toUpperCase();
	paraAray[1]  = owner_name.toUpperCase();
	paraAray[2]  = app_belong      ;
	paraAray[3]  = table_space     ;
	paraAray[4]  = table_type      ;
	paraAray[5]  = create_login    ;
	paraAray[6]  = busi_login      ;
	paraAray[7]  = busi_desc       ;
	paraAray[8]  = key_info        ;
	paraAray[9]  = struc_main_type ;
	paraAray[10] = busi_crtime     ;
	paraAray[11] = space_msize     ;
	paraAray[12] = use_type        ;
	paraAray[13] = offline_use_flag;
	paraAray[14] = data_bus_time   ;
	paraAray[15] = need_clean      ;
	paraAray[16] = back_use_target ;
	paraAray[17] = back_use_demand ;
	paraAray[18] = back_use_support;
	paraAray[19] = back_use_mathod ;

%>                     
	<wtc:service name="tbmsg_maint" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
	<wtc:param value="<%=paraAray[0]%>"/>
	<wtc:param value="<%=paraAray[1]%>"/>
	<wtc:param value="<%=paraAray[2]%>"/>
	<wtc:param value="<%=paraAray[3]%>"/>
	<wtc:param value="<%=paraAray[4]%>"/>
	<wtc:param value="<%=paraAray[5]%>"/>
	<wtc:param value="<%=paraAray[6]%>"/>
	<wtc:param value="<%=paraAray[7]%>"/>
	<wtc:param value="<%=paraAray[8]%>"/>
	<wtc:param value="<%=paraAray[9]%>"/>
	<wtc:param value="<%=paraAray[10]%>"/>
	<wtc:param value="<%=paraAray[11]%>"/>
	<wtc:param value="<%=paraAray[12]%>"/>
	<wtc:param value="<%=paraAray[13]%>"/>
	<wtc:param value="<%=paraAray[14]%>"/>
	<wtc:param value="<%=paraAray[15]%>"/>
	<wtc:param value="<%=paraAray[16]%>"/>
	<wtc:param value="<%=paraAray[17]%>"/>
	<wtc:param value="<%=paraAray[18]%>"/>
	<wtc:param value="<%=paraAray[19]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>	
<%
	   if(retCode.equals("0")||retCode.equals("000000")){
%>
		<script>
	     rdShowMessageDialog("操作成功！",2);
         location="f5553.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	    </script>
<%
	}else{
%>	
	     <script>
		   rdShowMessageDialog('错误<%=retCode%>：'+'<%=retMsg%>，请重新操作！',0);
		  location="f5553.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		 </script>	
<%	
		}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>                 
		<title><%=opName%></title>   
		<script>

		</script>
	</head>
	<body>
	
	</body>
</html>
