<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 亲情通（原邦尼老年人服务解决方案）业务
   * 版本: 2.0
   * 日期: 2011/1/5
   * 作者: weigp
   * 版权: si-tech
   * update: wanglma 20110527
   */
%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String phoneNo = request.getParameter("phoneNo");
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	String custSql = "   select doc.cust_name,doc.id_iccid,doc.id_type,sm.sm_name from dcustmsg msg,dcustdoc doc ,ssmcode sm where msg.cust_id = doc.cust_id and substr(msg.run_code,2,1) = 'A'  and msg.phone_no='"+phoneNo+"'  and substr(msg.belong_code,0,2)=sm.region_code and msg.sm_code=sm.sm_code";
	String custName = "";
	String propBirthday = "";
	String idNo = "";
	java.util.Date date = new java.util.Date();
	java.text.DateFormat format = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
	String todayTime = format.format(date);

	String chnSource		= "10";	//渠道标识
	String loginNo			= (String)session.getAttribute("workNo");	//操作工号
	String loginPwd			= (String)session.getAttribute("password");	//工号密码
	String userPwd			= "";	//号码密码
	String type_flag		= "";
	String offer_id			= "";
	String startTime		= "";
	String endTime			= "";
	//String custName			= "";
	String sm_name      ="";
	String custSex			= "";
	//String propBirthday		= "";
	//String idNo		= "";
	String propDistrict		= "";
	String custAddr		= "";
	String propTelephone	= "";
	String feeFlag			= "";
	String feePhone			= "";
	String password			= "";
	String userAccounts		= "";
	String propCommunity	= "";
	String propUrgentRoutes	= "";
	String propLifeStyle	= "";
	String isReportSafe		= "";
	String reportCycle		= "";
	String reportName		= "";
	String reportMobile		= "";
	String reportWay		= "";
	String famRelaInfoStr	= "";
	String firstRelaInfoStr	= "";
	String friRelaInfoStr	= "";
	String neiRelaInfoStr	= "";
	String PrintAccept="";
	
	String d076OfrIds="";
	String d076OfrNms="";
	String d076OfrCms="";
	
  PrintAccept = getMaxAccept();
%>

<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>亲情通</title>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="4">
		<wtc:sql><%=custSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result11" scope="end" />
<%
		if(result11.length <= 0){
%>
<script language="JavaScript">
			rdShowMessageDialog("该用户不是在网用户或状态不正常！");
			window.location = 'fd076_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>';
</script>
<%
			return ;
		}else{
			String isIdCarOpen=result11[0][2];
			if(isIdCarOpen.equals("0")||isIdCarOpen.equals("00"))
			{
				custName = result11[0][0];
				idNo = result11[0][1];
				sm_name = result11[0][3];
				if(idNo.length() == 18){
					propBirthday = idNo.substring(6, 14);
				}else{
					propBirthday = "";
				}
			}else
				{
%>
<script language="JavaScript">
			rdShowMessageDialog("非身份证开户的用户不能办理！");
			window.location = 'fd076_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>';
</script>
<%
				}


		}
%>
<%
		if("d077".equals(opCode)){ 
%>
		<wtc:service name="sD076Qry" routerKey="regionCode" 
			routerValue="<%=regionCode%>" 
			retcode="rcD076" retmsg="rmD076"  outnum="28">
			<wtc:param value="<%=PrintAccept%>" />
			<wtc:param value="<%=chnSource%>" />
			<wtc:param value="d076" />
			<wtc:param value="<%=loginNo%>" />
			<wtc:param value="<%=loginPwd%>" />
			<wtc:param value="<%=phoneNo%>" /> 
			<wtc:param value="<%=userPwd%>" />
		</wtc:service>
		<wtc:array id="rstD076Qry" scope="end" />
		<%
		if ( !rcD076.equals("000000") )
		{
		%>
			<script language="JavaScript">
				rdShowMessageDialog("错误代码：<%=rcD076%>，错误信息：<%=rmD076%>",0);
				window.location = 'fd076_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>';
			</script>					
		<%
		}
		
		if (rstD076Qry.length==0)
		{
		%>
			<script language="JavaScript">
				rdShowMessageDialog("服务没有返回对应资费!",0);
				window.location = 'fd076_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>';
			</script>			
		<%
		}
		
		d076OfrIds =rstD076Qry[0][0];
		d076OfrNms =rstD076Qry[0][1];
		d076OfrCms =rstD076Qry[0][2];
	
		System.out.println("d077~~~~d076OfrIds="+d076OfrIds
			+"~~~~d076OfrNms="+d076OfrNms
			+"~~~~d076OfrCms="+d076OfrCms);	
		%>

		<wtc:service name="sD077Qry" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="28">
			<wtc:param value="<%=PrintAccept%>" />
			<wtc:param value="<%=chnSource%>" />
			<wtc:param value="<%=opCode%>" />
			<wtc:param value="<%=loginNo%>" />
			<wtc:param value="<%=loginPwd%>" />
			<wtc:param value="<%=phoneNo%>" /> 
			<wtc:param value="<%=userPwd%>" />
		</wtc:service>
		<wtc:array id="result1" scope="end" />
<%
		if(!errCode.equals("000000")){
%>
<script language="JavaScript">
			rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>",0);
			window.location = 'fd076_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>';
</script>
<%
		}
		if(result1.length <= 0){
%>
<script language="JavaScript">
			rdShowMessageDialog("该用户未曾办理过亲情通业务！");
</script>
<%
			return ;
		}else{

			type_flag			= ("NULL".equals(result1[0][2]))?"":result1[0][2];
			startTime			= ("NULL".equals(result1[0][3]))?"":result1[0][3];
			endTime				= ("NULL".equals(result1[0][4]))?"":result1[0][4];
			custName			= ("NULL".equals(result1[0][5]))?"":result1[0][5];
			custSex				= ("NULL".equals(result1[0][6]))?"":result1[0][6];
			propBirthday		= ("NULL".equals(result1[0][7]))?"":result1[0][7];
			idNo				= ("NULL".equals(result1[0][8]))?"":result1[0][8];
			propDistrict		= ("NULL".equals(result1[0][9]))?"":result1[0][9];
			custAddr			= ("NULL".equals(result1[0][10]))?"":result1[0][10];
			propTelephone		= ("NULL".equals(result1[0][11]))?"":result1[0][11];
			feeFlag				= ("NULL".equals(result1[0][12]))?"":result1[0][12];
			feePhone			= ("NULL".equals(result1[0][13]))?"":result1[0][13];
			userAccounts		= ("NULL".equals(result1[0][14]))?"":result1[0][14];
			propCommunity		= ("NULL".equals(result1[0][15]))?"":result1[0][15];
			propUrgentRoutes	= ("NULL".equals(result1[0][16]))?"":result1[0][16];
			propLifeStyle		= ("NULL".equals(result1[0][17]))?"":result1[0][17];
			isReportSafe		= ("NULL".equals(result1[0][18]))?"":result1[0][18];
			reportCycle			= ("NULL".equals(result1[0][19]))?"":result1[0][19];
			reportName			= ("NULL".equals(result1[0][20]))?"":result1[0][20];
			reportMobile		= ("NULL".equals(result1[0][21]))?"":result1[0][21];
			reportWay			= ("NULL".equals(result1[0][22]))?"":result1[0][22];
			famRelaInfoStr		= ("NULL".equals(result1[0][23]))?"":result1[0][23];
			firstRelaInfoStr	= ("NULL".equals(result1[0][24]))?"":result1[0][24];
			friRelaInfoStr		= ("NULL".equals(result1[0][25]))?"":result1[0][25];
			neiRelaInfoStr		= ("NULL".equals(result1[0][26]))?"":result1[0][26];
			offer_id 			= ("NULL".equals(result1[0][27]))?"":result1[0][27];
		}
%>
		<script type="text/javascript">
			$(document).ready(function(){
				if("<%=opCode%>" == "d077")//当为亲情通业务变更 页面的展示样式
				{
				//alert("<%=type_flag%>")
					$("#type_flag").css("display","none");
					$("#type_flag_delete").css("display","block");
					document.all.startTime.readOnly=true;
					document.all.endTime.readOnly=true;
					if("<%=offer_id%>"=="34515")
					{
						$("#type_flag_delete").val("亲情通业务基础套餐--34515");
					}
					if("<%=offer_id%>"=="34517")
					{
						$("#type_flag_delete").val("亲情通业务升级套餐--34517");
					}
					if("<%=offer_id%>"=="36724")
					{
						$("#type_flag_delete").val("亲情通A计划3元-0.50--36724");
					}
					if("<%=offer_id%>"=="36725")
					{
						$("#type_flag_delete").val("亲情通B计划5元-0.40--36725");
					}
					if("<%=offer_id%>"=="36726")
					{
						$("#type_flag_delete").val("亲情通C计划8元-0.20--36726");
					}
					if("<%=offer_id%>"=="46865")
					{
						$("#type_flag_delete").val("亲情通D套餐--46865");
					}
					if("<%=feeFlag%>"=="Y")
					{
					//ava	$("#trd1").css("display","block");
					}
				}
			//	$("#d0").css("display","none");
			/*	$("#tab0").css("display","none");*/
				/*====innet====*/
				$("#type_flag").val("<%=type_flag%>");
				$("#offerId").val("<%=offer_id%>");
				$("#startTime").val("<%=startTime%>");
				$("#endTime").val("<%=endTime%>");
				$("#custName").val("<%=custName%>");
				$("#idNo").val("<%=idNo%>");
				$("#custSex").val("<%=custSex%>");
				$("#propBirthday").val("<%=propBirthday%>");
				/*$("#propCommunity").val("<%=propCommunity%>");*/
				if("01" == "<%=type_flag%>"){
					$("#propDistrict").val("<%=propDistrict%>");
				}else{
					var len = $("#propDistrict_select option").length;
					$("#propDistrict_select option").each(function(){
					   if($(this).text() == "<%=propDistrict%>"){
					   	  $(this).attr("selected","selected");
					   	  changePropCommunity();
					   }	
					});
					var len = $("#propCommunity_select option").length;
					$("#propCommunity_select option").each(function(){
					   if($(this).text() == "<%=propCommunity%>"){
					   	  $(this).attr("selected","selected");
					   }	
					});
				}
				//alert($("#propDistrict_select option").length);
				$("#custAddr").val("<%=custAddr%>");
				$("#propTelephone").val("<%=propTelephone%>");
				$("#feeFlay").val("<%=feeFlag%>");
				$("#feePhone").val("<%=feePhone%>");
				$("#feePhone1").val("<%=feePhone%>");
				$("#userAccounts").val("<%=userAccounts%>");
				
				$("#propUrgentRoutes").val("<%=propUrgentRoutes%>");
				$("#propLifestyle").val("<%=propLifeStyle%>");
				$("#isReportSafe").val("<%=isReportSafe%>");
				//alert($("#isReportSafe").val());
				$("#reportCycle").val("<%=reportCycle%>");
				$("#reportName").val("<%=reportName%>");
				$("#reportMobile").val("<%=reportMobile%>");
				$("#reportWay").val("<%=reportWay%>");
				var famRelaInfo   = "<%=famRelaInfoStr%>";
				var firstRelaInfo = "<%=firstRelaInfoStr%>";
				var friRelaInfo   = "<%=friRelaInfoStr%>";
				var neiRelaInfo   = "<%=neiRelaInfoStr%>";
				var tab1 = document.getElementById("tab1");
				//alert($("#type_flag").val());
					if(famRelaInfo!="")
					{
						var fams = famRelaInfo.split("|");
						for(var i=0;i<fams.length;i++){
						/*屏蔽修改按钮
						var tempData = fams[i].replace("~","-").replace("~","-").replace("~","-").replace("~","-").replace("~","-").replace("~","-").replace("~","-");
						fams[i] += "~<input type='button' class='b_text' value='修改' onclick='this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode),window.open(\"fd076_personInfo.jsp?method=addRela&tabData="+tempData+"\",\"家属信息\",\"width=400,height=360,left=400,top=200\");'/>";
						*/
						fams[i] += "~<input type='button' class='b_text' value='删除' onclick='deleteTR(this,2);'/>";
						//alert(fams[i]);
						var tabData = fams[i].replace(new RegExp("~","gm"),"|");
						addTr(tab1,9,tabData);
					}
				}
				if("<%=type_flag%>" == "02"){//if 升级套餐
					$("#sq").css("display","block");
					$("#sq2").css("display","block");
					
					$("#sq3").css("display","none");
					$("#sq4").css("display","block");
					
					$("#t3").css("display","block");
					$("#t4").css("display","block");
					//$("#isReportSafe")[0].options(0).selected = true; huangrong 注释  原因：d077页面的是否需要报平安服务的显示有问题
					//alert("<%=isReportSafe%>");
					if("<%=isReportSafe%>"=="02")
					{
						$("#t1").css("display","none");
						$("#t2").css("display","none");
					}else{
						$("#t1").css("display","block");
						$("#t2").css("display","block");
					}
					//联系人信息
					$("#d1").css("display","none");
					$("#tab1").css("display","none");
					$("#d2").css("display","block");
					$("#tab2").css("display","block");
					$("#d3").css("display","block");
					$("#tab3").css("display","block");
					$("#d4").css("display","block");
					$("#tab4").css("display","block");
					//begin huangrong add
					//第一联系人信息
					if(firstRelaInfo!="")
					{
						var tab2 = document.getElementById("tab2");
						var firsts = firstRelaInfo.split("|");
						for(var i=0;i<firsts.length;i++){
						firsts[i] += "~<input type='button' class='b_text' value='删除' onclick='deleteTR(this,2);'/>";
						var tabData = firsts[i].replace(new RegExp("~","gm"),"|");
						addTr(tab2,10,tabData);
						var j = i + 1 ;
						var r = $("#tab2 tr:eq("+j+") td:eq(5)").html();
						if(r == "0"){
							$("#tab2 tr:eq("+j+") td:eq(5)").html("是") ;
						}else{
							$("#tab2 tr:eq("+j+") td:eq(5)").html("否") ;
						}
						}
					}
				//亲友信息
					if(friRelaInfo!="")
					{
						var tab3 = document.getElementById("tab3");
						var friRelas = friRelaInfo.split("|");
						for(var i=0;i<friRelas.length;i++){
						friRelas[i] += "~<input type='button' class='b_text' value='删除' onclick='deleteTR(this,3);'/>";
						var tabData = friRelas[i].replace(new RegExp("~","gm"),"|");
						addTr(tab3,7,tabData);
						var j = i + 1 ;
						var r = $("#tab3 tr:eq("+j+") td:eq(4)").html();
						if(r == "0"){
							$("#tab3 tr:eq("+j+") td:eq(4)").html("是") ;
						}else{
							$("#tab3 tr:eq("+j+") td:eq(4)").html("否") ;
						}
						}
					}
				//邻居信息
			//	alert(neiRelaInfo);
					if(neiRelaInfo!="")
					{
						var tab4= document.getElementById("tab4");
						var neiRelas = neiRelaInfo.split("|");
						for(var i=0;i<neiRelas.length;i++){
						neiRelas[i] += "~<input type='button' class='b_text' value='删除' onclick='deleteTR(this,2);'/>";
						var tabData = neiRelas[i].replace(new RegExp("~","gm"),"|");
						addTr(tab4,6,tabData);
						var j = i + 1 ;
						var r = $("#tab4 tr:eq("+j+") td:eq(3)").html();
						if(r == "0"){
							$("#tab4 tr:eq("+j+") td:eq(3)").html("是") ;
						}else{
							$("#tab4 tr:eq("+j+") td:eq(3)").html("否") ;
						}
						}
					}
				  //end huangrong add
				}
				/*====innet====*/
			});
//删除记录并记录移动电话号码
			function deleteTR(bing,phone_address){
			  if(rdShowConfirmDialog('是否确认删除？')==1)
				{
					  var phoneList="";
          	var tr=bing.parentNode.parentNode;
          	var tds=tr.childNodes; 
					  var phoneList=tds[phone_address].innerHTML;
					  if(document.all.phoneList.value=="")
					  {
					  	document.all.phoneList.value=phoneList;
					  }else
					  {	
				    document.all.phoneList.value =document.all.phoneList.value+"~"+phoneList;
				    }
						bing.parentNode.parentNode.parentNode.removeChild(bing.parentNode.parentNode);
						return true;
				}else
				{
					return false;
				}

			}
		</script>
<%
		}//亲情通业务变更end
		else if("d076".equals(opCode))
		{//亲情通业务申请start
			String tempSql1 = "select * from dRelaBaseMsg where id_no=(select id_no from dcustmsg where phone_no='"+phoneNo+"') and endtime =to_char(last_day(sysdate),'YYYYMMDDHH24miss') ";
			String tempSql2 = "select * from dRelaBaseMsgHis where OprType='1' and to_char(sysdate,'yyyymm')=to_char(update_time,'yyyymm') and id_no=(select id_no from dcustmsg where phone_no='"+phoneNo+"')";
	String[] inParamsss1 = new String[2];
	inParamsss1[0] = "select b.cust_address from dcustmsg a ,dcustdoc b where a.id_no =b.cust_id and a.phone_no=:phonesNO";
	inParamsss1[1] = "phonesNO="+phoneNo;
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode22" retmsg="retMsg22" outnum="2">
		<wtc:sql><%=tempSql1%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="result22" scope="end" />
<%
		if(result22.length > 0){
%>
<script language="JavaScript">
			rdShowMessageDialog("该用户已经办理过亲情通业务！");
			window.location = 'fd076_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>';
</script>
<%
			return ;
		}
%>

	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="1">			
	<wtc:param value="<%=inParamsss1[0]%>"/>
	<wtc:param value="<%=inParamsss1[1]%>"/>	
	</wtc:service>	
  <wtc:array id="dcustss" scope="end" />
<!--取客户详细信息-->

<%
if(dcustss.length>0) {
  custAddr=dcustss[0][0];
  }
		}
