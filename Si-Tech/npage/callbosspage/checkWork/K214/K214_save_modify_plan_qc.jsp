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
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
//jiangbing 20091118 批量服务替换
String regionCode_sqlMulKfCfm = regionCode; 
String sqlMulKfCfm="";
	
String myParams="";
String retType     = WtcUtil.repNull(request.getParameter("retType"));
String[] scoreBefValues = request.getParameterValues("scoreBefValues");//zhengjiang 20091023 add       
String[] scores    = request.getParameterValues("scores");

String[] itemids   = request.getParameterValues("itemIds");
String nowYYYYMM   = WtcUtil.repNull(request.getParameter("nowYYYYMM"));
String serialnum   = WtcUtil.repNull(request.getParameter("serialnum"));
String contact_id  = WtcUtil.repNull(request.getParameter("contact_id"));//通话流水
String content_id = WtcUtil.repNull(request.getParameter("content_id"));
String object_id = WtcUtil.repNull(request.getParameter("object_id"));	
String modevterno  = (String)session.getAttribute("workNo");//修改人工号
String evterno  = (String)session.getAttribute("evterno");//修改人工号	
	
String contentinsum      = WtcUtil.repNull(request.getParameter("contentinsum"));
String handleinfo        = WtcUtil.repNull(request.getParameter("handleinfo"));
String improveadvice     = WtcUtil.repNull(request.getParameter("improveadvice"));
String commentinfo       = WtcUtil.repNull(request.getParameter("commentinfo"));
String error_level_id    = WtcUtil.repNull(request.getParameter("error_level_id"));
String error_class_ids   = WtcUtil.repNull(request.getParameter("error_class_ids"));
String service_class_ids = WtcUtil.repNull(request.getParameter("service_class_ids"));
String totalScore        = WtcUtil.repNull(request.getParameter("totalScore"));
String flag              = WtcUtil.repNull(request.getParameter("flag"));
//zengzq 增加评定原因 091016
String check_reason_ids   = WtcUtil.repNull(request.getParameter("check_reason_ids"));
//zengzq 增加评定原因 091016
String check_reason_texts = WtcUtil.repNull(request.getParameter("check_reason_texts"));
String endtime           = WtcUtil.repNull(request.getParameter("endtime"));
String modmemo           = WtcUtil.repNull(request.getParameter("modmemo"));
String modflag           = WtcUtil.repNull(request.getParameter("modflag"));
String service_class_texts = WtcUtil.repNull(request.getParameter("service_class_texts"));
String error_level_texts = WtcUtil.repNull(request.getParameter("error_level_texts"));
String error_class_texts = WtcUtil.repNull(request.getParameter("error_class_texts"));
String moddes            = WtcUtil.repNull(request.getParameter("moddes"));
String handleTime        = WtcUtil.repNull(request.getParameter("handleTime"));
String listenTime        = WtcUtil.repNull(request.getParameter("listenTime"));     
String adjustTime        = WtcUtil.repNull(request.getParameter("adjustTime"));
String totalTime         = WtcUtil.repNull(request.getParameter("totalTime"));
String mod_flag         = WtcUtil.repNull(request.getParameter("mod_flag"));  
//added by tangsong 20100531 被加分的考评项名称、被扣分的考评项名称
String addedScoreItem = WtcUtil.repNull(request.getParameter("addedScoreItem"));
String lostScoreItem = WtcUtil.repNull(request.getParameter("lostScoreItem"));
String modserialnumBefore="";
String modserialnumAfter="";
	
