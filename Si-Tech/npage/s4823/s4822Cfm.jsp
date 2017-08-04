<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<wtc:pubselect name="sPubSelect" outnum="1">
    <wtc:sql>select SMAXSYSACCEPT.Nextval from dual</wtc:sql>
  </wtc:pubselect>
<wtc:array id="sysAccept" scope="end"/>
<%
if(sysAccept.length==0){
%>
<script language="JavaScript">
		rdShowMessageDialog("取流水错误!",0);
		parent.removeTab('4822');
</script>	
<%
return;
}
  String accept = sysAccept[0][0];
  String activeId = (String)request.getParameter("activeId");
  String reFlag = (String)request.getParameter("reFlag");
  String channelType= "906";
  String channelCode= "";
  String teamId = (String)request.getParameter("teamId");
  String regionCode = (String)request.getParameter("regionCode");
  String idNo = (String)request.getParameter("idNo");
  String phoneNo = (String)request.getParameter("phoneNo");
  String isCommit = "0";
  String isContent = "0";
  String contentCause = "";
  String conFlag = (String)request.getParameter("conFlag");
  String backFail = (String)request.getParameter("backFail");
  String isPresent = "1";
  String transactCode = (String)request.getParameter("transactCode");
  String resultCode = (String)request.getParameter("resultCode");
  String feedbackInfo = (String)request.getParameter("feedbackInfo");
  String backInfo = (String)request.getParameter("backInfo");
  String orgCode = (String)session.getAttribute("orgCode");
  String workNo = (String)session.getAttribute("workNo");
  String workName = (String)session.getAttribute("workName");
  String custName = (String)request.getParameter("custName");
  String presentCode = "";
  String presentCount = "0";
  String otherCount = "";
  String presentAllCountText = "0";
  System.out.println("isPresent:="+isPresent);

  String sql=" insert into dbsalesadm.dFndCustExecCircs(Exec_Circs_Id,Action_Id,Back_Flag,Contact_Channel_Type,Contact_Channel_Code,Cust_Group_Id,City_Code"+
						 ",Id_No,Phone_No,Exec_Status,Exec_Result,Fail_Reason,Feedback_Status,Feedback_Reason,Is_Present,Is_Local_Transact,Feedback_Code,Feedback_Info"+
						 ",Proposal_Info,Succ_Experience,Present_Code,Present_Count,Other_Fee_Code,Update_Time,Action_Eval,Note,Site_Code,Exec_By_Id,Exec_By_Name"+
						 ",Exec_Time) values('?','?','?','?','?','?','?',?,'?','?','?','?','?','?','?','?','?','?','','','?',?,'?',sysdate,'','?','?','?','?',sysdate)";
  System.out.println("wanglei test here @@@@@@@@@@@@@@@@@");
  System.out.println("sql:="+sql);
  System.out.println("'"+accept+"','"+activeId+"','"+reFlag+"','"+channelType+"','"+channelCode+"','"+teamId+"','"+regionCode+"',"+idNo+",'"+phoneNo+"','"+isCommit+"','"+isContent+"','"+contentCause+"','"+conFlag+"','"+backFail+"','"+backFail+"','"+isPresent+"','"+transactCode+"','"+resultCode+"','','','"+feedbackInfo+"',"+presentCount+",'"+otherCount+"',sysdate,'','"+backInfo+"','"+orgCode+"','"+workNo+"','"+workName+"',sysdate");
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
  <wtc:sql><%=sql%></wtc:sql>
  <wtc:param value="<%=accept%>"/>
  <wtc:param value="<%=activeId%>"/>
  <wtc:param value="<%=reFlag%>"/>
  <wtc:param value="<%=channelType%>"/>
  <wtc:param value="<%=channelCode%>"/>
  <wtc:param value="<%=teamId%>"/>
  <wtc:param value="<%=regionCode%>"/>
  <wtc:param value="<%=idNo%>"/>
  <wtc:param value="<%=phoneNo%>"/>
  <wtc:param value="<%=isCommit%>"/>
  <wtc:param value="<%=isContent%>"/>
  <wtc:param value="<%=contentCause%>"/>
  <wtc:param value="<%=conFlag%>"/>
  <wtc:param value="<%=backFail%>"/>
  <wtc:param value="<%=isPresent%>"/>
  <wtc:param value="<%=transactCode%>"/>
  <wtc:param value="<%=resultCode%>"/>
  <wtc:param value="<%=feedbackInfo%>"/>
  <wtc:param value="<%=presentCode%>"/>
  <wtc:param value="<%=presentCount%>"/>
  <wtc:param value="<%=otherCount%>"/>
  <wtc:param value="<%=backInfo%>"/>
  <wtc:param value="<%=orgCode%>"/>
  <wtc:param value="<%=workNo%>"/>
  <wtc:param value="<%=workName%>"/>
