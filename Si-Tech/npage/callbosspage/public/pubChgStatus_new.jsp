<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%> 
<%@page import="com.sitech.crmpd.kf.dto.dstaffstatus.Dstaffstatus"%>
<%

   
    
    String retType = request.getParameter("retType");
    String op_code ="";
    String phone_no ="";
    String status_name = request.getParameter("status_name");
    String op_note="状态更改为"+status_name;
    String staff_status = request.getParameter("status_code");
	String login_no  = (String)session.getAttribute("workNo");    
	String login_name = (String)session.getAttribute("workName");
	String org_code ="01"; 
	String ip_addr = (String)session.getAttribute("ipAddr");
	String long_Time = WtcUtil.repNull(request.getParameter("long_Time"));
    String kf_longin_n=request.getParameter("ccsWorkNo");
    String monitorFlag=request.getParameter("monitorFlag");
    String workGroup=request.getParameter("workGroup");
    String vdnWork=request.getParameter("vdnWork");
    String mainCCS=request.getParameter("mainCCS");
    String BackCcsIP=request.getParameter("BackCcsIP");   
   
    String retCode="000000";
    String retMsg="成功";
    String datea =(String)KFEjbClient.queryForObject("getSysdate");
    try{
	    Dstaffstatus dstaffstatus=new Dstaffstatus();
	    dstaffstatus.setLogin_no(login_no);
	    dstaffstatus.setKf_name(login_name);
	    dstaffstatus.setOrg_id(org_code);
	    dstaffstatus.setStaffstatus(staff_status);
	    dstaffstatus.setCheckno(login_no);
	    dstaffstatus.setCcsworkno(kf_longin_n);
	    dstaffstatus.setKf_no(kf_longin_n);
	    dstaffstatus.setVdnno("1");
	    dstaffstatus.setOp_imte(datea);
	    dstaffstatus.setDuty(monitorFlag);
	    dstaffstatus.setClass_id(workGroup);
	    dstaffstatus.setVdnno(vdnWork);
	    dstaffstatus.setMainccs(mainCCS);
	    dstaffstatus.setBackccs(BackCcsIP);
	    int updatflag = KFEjbClient.update("updateDstaffstatus",dstaffstatus); 
	    if(updatflag==0)
	    {
	    	KFEjbClient.insert("insertDstaffstatus",dstaffstatus);
	    }
	}
	catch(Exception e){
		retCode="000001";
		retMsg="失败";
	}
	 out.println(retCode);
%>