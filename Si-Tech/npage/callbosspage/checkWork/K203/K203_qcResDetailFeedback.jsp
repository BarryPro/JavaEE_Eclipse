
<%
  /*
   * 功能: 质检结果确认详情
　 * 版本: 1.0
　 * 日期: 2008/11/11
　 * 作者: hanjc
　 * 版权: sitech
   * update:  mixh 2009/02/19 确认之后的通知、通知标题、通知内容为只读。
   *          mixh 2009/08/03 被质检人不能对申诉通知进行确认。
   *
 　*/
 %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/callbosspage/public/constants.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.* "%>
<%
    String opCode          = "K203";
    String opName          = "质检查询-质检结果确认详情";
    String tName="质检结果确认详情";
    String orgCode = (String)session.getAttribute("orgCode");
		String regionCode = orgCode.substring(0,2);
		String myParams="";
    String serialno        = WtcUtil.repNull(request.getParameter("serialno"));  //当前质检结果通知流水
    String serialnum       = WtcUtil.repNull(request.getParameter("serialnum")); //该通知所属的质检单流水
    String tableName       = WtcUtil.repNull(request.getParameter("tableName"));
    String action          = WtcUtil.repNull(request.getParameter("myaction"));
    //String loginNo         = (String)session.getAttribute("kfWorkNo");
    String loginNo         = (String)session.getAttribute("workNo");
    String isPwdVer        = "N";
    String isCheckLogin    = "N";  //Y: 具质检权限工号,N:不具质检权限工号
    String isResCfm        = "N";

    String[][] dataRows    = new String[][]{};
    String[][] callResList = new String[][]{};
    
	String  powerCode      = (String)session.getAttribute("powerCodekf");
	String[]  powerCodeArr = powerCode.split(",");

    //判断当前质检结果是否已经确认
    if(serialnum!=null){
    	String getFlag = "select to_char(count(*)) count from dqcinfo where serialnum=:serialnum and flag='3'";
    	myParams = "serialnum="+serialnum;
    	
 %>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
			<wtc:param value="<%=getFlag%>"/>
			<wtc:param value="<%=myParams%>"/>
		</wtc:service>
		<wtc:array id="queryFlagList" scope="end"/>
 <%
      if(queryFlagList.length>0){
        if(!"0".equals(queryFlagList[0][0].trim())){
          isResCfm = "Y";
        }
      }
    }

    if (serialno!=null) {
    	String temp = "select contentid,objectid from dqcinfo where serialnum=(select serialnum from dqcresultaffirm where serialno =:serialno)";
    	myParams = "serialno="+serialno;
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
			<wtc:param value="<%=temp%>"/>
			<wtc:param value="<%=myParams%>"/>
		</wtc:service>
		<wtc:array id="queryTempList" scope="end"/>
<%

    	String sqlStr= "select   "
              +" t1.belongno ,"     //后续流水号
              +" t1.submitno ,"     //提交人工号
              +" decode(t1.type,'0','质检结果通知','1','申诉','2','答复','3','确认'),"     //质检结果状态
              +" t1.serialnum,"     //质检单流水号
              +" t1.staffno  ,"     //被检工号
              +" t1.evterno  ,"     //质检员工号
              +" t1.title    ,"     //质检结果确认标题
              +" to_char(t1.applydate,'yyyy-MM-dd hh24:mi:ss'),"     //提交时间
              +" t2.contentinsum,"  //内容概括
              +" t2.handleinfo,"    //处理情况|
              +" t3.object_name,"   //对象类别|-质检结果确认信息
              +" t4.name, "         //考评内容|
              +" t1.type, "
              +" t2.recordernum "
              +" from dqcresultaffirm t1,dqcinfo t2,dqcobject t3,dqccheckcontect t4 ";
              
    	String strFilterSql = " where t1.serialno=：serialno ";
    	myParams = "serialno="+serialno;
		String strJoinSql=" and t1.serialnum=t2.serialnum "
                   +" and t2.objectid=t3.object_id "
                   +" and t2.contentid=t4.contect_id ";
                   
		if(queryTempList.length>0){
			strJoinSql+=" and t4.contect_id=:contect_id and t4.object_id=:object_id ";
			myParams = myParams + ",contect_id="+queryTempList[0][0]+",object_id="+queryTempList[0][1];
			
		}
    	sqlStr = sqlStr + strFilterSql + strJoinSql;
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="14">
			<wtc:param value="<%=sqlStr%>"/>
			<wtc:param value="<%=myParams%>"/>
		</wtc:service>
		<wtc:array id="queryList" scope="end"/>
<%
    	dataRows = queryList;
	}
