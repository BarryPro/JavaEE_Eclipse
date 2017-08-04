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

		String contactId=request.getParameter("contactId");
		String contactMonth=request.getParameter("contactMonth");	
		if(contactMonth.equals("")||contactMonth==null){
		//取得系统当前的年月
		  String date[]=new String[6];    
      Calendar calendar = Calendar.getInstance();
      int year = calendar.get(Calendar.YEAR);
      int month = calendar.get((Calendar.MONTH))+1; 
      String _month = month<=9 ? "0"+month : ""+month;
      contactMonth=year+_month;
		}
		String sqr="select t.contact_id,t.accept_phone,t.CALLER_PHONE,a.accept_name from dcallcall"+contactMonth+" t,saccepttype a where 1=1"; 
		if(contactId!=null&&!contactId.equals("")){
		   sqr+=" and t.contact_id=:contactId";
		   myParams="contact_id="+contactId;
		}
		sqr+=" and t.call_cause_id is null and t.bak is null";
		sqr+=" and t.acceptid=a.accept_type";

		
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="4">
   <wtc:param value="<%=sqr%>"/>
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