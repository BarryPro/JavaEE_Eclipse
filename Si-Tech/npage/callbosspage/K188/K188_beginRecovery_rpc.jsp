<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="/npage/callbosspage/public/constants.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%

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
	System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++");
	List sqlList = new ArrayList();
	String[] sqlArr = new String[]{};
	
	//判断是否是复核产生的流水
	String checkSql = "select count(1) from dqcinfo where serialnum = '" + recordernum + "' and is_del='N' " ;
	
	String strUpd2 = "update dcallcall" + recordernum.substring(0,6) 
									 + " set QC_FLAG = 'Y' where trim(contact_id) =  '" + recordernum.trim() + "'";			
			 
	String strUpd1 = "update dqcinfo set is_del = 'N'  where serialnum = '" + serialnum + "' ";
	
	
	String strUpd3 = "update dqcloginplan dp set dp.current_times = dp.current_times+1 "
				 + "where dp.plan_id = '" + plan_id.trim() +"' and object_id = '" + objectid.trim() 
				 + "' and content_id = '" + contentid.trim() + "' and login_no = '" + staffno.trim() + "'" ; 
				 
	sqlList.add(strUpd1);
%>	

	<wtc:service name="s151Select" outnum="1">
		<wtc:param value="<%=checkSql%>"/>
	</wtc:service>
	<wtc:array id="temp" scope="end"/>
<%
    if(temp.length>0){
      returnNum = temp[0][0];      
    }
    
    //如果结果大于0，则为复核产生的流水  checkflag=1表示该条流水已被复核
    if(Integer.parseInt(returnNum) > 0 ){
    		String strSetCheckFlag = "update dqcinfo set checkflag = '1'  where serialnum = '" + recordernum.trim() + "' and is_del = 'N' ";
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
   	System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++");
   	System.out.println(sqlArr[i]);
   	System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++");
   	}
		String outnum = String.valueOf(sqlArr.length + 1);  
%>
			<wtc:service name="sPubModify"  outnum="<%=outnum%>">
					<wtc:params value="<%=sqlArr%>"/>
					<wtc:param value="dbcall"/>	
			</wtc:service>
			<wtc:array id="retRows"  scope="end"/>	
				
      var response = new AJAXPacket();
      response.data.add("retCode","000000");      
      core.ajax.receivePacket(response);