<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
   
   String retType = WtcUtil.repNull(request.getParameter("retType"));
   String org_id = WtcUtil.repNull(request.getParameter("org_id"));
   String class_id = WtcUtil.repNull(request.getParameter("class_id"));
   String staffstatus = WtcUtil.repNull(request.getParameter("staffstatus"));
   String endNum=WtcUtil.repNull(request.getParameter("endNum"));
   String orgCode = (String)session.getAttribute("orgCode");
   String regionCode = orgCode.substring(0,2);
   String params = "";
   String sqlStr = "select ccsworkno, org_id, login_no, staffstatus, kf_name, class_id, duty from dstaffstatus where 1=1 ";

   if(org_id !=null && !org_id.equals("null") && !org_id.equals("")){
       sqlStr += "and org_id =:org_id ";
       params+="org_id="+org_id;
   }
   if(class_id !=null && !class_id.equals("null") && !class_id.equals("")){
   	   sqlStr += "and class_id =:class_id ";
   	   params+=",class_id="+class_id;
   }
   if(staffstatus !=null && !staffstatus.equals("null") && !staffstatus.equals("")){
   	   sqlStr += " and staffstatus =:staffstatus ";
   	   params+=",staffstatus="+staffstatus;
   } 
    System.out.println("endNum:*************"+endNum);
   if(endNum !=null && !endNum.equals("null") && !endNum.equals("")){
   	   sqlStr += " and rownum <=:endNum ";
   	   params+=",endNum="+endNum;
   }
     

   
  

%>

<wtc:service name="TlsPubSelCrm" outnum="8" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=params%>"/>
</wtc:service>

<wtc:array id="resultList" start="0" length="8">
<%

System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");


for(int i = 0; i < resultList.length; i++){
	for(int j = 0; j < resultList[i].length; j++){
		System.out.println(resultList[i][j]);
	}
}

System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");

%>
var worknos = new Array();
<%for(int i = 0; i < resultList.length; i++){%>
    var tmpArr = new Array();
	<%for(int j = 0; j < resultList[i].length; j++){%>
		tmpArr[<%=j%>] = '<%=resultList[i][j]%>';
	<%}%>
	worknos[<%=i%>] = tmpArr;
<%}%>

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("worknos",worknos);
core.ajax.receivePacket(response);

</wtc:array>