if(scores==null){
     scores=new String[]{};
}
StringBuffer sb = new StringBuffer();
String[] sqlStrsUpdate   = new String[scores.length];
//zengzq 只有作修改操作时才对修改相关表进行操作
if("mod".equals(mod_flag.trim())){
     String[] sqlStrsBrfore   = new String[scores.length];
     String[] sqlStrsAfter   = new String[scores.length];
     //String[] sqlUpdQcModInfo   = new String[2];
     String[] sqlInsertInfo = new String[2];
	
     //获得修改结果流水
     String sqlGetModserialnum = "select :nowYYYYMM || lpad(seq_qc_result.nextval,13,'0') from dual";
     myParams = "nowYYYYMM="+nowYYYYMM;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
  <wtc:param value="<%=sqlGetModserialnum%>"/>
  <wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="modserialnum" scope="end"/>
<%    
if(modserialnum.length>0){
  modserialnumBefore=modserialnum[0][0];
} 

%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
  	<wtc:param value="<%=sqlGetModserialnum%>"/>
  	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="modserialnum" scope="end"/>
<%    
if(modserialnum.length>0){
  modserialnumAfter=modserialnum[0][0];
} 

     //在DQCMODINFO插入两条记录，一条为备份。另一条为修改后的记录
     String sqlInsertInfoBefore = "insert into dqcmodinfo  "
          +"(select :v1,serialnum,recordernum,serviceclassid,staffno,objectid,contentid,score,contentlevelid,evterno,checktype,kind,starttime,"
          +"endtime,:v2,:v3,:v4,:v5,flag,signataryid,affirmtime,contentinsum,handleinfo,improveadvice,trainadvice,"
          +"errorclassid,qcserviceclassid,errorlevelid,checkflag,abortreasonid,outplanflag,planserialnum,staffgroupid,commentinfo,checkclass,"
          +"confirmscoreflag,confirmscoredt,errorclassdesc,0,null,null,null,null,serviceclassdesc,VERTIFY_PASSWD_FLAG, moddes, errorleveldesc "
          +" from dqcinfo a,dual b where serialnum=:v6)&&"+modserialnumBefore+"^"+handleTime+"^"+listenTime+"^"+adjustTime+"^"+totalTime+"^"+serialnum;

     String sqlInsertInfoAfter  = "insert into dqcmodinfo  "
          +"(select :v1,serialnum,recordernum,serviceclassid,staffno,objectid,contentid,score,contentlevelid,evterno,checktype,kind,starttime,"
          +"endtime,:v2,:v3,:v4,:v5,flag,signataryid,affirmtime,contentinsum,handleinfo,improveadvice,trainadvice,"
          +"errorclassid,qcserviceclassid,errorlevelid,checkflag,abortreasonid,outplanflag,planserialnum,staffgroupid,commentinfo,checkclass,"
          +"confirmscoreflag,confirmscoredt,errorclassdesc,1,null,null,null,null,serviceclassdesc,VERTIFY_PASSWD_FLAG, moddes, :v6 "
          +" from dqcinfo a,dual b where serialnum=:v7)&&"+modserialnumAfter+"^"+handleTime+"^"+listenTime+"^"+adjustTime+"^"+totalTime+"^"+error_level_texts+"^"+serialnum;

     sqlInsertInfo[0]=sqlInsertInfoBefore;
     sqlInsertInfo[1]=sqlInsertInfoAfter;                         
%>
<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode_sqlMulKfCfm%>">
<wtc:param value="<%=sqlMulKfCfm%>"/>
<wtc:param value="dbchange"/>
<wtc:params value="<%=sqlInsertInfo%>"/>
</wtc:service>
<%  
   
      //在DQCMODINFODETAIL插入两条记录，一条为备份。另一条为修改后的记录
                       
      /**
         String sqlInsertInfoBefore = "insert into dqcmodinfo (modserialnum,objectid,contentid,itemid,weight,orgvalue,score) "
         +"(select seq_qc_result.nextval,objectid,contentid,itemid,weight,orgvalue,score from dqcinfodetail,dual where serialnum='481')";
      */
      //备份质检结果明细zhengjiang 20091023 修改scores为scoreBefValues
      for(int i = 0; i < scoreBefValues.length; i++){
           sb.append("insert into dqcmodinfodetail (modserialnum,objectid,contentid,itemid,weight,orgvalue,score,modflag) "
                     +" select :v1,objectid,contentid,itemid,0,0,:v2,0 from dqcinfodetail,dual where serialnum=:v3 and objectid=:v4 and contentid=:v5 and itemid=:v6&&"+modserialnumBefore+"^"+scoreBefValues[i]+"^"+serialnum+"^"+object_id+"^"+content_id+"^"+itemids[i]);
           sqlStrsBrfore[i] = sb.toString();
           sb.delete(0, sb.length());
      }
	
     //更新修改质检结果明细	
     for(int i = 0; i < scores.length; i++){
          sb.append("insert into dqcmodinfodetail (modserialnum,objectid,contentid,itemid,weight,orgvalue,score,modflag) "
                    +" select :v1,objectid,contentid,itemid,0,0,:v2,1 from dqcinfodetail,dual where serialnum=:v3 and objectid=:v4 and contentid=:v5 and itemid=:v6&&"+modserialnumAfter+"^"+scores[i]+"^"+serialnum+"^"+object_id+"^"+content_id+"^"+itemids[i]);
          System.out.println(sb.toString());
          sqlStrsAfter[i] = sb.toString();
          sb.delete(0, sb.length());
     }
     String tmpSqlUpdQcModInfo1 = "update dqcmodinfo set endtime = sysdate,  " +
          "contentinsum = :v1, handleinfo = :v2, " +
          "improveadvice = :v3, commentinfo = :v4, " +
          "errorlevelid = :v5, errorclassid = :v6, qcserviceclassid=:v7, "  +
          "serviceclassdesc=:v8,"+   
          "score = :v9, flag = :v10, modmemo = :v11, modtime = sysdate, "+
          "errorleveldesc = :v12, errorclassdesc = :v13, moddes = :v14, "	+
          "DEALDURATION = :v15, LISDURATION = :v16, ARRDURATION = :v17, EVTDURATION = :v18,MODEVTERNO=:v19 "	+
          "where modseRialnum = :v20 and modflag='1'";
			
     //sqlUpdQcModInfo[0] = tmpSqlUpdQcModInfo1;
     String tmpSqlUpdQcModInfo2 = "update dqcmodinfo set MODEVTERNO=:v1 , modtime = sysdate where modserialnum = :v2";
     //sqlUpdQcModInfo[1] = tmpSqlUpdQcModInfo2;
%>
  <wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode_sqlMulKfCfm%>">
<wtc:param value="<%=sqlMulKfCfm%>"/>
<wtc:param value="dbchange"/>
<wtc:params value="<%=sqlStrsBrfore%>"/>
</wtc:service>

	<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode_sqlMulKfCfm%>">
<wtc:param value="<%=sqlMulKfCfm%>"/>
<wtc:param value="dbchange"/>
<wtc:params value="<%=sqlStrsAfter%>"/>
</wtc:service>
        
	<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	  <wtc:param value="<%=tmpSqlUpdQcModInfo2%>"/>
	  <wtc:param value="dbchange"/>
		<wtc:param value="<%=modevterno%>"/>
		<wtc:param value="<%=modserialnumBefore%>"/>
	</wtc:service>
   
	<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	  <wtc:param value="<%=tmpSqlUpdQcModInfo1%>"/>
	  <wtc:param value="dbchange"/>
		<wtc:param value="<%=contentinsum%>"/>
		<wtc:param value="<%=handleinfo%>"/>
		<wtc:param value="<%=improveadvice%>"/>
		<wtc:param value="<%=commentinfo%>"/>
		<wtc:param value="<%=error_level_id%>"/>
		<wtc:param value="<%=error_class_ids%>"/>
		<wtc:param value="<%=service_class_ids%>"/>
		<wtc:param value="<%=service_class_texts%>"/>
		<wtc:param value="<%=totalScore%>"/>
		<wtc:param value="<%=flag.trim()%>"/>
		<wtc:param value="<%=modmemo%>"/>
		<wtc:param value="<%=error_level_texts%>"/>
		<wtc:param value="<%=error_class_texts%>"/>
		<wtc:param value="<%=moddes%>"/>
		<wtc:param value="<%=handleTime%>"/>
		<wtc:param value="<%=listenTime%>"/>
		<wtc:param value="<%=adjustTime%>"/>
		<wtc:param value="<%=totalTime%>"/>
		<wtc:param value="<%=modevterno%>"/>
		<wtc:param value="<%=modserialnumAfter%>"/>
	</wtc:service>
	
<%
//zengzq
              }