%>

<%
	//zengzq start 取以该流水为后续流水的记录条数，用于后面判定申诉，答复，确认按钮的状态（若count值大于0则按钮皆不可用）
	String getSerialNo = (dataRows.length>0)?dataRows[0][0]:" ";
	String serNumber = "0";
	String getSerialNum = "select to_char(count(*)) count from dqcresultaffirm where belongno=:serialno";
	myParams = "serialno="+serialno;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
		<wtc:param value="<%=getSerialNum%>"/>
		<wtc:param value="<%=myParams%>"/>
	</wtc:service>
	<wtc:array id="getSerialNumList" scope="end"/>
<%
	if(getSerialNumList.length>0){
		serNumber=getSerialNumList[0][0].trim();
	}
	//zengzq end
%>

<%
	//取被检查工号
	String bqcCheckNo = (dataRows.length!=0 && dataRows[0][4].length()!=0)? dataRows[0][4]:" ";

	for(int i = 0; i < powerCodeArr.length; i++){
		if(!(loginNo.equals(bqcCheckNo.trim()))){//如果当前工号不是被质检工号
			//add by hucw,20100603
			for(int j=0; j<ZHIJIANYUAN_ID.length; j++)
			if(ZHIJIANYUAN_ID[j].equals(powerCodeArr[i]) || FUHEYUAN_ID.equals(powerCodeArr[i])){
				isCheckLogin = "Y";
			}
			for(int k=0; k<ZHIJIANZUZHANG_ID.length; k++){
				if(ZHIJIANZUZHANG_ID[k].equals(powerCodeArr[i])) {
					isCheckLogin="Y";
				}
			}
		}
	}
%>

<%
	//------------add mixh begin 
	String belongno  = "";
	String submitno = "";
	String type      = "";
	String staffno   = "";
	String evterno   = "";
	String applydate = "";
	String title     = "";
	String content   = "";
	String recordernum  = "";
	String commentinfo = "";
	String handleinfo   = "";
	String improveadvice = "";
	String contentinsum = "";
	
	String sqlGetAffirm = "SELECT t1.belongno, t1.submitno, decode(t1.type,'0','质检结果通知','1','申诉','2','答复','3','确认'), " + 
	                      "t1.staffno, t1.evterno, to_char(t1.applydate,'yyyy-mm-dd hh24:mi:ss'), t1.title, t1.content, nvl(t2.recordernum,' '), " + 
	                      "nvl(t2.commentinfo,' '), nvl(t2.handleinfo,' '), nvl(t2.improveadvice,' '), nvl(t2.contentinsum,' ') " +
	                      "FROM dqcresultaffirm t1, dqcinfo t2 " +
	                     "WHERE t1.serialnum = t2.serialnum AND serialno = :serialno ";
	myParams = "serialno="+serialno;
	
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="13">
		<wtc:param value="<%=sqlGetAffirm%>"/>
		<wtc:param value="<%=myParams%>"/>
	</wtc:service>
	<wtc:array id="affirmList" scope="end"/>

<%
	if(affirmList.length > 0){
		belongno  = affirmList[0][0];
		submitno  = affirmList[0][1];
		type      = affirmList[0][2];
		staffno   = affirmList[0][3];
		evterno   = affirmList[0][4];
		applydate = affirmList[0][5];
		title     = affirmList[0][6];
		content   = affirmList[0][7];
		recordernum  = affirmList[0][8];
    commentinfo = affirmList[0][9];
    handleinfo   =affirmList[0][10];
    improveadvice = affirmList[0][11];
    contentinsum   =affirmList[0][12];
		
	}
	//------------add mixh end
	