%>
		<script type="text/javascript">
			$(document).ready(function () {
				//绑定是否需要付费手机号
				$("#feeFlay").change(function(){
					if("<%=opCode%>" == "d076")
					{
						if($("#feeFlay").val() == "Y"){
							//ava $("#trd").css("display","block");

						}else{
							$("#trd").css("display","none");
						}
					}
					if("<%=opCode%>" == "d077")
					{
						if("<%=feeFlag%>"=="Y")
						{
							if($("#feeFlay").val() == "N")
							{
								//ava $("#trd1").css("display","none");
								//ava $("#trd2").css("display","block");
							}
							else
							{
		  					//ava	$("#trd1").css("display","block");
								//ava	$("#trd2").css("display","none");
							}
						}else if("<%=feeFlag%>"=="N")
						{
							if($("#feeFlay").val() == "Y")
							{
								//ava $("#trd").css("display","block");
							}
							else
							{
		  					$("#trd").css("display","none");
							}
						}

					}
				});
				//绑定是否接受报平安服务
				$("#isReportSafe").change(function(){
					if($("#isReportSafe").val() == "01"){
						$("#t1").css("display","block");
						$("#t2").css("display","block");
					}else{
						$("#t1").css("display","none");
						$("#t2").css("display","none");
					}
				});
				//绑定套餐类别
				$("#type_flag").change(function(){
					if($("#type_flag").val() == "34517" ){
						$("#sq").css("display","block");
						$("#sq2").css("display","block");
						$("#sq3").css("display","none");
						$("#sq4").css("display","block");
						$("#t3").css("display","block");
						$("#t4").css("display","block");
						$("#isReportSafe")[0].options(0).selected = true;
						//是否需要报平安服务 默认是需要报平安服务的，因此对页面报平安周期的信息的展示
						if($("#isReportSafe").val() == "01"){
							$("#t1").css("display","block");
							$("#t2").css("display","block");
						}else{
							$("#t1").css("display","none");
							$("#t2").css("display","none");
						}
						//联系人信息
						$("#d1").css("display","none");
						$("#tab1").css("display","none");
						$("#d2").css("display","block");
						$("#tab2").css("display","block");
						$("#d3").css("display","block");
						$("#tab3").css("display","block");
						$("#d4").css("display","block");
						$("#tab4").css("display","block");
					}else{
						$("#sq").css("display","none");
						$("#sq2").css("display","none");
						$("#sq3").css("display","block");
						$("#sq4").css("display","none");
						$("#t1").css("display","none");
						$("#t2").css("display","none");
						$("#t3").css("display","none");
						$("#t4").css("display","none");
						//联系人信息
						$("#d1").css("display","block");
						$("#tab1").css("display","block");
						$("#d2").css("display","none");
						$("#tab2").css("display","none");
						$("#d3").css("display","none");
						$("#tab3").css("display","none");
						$("#d4").css("display","none");
						$("#tab4").css("display","none");
					}
				});
				//给添加亲属按钮添加验证
				$("#addRela").click(function () {
					if(tab1.rows.length > 3){
						rdShowMessageDialog("最多添加3个亲属信息!",1);
						return ;
					}
					window.open('fd076_personInfo.jsp?method=addRela','授权定位人信息','width=400,height=360,left=400,top=200');
				});
				//给添加联系人添加验证
				$("#addFirst").click(function () {
					if(tab2.rows.length > 1){
						rdShowMessageDialog("最多添加1个第一联系人信息!",1);
						return ;
					}
					window.open('fd076_personInfo.jsp?method=addFirst','第一联系人信息','width=400,height=390,left=400,top=200');
				});
				//给添加亲人 添加验证
				$("#addFrid").click(function () {
					if(tab3.rows.length > 3){
						rdShowMessageDialog("最多添加3个亲友联系人信息!",1);
						return ;
					}
					window.open('fd076_personInfo.jsp?method=addFrid','亲友信息','width=400,height=330,left=400,top=200');
				});
				//给添加邻居 添加验证
				$("#addNaber").click(function() {
					if(tab4.rows.length > 3){
						rdShowMessageDialog("最多添加3个邻居信息!",1);
						return ;
					}
					window.open('fd076_personInfo.jsp?method=addNaber','邻居信息','width=400,height=330,left=400,top=200');
				});
				//提交按钮
				$("#confirm").click(function() { //确认，或信息变更
					//20120912 gaopeng修改 判断点击的是不是信息变更，如果是信息变更，将隐藏域的值还原成0，以便于免填单的逻辑不错。 begin
					var th = $(this);
					if(th.val()=="信息变更")
					{
						$("#ofrId").val("0");
					}
					//20120912 gaopeng修改 判断点击的是不是信息变更，如果是信息变更，将隐藏域的值还原成0，以便于免填单的逻辑不错。 end
					document.all.opFlag.value="1";
						if( <%if(type_flag==null || type_flag=="" || type_flag.equals("")) {out.print("$('#type_flag').val() != '34517'");}else {out.print("'01'=="+type_flag);}%>){
						//alert($("#type_flag").val()+"qqqqqqqqqqq");
							if("<%=opCode%>" == "d076")
							{
									if($("#feeFlay").val() == "Y"){
										if($("#feePhone").val() == ""){
										rdShowMessageDialog("请输入付费号码!",1);
										return ;
										}
										if(document.all.password.value == ""){
										rdShowMessageDialog("请输入付费号码的用户密码!",1);
										return ;
										}
								}
							}else if("<%=opCode%>" == "d077")
								{
									if("<%=feeFlag%>"=="Y")
										{
											if($("#feeFlay").val() == "N")
											{
												if(document.all.password1.value == ""){
												rdShowMessageDialog("请输入付费号码的用户密码!",1);
												return ;
												}
											}
											document.all.feePwdEnd.value=document.all.password1.value;
										}else if("<%=feeFlag%>"=="N")
										{
											if($("#feeFlay").val() == "Y")
											{
												if(document.all.password.value == ""){
												rdShowMessageDialog("请输入付费号码的用户密码!",1);
												return ;
												}
											}
											document.all.feePwdEnd.value=document.all.password.value;
										}


								}
							
							
							if($("#propBirthday").val() != ""){
							if($("#propBirthday").val().length!=8) {
									rdShowMessageDialog("出生日期格式不正确！",1);
									return ;
								}
								if (/[^\d]/.test($("#propBirthday").val())){
									rdShowMessageDialog("出生日期格式不正确！",1);
									return ;
								}

							}
							/*
							if($("#propDistrict").val() == ""){
									rdShowMessageDialog("请填写行政区!",0);
									return ;
							}
							if($("#propTelephone").val() == ""){
									rdShowMessageDialog("请填写常住地固话!",0);
									return ;
							}
							if($("#custAddr").val() == ""){
									rdShowMessageDialog("请填写客户地址!",0);
									return ;
							}
							*/
							
							//验证家属信息列表中，如果有两个以上家属，则判断其输入的移动电话号码是否一致

							
							//需要拼接亲属联系人和亲情号
							//var affectionNoStr = joinData("relaPhone",6);
							var t = document.getElementById("tab1");
							var famRelaInfoStr = getTableData(t,0,7,1,t.rows.length);
							//alert(famRelaInfoStr);
							/*if(famRelaInfoStr == ""){
								rdShowMessageDialog("最少添加一个亲属信息!",0);
								return ;
							}
							*/
							$("#famRelaInfoStr").val(famRelaInfoStr);

						}else {//升级套餐
							//alert($("#type_flag").val()+"-----");
							//需要拼接亲情号和第一联系人   亲友信息   邻居信息
							/*===========升级套餐限制 start=============*/
							if($("#propBirthday").val() != ""){
							if($("#propBirthday").val().length!=8) {
									rdShowMessageDialog("出生日期格式不正确！",1);
									return ;
								}
								if (/[^\d]/.test($("#propBirthday").val())){
									rdShowMessageDialog("出生日期格式不正确！",1);
									return ;
								}

							}
							/*if($("#propBirthday").val() == ""){
									rdShowMessageDialog("请填写出生日期!",0);
									return ;
							}
							
							if($("#propDistrict_select").val() == "0"){
									rdShowMessageDialog("请选择行政区!",0);
									return ;
							}
							if($("#propCommunity_select").val() == "0"){
									rdShowMessageDialog("请选择社区!",0);
									return ;
							}
							if($("#propTelephone").val() == ""){
									rdShowMessageDialog("请填写常住地固话!",0);
									return ;
							}
							if($("#custAddr").val() == ""){
									rdShowMessageDialog("请填写客户地址!",0);
									return ;
							}
							if($("#propUrgentRoutes").val() == ""){
									rdShowMessageDialog("请输入急救车辆到达常住地的路线!",0);
									return ;
							}
							*/
							/*
							if($("#propLifestyle").val() == "05"){
									rdShowMessageDialog("请选择申请人生活情况!",0);
									return ;
							}
							*/
							if($("#isReportSafe").val() == "01"){
								if($("#reportCycle").val() == ""){
									rdShowMessageDialog("请输入报平安周期以天为单位!",1);
									return ;
								}
								if($("#reportName").val() == ""){
									rdShowMessageDialog("请输入接受者名称!",1);
									return ;
								}
								if($("#reportMobile").val() == ""){
									rdShowMessageDialog("请输入接受者移动电话!",1);
									return ;
								}
							}
							//if(feeFlay = Y)  feePhone password need



							if("<%=opCode%>" == "d076")
							{
									if($("#feeFlay").val() == "Y"){
										if($("#feePhone").val() == ""){
											rdShowMessageDialog("请输入付费号码!",1);
											return ;
										}
										if(document.all.password.value == ""){
										rdShowMessageDialog("请输入付费号码的用户密码!",1);
										return ;
										}
								}
							}else if("<%=opCode%>" == "d077")
								{
									if("<%=feeFlag%>"=="Y")
										{
											if($("#feeFlay").val() == "N")
											{
												if(document.all.password1.value == ""){
												rdShowMessageDialog("请输入付费号码的用户密码!",1);
												return ;
												}
											}
											document.all.feePwdEnd.value=document.all.password1.value;
										}else if("<%=feeFlag%>"=="N")
										{
											if($("#feeFlay").val() == "Y")
											{
												if(document.all.password.value == ""){
												rdShowMessageDialog("请输入付费号码的用户密码!",1);
												return ;
												}
											}
											document.all.feePwdEnd.value=document.all.password.value;
										}

								}
							/*===========升级套餐限制 end=============*/
							var firstRelaInfoStr = "";
							var friRelaInfoStr = "";
							var neiRelaInfoStr = "";
							//var affectionNoStr = joinData("relaPhone",6);
							var t2 = document.getElementById("tab2");
							var t3 = document.getElementById("tab3");
							var t4 = document.getElementById("tab4");
							firstRelaInfoStr = getTableData(t2,0,8,1,t2.rows.length);
							friRelaInfoStr = getTableData(t3,0,5,1,t3.rows.length);
							neiRelaInfoStr = getTableData(t4,0,4,1,t4.rows.length);
							//把 显示 移动电话是否对申请人定位 为“是”的换成 0 ， “否”的换成 1
							firstRelaInfoStr=firstRelaInfoStr.replace(new RegExp("~是~","gm"),"~0~");
							firstRelaInfoStr=firstRelaInfoStr.replace(new RegExp("~否~","gm"),"~1~");
							friRelaInfoStr=friRelaInfoStr.replace(new RegExp("~是~","gm"),"~0~");
							friRelaInfoStr=friRelaInfoStr.replace(new RegExp("~否~","gm"),"~1~");
							neiRelaInfoStr=neiRelaInfoStr.replace(new RegExp("~是~","gm"),"~0~");
							neiRelaInfoStr=neiRelaInfoStr.replace(new RegExp("~否~","gm"),"~1~");
							/*** ningtn 关于协助配置亲情通ABC套餐的函 (补充需求) 需求删除限制
							if(firstRelaInfoStr == ""){
								rdShowMessageDialog("最少添加一个第一联系人信息!",0);
								return ;
							}
							if(friRelaInfoStr == ""){
								rdShowMessageDialog("最少添加一个亲人信息!",0);
								return ;
							}
							*/
/*	//wanghfa 2011/8/30修改
							if(neiRelaInfoStr == ""){
								rdShowMessageDialog("最少添加一个邻居信息!",0);
								return ;
							}
*/
						//	$("#affectionNoStr").val(affectionNoStr);
							$("#firstRelaInfoStr").val(firstRelaInfoStr);
							$("#friRelaInfoStr").val(friRelaInfoStr);
							$("#neiRelaInfoStr").val(neiRelaInfoStr);

						}
						//将 行政区 和 社区的信息 放入隐藏表单
						$("#propDistrict_select_hidd").val($("#propDistrict_select option:selected").val());
						$("#propCommunity_select_hidd").val($("#propCommunity_select option:selected").val());
						if("<%=opCode%>" == "d076"){
						 //打印工单并提交表单
						  var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
						  if(typeof(ret)!="undefined")
						  {
						    if((ret=="confirm"))
						    {
						      if(rdShowConfirmDialog('确认要提交信息吗？')==1)
						      {
							   		frmCfm();
						      }
							}
							if(ret=="continueSub")
							{
						      if(rdShowConfirmDialog('确认要提交信息吗？')==1)
						      {
							    	frmCfm();
						      }
							}
						  }
						  else
						  {
						     if(rdShowConfirmDialog('确认要提交信息吗？')==1)
						     {
							     frmCfm();
						     }
						  }	
						  return true;				
						}else if("<%=opCode%>" == "d077"){
						var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
						  if(typeof(ret)!="undefined")
						  {
						    if((ret=="confirm"))
						    {
						      if(rdShowConfirmDialog('确认电子免填单吗？')==1)
						      {
							   		frmCfm1();
						      }
							}
							if(ret=="continueSub")
							{
						      if(rdShowConfirmDialog('确认要提交信息吗？')==1)
						      {
							    	frmCfm1();
						      }
							}
						  }
						  else
						  {
						     if(rdShowConfirmDialog('确认要提交信息吗？')==1)
						     {
							     frmCfm1();
						     }
						  }	
						  return true;

						}
				});
				$("#ofrCfm").click(function() {
					document.all.opFlag.value="0";
					if ( document.all.ofrId.value=="0" )
					{
						rdShowMessageDialog("变更资费必须选择!",1);
						return false;
					}
						if( <%if(type_flag==null || type_flag=="" || type_flag.equals("")) {out.print("$('#type_flag').val() != '34517'");}else {out.print("'01'=="+type_flag);}%>){
						//alert($("#type_flag").val()+"qqqqqqqqqqq");
							if("<%=opCode%>" == "d076")
							{ 
									if($("#feeFlay").val() == "Y"){
										if($("#feePhone").val() == ""){
										rdShowMessageDialog("请输入付费号码!",1);
										return ;
										}
										if(document.all.password.value == ""){
										rdShowMessageDialog("请输入付费号码的用户密码!",1);
										return ;
										}
								}
							}else if("<%=opCode%>" == "d077")
								{
									if("<%=feeFlag%>"=="Y")
										{
											if($("#feeFlay").val() == "N")
											{
												if(document.all.password1.value == ""){
												rdShowMessageDialog("请输入付费号码的用户密码!",1);
												return ;
												}
											}
											document.all.feePwdEnd.value=document.all.password1.value;
										}else if("<%=feeFlag%>"=="N")
										{
											if($("#feeFlay").val() == "Y")
											{
												if(document.all.password.value == ""){
												rdShowMessageDialog("请输入付费号码的用户密码!",1);
												return ;
												}
											}
											document.all.feePwdEnd.value=document.all.password.value;
										}


								}
							
							
							if($("#propBirthday").val() != ""){
							if($("#propBirthday").val().length!=8) {
									rdShowMessageDialog("出生日期格式不正确！",1);
									return ;
								}
								if (/[^\d]/.test($("#propBirthday").val())){
									rdShowMessageDialog("出生日期格式不正确！",1);
									return ;
								}

							}
							/*
							if($("#propDistrict").val() == ""){
									rdShowMessageDialog("请填写行政区!",0);
									return ;
							}
							if($("#propTelephone").val() == ""){
									rdShowMessageDialog("请填写常住地固话!",0);
									return ;
							}
							if($("#custAddr").val() == ""){
									rdShowMessageDialog("请填写客户地址!",0);
									return ;
							}
							*/
							
							//验证家属信息列表中，如果有两个以上家属，则判断其输入的移动电话号码是否一致

							
							//需要拼接亲属联系人和亲情号
							//var affectionNoStr = joinData("relaPhone",6);
							var t = document.getElementById("tab1");
							var famRelaInfoStr = getTableData(t,0,7,1,t.rows.length);
							//alert(famRelaInfoStr);
							/*if(famRelaInfoStr == ""){
								rdShowMessageDialog("最少添加一个亲属信息!",0);
								return ;
							}
							*/
							$("#famRelaInfoStr").val(famRelaInfoStr);

						}else {//升级套餐
							//alert($("#type_flag").val()+"-----");
							//需要拼接亲情号和第一联系人   亲友信息   邻居信息
							/*===========升级套餐限制 start=============*/
							if($("#propBirthday").val() != ""){
							if($("#propBirthday").val().length!=8) {
									rdShowMessageDialog("出生日期格式不正确！",1);
									return ;
								}
								if (/[^\d]/.test($("#propBirthday").val())){
									rdShowMessageDialog("出生日期格式不正确！",1);
									return ;
								}

							}
							/*if($("#propBirthday").val() == ""){
									rdShowMessageDialog("请填写出生日期!",0);
									return ;
							}
							
							if($("#propDistrict_select").val() == "0"){
									rdShowMessageDialog("请选择行政区!",0);
									return ;
							}
							if($("#propCommunity_select").val() == "0"){
									rdShowMessageDialog("请选择社区!",0);
									return ;
							}
							if($("#propTelephone").val() == ""){
									rdShowMessageDialog("请填写常住地固话!",0);
									return ;
							}
							if($("#custAddr").val() == ""){
									rdShowMessageDialog("请填写客户地址!",0);
									return ;
							}
							if($("#propUrgentRoutes").val() == ""){
									rdShowMessageDialog("请输入急救车辆到达常住地的路线!",0);
									return ;
							}
							*/
							/*
							if($("#propLifestyle").val() == "05"){
									rdShowMessageDialog("请选择申请人生活情况!",0);
									return ;
							}
							*/
							if($("#isReportSafe").val() == "01"){
								if($("#reportCycle").val() == ""){
									rdShowMessageDialog("请输入报平安周期以天为单位!",1);
									return ;
								}
								if($("#reportName").val() == ""){
									rdShowMessageDialog("请输入接受者名称!",1);
									return ;
								}
								if($("#reportMobile").val() == ""){
									rdShowMessageDialog("请输入接受者移动电话!",1);
									return ;
								}
							}
							//if(feeFlay = Y)  feePhone password need



							if("<%=opCode%>" == "d076")
							{
									if($("#feeFlay").val() == "Y"){
										if($("#feePhone").val() == ""){
											rdShowMessageDialog("请输入付费号码!",1);
											return ;
										}
										if(document.all.password.value == ""){
										rdShowMessageDialog("请输入付费号码的用户密码!",1);
										return ;
										}
								}
							}else if("<%=opCode%>" == "d077")
								{
									if("<%=feeFlag%>"=="Y")
										{
											if($("#feeFlay").val() == "N")
											{
												if(document.all.password1.value == ""){
												rdShowMessageDialog("请输入付费号码的用户密码!",1);
												return ;
												}
											}
											document.all.feePwdEnd.value=document.all.password1.value;
										}else if("<%=feeFlag%>"=="N")
										{
											if($("#feeFlay").val() == "Y")
											{
												if(document.all.password.value == ""){
												rdShowMessageDialog("请输入付费号码的用户密码!",1);
												return ;
												}
											}
											document.all.feePwdEnd.value=document.all.password.value;
										}

								}
							/*===========升级套餐限制 end=============*/
							var firstRelaInfoStr = "";
							var friRelaInfoStr = "";
							var neiRelaInfoStr = "";
							//var affectionNoStr = joinData("relaPhone",6);
							var t2 = document.getElementById("tab2");
							var t3 = document.getElementById("tab3");
							var t4 = document.getElementById("tab4");
							firstRelaInfoStr = getTableData(t2,0,8,1,t2.rows.length);
							friRelaInfoStr = getTableData(t3,0,5,1,t3.rows.length);
							neiRelaInfoStr = getTableData(t4,0,4,1,t4.rows.length);
							//把 显示 移动电话是否对申请人定位 为“是”的换成 0 ， “否”的换成 1
							firstRelaInfoStr=firstRelaInfoStr.replace(new RegExp("~是~","gm"),"~0~");
							firstRelaInfoStr=firstRelaInfoStr.replace(new RegExp("~否~","gm"),"~1~");
							friRelaInfoStr=friRelaInfoStr.replace(new RegExp("~是~","gm"),"~0~");
							friRelaInfoStr=friRelaInfoStr.replace(new RegExp("~否~","gm"),"~1~");
							neiRelaInfoStr=neiRelaInfoStr.replace(new RegExp("~是~","gm"),"~0~");
							neiRelaInfoStr=neiRelaInfoStr.replace(new RegExp("~否~","gm"),"~1~");
							/*** ningtn 关于协助配置亲情通ABC套餐的函 (补充需求) 需求删除限制
							if(firstRelaInfoStr == ""){
								rdShowMessageDialog("最少添加一个第一联系人信息!",0);
								return ;
							}
							if(friRelaInfoStr == ""){
								rdShowMessageDialog("最少添加一个亲人信息!",0);
								return ;
							}
							*/
/*	//wanghfa 2011/8/30修改
							if(neiRelaInfoStr == ""){
								rdShowMessageDialog("最少添加一个邻居信息!",0);
								return ;
							}
*/
						//	$("#affectionNoStr").val(affectionNoStr);
							$("#firstRelaInfoStr").val(firstRelaInfoStr);
							$("#friRelaInfoStr").val(friRelaInfoStr);
							$("#neiRelaInfoStr").val(neiRelaInfoStr);

						}
						//将 行政区 和 社区的信息 放入隐藏表单
						$("#propDistrict_select_hidd").val($("#propDistrict_select option:selected").val());
						$("#propCommunity_select_hidd").val($("#propCommunity_select option:selected").val());
						if("<%=opCode%>" == "d076"){
						 //打印工单并提交表单
						  var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
						  if(typeof(ret)!="undefined")
						  {
						    if((ret=="confirm"))
						    {
						      if(rdShowConfirmDialog('确认电子免填单吗？')==1)
						      {
							   		frmCfm();
						      }
							}
							if(ret=="continueSub")
							{
						      if(rdShowConfirmDialog('确认要提交信息吗？')==1)
						      {
							    	frmCfm();
						      }
							}
						  }
						  else
						  {
						     if(rdShowConfirmDialog('确认要提交信息吗？')==1)
						     {
							     frmCfm();
						     }
						  }	
						  return true;				
						}else if("<%=opCode%>" == "d077"){
						var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
						  if(typeof(ret)!="undefined")
						  {
						    if((ret=="confirm"))
						    {
						      if(rdShowConfirmDialog('确认电子免填单吗？')==1)
						      {
							   		frmCfm1();
						      }
							}
							if(ret=="continueSub")
							{
						      if(rdShowConfirmDialog('确认要提交信息吗？')==1)
						      {
							    	frmCfm1();
						      }
							}
						  }
						  else
						  {
						     if(rdShowConfirmDialog('确认要提交信息吗？')==1)
						     {
							     frmCfm1();
						     }
						  }	
						  return true;

						}
				});				
			});
			
			function chgOfr( ofrId)
			{
				document.all.ofrId.value=ofrId;	
			}
			
			function frmCfm()
			{
				document.f1.action="fd076Cfm.jsp";
				$("#f1").submit();
				$("#confirm").attr("disabled",true);
				$("#ofrCfm").attr("disabled",true);
			}
			function frmCfm1()
			{
							document.f1.action="fd077Cfm.jsp";
							$("#f1").submit();
							document.all.confirm.disabled = true;//为防止二次确认
			}
			
			function showPrtDlg(printType,DlgMessage,submitCfm)
			{  //显示打印对话框
				var h=180;
				var w=350;
				var t=screen.availHeight/2-h/2;
				var l=screen.availWidth/2-w/2;
				
				var pType="subprint";             				 		//打印类型：print 打印 subprint 合并打印
				var billType="1";              				 			//票价类型：1电子免填单、2发票、3收据
				var sysAccept ="<%=PrintAccept%>";  
<%
		if("d077".equals(opCode)){
%> 
       var printStr =  printInfo1(printType);			 		//调用printinfo()返回的打印内容
        //alert("<%=opCode%>"+"-111111");
<%
		}
	  if("d076".equals(opCode))
		{
%>
       var printStr =  printInfo(printType);
        //alert("<%=opCode%>"+"-222222");
<%          			
							 	
    }
%>				
				var mode_code=null;           							//资费代码
				var fav_code=null;                				 		//特服代码
				var area_code=null;             				 		//小区代码
				var opCode="d076" ;                   			 		//操作代码
				var phoneNo="<%=phoneNo%>";                  	 		//客户电话
				var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";  
				var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
				path+="&mode_code="+mode_code+
					"&fav_code="+fav_code+"&area_code="+area_code+
					"&opCode=<%=opCode%>&sysAccept="+sysAccept+
					"&phoneNo="+document.f1.phoneNo.value+
					"&submitCfm="+submitCfm+"&pType="+
					pType+"&billType="+billType+ "&printInfo=" + printStr; 
				var ret=window.showModalDialog(path,printStr,prop);
				return ret;   
			}
			
			function printInfo(printType)
			{
				var cust_info="";  				//客户信息
				var opr_info="";   				//操作信息
				var note_info1=""; 				//备注1
				var note_info2=""; 				//备注2
				var note_info3=""; 				//备注3
				var note_info4=""; 				//备注4
				var retInfo = "";  				//打印内容
				
				cust_info+="手机号码："+document.all.phoneNo.value+"|";
				cust_info+="客户姓名："+document.all.custName.value+"|";
				cust_info+="证件号码："+document.all.idNo.value+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				if($("#type_flag").val() == "34515"){
				   opr_info+="办理业务：亲情通业务基础套餐"+"|";
			    }else if($("#type_flag").val() == "34517"){
			       opr_info+="办理业务：亲情通业务升级套餐"+"|";
			    }
			    else if($("#type_flag").val() == "36724"){
			       opr_info+="办理业务：亲情通A计划3元-0.50"+"|";
			    }
			    else if($("#type_flag").val() == "36725"){
			       opr_info+="办理业务：亲情通B计划5元-0.40"+"|";
			    }
			    else if($("#type_flag").val() == "36726"){
			       opr_info+="办理业务：亲情通C计划8元-0.20"+"|";
			    }
			    else if($("#type_flag").val() == "46865"){
			       opr_info+="办理业务：亲情通D套餐"+"|";
			    }
				opr_info+="操作流水："+document.all.loginAccept.value+"|";
				opr_info+="业务受理时间：<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>"+"|";
				opr_info+="用户品牌：<%=sm_name%>"+"|";
					
		    if($("#type_flag").val() != "34517")
		    {
		    	opr_info+="定位授权申请人:"+"|";
		    	var t1 = document.getElementById("tab1");
					var trs=t1.rows;
					var changdu=trs.length;
			if(changdu>1)
	      	{
	      	 for(var i=1;i<changdu;i++)
		       {  
		      		var tds=trs[i].childNodes; 
			    	  opr_info+=i+"、"+tds[0].innerHTML+"/"+tds[2].innerHTML+"  ";
			    }  
		    }else{
		   			 		opr_info+="无  |";
		   		}
		   	
		   	/* begin for 关于新增“亲情通”套餐资费和配置营销活动界面的函 @2014/12/2 */
		   	var note1 = "";
		   	var note2 = "";
				var chkPacket = new AJAXPacket ("fd076_ajax_getPrintNotes.jsp","请等待。。。");
				chkPacket.data.add("type_flag" , $("#type_flag").val());
				core.ajax.sendPacket(chkPacket,function(packet){
					var retCode = packet.data.findValueByName("retCode");
					var retMsg = packet.data.findValueByName("retMsg");
					var note1 = packet.data.findValueByName("note1");
					var note2 = packet.data.findValueByName("note2");
					if(retCode!="000000"){
	          rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
	          return false;
          }else{
          	note_info1 = note1 + "：" + note2 + "|";
          }
				});
				chkPacket =null; 		   	
		   	/* end for 关于新增“亲情通”套餐资费和配置营销活动界面的函 @2014/12/2 */
		   	
		   	/*
		    if($("#type_flag").val() == "34515") {
		    	note_info1+="亲情通业务基础套餐：功能费8元/月（若超出赠送部分，则按超出后的资费标准加收费用）；亲情号码：最多可设6个亲情号码，";
		    	note_info1+="每月赠送本地拨打亲情号码主叫时长100分钟，超出赠送部分0.10元/分钟，被叫免费，亲情号码为本地的中国移动手机号码，亲情号码每月只能修改一次，修改后立即生效；";
		    	note_info1+="定位服务：赠送每月10次定位服务，超出部分1次/元，包括机主发起的和授权定位手机号码发起的";
		    	note_info1+="定位操作。其它按照标准资费收取。|";	
		    	}	  
		    if($("#type_flag").val() == "36724") {
		    	note_info1+="亲情通A计划3元-0.50：月功能费3元（含本地网内亲情号码主叫30分钟），可设置一个亲情号码（本地移动号码或省内移动号码），";
		    	note_info1+="拨打本地亲情号码0.05元/分钟，拨打省内亲情号码0.15元/分钟；";
		    	note_info1+="亲情定位0.50元/次。其他按照标准资费收取。|";
					note_info1+="办理亲情号码立即生效，取消号码立即生效；每月仅允许变更一次，每次变更1个号码。|"
		    	}  
		     if($("#type_flag").val() == "36725") {
		    	note_info1+="亲情通B计划5元-0.40：月功能费5元（含本地网内亲情号码主叫50分钟，5次亲情定位/月），可设置3个亲情号码（本地移动号码或省内移动号码，省内移动号码不超过1个），";
		    	note_info1+="拨打本地亲情号码0.05元/分钟，拨打省内亲情号码0.15元/分钟；";
		    	note_info1+="亲情定位0.40元/次。其他按照标准资费收取。|";
		    	note_info1+="办理亲情号码立即生效，取消号码立即生效；每月仅允许变更一次，每次变更1个号码。|"	
		    	}
		    	if($("#type_flag").val() == "36726") {
		    	note_info1+="亲情通C计划8元-0.20：月功能费8元（含本地网内亲情号码主叫150分钟），可设置6个亲情号码（本地移动号码或省内移动号码，省内移动号码不超过2个），";
		    	note_info1+="拨打本地亲情号码0.05元/分钟，拨打省内亲情号码0.15元/分钟；";
		    	note_info1+="亲情定位0.20元/次。其他按照标准资费收取。|";	
		    	note_info1+="办理亲情号码立即生效，取消号码立即生效；每月仅允许变更一次，每次变更1个号码。|"
		    	}*/	    	
		    	
		    }else
	    	{
	    		var t2 = document.getElementById("tab2");
				var tr2s=t2.rows;
				var changdu1 = tr2s.length;
				if(changdu1>1){//只有一个 ， 就不用循环了。
				   	var td2s=tr2s[1].childNodes; 					
		    		opr_info+="1、第一联系人："+td2s[0].innerHTML+"/"+td2s[2].innerHTML+"|";
				}
				
		        opr_info+="2、亲友：";
		        			
	    		var t3 = document.getElementById("tab3");
				var tr3s=t3.rows;
				var changdu3 = tr3s.length;
				 if(changdu3>1)
	      	     {
	      	      for(var i=1;i<changdu3;i++)
		            {  
		           		var td3s=tr3s[i].childNodes;  
			         	opr_info+=td3s[0].innerHTML+"/"+td3s[3].innerHTML+";";
			         }  
		         } 
	    		opr_info+="|";
	    		opr_info+="3、邻居：";
	    		
	    		var t4 = document.getElementById("tab4");
					var tr4s=t4.rows;
					var changdu4 = tr4s.length;
				 if(changdu4>1){
	  	      for(var i=1;i<changdu4;i++)
	          {  
	         		var td4s=tr4s[i].childNodes;  
	         		opr_info+=td4s[0].innerHTML+"/"+td4s[2].innerHTML+";";
	         }  
	       } 
          opr_info+="|";
	    		note_info1+="亲情通业务升级套餐：月功能费15元/月（若超出赠送部分，则按超出后的资费标准加收费用）；最多可设6个亲情号码，每月赠送本地拨打情号码主叫时长100分钟，超出赠送部分0.10元/分钟，被叫";
		    	note_info1+="免费，亲情号码为本地的中国移动手机号码，亲情号码每月只能修改一次，修改后立即生效；紧急援助：免费拔打人工服务平台9679566，不限次数；生活咨询：每月赠送30分钟免费接入人工服务平";
		    	note_info1+="台967956通话时长（赠送时长和超出赠送时长的计费，均不区分本地或漫游），超出赠送部分0.1";
		    	note_info1+="元/分钟，其中的人工定位服务不再另加收定位产生的费用。其它按照标准资费收取。|";		    
	    	}
		    
		  	note_info1+="|";
			
				retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
				retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
			  return retInfo;
			}		
			function printInfo1(printType)
			{
				var ofrIdneed = document.getElementById("ofrId").value;
				var cust_info="";  				//客户信息
				var opr_info="";   				//操作信息
				var note_info1=""; 				//备注1
				var note_info2=""; 				//备注2
				var note_info3=""; 				//备注3
				var note_info4=""; 				//备注4
				var retInfo = "";  				//打印内容
				
				cust_info+="手机号码："+document.all.phoneNo.value+"|";
				cust_info+="客户姓名："+document.all.custName.value+"|";
				cust_info+="证件号码："+document.all.idNo.value+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";

				//如果是信息变更
				if(ofrIdneed=="0")
				{
					opr_info+="办理业务：亲情通业务信息变更"+"|";
					var note1 = "";
			   	var note2 = "";
					var chkPacket = new AJAXPacket ("fd076_ajax_getPrintNotes.jsp","请等待。。。");
					chkPacket.data.add("type_flag" , "<%=offer_id%>");
					core.ajax.sendPacket(chkPacket,function(packet){
						var retCode = packet.data.findValueByName("retCode");
						var retMsg = packet.data.findValueByName("retMsg");
						var note1 = packet.data.findValueByName("note1");
						var note2 = packet.data.findValueByName("note2");
						if(retCode!="000000"){
		          rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
		          return false;
	          }else{
	          	note_info1 = note1 + "：" + note2 + "|";
	          }
					});
					chkPacket =null; 	
					
					/*
						if("<%=offer_id%>"=="34515"){
		    	note_info1+="亲情通业务基础套餐：功能费8元/月（若超出赠送部分，则按超出后的资费标准加收费用）；亲情号码：最多可设6个亲情号码，";
		    	note_info1+="每月赠送本地拨打亲情号码主叫时长100分钟，超出赠送部分0.10元/分钟，被叫免费，亲情号码为本地的中国移动手机号码，亲情号码每月只能修改一次，修改后立即生效；";
		    	note_info1+="定位服务：赠送每月10次定位服务，超出部分1次/元，包括机主发起的和授权定位手机号码发起的";
		    	note_info1+="定位操作。其它按照标准资费收取。|";	
		    	}
		    			if("<%=offer_id%>"=="36724"){
		    	note_info1+="亲情通A计划3元-0.50：月功能费3元（含本地网内亲情号码主叫30分钟），可设置一个亲情号码（本地移动号码或省内移动号码），";
		    	note_info1+="拨打本地亲情号码0.05元/分钟，拨打省内亲情号码0.15元/分钟；";
		    	note_info1+="亲情定位0.50元/次。其他按照标准资费收取。|";
		    	note_info1+="办理亲情号码立即生效，取消号码立即生效；每月仅允许变更一次，每次变更1个号码。|"
		    	}  
		     			if("<%=offer_id%>"=="36725") {
		    	note_info1+="亲情通B计划5元-0.40：月功能费5元（含本地网内亲情号码主叫50分钟，5次亲情定位/月），可设置3个亲情号码（本地移动号码或省内移动号码，省内移动号码不超过1个），";
		    	note_info1+="拨打本地亲情号码0.05元/分钟，拨打省内亲情号码0.15元/分钟；";
		    	note_info1+="亲情定位0.40元/次。其他按照标准资费收取。|";	
		    	note_info1+="办理亲情号码立即生效，取消号码立即生效；每月仅允许变更一次，每次变更1个号码。|"
		    	}
		    			if("<%=offer_id%>"=="36726") {
		    	note_info1+="亲情通C计划8元-0.20：月功能费8元（含本地网内亲情号码主叫150分钟），可设置6个亲情号码（本地移动号码或省内移动号码，省内移动号码不超过2个），";
		    	note_info1+="拨打本地亲情号码0.05元/分钟，拨打省内亲情号码0.15元/分钟；";
		    	note_info1+="亲情定位0.20元/次。其他按照标准资费收取。|";	
		    	note_info1+="办理亲情号码立即生效，取消号码立即生效；每月仅允许变更一次，每次变更1个号码。|"
		    	}*/
				}
				if(ofrIdneed!="0")
				{
						opr_info+="办理业务：亲情通业务资费变更"+"|";
				}
				opr_info+="操作流水："+document.all.loginAccept.value+"|";
				opr_info+="业务受理时间：<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>"+"|";
				opr_info+="用户品牌：<%=sm_name%>"+"|";
		    if("<%=offer_id%>"!="34517")
		    {
		   		if(ofrIdneed=="0") //信息变更
					{
			    	opr_info+="变更后定位授权申请人:"+"|";
			    	var t1 = document.getElementById("tab1");
						var trs=t1.rows;
						var changdu=trs.length;
						if(changdu>1)
		      	{
			      	for(var i=1;i<changdu;i++)
				      {  
			      		var tds=trs[i].childNodes; 
				    	  opr_info+=i+"、"+tds[0].innerHTML+"/"+tds[2].innerHTML+"  ";
					    }  
				    }else{
			   			opr_info+="无  |";
			   		} 
			   	}	
		   		
		   		if(ofrIdneed!="0") //资费变更
					{
						/* begin for 关于新增“亲情通”套餐资费和配置营销活动界面的函 @2014/12/2 */
				   	if("<%=offer_id%>" =="34515" || "<%=offer_id%>"=="36724" || "<%=offer_id%>"=="36725" || "<%=offer_id%>"=="36726" || "<%=offer_id%>"=="46865"){
		          var note1 = "";
				   		var note2 = "";
		          var chkPacket = new AJAXPacket ("fd076_ajax_getPrintNotes.jsp","请等待。。。");
							chkPacket.data.add("type_flag" , "<%=offer_id%>");
							core.ajax.sendPacket(chkPacket,function(packet){
								var retCode = packet.data.findValueByName("retCode");
								var retMsg = packet.data.findValueByName("retMsg");
								var note1 = packet.data.findValueByName("note1");
								var note2 = packet.data.findValueByName("note2");
								if(retCode!="000000"){
				          rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
				          return false;
			          }else{
			          	note_info1 += "原套餐名称："+ note1 + "|";
			          	note_info1 += "原套餐描述："+ note2 + "|";
			          }
							});
							chkPacket =null; 	
		        }
						/* end for 关于新增“亲情通”套餐资费和配置营销活动界面的函 @2014/12/2 */
						/*
				    if("<%=offer_id%>"=="34515"){
				    	note_info1+="原套餐名称：亲情通业务基础套餐。|";
				    	note_info1+="原套餐描述：功能费8元/月（若超出赠送部分，则按超出后的资费标准加收费用）；亲情号码：最多可设6个亲情号码，";
				    	note_info1+="每月赠送本地拨打亲情号码主叫时长100分钟，超出赠送部分0.10元/分钟，被叫免费，亲情号码为本地的中国移动手机号码，亲情号码每月只能修改一次，修改后立即生效；";
				    	note_info1+="定位服务：赠送每月10次定位服务，超出部分1次/元，包括机主发起的和授权定位手机号码发起的";
				    	note_info1+="定位操作。其它按照标准资费收取。|";	
				    	}	  
				    if("<%=offer_id%>"=="36724"){
				    	note_info1+="原套餐名称：亲情通A计划3元-0.50。|";
				    	note_info1+="原套餐描述：月功能费3元（含本地网内亲情号码主叫30分钟），可设置一个亲情号码（本地移动号码或省内移动号码），";
				    	note_info1+="拨打本地亲情号码0.05元/分钟，拨打省内亲情号码0.15元/分钟；";
				    	note_info1+="亲情定位0.50元/次。其他按照标准资费收取。|";
				    	note_info1+="办理亲情号码立即生效，取消号码立即生效；每月仅允许变更一次，每次变更1个号码。|"
				    	}  
				     if("<%=offer_id%>"=="36725") {
				      note_info1+="原套餐名称：亲情通B计划5元-0.40。|";
				    	note_info1+="原套餐描述：月功能费5元（含本地网内亲情号码主叫50分钟，5次亲情定位/月），可设置3个亲情号码（本地移动号码或省内移动号码，省内移动号码不超过1个），";
				    	note_info1+="拨打本地亲情号码0.05元/分钟，拨打省内亲情号码0.15元/分钟；";
				    	note_info1+="亲情定位0.40元/次。其他按照标准资费收取。|";	
				    	note_info1+="办理亲情号码立即生效，取消号码立即生效；每月仅允许变更一次，每次变更1个号码。|"
				    	}
				    	if("<%=offer_id%>"=="36726") {
				    	note_info1+="原套餐名称：亲情通C计划8元-0.20。|";
				    	note_info1+="原套餐描述：月功能费8元（含本地网内亲情号码主叫150分钟），可设置6个亲情号码（本地移动号码或省内移动号码，省内移动号码不超过2个），";
				    	note_info1+="拨打本地亲情号码0.05元/分钟，拨打省内亲情号码0.15元/分钟；";
				    	note_info1+="亲情定位0.20元/次。其他按照标准资费收取。|";	
				    	note_info1+="办理亲情号码立即生效，取消号码立即生效；每月仅允许变更一次，每次变更1个号码。|"
				    	}*/ 
			    	}
		    	/* begin for 关于新增“亲情通”套餐资费和配置营销活动界面的函 @2014/12/2 */
		    	var note3 = "";
		    	var note4 = "";
	    		var chkPacket2 = new AJAXPacket ("fd076_ajax_getPrintNotes.jsp","请等待。。。");
					chkPacket2.data.add("type_flag" , ofrIdneed);
					core.ajax.sendPacket(chkPacket2,function(packet){
						var retCode = packet.data.findValueByName("retCode");
						var retMsg = packet.data.findValueByName("retMsg");
						var note3 = packet.data.findValueByName("note1");
						var note4 = packet.data.findValueByName("note2");
						if(retCode!="000000"){
		          rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
		          return false;
	          }else{
	          	note_info1 += "新套餐名称："+ note3 + "|";
	          	note_info1 += "新套餐描述："+ note4 + "|";
	          }
					});
					chkPacket2 =null; 	
					/* end for 关于新增“亲情通”套餐资费和配置营销活动界面的函 @2014/12/2 */
		    	/*
		    	if(ofrIdneed=="34515"){
		    	note_info1+="新套餐名称：亲情通业务基础套餐。|";
		    	note_info1+="新套餐描述：功能费8元/月（若超出赠送部分，则按超出后的资费标准加收费用）；亲情号码：最多可设6个亲情号码，";
		    	note_info1+="每月赠送本地拨打亲情号码主叫时长100分钟，超出赠送部分0.10元/分钟，被叫免费，亲情号码为本地的中国移动手机号码，亲情号码每月只能修改一次，修改后立即生效；";
		    	note_info1+="定位服务：赠送每月10次定位服务，超出部分1次/元，包括机主发起的和授权定位手机号码发起的";
		    	note_info1+="定位操作。其它按照标准资费收取。|";	
		    	}	  
		    if(ofrIdneed=="36724"){
		    	note_info1+="新套餐名称：亲情通A计划3元-0.50。|";
		    	note_info1+="新套餐描述：月功能费3元（含本地网内亲情号码主叫30分钟），可设置一个亲情号码（本地移动号码或省内移动号码），";
		    	note_info1+="拨打本地亲情号码0.05元/分钟，拨打省内亲情号码0.15元/分钟；";
		    	note_info1+="亲情定位0.50元/次。其他按照标准资费收取。|";
		    	note_info1+="办理亲情号码立即生效，取消号码立即生效；每月仅允许变更一次，每次变更1个号码。|"
		    	}  
		     if(ofrIdneed=="36725") {
		      note_info1+="新套餐名称：亲情通B计划5元-0.40。|";
		    	note_info1+="新套餐描述：月功能费5元（含本地网内亲情号码主叫50分钟，5次亲情定位/月），可设置3个亲情号码（本地移动号码或省内移动号码，省内移动号码不超过1个），";
		    	note_info1+="拨打本地亲情号码0.05元/分钟，拨打省内亲情号码0.15元/分钟；";
		    	note_info1+="亲情定位0.40元/次。其他按照标准资费收取。|";	
		    	note_info1+="办理亲情号码立即生效，取消号码立即生效；每月仅允许变更一次，每次变更1个号码。|"
		    	}
		    	if(ofrIdneed=="36726") {
		    	note_info1+="新套餐名称：亲情通C计划8元-0.20。|";
		    	note_info1+="新套餐描述：月功能费8元（含本地网内亲情号码主叫150分钟），可设置6个亲情号码（本地移动号码或省内移动号码，省内移动号码不超过2个），";
		    	note_info1+="拨打本地亲情号码0.05元/分钟，拨打省内亲情号码0.15元/分钟；";
		    	note_info1+="亲情定位0.20元/次。其他按照标准资费收取。|";	
		    	note_info1+="办理亲情号码立即生效，取消号码立即生效；每月仅允许变更一次，每次变更1个号码。|"
		    	}		
		    	*/
		    }else
	    	{
	    		if(ofrIdneed=="0")
					{
		    		var t2 = document.getElementById("tab2");
						var tr2s=t2.rows;
						var changdu1 = tr2s.length;
						if(changdu1>1){//只有一个 ， 就不用循环了。
						   	var td2s=tr2s[1].childNodes; 					
				    		opr_info+="1、第一联系人："+td2s[0].innerHTML+"/"+td2s[2].innerHTML+"|";
						}
					
			      opr_info+="2、亲友：";
			        			
		    		var t3 = document.getElementById("tab3");
						var tr3s=t3.rows;
						var changdu3 = tr3s.length;
					  if(changdu3>1)
	    	    {
		  	      for(var i=1;i<changdu3;i++)
		          {  
			         	var td3s=tr3s[i].childNodes;  
			         	opr_info+=td3s[0].innerHTML+"/"+td3s[3].innerHTML+";";
			        }  
	         	} 
		    		opr_info+="|";
		    		opr_info+="3、邻居：";
		    	}
		    	var t4 = document.getElementById("tab4");
					var tr4s=t4.rows;
					var changdu4 = tr4s.length;
					if(changdu4>1)
	    	  {
	  	      for(var i=1;i<changdu4;i++)
	          {  
	         		var td4s=tr4s[i].childNodes;  
	         		opr_info+=td4s[0].innerHTML+"/"+td4s[2].innerHTML+";";
	          }  
	        }
	        opr_info+="|";
	    		note_info1+="亲情通业务升级套餐：月功能费15元/月（若超出赠送部分，则按超出后的资费标准加收费用）；最多可设6个亲情号码，每月赠送本地拨打情号码主叫时长100分钟，超出赠送部分0.10元/分钟，被叫";
		    	note_info1+="免费，亲情号码为本地的中国移动手机号码，亲情号码每月只能修改一次，修改后立即生效；紧急援助：免费拔打人工服务平台9679566，不限次数；生活咨询：每月赠送30分钟免费接入人工服务平";
		    	note_info1+="台967956通话时长（赠送时长和超出赠送时长的计费，均不区分本地或漫游），超出赠送部分0.1";
		    	note_info1+="元/分钟，其中的人工定位服务不再另加收定位产生的费用。其它按照标准资费收取。|";		    
	    	}
		    
		  	note_info1+="|";
			
				retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
				retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
			  return retInfo;
			}		
			/*
			*用于拼接~连接亲情号
			function joinData(idStr,num){
				var dataInfo = "";
				for(var i=1;i<=num;i++){
					dataInfo += $("#"+idStr+i).val() + "~";
				}
				return dataInfo;
			}
			*/
			/*
			*用于给指定的tab添加TR
			*/
			function addTr(dyntb,cols,tabInfo){
				tr1=dyntb.insertRow();
				var info = tabInfo.split("|");
				for(var i=0;i<cols;i++){
					if(info[i].trim()==""){
						info[i]="NULL"
					}
					tr1.insertCell().innerHTML = info[i];
				}
			}
			/*
			*用于删除指定tab中的TR
			*/
			function delTr(dyntb){
				dyntb.deleteRow(dyntb.rows.length-1);
			}
			/*
			*功能：用于获得tab中的TD数据信息如果TD中是input框则返回input的value值
			*dyntb：指定table对象
			*fromCol：指定开始的列数
			*toCol：指定结束的列数
			*fromRow：指定开始行数
			*toRow：指定结束行数
			*返回：数据每行信息使用"|"分割，一行中的各个字段数据用"~"分割
			*/
			function getTableData(dyntb,fromCol,toCol,fromRow,toRow){
				var dataInfo="";
				var table=dyntb;
				for(var i=fromRow;i<toRow;i++){
				   for(var j=fromCol;j<toCol;j++){
					  var td=table.rows[i].cells[j];
					  if(td.hasChildNodes()){
						  var input = td.getElementsByTagName("input");
							if (input && input[0]){
							  dataInfo += input[0].value + "~";
							}else{
								dataInfo += td.innerHTML + "~";
							}
					  }
				   }
				   dataInfo = dataInfo + i + "~" + "|"
				}
				return dataInfo;
			}
			
			function changePropCommunity(){
				var chkPacket = new AJAXPacket ("fd076_ajaxGetPropCommunity.jsp","请等待。。。");
				chkPacket.data.add("propDistrictId" , $("#propDistrict_select option:selected").val());
				core.ajax.sendPacketHtml (chkPacket,getPropCommunity);
				chkPacket =null; 
			}
			function getPropCommunity(data){
				$("#propCommunity_select").empty().append(data);
			}
		</script>
	</head>
	<body>
		<form method="post" id="f1" name="f1" onKeyUp="chgFocus(f1)">
			<%@ include file="/npage/common/pwd_comm.jsp" %>
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">亲情通业务基本信息(升级套餐:如出现紧急情况，联系人顺序以页面显示顺序为准)</div>
			</div>
			<table cellspacing="0">
				<tr>
					<td width="10%" class="blue">套餐类型</td>
					<td width="20%" class="blue">
						<select name="type_flag" id="type_flag" style="width:190px">
							<option value="34515" selected>亲情通业务基础套餐--34515</option>						
							<option value="36724">亲情通A计划3元-0.50--36724</option>
							<option value="36725">亲情通B计划5元-0.40--36725</option>
							<option value="36726">亲情通C计划8元-0.20--36726</option>
							<option value="34517">亲情通业务升级套餐--34517</option>
							<option value="46865">亲情通D套餐--46865</option>
						</select>
						<input type="text" value="" name="type_flag_delete" id="type_flag_delete" readonly display : none class="InputGrey" style="width:145px"/>
					</td>
					<td width="10%" class="blue">操作类型</td>
					<td width="20%" class="blue">
						<input type="text" value="亲情通业务" readonly class="InputGrey"/>
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">开通号码</td>
					<td width="20%" class="blue">
						<input class="InputGrey" readonly  type="text" size="12" name="phoneNo" id="phoneNo" value="<%=phoneNo%>" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 index="0">
					</td>
					<td width="10%" class="blue">用户登录帐号</td>
					<td width="20%" class="blue">
						<input type="text" v_minlength=1 v_maxlength=16  id="userAccounts" name="userAccounts" v_must=1 v_name="用户登录帐号" value="<%=phoneNo%>" maxlength="20" onblur="checkElement(this)"/>
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">客户名称</td>
					<td width="20%" class="blue">
						<input type="text" name="custName" id="custName" value="<%=custName%>" readonly class="InputGrey"/>
					</td>
					<td width="10%" class="blue">用户ID</td>
					<td width="20%" class="blue">
						<input type="text" name="idNo" id="idNo" value="<%=idNo%>" readonly class="InputGrey"/>
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">性别</td>
					<td width="20%" class="blue">
						<select name="custSex" id="custSex" style="width:135px" >
							<option value="0">男</option>
							<option value="1">女</option>
						</select>
					</td>
					<td width="10%" class="blue">出生日期</td>
					<td width="20%" class="blue">
						<input type="text" name="propBirthday" id="propBirthday" value="<%=propBirthday%>" v_type="date" v_must=1  /><font class="orange">(格式为：YYYYMMDD)</font>
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">行政区</td>
					<td width="20%" class="blue">
						<div id="sq3" >
							<input type="text" maxlength="10" name="propDistrict" id="propDistrict" v_must=1 />
					    </div>
					    <div id="sq4" style="display:none">
					    	<select name="propDistrict_select" id="propDistrict_select" onChange="changePropCommunity()">
					    		<option value="">请选择</option>
							<wtc:qoption name="sPubSelect" outnum="2">
								<wtc:sql>select distinct a.location_id ,a.location_name from sCommunityMsg a ,dloginmsg b where a.region_code = substr(org_code,0,2)  and b.login_no = '<%=loginNo%>'   </wtc:sql>
							</wtc:qoption>
						</select>
						
						</div>
					</td>
					<td width="10%" class="blue"><span id="sq" style="display:none">社区</span></td>
					<td width="20%" class="blue">
						<div id="sq2" style="display:none">
						<select name="propCommunity_select" id="propCommunity_select" >
							<option value="">请选择</option>
						</select>
						
						</div>
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">常住地固话</td>
					<td width="20%" class="blue">
						<input type="text" maxlength="20" name="propTelephone" id="propTelephone" v_must=1   />
					</td>
					<td width="10%" class="blue">客户地址</td>
					<td width="20%" class="blue">
						<input type="text" name="custAddr" id="custAddr" value="<%=custAddr%>" size="40" maxlength="100"  v_must=1 >
					</td>
				</tr>
				<tr id="t3" style="display:none">
					<td width="10%" class="blue">急救车辆到达常住地的路线</td>
					<td width="20%" class="blue">
						<input type="text" name="propUrgentRoutes" id="propUrgentRoutes" size="40" maxlength="150" />
					</td>
					<td width="10%" class="blue">申请人生活情况</td>
					<td width="20%" class="blue">
						<select name="propLifestyle" id="propLifestyle" style="width:135px">
							<option value="05">其它</option>
							<option value="01">与子女同住</option>
							<option value="02">与配偶生活</option>
							<option value="03">与亲属生活</option>
							<option value="04">独自生活</option>
						</select>
					</td>
				</tr>
				<tr id="t4" style="display:none">
					<td width="10%" class="blue">是否需要报平安服务</td>
					<td width="20%" class="blue">
						<select name="isReportSafe" id="isReportSafe" style="width:135px">
							<option value="02">否</option>
							<option value="01">是</option>
						</select>
					</td>
					<td width="10%" class="blue">&nbsp;</td>
					<td width="20%" class="blue">
							&nbsp;
					</td>
				</tr>
				<tr id="t1" style="display:none">
					<td width="10%" class="blue">报平安周期</td>
					<td width="20%" class="blue">
						<input type="text" name="reportCycle" value="7" id="reportCycle"/><font class="orange">天*</font>
					</td>
					<td width="10%" class="blue">接受者名称</td>
					<td width="20%" class="blue">
						<input type="text" name="reportName" id="reportName"/><font class="orange">*</font>
					</td>
				</tr>
				<tr id="t2" style="display:none">
					<td width="10%" class="blue">接受者移动电话</td>
					<td width="20%" class="blue">
						<input type="text" name="reportMobile" id="reportMobile"/><font class="orange">*</font>
					</td>
					<td width="10%" class="blue">接受方式</td>
					<td width="20%" class="blue">
						<select name="reportWay" id="reportWay" style="width:135px">
							<option value="02">短信</option>
							<option value="01" selected >电话+短信</option>
						</select>
					</td>
				</tr>
				<tr id="t2" style="display:none">
					<td width="10%" class="blue">是否设定付费号码</td>
					<td width="20%" class="blue" >
						<select name="feeFlay" id="feeFlay" style="width:135px">
							<option value="N" selected >否</option>
							<option value="Y">是</option>
						</select>
					</td>
					<td>&nbsp;</td><td>&nbsp;</td>
				</tr>
				<tr style="display:none" id="trd">
					<td width="10%" class="blue">付费号码</td>
					<td width="20%" class="blue">
						<input type="text" name="feePhone"  id="feePhone" v_minlength=1 v_maxlength=16 v_type="mobphone" index="0">
					</td>
					<td width="10%" class="blue">密码</td>
					<td width="20%" class="blue">
						<jsp:include page="/npage/common/pwd_one_new.jsp">
							<jsp:param name="width1" value="16%"  />
							<jsp:param name="width2" value="34%"  />
							<jsp:param name="pname" value="password"  />
							<jsp:param name="pwd" value=""  />
						</jsp:include>
					</td>
				</tr>

				<tr style="display:none" id="trd1">
					<td width="10%" class="blue">付费号码</td>
					<td width="20%" class="blue">
						<input type="text" name="feePhone1"  id="feePhone1" v_minlength=1 v_maxlength=16 v_type="mobphone" index="0">
					</td>
					<td>&nbsp;</td><td>&nbsp;</td>
				</tr>

				<tr style="display:none" id="trd2">
					<td width="10%" class="blue">密码</td>
					<td width="20%" class="blue">
						<jsp:include page="/npage/common/pwd_one_new.jsp">
							<jsp:param name="width1" value="16%"  />
							<jsp:param name="width2" value="34%"  />
							<jsp:param name="pname" value="password1"  />
							<jsp:param name="pwd" value=""  />
						</jsp:include>
					</td>
					<td>&nbsp;</td><td>&nbsp;</td>
				</tr>


				<tr>
					<td width="10%" class="blue">开始时间</td>
					<td width="20%" class="blue">
						<input type="text" v_must=1 id="startTime" value="<%=todayTime%>" name="startTime" v_name="开始时间" maxlength="6"/>
						<font class="orange">*</font>
					</td>
					<td width="10%" class="blue">结束时间</td>
					<td width="20%" class="blue">
						<input type="text" v_must=1 id="endTime" value="20500101235959" name="endTime" v_name="结束时间" maxlength="6"/>
						<font class="orange">*</font>
					</td>
				</tr>
			</table>
			<!--
			<div class="title" id="d0">
				<div id="title_zi">亲情号列表</div>
			</div>
			<table cellspacing="0" id="tab0">
				<tr>
					<td  class="blue">亲情号码1</td>
					<td  class="blue">亲情号码2</td>
					<td  class="blue">亲情号码3</td>
					<td  class="blue">亲情号码4</td>
					<td  class="blue">亲情号码5</td>
					<td  class="blue">亲情号码6</td>
				</tr>
				<tr>
					<td>
						<input type="text" name="relaPhone1" id="relaPhone1"/>
					</td>
					<td>
						<input type="text" name="relaPhone2" id="relaPhone2"/>
					</td>
					<td>
						<input type="text" name="relaPhone3" id="relaPhone3"/>
					</td>
					<td>
						<input type="text" name="relaPhone4" id="relaPhone4"/>
					</td>
					<td>
						<input type="text" name="relaPhone5" id="relaPhone5"/>
					</td>
					<td>
						<input type="text" name="relaPhone6" id="relaPhone6"/>
					</td>
				</tr>
			</table>
			-->
			<%
			if ( opCode.equals("d077") )
			{
				/*
				d076OfrIds="36725|";
				d076OfrNms="亲情通B计划5元-0.40|";
				d076OfrCms="月功能费5元（含本地网内亲情号码主叫50分钟，5次亲情定位/月），可设置3个亲情号码（本地移动号码或省内移动号码，省内移动号码不超过1个），拨打本地亲情号码0.05元/分钟，拨打省内亲情号码0.15元/分钟；亲情定位0.40元/次。其他按照标准资费收取|";
			*/
				String d076OfrId[]=d076OfrIds.split("\\|");
				String d076OfrNm[]=d076OfrNms.split("\\|");
				String d076OfrCm[]=d076OfrCms.split("\\|");
				
			%>
			<div class="title" id="d1">
				<div id="title_zi">对应资费</div>
			</div>		
			<table cellspacing="0" id="tabOfr">
				<tr>
					<th>选择</th>
					<th>资费ID</th>
					<th>资费名称</th>
					<th>资费描述</th>
				</tr>
				
				<%
				for ( int i=0; i<d076OfrId.length;i++ )
				{
				%>
					<tr>
						<td>
							<input type='radio' name='d076Ofr' id='d076Ofr' 
								onclick='chgOfr(<%=d076OfrId[i]%>)'>
						</td>
						<td><%=d076OfrId[i]%></td>
						<td><%=d076OfrNm[i]%></td>
						<td>
							<textarea id="offerCmt" name="offerCmt" readOnly
								cols='100' rows='3' align='left'><%=d076OfrCm[i]%></textarea>								
						</td>		
					</tr>
				<%
				}
				%>
			</table>
			<%
			}
			%>
			
			<div class="title" id="d1">
				<div id="title_zi">授权定位人信息列表&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="b_text" value="添加授权定位人信息" id="addRela" /></div>
			</div>
			<table cellspacing="0" id="tab1">
				<tr>
					<td class="blue">家属姓名</td>
					<td class="blue">家属关系</td>
					<td class="blue">家属移动电话</td>
					<td class="blue">家属住所电话</td>
					<td class="blue">家属住所地址</td>
					<td class="blue">家属单位电话</td>
					<td class="blue">家属单位地址</td>
					<td class="blue">对老人定位功能是否生效</td>
					<td class="blue">操作</td>
				</tr>
			</table>
			<div class="title" id="d2" style="display:none">
				<div id="title_zi">第一联系人信息&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="b_text" value="添加第一联系人" id="addFirst"/></div>
			</div>
			<table cellspacing="0" id="tab2" style="display:none">
				<tr>
					<td class="blue">第一联系人姓名</td>
					<td class="blue">第一联系人关系</td>
					<td class="blue">第一联系人移动电话</td>
					<td class="blue">第一联系人住所电话</td>
					<td class="blue">第一联系人住所地址</td>
					<td class="blue">移动电话是否对申请人定位</td>
					<td class="blue">第一联系人单位电话</td>
					<td class="blue">第一联系人单位地址</td>
					<td class="blue">对老人定位功能是否生效</td>
					<td class="blue">操作</td>
				</tr>
			</table>
			<div class="title" id="d3" style="display:none">
				<div id="title_zi">亲友信息列表&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="b_text" value="添加亲友信息" id="addFrid"/></div>
			</div>
			<table cellspacing="0" id="tab3" style="display:none">
				<tr>
					<td class="blue">亲友姓名</td>
					<td class="blue">亲友关系</td>
					<td class="blue">亲友固定电话</td>
					<td class="blue">亲友移动电话</td>
					<td class="blue">移动电话是否对申请人定位</td>
					<td class="blue">对老人定位功能是否生效</td>
					<td class="blue">操作</td>
				</tr>
			</table>
			<div class="title" id="d4" style="display:none">
				<div id="title_zi">邻居信息列表&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="b_text" value="添加邻居信息" id="addNaber" disabled="true"/></div>
			</div>
			<table cellspacing="0" id="tab4" style="display:none">
				<tr>
					<td class="blue">邻居姓名</td>
					<td class="blue">邻居固定电话</td>
					<td class="blue">邻居移动电话</td>
					<td class="blue">移动电话是否对申请人定位</td>
					<td class="blue">对老人定位功能是否生效</td>
					<td class="blue">操作</td>
				</tr>
			</table>
			<table cellspacing="0">
				<tr>
					<td colspan="4" id="footer">
			           <div align="center">

						<%
						if ( opCode.equals("d077") )
						{
						%>
							<input class="b_foot" type="button" 
			              		id="confirm" name="confirm" value="信息变更" index="2">						
							<input class="b_foot" type="button" 
			              		id="ofrCfm" name="ofrCfm" value="资费变更" index="2">
						<%
						}
						else
						{
						%>
							<input class="b_foot" type="button" 
			              		id="confirm" name="confirm" value="确认" index="2">						
						<%
						}
						%>

			              <input class="b_foot" type="button" name="back" id="back" value="清除" onclick="window.location.reload()">
					      <input class="b_foot" type="button" name=qryP value="返回" onClick="history.go(-1)">
			            </div>
			        </td>
				</tr>
			</table>
			<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>"/>
			<input type="hidden" name="opName" id="opName" value="<%=opName%>"/>
			<!--信息变更还是资费变更-->
			<input type="hidden" name="opFlag" id="opFlag" value=""/>			
			<input type="hidden" name="famRelaInfoStr" id="famRelaInfoStr"/>
			<input type="hidden" name="firstRelaInfoStr" id="firstRelaInfoStr"/>
			<input type="hidden" name="friRelaInfoStr" id="friRelaInfoStr"/>
			<input type="hidden" name="neiRelaInfoStr" id="neiRelaInfoStr"/>
			<input type="hidden" name="feePwdEnd" id="feePwdEnd"/>
			<input type="hidden" name="phoneList" id="phoneList"/>
			<input type="hidden" name="loginAccept" id="loginAccept" value="<%=PrintAccept%>"/>
			<input type="hidden" name="offerId" id="offerId"/>
			<input type="hidden" name="propDistrict_select_hidd" id="propDistrict_select_hidd"/>
			<input type="hidden" name="propCommunity_select_hidd" id="propCommunity_select_hidd"/>
			<!--亲情通变更时所选的资费ID-->
			<input type="hidden" name="ofrId" id="ofrId" value="0"/>
		<!--	<input type="hidden" name="affectionNoStr" id="affectionNoStr"/>-->
			<%@ include file="/npage/include/footer.jsp" %>
		</form>
	</body>
</html>