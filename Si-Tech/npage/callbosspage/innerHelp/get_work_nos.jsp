<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

   System.out.println("############################################");
   String retType = WtcUtil.repNull(request.getParameter("retType"));
   String org_id = WtcUtil.repNull(request.getParameter("org_id"));
   String class_id = WtcUtil.repNull(request.getParameter("class_id"));
   String skill_id = WtcUtil.repNull(request.getParameter("skill_id"));
   String staffstatus = WtcUtil.repNull(request.getParameter("staffstatus"));
   String endNum=WtcUtil.repNull(request.getParameter("endNum"));
   String WorkNo=(String)session.getAttribute("kfWorkNo");
   
   System.out.println("11111 skill_id= "+skill_id+" org_id="+org_id+" class_id="+class_id+" staffstatus="+staffstatus);
   
   
/*   String sqlStr = "select ccsworkno, org_id, login_no, staffstatus, kf_name, class_id, duty from dstaffstatus where 1=1 ";

   if(org_id !=null && !org_id.equals("null") && !org_id.equals("")){
       sqlStr += "and org_id ='" + org_id + "' ";
   }
   if(class_id !=null && !class_id.equals("null") && !class_id.equals("")){
   	   sqlStr += "and class_id ='" + class_id + "' ";
   }
   if(staffstatus !=null && !staffstatus.equals("null") && !staffstatus.equals("")){
   	   sqlStr += "and staffstatus ='" + staffstatus + "' ";
   }
   */
   
   String sqlStr="select distinct ccsworkno, b.region_name, login_no, c.status_name, kf_name,a.class_id, a.class_id as skillgroup, duty "+
                 " from dstaffstatus a,scallregioncode b ,sstaffstatuscode c " ;
   if((class_id !=null && !class_id.equals("null") && !class_id.equals(""))||(skill_id !=null && !skill_id.equals("null") && !skill_id.equals(""))){
   	   sqlStr += ",sCALLCLASS d ";
   }   
              
   sqlStr +=" where a.org_id=b.region_code " +
            " and trim(a.staffstatus)=trim(c.status_code) ";

                 
   if(org_id !=null && !org_id.equals("null") && !org_id.equals("")){
       sqlStr += "and a.org_id =:org_id ";
       myParams = "org_id="+org_id ;
   }
   if(class_id !=null && !class_id.equals("null") && !class_id.equals("")){
       //针对神州行的两个班组划分sql by libin 2009-05-15
   		 if(class_id != null && ("015".equals(class_id) || "016".equals(class_id))){
   		 	sqlStr += " and d.class_name like a.class_id||'%' and d.class_id=:class_id ";
   		 	if(myParams.equals("")){
   		 		myParams = "class_id="+class_id ;
   			}else{
   				myParams += ",class_id="+class_id ;
   			}
   		 }else{
   		 	 sqlStr += " and a.class_id=d.class_name and d.class_id=:class_id ";
   		 	if(myParams.equals("")){
   		 		myParams = "class_id="+class_id ;
   			}else{
   				myParams += ",class_id="+class_id ;
   			}
   		 }
   	   
   }
   
   if(skill_id !=null && !skill_id.equals("null") && !skill_id.equals("")){
   	   sqlStr += " and a.class_id=d.class_name and d.class_id=:skill_id ";
   	   if(myParams.equals("")){
   		 		myParams = "skill_id="+skill_id ;
   			}else{
   				myParams += ",skill_id="+skill_id ;
   			}
   }
   
   if(staffstatus !=null && !staffstatus.equals("null") && !staffstatus.equals("")){
   	   sqlStr += "and c.status_code =:staffstatus ";
   	   if(myParams.equals("")){
   		 		myParams = "staffstatus="+staffstatus ;
   			}else{
   				myParams += ",staffstatus="+staffstatus ;
   			}
   }

   
    // sqlStr += "and ccsworkno !='" + WorkNo + "' "; 
    System.out.println("endNum:*************"+endNum);
   if(endNum !=null && !endNum.equals("null") && !endNum.equals("")){
   	   sqlStr += " and rownum <=:endNum ";
   	   if(myParams.equals("")){
   		 		myParams = "endNum="+endNum ;
   			}else{
   				myParams += ",endNum="+endNum ;
   			}
   }
   System.out.println("############################################"+sqlStr);

%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="8">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=myParams%>"/>	
</wtc:service>

<wtc:array id="resultList" start="0" length="8">
<%
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