%>
<html>
<head>
<title>质检结果确认详情</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
<script language=javascript>
	$(document).ready(
		function()
		{
	    $("td").not("[input]").addClass("blue");
			$("#footer input:button").addClass("b_foot");
			$("td:not(#footer) input:button").addClass("b_text");
			$("input:text[@v_type]").blur(checkElement2);

			$("a").hover(function() {
				$(this).css("color", "orange");
			}, function() {
				$(this).css("color", "blue");
			});
		}
	);

	function checkElement2() {
    	checkElement(this);
	}

	function submitInput(url){
		if( document.sitechform.serialno.value == ""){
			showTip(document.sitechform.serialno,"流水号不能为空！请重新选择后输入");
			sitechform.serialno.focus();
    	}else {
			hiddenTip(document.sitechform.serialno);
			doSubmit(url);
		}
	}

	function doSubmit(url){
	    window.sitechform.action=url;
	    window.sitechform.method='post';
	    window.sitechform.submit();
	}

	//关闭窗口
	function closeWin(){
	  window.close();
	}

	//质检结果申诉、答复
	function checkSubmit(typeVal){
	   if(typeVal=='1'&&document.sitechform.apptitle.value == ""&&document.sitechform.content.value==""){
		    showTip(document.sitechform.apptitle,"标题或内容不能都为空！请重新选择后输入");
		    sitechform.apptitle.focus();
	  }else{
			  hiddenTip(document.sitechform.apptitle);
			  hiddenTip(document.sitechform.content);
		    doQcCfm(typeVal);
	  }
	}

	/**
	  *功能：质检结果确认
	  *参数：0:质检结果通知
	  *      1:申诉
	  *      2:答复
	  *      3:确认
	  */
	function doQcCfm(typeVal){
		var mypacket = new AJAXPacket("K203_appOrCfm_rpc.jsp","");
		mypacket.data.add("belongno", "<%=serialno%>");
		mypacket.data.add("submitno", "<%=submitno%>");
		mypacket.data.add("type", typeVal);
		mypacket.data.add("serialnum", "<%=serialnum%>");
		mypacket.data.add("staffno", "<%=staffno%>");
		mypacket.data.add("evterno", "<%=evterno%>");
		mypacket.data.add("apptitle", document.sitechform.apptitle.value);
		mypacket.data.add("content", document.sitechform.content.value);
		mypacket.data.add("recordeserialnum", "<%=recordernum%>");
		core.ajax.sendPacket(mypacket,doProcess,true);
		mypacket=null;
	}

	//rpc回调函数
	function doProcess(packet){
		var retCode = packet.data.findValueByName("retCode");
		var retType = packet.data.findValueByName("type");
	
		if(retCode=='000000'){
			if(retType=='1'){
	      		similarMSNPop("申诉成功！");
	    	}else if(retType=='2'){
	      		similarMSNPop("答复成功！");
	    	}else if(retType=='3'){
	      		similarMSNPop("确认成功！");
	    	}
	    	disabledButton();
		}else{
		  similarMSNPop("提交失败！");
		}
	}

	function disabledButton(){
		document.sitechform.complaint.disabled=true;
		document.sitechform.apply.disabled=true;
		document.sitechform.resCfm.disabled=true;
		document.sitechform.apptitle.disabled=true;
		document.sitechform.content.disabled=true;
	}

	window.onload=function(){
		var resType = '<%=(dataRows.length>0)?dataRows[0][12]:"-1"%>';
		var getBelongNo = '<%=(dataRows.length>0)?dataRows[0][0]:" "%>';
	
		//如果该质检通知单已经确认，则所有按钮置灰
		if(3 == resType || "<%=isResCfm%>" == "Y"){
			disabledButton();
		}
	
		//如果该质检单通知有后续通知，则按钮全灰 begin 
		if(parseInt('<%=serNumber%>') > 0){
			disabledButton();
		}
		//如果该质检单通知有后续通知，则按钮全灰 end
		
		//如果为质检单中的质检工号+质检单结果通知，则按钮全灰 add mixh 20090803 begin
		if(0 == resType && "<%=isCheckLogin%>" == "Y"){
			disabledButton();
		}
		//如果为质检单中的质检工号+质检单结果通知，则按钮全灰 add mixh 20090803 end
		
	
		if('<%=isCheckLogin%>' == 'Y'){//如果是具有质检权限的工号、比如质检员相对话务员、复核员相对质检员
			document.sitechform.complaint.disabled = true;
			document.sitechform.resCfm.disabled = true;
		}else{
			document.sitechform.apply.disabled = true;
		}
	
		//被质检人不能对申诉通知进行确认 mixh add 20090803 begin
		if(1 == resType && '<%=isCheckLogin%>'=='N'){
			document.sitechform.resCfm.disabled = true;
		}
		//被质检人不能对申诉通知进行确认 mixh add 20090803 end
	
	}
