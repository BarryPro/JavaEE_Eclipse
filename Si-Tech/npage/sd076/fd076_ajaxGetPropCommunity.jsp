<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by wanglm @ 2011-05-23
 ********************/
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%        
	String propDistrictId = request.getParameter("propDistrictId");
	String loginNo = (String)session.getAttribute("workNo");	//操作工号
	String regionCode=(String)session.getAttribute("regCode");
	String sql = "select  a.location_id ,a.communityname from sCommunityMsg a ,dloginmsg b where a.region_code = substr(org_code,0,2)   "
    			+"and b.login_no = '"+loginNo+"' and  trim(a.location_id) = '"+propDistrictId+"' ";

 %>	
 	  <wtc:pubselect name="sPubSelect" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
  	      <wtc:sql><%=sql%></wtc:sql>
 	  </wtc:pubselect>
 	  <wtc:array id="retarr" scope="end"/> 
 	  <%
 	     
 	  	for(int i=0;i<retarr.length;i++){
 	  %>
        <option value="<%=retarr[i][0]%>"><%=retarr[i][1]%></option> 	  		
 	  <%	
 	  	}
 	  %>
	