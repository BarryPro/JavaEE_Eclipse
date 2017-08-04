<%
  /*
   * 功能: 保存质检结果
　 * 版本: 1.0.0
　 * 日期: 2008/11/29
　 * 作者: hanjc
　 * 版权: sitech
   * update:
　 */
%>
<%
	//String opCode = "K214";
	//String opName = "保存质检结果";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	System.out.println("############################################");

	String retType     = WtcUtil.repNull(request.getParameter("retType"));
	String[] scores    = request.getParameterValues("scores");
	String[] itemids   = request.getParameterValues("itemIds");
	String serialnum   = WtcUtil.repNull(request.getParameter("serialnum"));
	String modevterno  = (String)session.getAttribute("kfWorkNo");//修改人工号
  System.out.println("modevterno ----------------> " + modevterno);
	System.out.println("serialnum ----------------> " + serialnum);
	String objectid    = "1";
	String contentid   = "1";
	if(scores==null){
	  scores=new String[]{};
	}
System.out.println("==============scores.length=="+scores.length);
	String[] sqlStrs   = new String[scores.length];
	StringBuffer sb = new StringBuffer();
	
	//在DQCMODINFODETAIL插入两条记录，一条为备份。另一条为修改后的记录
  String[] sqlInsert = new String[2];
  String sqlInsertDetailBefore = "insert into dqcmodinfodetail (modserialnum,objectid,contentid,itemid,weight,orgvalue,score,modflag) "
                          +"(select seq_qc_result.nextval,objectid,contentid,itemid,weight,orgvalue,score,0 from dqcinfodetail,dual where serialnum='"+serialnum+"')";
  String sqlInsertDetailAfter = "insert into dqcmodinfodetail (modserialnum,objectid,contentid,itemid,weight,orgvalue,score,modflag) "
                          +"(select seq_qc_result.nextval,objectid,contentid,itemid,weight,orgvalue,score,1 from dqcinfodetail,dual where serialnum='"+serialnum+"')";
  sqlInsert[0]= sqlInsertDetailBefore;
  sqlInsert[1]= sqlInsertDetailAfter;
%>
  <wtc:service name="sPubModify" outnum="3">
  	<wtc:params value="<%=sqlInsert%>"/>
  	<wtc:param value="dbcall"/>
  </wtc:service>
<%  
  //在DQCMODINFO插入两条记录，一条为备份。另一条为修改后的记录
  String sqlInsertInfoBefore = "insert into dqcmodinfo  "
                         +"(select seq_qc_result.nextval,serialnum,recordernum,serviceclassid,staffno,objectid,contentid,score"
                         +",contentlevelid,evterno,checktype,kind,starttime,endtime,dealduration,lisduration"
                         +",arrduration,evtduration,flag,signataryid,affirmtime,contentinsum,handleinfo,improveadvice"
                         +",trainadvice,errorclassid,qcserviceclassid,errorlevelid,checkflag,abortreasonid,outplanflag"
                         +",planserialnum,staffgroupid,commentinfo,checkclass,confirmscoreflag,confirmscoredt,errorclassdesc"
                         +",0,null,null,null from dqcinfo a,dual b where serialnum='"+serialnum+"')";
  String sqlInsertInfoAfter = "insert into dqcmodinfo  "
                         +"(select seq_qc_result.nextval,serialnum,recordernum,serviceclassid,staffno,objectid,contentid,score"
                         +",contentlevelid,evterno,checktype,kind,starttime,endtime,dealduration,lisduration"
                         +",arrduration,evtduration,flag,signataryid,affirmtime,contentinsum,handleinfo,improveadvice"
                         +",trainadvice,errorclassid,qcserviceclassid,errorlevelid,checkflag,abortreasonid,outplanflag"
                         +",planserialnum,staffgroupid,commentinfo,checkclass,confirmscoreflag,confirmscoredt,errorclassdesc"
                         +",1,null,null,null from dqcinfo a,dual b where serialnum='"+serialnum+"')";
                         
  sqlInsert[0]= sqlInsertInfoBefore;
  sqlInsert[1]= sqlInsertInfoAfter;
%>
  <wtc:service name="sPubModify" outnum="3">
  	<wtc:params value="<%=sqlInsert%>"/>
  	<wtc:param value="dbcall"/>
  </wtc:service>
<%                           
  /**
  String sqlInsertInfoBefore = "insert into dqcmodinfo (modserialnum,objectid,contentid,itemid,weight,orgvalue,score) "
                          +"(select seq_qc_result.nextval,objectid,contentid,itemid,weight,orgvalue,score from dqcinfodetail,dual where serialnum='481')";
  */

	for(int i = 0; i < scores.length; i++){
		System.out.println(scores[i]);
		sb.append("update dqcmodinfodetail set itemid='"+ itemids[i] +"',weight='0',orgvalue='0',score='"+ scores[i] +"' where modserialnum='"+serialnum+"' and modflag='1'");
		System.out.println(sb.toString());
		sqlStrs[i] = sb.toString();
		sb.delete(0, sb.length());
	}

	String contentinsum      = WtcUtil.repNull(request.getParameter("serialnum"));
	String handleinfo        = WtcUtil.repNull(request.getParameter("handleinfo"));
	String improveadvice     = WtcUtil.repNull(request.getParameter("improveadvice"));
	String commentinfo       = WtcUtil.repNull(request.getParameter("commentinfo"));
	String error_level_id    = WtcUtil.repNull(request.getParameter("error_level_id"));
	String error_class_ids   = WtcUtil.repNull(request.getParameter("error_class_ids"));
	String service_class_ids = WtcUtil.repNull(request.getParameter("service_class_ids"));
	String totalScore        = WtcUtil.repNull(request.getParameter("totalScore"));
	String flag              = WtcUtil.repNull(request.getParameter("flag"));
  String endtime           = WtcUtil.repNull(request.getParameter("endtime"));
  String modmemo           = WtcUtil.repNull(request.getParameter("modmemo"));
  String modflag           = WtcUtil.repNull(request.getParameter("modflag"));


	String sqlUpdQcInfo = "update dqcmodinfo set endtime = '"+endtime+"', dealduration=ceil(to_number("+endtime+"-starttime)*86400) ," +
						  "contentinsum = '" + contentinsum +"', handleinfo = '" + handleinfo + "', " +
						  "improveadvice = '" + improveadvice + "', commentinfo = '" + commentinfo + "', " +
						  "errorlevelid = '" + error_level_id + "', errorclassid = '" + error_class_ids + "', qcserviceclassid='" + service_class_ids + "', "  +
						  "score = '" + totalScore + "', flag = '" + flag + " ', modmemo = '" + modmemo + "', modtime = sysdate "+
						  "where serialnum = '" + serialnum + "' and modflag='1'";
	System.out.println(sqlUpdQcInfo);
	System.out.println("----->############################################");
%>

<wtc:service name="sPubModify" outnum="3">
	<wtc:params value="<%=sqlStrs%>"/>
	<wtc:param value="dbcall"/>
</wtc:service>

<wtc:service name="sPubModify" outnum="3">
	<wtc:param value="<%=sqlUpdQcInfo%>"/>
	<wtc:param value="dbcall"/>
</wtc:service>

<wtc:row id="row" start="0" length="3">

<%
System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");

System.out.println(row[0]);
System.out.println(row[1]);
System.out.println(row[2]);
System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");

%>


var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%="000000"%>");
response.data.add("retMsg","<%="success"%>");
response.data.add("object_id","<%="aaa"%>");
core.ajax.receivePacket(response);
</wtc:row>