<%
	/*
	 * 功能: 未保存来电原因
	 * 版本: 1.0
	 * 日期: 2008/12/29
	 * 作者: lijin 
	 * 版权: sitech
	 * 
	 *  
	 */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
		  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

		String captionName=request.getParameter("caption");
		String sqlStr ="";
		if(!captionName.equals("")){
    sqlStr="select t.callcause_id,t.caption,t.fullname,t.is_leaf from DCALLCAUSECFG t where t.caption like '%'||:captionName||'%' and t.is_del='N'and visible='1'  order by t.callcause_id";
    myParams = "captionName="+captionName ;
   }		
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="4">
   <wtc:param value="<%=sqlStr%>"/>
   <wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="queryList" scope="end" />
   var contact = new Array();
  <%for(int i = 0; i < queryList.length; i++){%>
    var tmpArr = new Array();
	<%for(int j = 0; j < queryList[i].length; j++){%>
		tmpArr[<%=j%>] = '<%=queryList[i][j]%>';
	<%}%>
	contact[<%=i%>] = tmpArr;
<%}%>
	var response = new AJAXPacket();
	response.data.add("contact",contact);
	core.ajax.receivePacket(response);	