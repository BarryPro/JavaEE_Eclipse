<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="/npage/callbosspage/public/constants.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

	String serialnum = WtcUtil.repNull(request.getParameter("serialnum"));
	String recordernum = WtcUtil.repNull(request.getParameter("recordernum"));
	String staffno = WtcUtil.repNull(request.getParameter("staffno"));
	String evterno = WtcUtil.repNull(request.getParameter("evterno"));
	String objectid = WtcUtil.repNull(request.getParameter("objectid"));
	String contentid = WtcUtil.repNull(request.getParameter("contentid"));
	String plan_id = WtcUtil.repNull(request.getParameter("plan_id"));	
	String group_flag = WtcUtil.repNull(request.getParameter("group_flag"));
	String strSql = null;
	String returnNum = "0";
	List sqlList = new ArrayList();
	String[] sqlArr = new String[]{};
	
	//判断是否是复核产生的流水
	String checkSql = "select to_char(nvl(count(*),0)) from dqcinfo where serialnum = :recordernum and is_del='N' " ;
	myParams = "recordernum="+recordernum ;
	
	/**String strUpd2 = "update dcallcall" + recordernum.substring(0,6) 
									 + " set QC_FLAG = 'Y' where trim(contact_id) =  '"+ recordernum.trim() +"'";			
	*/
	String strUpd2 = "update dcallcall" + recordernum.substring(0,6) 
	 + " set QC_FLAG = 'Y',QC_LOGIN_NO=:v1 where contact_id =   :v2&&"+evterno.trim()+"^"+ recordernum.trim();
			 
	/**String strUpd1 = "update dqcinfo set is_del = 'N'  where serialnum = '"+serialnum+"' ";
	*/
	String strUpd1 = "update dqcinfo set is_del = 'N'  where serialnum =  :v1&&"+serialnum;
	
	
	/**String strUpd3 = "update dqcloginplan dp set dp.current_times = dp.current_times+1 "
				 + "where dp.plan_id = '"+ plan_id.trim() +"' and object_id = '"+objectid.trim() +"' and content_id = '"+ contentid.trim() +"' and login_no = '"+ staffno.trim() +"'" ; 
	*/
	String strUpd3 = "update dqcloginplan dp set dp.current_times = dp.current_times+1 "
		 + "where dp.plan_id =  :v1 and object_id =  :v2 and content_id =  :v3 and login_no =  :v4" ;
	strUpd3 += "&&"+ plan_id.trim() +"^"+objectid.trim() +"^"+ contentid.trim() +"^"+ staffno.trim() ;
	sqlList.add(strUpd1);
%>	

	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
		<wtc:param value="<%=checkSql%>"/>
		<wtc:param value="<%=myParams%>"/>
	</wtc:service>
	<wtc:array id="temp" scope="end"/>
<%
    if(temp.length>0){
      returnNum = temp[0][0];      
    }
    
    //如果结果大于0，则为复核产生的流水  checkflag=1表示该条流水已被复核
    if(Integer.parseInt(returnNum) > 0 ){
    		/**String strSetCheckFlag = "update dqcinfo set checkflag = '1'  where serialnum = '"+ recordernum.trim() +"' and is_del = 'N' ";
    		*/
    		String strSetCheckFlag = "update dqcinfo set checkflag = '1' where serialnum = :v1 and is_del = 'N' ";
    		strSetCheckFlag += "&&"+ recordernum.trim();
			sqlList.add(strSetCheckFlag);
   	}else{
   			sqlList.add(strUpd2);
   	}
   	//plan_id 为 -1 时为计划外质检故只有为非-1时才更新计划执行次数
   	if(!("-1".equals(plan_id))){
   			sqlList.add(strUpd3);
   	}
   	
   	sqlArr = (String[])sqlList.toArray(new String[0]);
   	for(int i=0;i<sqlArr.length;i++){
   	}
		String outnum = String.valueOf(sqlArr.length + 1);  
%>
			
			<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode%>">
			    <wtc:param value=""/>
			    <wtc:param value="dbchange"/>
			    <wtc:params value="<%=sqlArr%>"/>
			</wtc:service>

			<wtc:array id="retRows"  scope="end"/>	
				
      var response = new AJAXPacket();
      response.data.add("retCode","000000");      
      core.ajax.receivePacket(response);