</script>
</head>
<body>
<form id=sitechform name=sitechform>
<%@ include file="/npage/callbosspage/checkWork/K203/check_header.jsp"%>
<div id="Operation_Table" style="width:100%;">
	<div class="title" id="footer">	 
 		<div id="title_zi">流水号&nbsp;<input name="serialno" type="text" id="serialno" value="<%=serialno%>" readonly >
		<input name="tableName" type="hidden" value="<%=tableName%>">
</div>
</div>
	<br/>

	<div class="title"><div id="title_zi">质检结果</div></div>
	<table cellspacing="0" style="width:100%;">
	<tr>
		<td nowrap >后续处理流水号</td>
		<td nowrap ><%=belongno%>&nbsp;</td>
		<td nowrap >提交人工号</td>
		<td nowrap ><%=submitno%>&nbsp;</td>
		<td nowrap >质检确认状态</td>
		<td nowrap ><%=type%>&nbsp;</td>
		<td nowrap >质检信息流水号</td>
		<td nowrap ><%=serialnum%>&nbsp;</td>
	</tr>
	<tr>
		<td nowrap >被质检人</td>
		<td nowrap ><%=staffno%>&nbsp;</td>
		<td nowrap >质检员工号</td>
		<%if("Y".equals(isCheckLogin)){%>
		<td nowrap ><%=evterno%>&nbsp;</td>
		<%}else{%>
		<td nowrap >******</td>
		<%}%>
		<td nowrap >质检确认信息标题</td>
		<td nowrap ><%=title%>&nbsp;</td>
		<td nowrap >质检结果提交时间</td>
		<td nowrap ><%=applydate%>&nbsp;</td>
	</tr>
	</table><br/>
	<!--added by tangsong 20100830 黑龙江客户需求-->
  <div class="title"><div id="title_zi">综合评价</div></div>
	<table cellspacing="0" style="word-break:break-all;">
    <tr>
			<td bgcolor="white" style="width:800px;word-wrap: break-word;"><%=commentinfo%>&nbsp;</td>
    </tr>
	</table><br/>
	
  <div class="title"><div id="title_zi">处理情况</div></div>
	<table cellspacing="0">
    <tr>
		<td style="width:800px;word-wrap: break-word;"><%=handleinfo%>&nbsp;</td>
    </tr>
	</table><br/>
	
  <div class="title"><div id="title_zi">改进建议</div></div>
	<table cellspacing="0" style="word-break:break-all;">
    <tr>
			<td bgcolor="white" style="width:800px;word-wrap: break-word;"><%=improveadvice%>&nbsp;</td>
    </tr>
	</table><br/>
	
  <div class="title"><div id="title_zi">内容概括</div></div>
	<table cellspacing="0" style="word-break:break-all;">
    <tr>
		<td bgcolor="white" style="width:800px;word-wrap: break-word;"><%=contentinsum%>&nbsp;</td>
    </tr>
	</table><br/>
  
	<div class="title"><div id="title_zi">质检结果确认信息内容</div></div>
	<table cellspacing="0">
	<tr>
		<td style="width:800px;word-wrap: break-word;"><%=content%>&nbsp;</td>
    </tr>
	</table><br/>
  	<div class="title"><div id="title_zi">质检结果反馈信息</div></div>
	<table cellspacing="0">
    <tr>
		<td nowrap >标题</td>
		<td bgcolor="white" colspan="3">
		<textarea id="apptitle" name="apptitle" rows="1" cols="40" style="overflow:hidden" value=""></textarea>
		</td>
    </tr>
    <tr>
	<td nowrap >反馈信息内容</td>
	<td bgcolor="white">
		<textarea id="content" name="content" rows="4" cols="55" colspan="3" value=""></textarea>
	</td>
    </tr>
	<tr>
	<td id="footer" colspan="2">
		<input name="complaint" type="button"  id="complaint" value="申诉" onClick="checkSubmit(1)">&nbsp;&nbsp;&nbsp;&nbsp;
		<input name="apply" type="button"  id="apply" value="答复" onClick="checkSubmit(2)">
		<input name="resCfm" type="button"  id="resCfm" value="确认" onClick="checkSubmit(3)">
	</td>
	</tr>
  </table>
</div>
</form>
<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>