</wtc:pubselect>
<%
System.out.println("=================retcode====="+retCode+"======================");
if(!retCode.equals("000000")){
%>
<script language="JavaScript">
		rdShowMessageDialog("插入反馈表失败！",0);
		history.go(-1);
</script>
<%
return;
}
System.out.println("===========resultcode==========="+resultCode+"======================");
if(resultCode.equals("04")||resultCode.equals("05")){
String sql2=" insert into dbsalesadm.dFndSaleAshCust(sale_ash_id,id_no,phone_no,cust_name,action_id,contact_channel_type,contact_channel_code"+
						 ",become_ash_reason,note,created_no,created_name,created_date)"+
						 " values('?','?','?','?','?','?','?','?','?','?','?',sysdate)";
String sql3=" insert into dbsalesadm.dFndSaleAshCustLog(log_id,sale_ash_id,id_no,phone_no,cust_name,action_id,contact_channel_type,contact_channel_code"+
						 ",become_ash_reason,note,oper_type,created_no,created_name,created_date)"+
						 " values('?','?','?','?','?','?','?','?','?','?','?','?','?',sysdate)";						 
  
  //System.out.println("sql2:="+sql2);
%>
<wtc:pubselect name="sPubSelect" outnum="1">
    <wtc:sql>select SMAXSYSACCEPT.Nextval from dual</wtc:sql>
  </wtc:pubselect>
<wtc:array id="sysAccept2" scope="end"/>
<wtc:pubselect name="sPubSelect" outnum="1">
    <wtc:sql>select SMAXSYSACCEPT.Nextval from dual</wtc:sql>
  </wtc:pubselect>
<wtc:array id="sysAccept3" scope="end"/>		
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
  <wtc:sql><%=sql2%></wtc:sql>
  <wtc:param value="<%=sysAccept2[0][0]%>"/>
  <wtc:param value="<%=idNo%>"/>
  <wtc:param value="<%=phoneNo%>"/>
  <wtc:param value="<%=custName%>"/>
  <wtc:param value="<%=activeId%>"/>
  <wtc:param value="<%=channelType%>"/>
  <wtc:param value="<%=channelCode%>"/>
  <wtc:param value="boss反馈黑名单"/>
  <wtc:param value="boss反馈黑名单"/>
  <wtc:param value="<%=workNo%>"/>
  <wtc:param value="<%=workName%>"/>		
</wtc:pubselect>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
  <wtc:sql><%=sql3%></wtc:sql>
  <wtc:param value="<%=sysAccept3[0][0]%>"/>
  <wtc:param value="<%=sysAccept2[0][0]%>"/>
  <wtc:param value="<%=idNo%>"/>
  <wtc:param value="<%=phoneNo%>"/>
  <wtc:param value="<%=custName%>"/>
  <wtc:param value="<%=activeId%>"/>
  <wtc:param value="<%=channelType%>"/>
  <wtc:param value="<%=channelCode%>"/>
  <wtc:param value="boss反馈黑名单"/>
  <wtc:param value="boss反馈黑名单"/>	
  <wtc:param value="add"/>	
  <wtc:param value="<%=workNo%>"/>
  <wtc:param value="<%=workName%>"/>		
</wtc:pubselect>
<%}%>
<script language="JavaScript">
		rdShowMessageDialog("操作成功！",2);
	<%if(reFlag.equals("1")){%>
		parent.removeTab('4823');
	<%}%>
		parent.removeTab('4822');
</script>


