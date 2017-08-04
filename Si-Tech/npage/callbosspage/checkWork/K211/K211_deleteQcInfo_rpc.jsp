<%
  /*
   * 功能: 质检结果记录删除
　* 版本: 1.0
　* 日期: 2008/10/20
　* 作者: hanjc
　* 版权: sitech
   * update:tangsong 20110411 实现批量删除功能
   */
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String myParams="";
	String workNo = (String)session.getAttribute("workNo");
	String serialnums=request.getParameter("serialnums");

	List sqlList = new ArrayList();

	/*1. '删除'质检记录*/
	String strDel = "update dqcinfo set is_del = 'Y',DELETETIME=sysdate,DELETELOGINNO='"
						 + workNo + "' where serialnum in (" + serialnums + ")";
	sqlList.add(strDel);

	String getDCCContact_id = "select recordernum,objectid,contentid,plan_id,staffno,to_char(checkflag) from dqcinfo where serialnum in ("
	                                  + serialnums +")";
%>

	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="6">
		<wtc:param value="<%=getDCCContact_id%>" />
		<wtc:param value="" />
	</wtc:service>
	<wtc:array id="dCCContact_id" scope="end"/>
<%
	for (int i = 0; i < dCCContact_id.length; i++) {
		String contact_id = dCCContact_id[0][0];
		String objectid = dCCContact_id[0][1];   //考评对象id
		String contentid = dCCContact_id[0][2]; //考评内容id
		String plan_id = dCCContact_id[0][3];		 //计划id
		String staffno = dCCContact_id[0][4];	    //被检工号
		String checkflag = dCCContact_id[0][5]; //复核标识(0:复核时产生的质检记录，-1:未复核质检记录，1:已被复核质检记录)

	   String updStatus = null;
	   String updCurrTimes = null;
	   String strSetCheckFlag = null;
	   if (contact_id != null && !contact_id.equals("")&&!contact_id.equals("null")) {
	   	/*2. 更新dcallcall表为未质检*/
			updStatus = "update dcallcall" + contact_id.substring(0,6)
							  + " set QC_FLAG = 'N',QC_LOGIN_NO='' where contact_id = :v1" + "&&" + contact_id.trim();
			 }
	   if (plan_id != null && !plan_id.equals("")&&!plan_id.equals("null")) {
	   	/*3. 更新dqcloginplan表，当前质检次数减少1*/
	      updCurrTimes = "update dqcloginplan dp set dp.current_times = decode(nvl(dp.current_times,0),0,0,dp.current_times-1) "
				               + "where dp.plan_id =:v1 and object_id =:v2 and content_id =:v3 and login_no =:v4"
			                  + "&&"+plan_id.trim()+"^"+objectid.trim()+"^"+contentid.trim()+"^"+staffno.trim();
	   }
	   if ("0".equals(checkflag)) {
	      /*4. 如果是复核记录，则不更新dcallcall表，而将质检记录设为未复核*/
	   		updStatus = null;
	   		strSetCheckFlag = "update dqcinfo set checkflag = '-1' where serialnum =:v1" + "&&"+contact_id.trim();
	   }
	   if (updStatus != null) {
			sqlList.add(updStatus);
	   }
	   if (updCurrTimes != null) {
			sqlList.add(updCurrTimes);
	   }
	   if (strSetCheckFlag != null) {
			sqlList.add(strSetCheckFlag);
	   }
	}
	String[] sqlArr = (String[])sqlList.toArray(new String[0]);
%>
	<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="" />
		<wtc:param value="dbchange" />
		<wtc:params value="<%=sqlArr%>" />
	</wtc:service>
	<wtc:array id="retRows" scope="end" />

	var response = new AJAXPacket();
	response.data.add("retCode",<%=retCode%>);
	core.ajax.receivePacket(response);