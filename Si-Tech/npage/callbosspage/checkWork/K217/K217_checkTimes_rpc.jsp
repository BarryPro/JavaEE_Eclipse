<%
  /*
   * 功能: 判断当前流水是否已经进行过质检
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>

<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode = orgCode.substring(0,2);
		String myParams="";
		
	  String plan_id = (String)request.getParameter("plan_id");
	  String object_id = (String)request.getParameter("object_id");
	  String content_id = (String)request.getParameter("content_id_checked");
	  String staffno = (String)request.getParameter("staffno");
	  
	  if(null==staffno){
	  		staffno = "";
	  }

	  String strSql ="";
	  String toCheck="true";
	  /**
     *判断当前流水是否已经进行过质检
     * 修改人：guozw 2010-5-5
     */
     /* 修改后 guozw 2010-5-5 */
     strSql = "select to_char(count(*)) from ";
     
	   strSql += "(select current_times "+
                "from dqcloginplan t1 where trim(t1.current_times)>=trim(t1.max_time) and " +
                "t1.plan_id = :plan_id and t1.content_id = :content_id and t1.object_id = :object_id and t1.login_no=:staffno and "+
                "sysdate >= t1.begin_date and sysdate<=t1.end_date) aa, ";
	   strSql += "(select max_time "+
                "from dqcloginplan t1 where trim(t1.current_times)>=trim(t1.max_time) and " +
                "t1.plan_id = :plan_id1 and t1.content_id = :content_id1 and t1.object_id = :object_id1 and t1.login_no= :staffno1 and "+
                "sysdate >= t1.begin_date and sysdate<=t1.end_date) bb ";  
     strSql += "where aa.current_times>=bb.max_time ";   
   	 myParams ="plan_id="+plan_id+",content_id="+content_id+",object_id="+object_id+",staffno="+staffno+",plan_id1="+plan_id+",content_id1="+content_id+",object_id1="+object_id+",staffno1="+staffno;
   	 
   	 /* 修改前 guozw 2010-5-5
   	 	strSql = "select to_char(count(*)) from ";
     
		   strSql += "(select to_char(current_times) "+
	                "from dqcloginplan t1 where trim(t1.current_times)>=trim(t1.max_time) and " +
	                "t1.plan_id = :plan_id and t1.content_id = :content_id and t1.object_id = :object_id and t1.login_no=:staffno and "+
	                "sysdate >= t1.begin_date and sysdate<=t1.end_date) aa, ";
		   strSql += "(select to_char(max_time) "+
	                "from dqcloginplan t1 where trim(t1.current_times)>=trim(t1.max_time) and " +
	                "t1.plan_id = :plan_id1 and t1.content_id = :content_id1 and t1.object_id = :object_id1 and t1.login_no= :staffno1 and "+
	                "sysdate >= t1.begin_date and sysdate<=t1.end_date) bb ";  
	     strSql += "where aa.current_times>=bb.max_time ";   
	   	 myParams ="plan_id="+plan_id+",content_id="+content_id+",object_id="+object_id+",staffno="+staffno+",plan_id1="+plan_id+",content_id1="+content_id+",object_id1="+object_id+",staffno1="+staffno;
   	 */

%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
				<wtc:param value="<%=strSql%>" />
				<wtc:param value="<%=myParams%>" />
		</wtc:service>
		<wtc:array id="checkList" scope="end" />
<%
		if(checkList.length>0){
		  	toCheck=checkList[0][0];
		}
%>
		var response = new AJAXPacket();
		response.data.add("toCheck","<%=toCheck%>");
		response.data.add("object_id","<%=object_id%>");
		response.data.add("content_id","<%=content_id%>");
		core.ajax.receivePacket(response);