//更新质检结果明细
for(int i = 0; i < scores.length; i++){
     sb.append("update dqcinfodetail set score=:v1 "
               +" where serialnum=:v2 and objectid=:v3 and contentid=:v4 and itemid=:v5&&"+scores[i]+"^"+serialnum+"^"+object_id+"^"+content_id+"^"+itemids[i]);
     System.out.println(sb.toString());
     sqlStrsUpdate[i] = sb.toString();
     sb.delete(0, sb.length());
}

if("saveQcInfo".equals(retType)&&!"".equals(contact_id)){
     //String nowYYYYMM = contact_id.substring(4, 10);
     String tableName = "dcallcall" + nowYYYYMM;
     String sqlUpdDcallcall="update "+tableName+" set QC_LOGIN_NO=:v1,QC_FLAG='Y' where contact_id=:v2";
     %>
    <wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	   <wtc:param value="<%=sqlUpdDcallcall%>"/>
	   <wtc:param value="dbchange"/>
			<wtc:param value="<%=evterno%>"/>
			<wtc:param value="<%=contact_id%>"/>
    </wtc:service>
 <%
  }

%>
<%
//if("mod".equals(mod_flag.trim())){

//}
%>
<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode_sqlMulKfCfm%>">
<wtc:param value="<%=sqlMulKfCfm%>"/>
<wtc:param value="dbchange"/>
<wtc:params value="<%=sqlStrsUpdate%>"/>
</wtc:service>

