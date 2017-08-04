<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
	    /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

	  String serialnum = WtcUtil.repNull(request.getParameter("serialnum"));
	  String start_date = WtcUtil.repNull(request.getParameter("start_date"));
	  String flag = WtcUtil.repNull(request.getParameter("flag"));
	  String staffno = WtcUtil.repNull(request.getParameter("staffno"));	  
//String evterno = WtcUtil.repNull((String)session.getAttribute("kfWorkNo"));//质检/复核工号
          String evterno = WtcUtil.repNull((String)session.getAttribute("workNo"));//改为客服工号!
	  String object_id = WtcUtil.repNull(request.getParameter("object_id"));
	  String content_id = WtcUtil.repNull(request.getParameter("content_id"));
	  String checkFlag = WtcUtil.repNull(request.getParameter("checkFlag"));	    

	  String strSql ="";
	  String planCounts="0";
          System.out.println("staffno"+staffno);
          System.out.println("evterno:"+evterno);
	  /**
     *判断当前流水是否已经进行过质检
     */
	   strSql = "select to_char(count(1)) "+
                "from dqcplan t1, dqcloginplan t2, dqccheckloginplan t3 " +
                "where t1.plan_id = t2.plan_id and t1.plan_id = t3.plan_id and t2.login_no =:staffno and " +
                "t3.check_login_no =:evterno and " +
                "sysdate >= t1.begin_date and sysdate<=t1.end_date ";
     myParams = "staffno="+staffno+",evterno="+evterno ;
      %>
      	     <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
      	       <wtc:param value="<%=strSql%>" />
      	       <wtc:param value="<%=myParams%>"/>
      	     </wtc:service>
      	     <wtc:array id="checkList" scope="end" />
      <%
        if(checkList.length>0){
          planCounts=checkList[0][0];
        }
      %>
      var response = new AJAXPacket();
      response.data.add("serialnum","<%=serialnum%>");
      response.data.add("planCounts","<%=planCounts%>");
      response.data.add("flag","<%=flag%>");
      response.data.add("staffno","<%=staffno%>");
      response.data.add("object_id","<%=object_id%>");
      response.data.add("content_id","<%=content_id%>");
      response.data.add("checkFlag","<%=checkFlag%>");      
      core.ajax.receivePacket(response);