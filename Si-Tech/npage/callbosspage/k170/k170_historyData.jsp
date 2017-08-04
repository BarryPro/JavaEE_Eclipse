<%
	/*
	 * 功能: 历史来电原因
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
		String contactMonth=request.getParameter("contactMonth");	
		String contactId=request.getParameter("contactId");
		String kfWorkNum=request.getParameter("kfWorkNum");
		 /*midify by yinzx 20091113 公共查询服务替换*/
 		String myParams="";
 		String org_code = (String)session.getAttribute("orgCode");
 		String regionCode = org_code.substring(0,2);
		//只能查询系统时间前一天的数据
		
		String sqr="";
		if(!contactMonth.equals("")&&!kfWorkNum.equals("")){
	  sqr="select t.contact_id,t.accept_phone,t.CALLER_PHONE,a.accept_name from dcallcall"+contactMonth+" t,saccepttype a where 1=1"; 
		sqr+=" and t.call_cause_id is null and t.accept_kf_login_no=:kfWorkNum  and t.begin_date>sysdate-1";
		myParams ="kfWorkNum="+kfWorkNum;
		if(contactId!=null&&!"".equals(contactId)){
			sqr+=" and contact_id!=:contactId ";
			myParams+=" ,contact_id="+contactId
		}
		sqr+=" and t.acceptid=a.accept_type order by t.begin_date desc";
		}
		
		
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%> outnum="4">
   <wtc:param value="<%=sqr%>"/>
   <wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="queryList" scope="end" />
<%
   System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
   for(int i = 0; i < queryList.length; i++){
	   for(int j = 0; j < queryList[i].length; j++){
		 System.out.println(queryList[i][j]);
	}
}
   System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
  %>
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