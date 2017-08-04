
<%
	 /*
	 * 功能: 来电原因查询
	 * 版本: 1.0
	 * 日期: 2008/10/17
	 * 作者: donglei 
	 * 版权: sitech
	 * 
	 *  
	 */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%@ page import="java.util.*"%>
<%@ include file="/npage/callbosspage/K098/checkpermission.jsp"%>
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>
<!--add by hanjc20090731 从内存中读取正在通话的接续记录---begin--->
<%@page import="com.sitech.crmpd.kf.dto.dcallcall.Dcallcallyyyymm"%>
<%@page import="com.sitech.crmpd.kf.cache.DCallCacheManager"%>
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient,com.sitech.crmpd.kf.ejb.client.KFEjbClient170"%>
<%@page import="java.util.HashMap"%>
<!--add by hanjc20090731 从内存中读取正在通话的接续记录---end--->

<%!
  public String getCodeName(String code){
    String codeName = "否";
    if(code==null){
      return codeName;
    }else if("Y".equals(code)){
    	 codeName="是";
    }else if("YY".equals(code)){
    	 codeName="是(正确)";
    }else if("YN".equals(code)){
    	 codeName="是(失败)";
    }
      return codeName;
  }
%>
<%
	String opCode = "K172";
	String opName = "综合查询-来电原因查询";
	String strPasswordSql = "";//是否验证密码
	String nowtoday = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String loginNo = (String) session.getAttribute("workNo");
	String orgCode = (String) session.getAttribute("orgCode");
	String kf_longin_no = (String) (session.getAttribute("kfWorkNo")==null?"":session.getAttribute("kfWorkNo"));

	String sqlStr = "";
	String strCountSql = "";
	String strAcceptTimeSql = "";
	String strAcceptLogSql = "";
	String strDateSql = "";
	String strCallIdNull = "";
	String[] tablenames;
	String month_interval = "";
	String sort_sql = "begin_date desc";
	//int del_flag = -1;

	//int success_flag = -1;
	//int search_flag = 3;
	//String sSqlCondition = "";
	//boolean codeExist = false;
	//int Temp = 0;
  //add by hanjc20090731 从内存中读取正在通话的接续记录---begin---
  Dcallcallyyyymm upatedcallcallpage=null;
  //add by hanjc20090731 从内存中读取正在通话的接续记录---end---  
  
	String start_date = request.getParameter("start_date")==null?nowtoday:request.getParameter("start_date"); //开始时间
	String VERTIFY_PASSWD_FLAG_ISNOT_NULL = request.getParameter("VERTIFY_PASSWD_FLAG_ISNOT_NULL");
	String end_date = request.getParameter("end_date"); //结束时间
	String contact_id = request.getParameter("contact_id"); //流水号  
	String region_code = request.getParameter("region_code"); //客户地市
        //变成KF工号
	String accept_login_no = request.getParameter("accept_login_no")==null?loginNo:request.getParameter("accept_login_no"); //受理工号
	String acceptid = request.getParameter("acceptid");
	String accept_phone = request.getParameter("accept_phone"); //受理号码
	String caller_phone = request.getParameter("caller_phone"); //主叫号码
	String call_cause_id = request.getParameter("call_cause_id");
	System.out.println(call_cause_id+"!!!!!!!!!!!");
	call_cause_id=("".equals(call_cause_id)||call_cause_id==null)?null:","+call_cause_id;
	String accept_long_begin = request.getParameter("accept_long_begin"); //通话时长
	String accept_long_end = request.getParameter("accept_long_end");
	String sm_code = request.getParameter("sm_code"); //客户品牌
	String staffcity = request.getParameter("staffcity"); //员工地市
	String statisfy_code = request.getParameter("statisfy_code"); //客户满意度
	String con_id = request.getParameter("con_id");
	String cause_id_is_null = request.getParameter("cause_id_is_null"); //来电原因为空
	month_interval = request.getParameter("month_interval");			//判断是否跨月

	String[][] dataRows = new String[][] {};
	
	//zengzq 20100125  若非查询，点击下一页等，则直接将总条数从原查询中取
	String rCount = (null == request.getParameter("rCount") ? "0": request.getParameter("rCount"));
	String isFirstQry = (null == request.getParameter("isFirstQry") ? "0": request.getParameter("isFirstQry"));
	int rowCount = Integer.parseInt(rCount);
	int pageSize = 10; // Rows each page
	int pageCount = 0; // Number of all pages
	int curPage = 0; // Current page
	String strPage; // Transfered pages
	String param = "";
	String action = "doLoad";
	String[] strHead = { "流水号", "受理时间", "来电原因", "客户名称", "客户地市",
			"客户满意度", "受理号码", "受理工号", "通话时长", "受理方式","是否密码验证","是否他机验证", "外呼流水号", "备注" };
	
	//add by hucw,根据月份,生成dcallcallYYYYMM的动态部分
	if("0".equals(month_interval)){
		tablenames = new String[1];
		tablenames[0] = start_date.substring(0,6);
	}else if ("1".equals(month_interval)){
		tablenames = new String[2];
		tablenames[0] = start_date.substring(0,6);
		tablenames[1] = end_date.substring(0,6);
	}else{
		tablenames = new String[1];
		tablenames[0] = start_date.substring(0,6);	
	}

	if ("doLoad".equals(action)) {
	  HashMap pMap=new HashMap();
		pMap.put("start_date", start_date);
		pMap.put("end_date", end_date);
		pMap.put("accept_long_begin", accept_long_begin);
		pMap.put("accept_long_end",accept_long_end);
		pMap.put("accept_login_no", accept_login_no);
		pMap.put("caller_phone", caller_phone);
		pMap.put("acceptid", acceptid);
		pMap.put("sm_code", sm_code);
		pMap.put("staffcity", staffcity);
		pMap.put("region_code", region_code);
		pMap.put("call_cause_id", call_cause_id);
		pMap.put("statisfy_code", statisfy_code);
		pMap.put("cause_id_is_null", cause_id_is_null);
		pMap.put("VERTIFY_PASSWD_FLAG_ISNOT_NULL", VERTIFY_PASSWD_FLAG_ISNOT_NULL);
		pMap.put("contact_id", contact_id);
		pMap.put("accept_phone", accept_phone);
		//add by hucw,20100916,实现跨月查询
		//String nowday = start_date.substring(0, 6);
		pMap.put("tablenames", tablenames);
		//end hucw,20100916
		//zengzq 20100125
    if("0".equals(isFirstQry)){
    		rowCount = ( ( Integer )KFEjbClient170.queryForObject("query_callcause_strCountSql",pMap)).intValue();
    }
		
		strPage = request.getParameter("page");
		if (strPage == null || strPage.equals("")
		|| strPage.trim().length() == 0) {
			curPage = 1;
		} else {
			curPage = Integer.parseInt(strPage);
			if (curPage < 1)
		curPage = 1;
		}
		pageCount = (rowCount + pageSize - 1) / pageSize;
		if (curPage > pageCount)
			curPage = pageCount;

			
		int start = (curPage - 1) * pageSize + 1;
		int end = curPage * pageSize;
		//add by hucw,结果集根据sort_sql排序
		pMap.put("sort_sql",sort_sql);
		pMap.put("start", ""+start);
		pMap.put("end", ""+end);
    
    List queryList =(List)KFEjbClient170.queryForList("query_callcause_sqlStr",pMap);     
    dataRows = getArrayFromListMap(queryList ,1,23);           
                
                //看数据
    //记录与客户接触日志
    /* 
    HashMap ipMap=new HashMap();
    ipMap.put("opCode", opCode);
    ipMap.put("orgCode", orgCode);
    ipMap.put("phone_no", accept_phone);
    ipMap.put("loginNo", loginNo);
    ipMap.put("con_id", con_id);
    ipMap.put("flag", "I");
    ipMap.put("contact_flag", "Y");
    if (con_id != null) {
      KFEjbClient.insert("insertOperlog",ipMap);
    }
		*/
	}
