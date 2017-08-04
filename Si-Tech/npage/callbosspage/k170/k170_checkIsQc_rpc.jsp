<%
  /*
   * 功能: 计划内质检权限校验/修改质检结果权限校验
　 * 版本: 1.0
　 * 日期: 2009/08/10
　 * 作者: mixh
　 * 版权: sitech
   * update: mixh 2009/08/10 修改权限校验逻辑：如该流水已经进行计划外质检，则也不能进行计划内质检
   * update: mixh 2009/08/13 修改权限校验逻辑：查询条件中去掉匹配质检工号
   *
 　*/
 %>
 
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

	String serialnum  = (String)request.getParameter("serialnum");  //被检流水号
	String start_date = (String)request.getParameter("start_date"); //流水生成日期
	String flag       = (String)request.getParameter("flag");       //0:计划外质检 1:计划内质检    
	String staffno    = (String)request.getParameter("staffno");	//被质检工号  
	String group_flag    = (String)request.getParameter("group_flag");	//个人 团体考评标识
	String plan_id    = (String)request.getParameter("plan_id");	//个人 团体考评标识
	String evterno    = (String)session.getAttribute("workNo");   //质检工号
	String strSql     = "";
	//对计划内质检进行权限校验
			if("1".equals(flag)){
				if("0".equals(group_flag)){
					strSql = "SELECT recordernum FROM dqcinfo WHERE  recordernum=:serialnum AND is_del != 'Y' ";
					myParams = "serialnum="+serialnum ;
				}else{
					strSql = "SELECT recordernum FROM dqcinfo WHERE  recordernum=:serialnum AND is_del != 'Y' and evterno=:evterno and plan_id=:plan_id " ;
					myParams = "serialnum="+serialnum+",evterno="+plan_id ;
				}
%>
				<wtc:service name="TlsPubSelCrm" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
				<wtc:param value="<%=strSql%>" />
					<wtc:param value="<%=myParams%>"/>
				</wtc:service>
				<wtc:array id="checkList" scope="end" />
				var response = new AJAXPacket();
				response.data.add("serialnum","<%=serialnum%>");
				response.data.add("checkList","<%=checkList.length%>");
				response.data.add("flag","<%=flag%>");
				response.data.add("staffno","<%=staffno%>");
				core.ajax.receivePacket(response);
<%	
			}
%>

<%
  //判断是否可以对质检结果进行修改
	if("3".equals(flag)){
		if(start_date!=null){
	     strSql = "select t2.recordernum from dcallcall" + start_date.substring(0,6)
	     				+ " t1,dqcinfo t2 where t2.recordernum =:serialnum and t2.recordernum = t1.contact_id and t2.flag <> '3' and t2.is_del != 'Y'";	
	     myParams = "serialnum="+serialnum ;    
	  }
  %>
      <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
        <wtc:param value="<%=strSql%>" />
        <wtc:param value="<%=myParams%>"/>
      </wtc:service>
      <wtc:array id="checkList" scope="end" />
      var response = new AJAXPacket();
      response.data.add("serialnum","<%=serialnum%>");
      response.data.add("checkList","<%=checkList.length%>");
      response.data.add("flag","<%=flag%>");
      response.data.add("staffno","<%=staffno%>");
      core.ajax.receivePacket(response);
<%
	}
%>