<%
	
      String sqlUpdQcInfo = "update dqcinfo set endtime = sysdate, "
                          + "contentinsum = :v1, handleinfo = :v2, "
                          +"improveadvice = :v3, commentinfo = :v4, "
                          + "errorlevelid = :v5, errorclassid = :v6, qcserviceclassid=:v7, "  
                          +"errorleveldesc = :v8, errorclassdesc = :v9, "
                          +"serviceclassdesc=:v10,"
                          + "score = :v11, flag = :v12,"
                          +" CHECKREASONID=:v13, "
                          + " CHECKREASONDESC=:v14, "
                          +"DEALDURATION =:v15, LISDURATION = :v16, ARRDURATION = :v17, EVTDURATION = :v18, "	
                          +"moddes = :v19 "
                          //updated by tangsong 20100531 被加分的考评项名称、被扣分的考评项名称
                          +",addedScoreItem=:v20,lostScoreItem=:v21 "
                          + "where serialnum=:v22 ";//serialnum  modserialnumAfter
      System.out.println("flag:====================================================");
      System.out.println("flag:"+flag);
      System.out.println("flag:====================================================");
%>
  
 <wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sqlUpdQcInfo%>"/>
	<wtc:param value="dbchange"/>
	<wtc:param value="<%=contentinsum%>"/>
		<wtc:param value="<%=handleinfo%>"/>
		<wtc:param value="<%=improveadvice%>"/>
		<wtc:param value="<%=commentinfo%>"/>
		<wtc:param value="<%=error_level_id%>"/>
		<wtc:param value="<%=error_class_ids%>"/>
		<wtc:param value="<%=service_class_ids%>"/>
		<wtc:param value="<%=error_level_texts%>"/>
		<wtc:param value="<%=error_class_texts%>"/>
		<wtc:param value="<%=service_class_texts%>"/>
		<wtc:param value="<%=totalScore%>"/>
		<wtc:param value="<%=flag.trim()%>"/>
		<wtc:param value="<%=check_reason_ids%>"/>
		<wtc:param value="<%=check_reason_texts%>"/>
		<wtc:param value="<%=handleTime%>"/>
		<wtc:param value="<%=listenTime%>"/>
		<wtc:param value="<%=adjustTime%>"/>
		<wtc:param value="<%=totalTime%>"/>
		<wtc:param value="<%=moddes%>"/>
		<wtc:param value="<%=addedScoreItem%>"/>
		<wtc:param value="<%=lostScoreItem%>"/>
		<wtc:param value="<%=serialnum%>"/>
 </wtc:service> 

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%="000000"%>");
response.data.add("retMsg","<%="success"%>");
response.data.add("object_id","<%="aaa"%>");
core.ajax.receivePacket(response);