%>
<html>
	<head>
		<%@ include file="k172_callCauseQry_include.jsp" %>
	</head>
	
<script language="javascript" type="text/javascript">
	//zengzq 20100125 控制遮罩
	function hiddenOperate(){
			parent.parent.document.getElementById("loadingresult").style.display='block';
	}
	function showOperate(){
			parent.parent.document.getElementById("loadingresult").style.display='none';
	}
	
	$(document).ready(
		function()
		{
	    $("tr").not("[input]").addClass("blue");
	    $("th").css("color","#3366FF").css("font-weight","bold");
		
			$("a").hover(function() {
				$(this).css("color", "orange");
			}, function() {
				$(this).css("color", "#159ee4");
			});
		}
	);
	</script>
	<body onLoad="insertParentFrameValue();showOperate();">
		<div id="Operation_Table">
			<!--input type="button" class="b_foot" value = "展开/收起" onClick="showQuery('frameset120');" >
            <input type="button" class="b_foot" value = "刷新" onClick="parent.queryFrame2.submitInputCheck();"-->
			<table cellspacing="0">
				<tr>
					<td align="left" colspan="24" class="Blue">
						<%if (pageCount != 0) {%>
							第<%=curPage%>页 共<%=pageCount%>页 共<%=rowCount%>条
						<%} else {%>
							<font color="orange">当前记录为空！</font>
						<%}%>
						<%if (pageCount != 1 && pageCount != 0) {%>
							<a href="#" onClick="doLoad('first');return false;">首页</a>
						<%}%>
						<%if (curPage > 1) {%>
							<a href="#" onClick="doLoad('pre');return false;">上一页</a>
						<%}%>
						<%if (curPage < pageCount) {%>
							<a href="#" onClick="doLoad('next');return false;">下一页</a>
						<%}%>
						<%if (pageCount > 1) {%>
							<a href="#" onClick="doLoad('last');return false;">尾页</a>
							<!--hucw 20100828<a>快速选择</a>-->
							<span>快速选择</span>
							<select onchange="jumpToPage(this.value);" style="width:3em;height:2em">
								<%
										for (int i = 1; i <= pageCount; i++) {
										out.print("<option value='" + i + "'");
										if (i == curPage) {
									out.print("selected");
										}
										out.print(">" + i + "</option>");
									}
								%>
							</select>&nbsp;&nbsp;
							<!--modify hucw 20100828<a >快速跳转</a>-->
							<span>快速跳转</span>
							<input id="thePage" name="thePage" type="text" value="<%=curPage%>" style="height:18px;width:30px" onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" />
							<a href="#" onClick="jumpToPage('jumpToPage');return false;">
								<font face=粗体>GO</font> 
							</a>
					<%}%>		
					</td>
				</tr>

				<input type="hidden" name="chkBoxNum" value="<%=dataRows.length%>">
				<input type="hidden" name="page" value="">
				<input type="hidden" name="myaction" value="">
				<input type="hidden" name="sqlFilter" value="">
				<input type="hidden" name="sqlWhere" value="">
				<tr>
					<script>
       	var tempBool ='flase';
      	if(checkRole(K171A_RolesArr)==true||checkRole(K171B_RolesArr)==true||checkRole(K171C_RolesArr)==true||checkRole(K171D_RolesArr)==true||checkRole(K171E_RolesArr)==true||checkRole(K171F_RolesArr)==true||checkRole(K171L_RolesArr)==true||checkRole(K171G_RolesArr)==true||checkRole(K171H_RolesArr)==true||checkRole(K172C_RolesArr)==true){	
      		document.write('<th align="center" class="blue" width="15%" nowrap > 操作 </th>');	
      		tempBool='true';
      	}
        </script>
					<th align="center" class="blue" width="8%" nowrap >
						流水号
					</th>
					<th align="center" class="blue" width="9%" nowrap >
						受理时间
					</th>
					<th align="center" class="blue" width="8%" nowrap >
						来电原因
					</th>
					<th align="center" class="blue" width="8%" nowrap >
						主叫号码
					</th>
					<th align="center" class="blue" width="9%" nowrap >
						客户名称
					</th>
					<th align="center" class="blue" width="8%" nowrap >
						客户地市
					</th>
					<th align="center" class="blue" width="5%" nowrap >
						客户满意度
					</th>
					<th align="center" class="blue" width="5%" nowrap >
						受理号码
					</th>
					<th align="center" class="blue" width="5%" nowrap >
						受理工号
					</th>
					<th align="center" class="blue" width="4%" nowrap >
						通话时长
					</th>
					<th align="center" class="blue" width="5%" nowrap >
						受理方式
					</th>
					<th align="center" class="blue" width="5%" nowrap >
						是否密码验证
					</th>
					<th align="center" class="blue" width="5%" nowrap >
						是否他机验证
					</th>	
					<th align="center" class="blue" width="4%" nowrap >
						外呼流水号
					</th>
					<th align="center" class="blue" width="5%" nowrap >
						备注
					</th>									
				</tr>
          <% 
           //add by hanjc20090731 从内存中读取正在通话的接续记录---begin---
            int m=0;
            String beGanTime="";
            Calendar day1 = Calendar.getInstance();
						Calendar day2 = Calendar.getInstance();
						int sy = 0;
						int sm = 0;
						int sd = 0;
						int s1 = 0;
						int s2 = 0;
						int s3 = 0;
						long start = 0;
						long end = 0;
						long days = 0;
            if(dataRows.length>0){
            	upatedcallcallpage=DCallCacheManager.getInstance().getValue(dataRows[0][0]);
            	System.out.println("dataRows[1][0]: "+dataRows[0][1]);
							beGanTime = dataRows[0][1];
						
						sy = Integer.parseInt(beGanTime.substring(0, 4));
						sm = Integer.parseInt(beGanTime.substring(5, 7));
						sd = Integer.parseInt(beGanTime.substring(8, 10));
						s1 = Integer.parseInt(beGanTime.substring(11, 13));
						s2 = Integer.parseInt(beGanTime.substring(14, 16));
						s3 = Integer.parseInt(beGanTime.substring(17, 19));
						day2.set(sy, sm - 1, sd, s1, s2, s3);
						start = day1.getTimeInMillis();
						end = day2.getTimeInMillis();
						days = (start - end) / (24 * 60 * 60 * 1000);//one day equal 24 * 60 * 60 *1000 milliseconds
   					}
            if(upatedcallcallpage!=null){
               m=1;
               //以下是从内存中取第一条
               //以下是从内存中取第一条
               String accept=upatedcallcallpage.getAcceptid();
               String acceptName="人工";
               if(accept.equals("0"))
               {
               acceptName="人工";
               }
               else if(accept.equals("7"))
               {
               acceptName="呼出";
               }
                else if(accept.equals("9"))
               {
               acceptName="内部呼叫";
               }
               else if(accept.equals("13"))
               {
               acceptName="未受理";
               } 
               else if(accept.equals("15"))
               {
               acceptName="内部求助";
               } 
               
            //zengzq add 20090916   
            String tmptdClass = "blue";
            %>
            <tr onClick="changeColor('<%=tmptdClass%>',this);"> 
             <script>
               if(tempBool=='true'){
      	       	document.write('<td align="center" class="<%=tmptdClass%>" >');
      	       }
      	       if(checkRole(K172A_RolesArr)==true){	
                    		document.write('<img style="cursor:hand" onclick="checkCallListen(\'<%=upatedcallcallpage.getContact_id()%>\',\'<%=upatedcallcallpage.getAccept_login_no()%>\');return false;" alt="听取语音" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/1.gif" width="16" height="16" align="absmiddle">&nbsp;');
                    	}
               if(checkRole(K172B_RolesArr)==true){	
                    		document.write('<img style="cursor:hand" onclick="getCallDetail(\'<%=upatedcallcallpage.getContact_id()%>\',\'<%=start_date%>\');return false;" alt="显示该通话的详细情况" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle">&nbsp;');
                    	}
                    	
      	       if(checkRole(K172C_RolesArr)==true){	
                 <%if("N".equals(isCommonLogin) || days < 1 )
                 {%>
                   document.write('<img style="cursor:hand" onclick="modifyCallCauseTree(\'<%=upatedcallcallpage.getCall_cause_id()%>\',\'<%=upatedcallcallpage.getContact_id()%>\',\'<%=upatedcallcallpage.getBegin_date()%>\');return false;" alt="修改来电原因" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/2.gif" width="16" height="16" align="absmiddle">&nbsp;');
                <%}else{%>
                   document.write('<img style="cursor:hand" onclick="canNotModify();" alt="修改来电原因" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/2.gif" width="16" height="16" align="absmiddle">&nbsp;');
                <%}%>
      	       }
      	       //呼叫轨迹 暂时屏蔽
      	       if(checkRole(K171D_RolesArr)==true){
				       		document.write('<img style="cursor:hand" onclick="showCallLoc(\'<%=dataRows[0][20]%>\',\'<%=dataRows[0][21]%>\')" alt="显示呼叫轨迹" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/11.gif" width="16" height="16" align="absmiddle">&nbsp;');
				       	}
       				
      	       if(checkRole(K172D_RolesArr)==true){	
                  document.write('<img style="cursor:hand" onclick="checkIsHavePlan(\'<%=upatedcallcallpage.getContact_id()%>\',1,\'<%=upatedcallcallpage.getAccept_login_no()%>\')" alt="计划内质检考评" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/5.gif" width="16" height="16" align="absmiddle">&nbsp;');
               }
      	       if(checkRole(K171L_RolesArr)==true){	
                  document.write('<img style="cursor:hand" onclick="planOutQua(\'<%=upatedcallcallpage.getContact_id()%>\',\'<%=upatedcallcallpage.getAccept_login_no()%>\',1)" alt="计划外质检考评(多次)" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/9.gif" width="16" height="16" align="absmiddle">&nbsp;');
               }
               if(checkRole(K171F_RolesArr)==true){	
               				
               		document.write('<img style="cursor:hand" onclick="planOutCheckQua(\'<%=upatedcallcallpage.getContact_id()%>\',\'<%=upatedcallcallpage.getAccept_login_no()%>\')" alt="计划外质检考评(单次)" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/9.gif" width="16" height="16" align="absmiddle">&nbsp;');
      					}
      	       if(checkRole(K172F_RolesArr)==true){	
               		document.write('<img style="cursor:hand" onclick="keepRec(\'<%=upatedcallcallpage.getContact_id()%>\',\'<%=upatedcallcallpage.getAccept_login_no()%>\')" alt="另存录音到本地" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/3.gif" width="16" height="16" align="absmiddle">&nbsp;');
               }
               if(tempBool=='true'){
      	       		document.write('</td>');
      	       } 
             </script>   
          
             <td align="center" class="<%=tmptdClass%>" nowrap ><%=upatedcallcallpage.getContact_id()%>&nbsp;</td>
             <td align="center" class="<%=tmptdClass%>" nowrap ><%=upatedcallcallpage.getBegin_date()%>&nbsp;</td>
             <td align="left" class="<%=tmptdClass%>" nowrap ><%=(upatedcallcallpage.getCallcausedescs()==null)?"&nbsp;":upatedcallcallpage.getCallcausedescs()%>&nbsp;</td>
             <td align="center" class="<%=tmptdClass%>" nowrap ><%=upatedcallcallpage.getCaller_phone()%>&nbsp;</td>
             <td align="center" class="<%=tmptdClass%>" nowrap ><%=upatedcallcallpage.getCust_name()%>&nbsp;</td>
					   <td align="center" class="<%=tmptdClass%>" nowrap ><%=(dataRows[0][5].length() != 0) ? dataRows[0][5]: "&nbsp;"%></td>
             <td align="center" class="<%=tmptdClass%>" nowrap ><%=(dataRows[0][6].length() != 0) ? dataRows[0][6]: "&nbsp;"%></td>
             <td align="center" class="<%=tmptdClass%>" nowrap ><%=upatedcallcallpage.getAccept_phone()%>&nbsp;</td>
             <td align="center" class="<%=tmptdClass%>" nowrap ><%=upatedcallcallpage.getAccept_kf_login_no()%>&nbsp;</td>
             <td align="center" class="<%=tmptdClass%>" nowrap >0</td>
             
             <td align="center" class="<%=tmptdClass%>" nowrap ><%=acceptName%>&nbsp;</td>
             <td align="center" class="<%=tmptdClass%>" nowrap ><%=getCodeName(upatedcallcallpage.getVertify_passwd_flag())%>&nbsp;</td>
             <td align="center" class="<%=tmptdClass%>" nowrap ><%=getCodeName(upatedcallcallpage.getOther_passwd_flag())%>&nbsp;</td>           
           	<td align="center" class="<%=tmptdClass%>" nowrap >&nbsp;</td>
           	<td align="center" class="<%=tmptdClass%>" nowrap ><%=(upatedcallcallpage.getBak()==null)?"&nbsp;":upatedcallcallpage.getBak()%>&nbsp;</td>
           </tr> 
            <%   
            }
            String tdClass = "blue";
            for (int i=0+m; i < dataRows.length; i++ ) {
           	//add by hanjc20090731 从内存中读取正在通话的接续记录---end---
            beGanTime = dataRows[i][1];
						sy = Integer.parseInt(beGanTime.substring(0, 4));
						sm = Integer.parseInt(beGanTime.substring(5, 7));
						sd = Integer.parseInt(beGanTime.substring(8, 10));
						s1 = Integer.parseInt(beGanTime.substring(11, 13));
						s2 = Integer.parseInt(beGanTime.substring(14, 16));
						s3 = Integer.parseInt(beGanTime.substring(17, 19));
						day2.set(sy, sm - 1, sd, s1, s2, s3);
						start = day1.getTimeInMillis();
						end = day2.getTimeInMillis();
						days = (start - end) / (24 * 60 * 60 * 1000);//one day equal 24 * 60 * 60 *1000 milliseconds
				%>
				<tr onClick="changeColor('<%=tdClass%>',this);">

					<script>
        if(tempBool=='true'){
      		document.write('<td align="center" class="<%=tdClass%>" >');
      	}
      	if(checkRole(K172A_RolesArr)==true){	
      		document.write('<img style="cursor:hand" onclick="checkCallListen(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][8]%>\');return false;" alt="听取语音" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/1.gif" width="16" height="16" align="absmiddle">&nbsp;');	
      	}
        if(checkRole(K172B_RolesArr)==true){	
      		document.write('<img style="cursor:hand" onclick="getCallDetail(\'<%=dataRows[i][0]%>\',\'<%=start_date%>\');return false;" alt="显示该通话的详细情况" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle">&nbsp;');	
      	}
      	if(checkRole(K172C_RolesArr)==true){	
          <%if("N".equals(isCommonLogin) || days < 1 )
          {%>
            document.write('<img style="cursor:hand" onclick="modifyCallCauseTree(\'<%=dataRows[i][11]%>\',\'<%=dataRows[i][0]%>\',\'<%=start_date%>\');return false;" alt="修改来电原因" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/2.gif" width="16" height="16" align="absmiddle">&nbsp;');
         <%}else{%>
            document.write('<img style="cursor:hand" onclick="canNotModify();" alt="修改来电原因" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/2.gif" width="16" height="16" align="absmiddle">&nbsp;');
         <%}%>
      	}
      	//呼叫轨迹 暂时屏蔽
      	if(checkRole(K171D_RolesArr)==true){
       		document.write('<img style="cursor:hand" onclick="showCallLoc(\'<%=dataRows[i][20]%>\',\'<%=dataRows[i][21]%>\')" alt="显示呼叫轨迹" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/11.gif" width="16" height="16" align="absmiddle">&nbsp;');
       	}
            	
      	<!-- dataRows[i][14] 改为 dataRows[i][8]-->
      	if(checkRole(K172D_RolesArr)==true){	
      		document.write('<img style="cursor:hand" onclick="checkIsHavePlan(\'<%=dataRows[i][0]%>\',1,\'<%=dataRows[i][8]%>\')" alt="计划内质检考评" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/5.gif" width="16" height="16" align="absmiddle">&nbsp;');	
      	}
      	if(checkRole(K171L_RolesArr)==true){	
      		document.write('<img style="cursor:hand" onclick="planOutQua(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][8]%>\',1)" alt="计划外质检考评(多次)" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/9.gif" width="16" height="16" align="absmiddle">&nbsp;');	
      	}
        if(checkRole(K171F_RolesArr)==true){	
      		document.write('<img style="cursor:hand" onclick="planOutCheckQua(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][8]%>\',\'<%=dataRows[i][19]%>\')" alt="计划外质检考评(单次)" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/9.gif" width="16" height="16" align="absmiddle">&nbsp;');	
      	}
      	if(checkRole(K172F_RolesArr)==true){	
      		document.write('<img style="cursor:hand" onclick="keepRec(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][8]%>\')" alt="另存录音到本地" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/3.gif" width="16" height="16" align="absmiddle">');	
      	}
        if(tempBool=='true'){
      		document.write('</td>');
      	}      	
      </script>


					<td align="center" class="<%=tdClass%>" nowrap >
						<%=(dataRows[i][0].length() != 0) ? dataRows[i][0]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>" nowrap >
						<%=(dataRows[i][1].length() != 0) ? dataRows[i][1]
						: "&nbsp;"%>
					</td>
					<td align="left" class="<%=tdClass%>" nowrap >
						<%=(dataRows[i][2].length() != 0) ? dataRows[i][2]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>" nowrap >
						<%=(dataRows[i][3].length() != 0) ? dataRows[i][3]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>" nowrap >
						<%=(dataRows[i][4].length() != 0) ? dataRows[i][4]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>" nowrap >
						<%=(dataRows[i][5].length() != 0) ? dataRows[i][5]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>" nowrap >
						<%=(dataRows[i][6].length() != 0) ? dataRows[i][6]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>" nowrap >
						<%=(dataRows[i][7].length() != 0) ? dataRows[i][7]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>" nowrap >
						<%=(dataRows[i][8].length() != 0) ? dataRows[i][8]
								: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>" nowrap >
						<%=(dataRows[i][9].length() != 0) ? dataRows[i][9]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>" nowrap >
						<%=(dataRows[i][10].length() != 0) ? dataRows[i][10]
								: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>" nowrap >
						<%=(dataRows[i][17].length() != 0) ? dataRows[i][17]
								: "&nbsp;"%>
					</td>	
					<td align="center" class="<%=tdClass%>" nowrap >
						<%=(dataRows[i][18].length() != 0) ? dataRows[i][18]
								: "&nbsp;"%>
					</td>						
					<td align="center" class="<%=tdClass%>" nowrap >
						<%=(dataRows[i][11].length() != 0) ? dataRows[i][11]
								: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>" nowrap >
						<%=(dataRows[i][12].length() != 0) ? dataRows[i][12]
								: "&nbsp;"%>
					</td>								
				</tr>
				<%
				}
				%>

				<tr>
					<td align="right" colspan="24">
						<%
						if (pageCount != 0) {
						%>
						第<%=curPage%>页 共<%=pageCount%>页 共<%=rowCount%>条
						<%} else {%>
							<font color="orange">当前记录为空！</font>
						<%}%>
						<%if (pageCount != 1 && pageCount != 0) {%>
							<a href="#" onClick="doLoad('first');return false;">首页</a>
						<%}%>
						<%if (curPage > 1) {%>
							<a href="#" onClick="doLoad('pre');return false;">上一页</a>
						<%}%>
						<%if (curPage < pageCount) {%>
							<a href="#" onClick="doLoad('next');return false;">下一页</a>
						<%}%>
						<%if (pageCount > 1) {%>
							<a href="#" onClick="doLoad('last');return false;">尾页</a>
							<!--hucw 20100828<a>快速选择</a>-->
							<span>快速选择</span>
							<select onchange="jumpToPage(this.value);" style="width:3em;height:2em">
							<%
										for (int i = 1; i <= pageCount; i++) {
										out.print("<option value='" + i + "'");
										if (i == curPage) {
									out.print("selected");
										}
										out.print(">" + i + "</option>");
									}
							%>
						</select>&nbsp;&nbsp;
						<!--hucw 20100828<a>快速跳转</a>-->
						<span>快速跳转</span>
						<input id="thePage1" name="thePage1" type="text"
							value="<%=curPage%>" style="height:18px;width:30px"
							onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "
							onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" />
						<a href="#" onClick="jumpToPage('jumpToPage1');return false;">
							<font face=粗体>GO</font>
						</a>
					<%}%>			
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>
