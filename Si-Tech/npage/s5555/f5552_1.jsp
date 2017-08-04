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
	String clean_ol_behave = "";
 
	String orgCode    = (String)session.getAttribute("orgCode");
	String workNo     = (String)session.getAttribute("workNo"); 
	String password   = (String)session.getAttribute("password");
	String regionCode = orgCode.substring(0,2);
	String table_name      =WtcUtil.repNull(request.getParameter("table_name")); 																																											
	String owner_name      =WtcUtil.repNull(request.getParameter("owner_name")); 																																											
	String ol_use_flag     =WtcUtil.repNull(request.getParameter("ol_use_flag")); 																																											
	String ol_store_flag   =WtcUtil.repNull(request.getParameter("ol_store_flag")); 																																											
	String need_clean      =WtcUtil.repNull(request.getParameter("need_clean")); 																																											
	String clean_stime     =WtcUtil.repNull(request.getParameter("clean_stime")); 																																											
	String clean_freq      =WtcUtil.repNull(request.getParameter("clean_freq")); 																																											
	String back_type       =WtcUtil.repNull(request.getParameter("back_type")); 																																											
	String back_add_type   =WtcUtil.repNull(request.getParameter("back_add_type")); 																																											
	String back_path       =WtcUtil.repNull(request.getParameter("back_path")); 																																											
	String back_ind_type   =WtcUtil.repNull(request.getParameter("back_ind_type")); 																																											
	String back_ana_type   =WtcUtil.repNull(request.getParameter("back_ana_type")); 																																											
	String clean_type      =WtcUtil.repNull(request.getParameter("clean_type")); 
	String clean_add_type  =WtcUtil.repNull(request.getParameter("clean_add_type")); 
	String clean_desc      =WtcUtil.repNull(request.getParameter("clean_desc")); 
	
	String index_pos =WtcUtil.repNull(request.getParameter("index_pos")); 
	String water_line =WtcUtil.repNull(request.getParameter("water_line")); 
	String table_analyse =WtcUtil.repNull(request.getParameter("table_analyse")); 
	String table_reb =WtcUtil.repNull(request.getParameter("table_reb")); 
	clean_ol_behave=index_pos.trim()+water_line.trim()+table_analyse.trim()+table_reb.trim();
	String need_docum      =WtcUtil.repNull(request.getParameter("need_docum")); 
	String docum_stime     =WtcUtil.repNull(request.getParameter("docum_stime")); 
	String docu_store_type =WtcUtil.repNull(request.getParameter("docu_store_type")); 
	String docu_store_time =WtcUtil.repNull(request.getParameter("docu_store_time")); 
	String flag = WtcUtil.repNull(request.getParameter("flag"));
	String paraAray[] = new String[21];		
	System.out.println(table_name     );
	System.out.println(owner_name     );
	System.out.println(ol_use_flag    );
	System.out.println(ol_store_flag  );
	System.out.println(need_clean     );
	System.out.println(clean_stime    );
	System.out.println(clean_freq     );
	System.out.println(back_type      );
	System.out.println(back_add_type  );
	System.out.println(back_path      );
	System.out.println(back_ind_type  );
	System.out.println(back_ana_type  );
	System.out.println(clean_type     );
	System.out.println(clean_add_type );
	System.out.println(clean_desc     );
	System.out.println(clean_ol_behave);
	System.out.println(need_docum     );
	System.out.println(docum_stime    );
    System.out.println(docu_store_type);
    System.out.println(docu_store_time);
    System.out.println(flag);
  paraAray[0]  = table_name.toUpperCase();
	paraAray[1]  = owner_name.toUpperCase();
	paraAray[2]  = ol_use_flag    ;
	paraAray[3]  = ol_store_flag  ;
	paraAray[4]  = need_clean     ;
	paraAray[5]  = clean_stime    ;
	paraAray[6]  = clean_freq     ;
	paraAray[7]  = back_type      ;
	paraAray[8]  = back_add_type  ;
	paraAray[9]  = back_path      ;
	paraAray[10] = back_ind_type  ;
	paraAray[11] = back_ana_type  ;
	paraAray[12] = clean_type     ;
	paraAray[13] = clean_add_type ;
	paraAray[14] = clean_desc     ;
	paraAray[15] = clean_ol_behave;
	paraAray[16] = need_docum     ;
	paraAray[17] = docum_stime    ;
	paraAray[18] = docu_store_type;
	paraAray[19] = docu_store_time;
%>                     
	<wtc:service name="tbclean_maint" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
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
         location="f5552.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	    </script>
<%
	}else{
%>	
	     <script>
		   rdShowMessageDialog('错误<%=retCode%>：'+'<%=retMsg%>，请重新操作！',0);
		  location="f5552.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
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
