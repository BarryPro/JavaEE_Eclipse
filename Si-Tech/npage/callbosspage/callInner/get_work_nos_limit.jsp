<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
   
   String retType = WtcUtil.repNull(request.getParameter("retType"));
   String org_id = WtcUtil.repNull(request.getParameter("org_id"));
   String class_id = WtcUtil.repNull(request.getParameter("class_id"));
   String skill_id = WtcUtil.repNull(request.getParameter("skill_id"));
   String staffstatus = WtcUtil.repNull(request.getParameter("staffstatus"));
   String endNum=WtcUtil.repNull(request.getParameter("endNum"));
   String workNo=(String)session.getAttribute("kfWorkNo");
   String orgCode = (String)session.getAttribute("orgCode");
   String regionCode = orgCode.substring(0,2);
   String params = "";
  // String sqlStr = "select ccsworkno, org_id, login_no, staffstatus, kf_name, class_id, duty from dstaffstatus where 1=1 ";
   
   
   String sqlStrMenu="select kf_login_no from DCALLLOGINMENU where auth_id = 'K014' ";
   String inString="";
   /*
   if(org_id !=null && !org_id.equals("null") && !org_id.equals("")){
       sqlStr += "and org_id ='" + org_id + "' ";
   }
   if(class_id !=null && !class_id.equals("null") && !class_id.equals("")){
   	   sqlStr += "and class_id ='" + class_id + "' ";
   }
   if(staffstatus !=null && !staffstatus.equals("null") && !staffstatus.equals("")){
   	   sqlStr += " and staffstatus ='" + staffstatus + "' ";
   } 
   */
   /*
   String sqlStr="select ccsworkno, b.region_name, login_no, c.status_name, kf_name, class_id, duty "+
                 " from dstaffstatus a,scallregioncode b ,sstaffstatuscode c" +
                 " where a.org_id=b.region_code " +
                 " and trim(a.staffstatus)=trim(c.status_code) ";   
     //  sqlStr += " and ccsworkno !='" + workNo + "' ";
    */ 
    
   String sqlStr="select distinct ccsworkno, b.region_name, login_no, c.status_name, kf_name, a.class_id, a.class_id as skillgroup,duty "+
                 " from dstaffstatus a,scallregioncode b ,sstaffstatuscode c " ;
   
   if((class_id !=null && !class_id.equals("null") && !class_id.equals(""))||(skill_id !=null && !skill_id.equals("null") && !skill_id.equals(""))){
   	   sqlStr += ",sCALLCLASS d ";
   }  
              
   sqlStr +=" where a.org_id=b.region_code " +
            " and trim(a.staffstatus)=trim(c.status_code) ";

                 
   if(org_id !=null && !org_id.equals("null") && !org_id.equals("")){
       sqlStr += "and a.org_id =:org_id ";
       params+="org_id="+org_id;
   }
   if(class_id !=null && !class_id.equals("null") && !class_id.equals("")){
   	   sqlStr += " and a.class_id=d.class_name and d.class_id=:class_id ";
   	   params+=",class_id="+class_id;
   }
   if(skill_id !=null && !skill_id.equals("null") && !skill_id.equals("")){
   	   sqlStr += " and a.class_id=d.class_name and d.class_id=:skill_id ";
   	   params+=",skill_id="+skill_id;
   }
   if(staffstatus !=null && !staffstatus.equals("null") && !staffstatus.equals("")){
   	   sqlStr += "and c.status_code =:staffstatus ";
   	   params+=",staffstatus="+staffstatus;
   }
    
     
     
    System.out.println("endNum:*************"+endNum);
   if(endNum !=null && !endNum.equals("null") && !endNum.equals("")){
   	   sqlStr += " and rownum <=:endNum ";
   	   params+=",endNum="+endNum;
   }
   
     System.out.println("############################################"+sqlStr);
%>
<wtc:service name="TlsPubSelCrm" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sqlStrMenu%>"/>
</wtc:service>
<wtc:array id="theResult" scope="end"/>
	<%
	if(theResult.length>0)
	{
	inString="and ccsworkno not in('"+theResult[0][0]+"'";
	for(int k=1;k<theResult.length;k++)
	{
	inString=inString+",'"+theResult[k][0]+"'";
	}
	inString=inString+") ";
	}
	sqlStr=sqlStr+inString;

	%>

<wtc:service name="TlsPubSelCrm" outnum="8" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=params%>"/>
</wtc:service>

<wtc:array id="resultList" start="0" length="8">
<%
for(int i = 0; i < resultList.length; i++){
	for(int j = 0; j < resultList[i].length; j++){
		System.out.println(resultList[i][j]);
	}
}



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
