<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 亲情通（原邦尼老年人服务解决方案）业务
   * 版本: 2.0
   * 日期: 2011/1/5
   * 作者: weigp
   * 版权: si-tech
   * update:
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
	//String custSql = "select doc.cust_name,doc.id_iccid from dcustmsg msg,dcustdoc doc where msg.cust_id = doc.cust_id and msg.phone_no='"+phoneNo+"'";
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
	String custSex			= "";
	//String propBirthday		= "";
	//String idNo		= "";
	String propDistrict		= "";
	String propAddress		= "";
	String propTelephone	= "";
	String feeFlag			= "";
	String feePhone			= "";
	String feePwd			= "";
	String userAccounts		= "";
	String propCommunity	= "";
	String propUrgentRoutes	= "";
	String propLifeStyle	= "";
	String isReportSafe		= "";
	String reportCycle		= "";
	String reportName		= "";
	String reportMobile		= "";
	String reportWay		= "";
	//20120921新增 加入家属信息串
	String relaInfoStr = "";
	//20120921 gaopeng新增打印流水
	String PrintAccept="";
	PrintAccept = getMaxAccept();
	//20120921 gaopeng新增用户品牌
	String sm_name      ="";

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
			custName = result11[0][0];
			idNo = result11[0][1];
			sm_name = result11[0][3];
			if(idNo.length() == 18){
				propBirthday = idNo.substring(6, 14);
			}else{
				propBirthday = "";
			}

		}
%>
<%
		if("d078".equals(opCode)){
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="loginAccept"/>
		<wtc:service name="sD077Qry" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="28">
			<wtc:param value="<%=loginAccept%>" />
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
			rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>");
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

			//套餐类型（01－基础套餐，02－升级套餐）
			type_flag			= ("NULL".equals(result1[0][2]))?"":result1[0][2]; 
			//开始时间
			startTime			= ("NULL".equals(result1[0][3]))?"":result1[0][3];
			//结束时间
			endTime				= ("NULL".equals(result1[0][4]))?"":result1[0][4];
			//申请人姓名
			custName			= ("NULL".equals(result1[0][5]))?"":result1[0][5];
			//申请人性别
			custSex				= ("NULL".equals(result1[0][6]))?"":result1[0][6];
			//出生日期
			propBirthday		= ("NULL".equals(result1[0][7]))?"":result1[0][7];
			//身份证号
			idNo			= ("NULL".equals(result1[0][8]))?"":result1[0][8];
			//行政区
			propDistrict		= ("NULL".equals(result1[0][9]))?"":result1[0][9];
			//常住详细地址
			propAddress			= ("NULL".equals(result1[0][10]))?"":result1[0][10];
			//申请人常住固话
			propTelephone		= ("NULL".equals(result1[0][11]))?"":result1[0][11];
			//是否设定付费号码（N-否，Y-是）
			feeFlag				= ("NULL".equals(result1[0][12]))?"":result1[0][12];
			//付费号码
			feePhone			= ("NULL".equals(result1[0][13]))?"":result1[0][13];
			//用户登录帐号
			userAccounts		= ("NULL".equals(result1[0][14]))?"":result1[0][14];
			//社区
			propCommunity		= ("NULL".equals(result1[0][15]))?"":result1[0][15];
			//详述急救车辆到达常住地的路线
			propUrgentRoutes	= ("NULL".equals(result1[0][16]))?"":result1[0][16];
			//申请人生活情况
			propLifeStyle		= ("NULL".equals(result1[0][17]))?"":result1[0][17];
			//是否需要报平安服务
			isReportSafe		= ("NULL".equals(result1[0][18]))?"":result1[0][18];
			//报平安周期（每x天报一次）
			reportCycle			= ("NULL".equals(result1[0][19]))?"":result1[0][19];
			//报平安接收方姓名
			reportName			= ("NULL".equals(result1[0][20]))?"":result1[0][20];
			//报平安接收方移动电话
			reportMobile		= ("NULL".equals(result1[0][21]))?"":result1[0][21];
			//报平安方式选择（01－电话+短信，02－只是短信）
			reportWay			= ("NULL".equals(result1[0][22]))?"":result1[0][22];
			//家属信息串
			relaInfoStr = ("NULL".equals(result1[0][23]))?"":result1[0][23];
			//资费代码
			offer_id 	= ("NULL".equals(result1[0][27]))?"":result1[0][27];
		}
%>
		<script type="text/javascript">
			$(document).ready(function(){
				/*====innet====*/
				/*alert("<%=propDistrict%>");*/
				$("#offerId").val("<%=offer_id%>");
				$("#startTime").val("<%=startTime%>");
				$("#endTime").val("<%=endTime%>");
				$("#custName").val("<%=custName%>");
				$("#idNo").val("<%=idNo%>");
				
				$("#propBirthday").val("<%=propBirthday%>");
				$("#propDistrict").val("<%=propDistrict%>");
				
				$("#propAddress").val("<%=propAddress%>");
				$("#propTelephone").val("<%=propTelephone%>");
	
				$("#feePhone").val("<%=feePhone%>");
				$("#feePhone1").val("<%=feePhone%>");
				$("#userAccounts").val("<%=userAccounts%>");
				$("#propCommunity").val("<%=propCommunity%>");
				$("#propUrgentRoutes").val("<%=propUrgentRoutes%>");
		

				$("#reportCycle").val("<%=reportCycle%>");
				$("#reportName").val("<%=reportName%>");
				$("#reportMobile").val("<%=reportMobile%>");

					if("<%=offer_id%>"=="34515")
					{
						$("#type_flag_del").val("亲情通业务基础套餐--34515");
					}
					if("<%=offer_id%>"=="46865")
					{
						$("#type_flag_del").val("亲情通D套餐--46865");
					}
					if("<%=offer_id%>"=="34517")
					{
						$("#type_flag_del").val("亲情通业务升级套餐--34517");
					}
					if("<%=offer_id%>"=="36724")
					{
						$("#type_flag_del").val("亲情通A计划3元-0.50--36724");
					}
					if("<%=offer_id%>"=="36725")
					{
						$("#type_flag_del").val("亲情通B计划5元-0.40--36725");
					}
					if("<%=offer_id%>"=="36726")
					{
						$("#type_flag_del").val("亲情通C计划8元-0.20--36726");
					}

				if("<%=propLifeStyle%>"=="01")
				{
					$("#propLifestyle").val("与子女同住");
				}else if("<%=propLifeStyle%>"=="02"){
					$("#propLifestyle").val("与配偶生活");
				}else if("<%=propLifeStyle%>"=="03"){
					$("#propLifestyle").val("与亲属生活");
				}else if("<%=propLifeStyle%>"=="04"){
					$("#propLifestyle").val("独自生活");
				}else
				{
				$("#propLifestyle").val("其他");
				}
				
				if("<%=custSex%>"=="0")
				{
					$("#custSex").val("男");
				}else{
					$("#custSex").val("女");					
				}

				if("<%=feeFlag%>"=="N")
				{
					$("#feeFlay").val("否");
				}else{
					$("#feeFlay").val("是");
					//ava $("#trd1").css("display","block");
				}

				if("<%=reportWay%>"=="01")
				{
					$("#reportWay").val("电话+短信");
				}else{
					$("#reportWay").val("短信");
				}

				if("<%=type_flag%>" == "02"){//if 升级套餐
					$("#sq").css("display","block");
					$("#propCommunity").css("display","block");
					$("#t3").css("display","block");
					$("#t4").css("display","block");
					if("<%=isReportSafe%>"=="02")
					{
						$("#isReportSafe").val("否");
						$("#t1").css("display","none");
						$("#t2").css("display","none");
					}else{
					  $("#isReportSafe").val("是");						
						$("#t1").css("display","block");
						$("#t2").css("display","block");
					}
				}
			});
		</script>
<%
		}
%>
<script type="text/javascript">
  function doCommit(){
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
						      if(rdShowConfirmDialog('是否确认销户？')==1)
						      {
							    	frmCfm1();
						      }
							}
						  }
						  else
						  {
						     if(rdShowConfirmDialog('是否确认销户？')==1)
						     {
							     frmCfm1();
						     }
						  }	
						  return true;
  }
  function frmCfm1()
  {
	  	document.f1.action="fd078Cfm.jsp";
			document.f1.submit();
			$("#confirm").attr("disabled",true);
			return true;
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
				var printStr =  printInfo(printType);
				var mode_code=null;           							//资费代码
				var fav_code=null;                				 		//特服代码
				var area_code=null;             				 		//小区代码
				var opCode="d078" ;                   			 		//操作代码
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
				/*20120921 gaopeng 取授权定位人号码（多个以","间隔）*/
				var resultPhoneFA="";
				//家属信息（可能多条）
				var relaInfo = "<%=relaInfoStr%>";
				if(relaInfo.length!=0){
				//如果只有一个家属
				if(relaInfo.indexOf("|")==-1)
				{
					resultPhoneFA = relaInfo.split("~")[2];
				}
				else if(relaInfo.indexOf("|")!=-1)
				{
					var relas = relaInfo.split("|");
					for(var i=0;i<relas.length;i++)
					{
						if(resultPhoneFA=="")
						{
							resultPhoneFA = relas[i].split("~")[2];
						}
						else{
						resultPhoneFA = resultPhoneFA +","+ relas[i].split("~")[2];
							}
					}
					
				}
			}
				
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
			  opr_info+="办理业务：亲情通业务取消"+"|";
				opr_info+="操作流水："+document.all.loginAccept.value+"|";
				opr_info+="业务受理时间：<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>"+"|";
				
				opr_info+="用户品牌：<%=sm_name%>"+"|";
				/* begin for 关于新增“亲情通”套餐资费和配置营销活动界面的函 @2014/12/2 */
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
          	note_info1 += "取消套餐名称："+ note1 + "|";
          	note_info1 += "取消套餐描述："+ note2 + "|";
          }
				});
				chkPacket =null; 	
		    /* end for 关于新增“亲情通”套餐资费和配置营销活动界面的函 @2014/12/2 */
		    /*
		    if("<%=offer_id%>" == "34515") {
		    	note_info1+="取消套餐名称：亲情通业务基础套餐|";
		    	note_info1+="取消套餐描述：功能费8元/月（若超出赠送部分，则按超出后的资费标准加收费用）；亲情号码：最多可设6个亲情号码，";
		    	note_info1+="每月赠送本地拨打亲情号码主叫时长100分钟，超出赠送部分0.10元/分钟，被叫免费，亲情号码为本地的中国移动手机号码，亲情号码每月只能修改一次，修改后立即生效；";
		    	note_info1+="定位服务：赠送每月10次定位服务，超出部分1次/元，包括机主发起的和授权定位手机号码发起的";
		    	note_info1+="定位操作。其它按照标准资费收取。|";	
		    	}	  
		    if("<%=offer_id%>" == "36724") {
		    	note_info1+="取消套餐名称：亲情通A计划3元-0.50|";
		    	note_info1+="取消套餐描述：月功能费3元（含本地网内亲情号码主叫30分钟），可设置一个亲情号码（本地移动号码或省内移动号码），";
		    	note_info1+="拨打本地亲情号码0.05元/分钟，拨打省内亲情号码0.15元/分钟；";
		    	note_info1+="亲情定位0.50元/次。其他按照标准资费收取。|";
					note_info1+="办理亲情号码立即生效，取消号码立即生效；每月仅允许变更一次，每次变更1个号码。|"
		    	}  
		     if("<%=offer_id%>"== "36725") {
		     	note_info1+="取消套餐名称：亲情通B计划5元-0.40|";
		    	note_info1+="取消套餐描述：月功能费5元（含本地网内亲情号码主叫50分钟，5次亲情定位/月），可设置3个亲情号码（本地移动号码或省内移动号码，省内移动号码不超过1个），";
		    	note_info1+="拨打本地亲情号码0.05元/分钟，拨打省内亲情号码0.15元/分钟；";
		    	note_info1+="亲情定位0.40元/次。其他按照标准资费收取。|";
		    	note_info1+="办理亲情号码立即生效，取消号码立即生效；每月仅允许变更一次，每次变更1个号码。|"	
		    	}
		    	if("<%=offer_id%>" == "36726") {
		    	note_info1+="取消套餐名称：亲情通C计划8元-0.20|";
		    	note_info1+="取消套餐描述：月功能费8元（含本地网内亲情号码主叫150分钟），可设置6个亲情号码（本地移动号码或省内移动号码，省内移动号码不超过2个），";
		    	note_info1+="拨打本地亲情号码0.05元/分钟，拨打省内亲情号码0.15元/分钟；";
		    	note_info1+="亲情定位0.20元/次。其他按照标准资费收取。|";	
		    	note_info1+="办理亲情号码立即生效，取消号码立即生效；每月仅允许变更一次，每次变更1个号码。|"
		    	}		
		    	if("<%=offer_id%>" == "34517") {
		    	note_info1+="取消套餐名称：亲情通业务升级套餐|";
		    	note_info1+="取消套餐描述：月功能费15元/月（若超出赠送部分，则按超出后的资费标准加收费用）；最多可设6个亲情号码，每月赠送本地拨打情号码主叫时长100分钟，超出赠送部分0.10元/分钟，被叫";
		    	note_info1+="免费，亲情号码为本地的中国移动手机号码，亲情号码每月只能修改一次，修改后立即生效；紧急援助：免费拔打人工服务平台9679566，不限次数；生活咨询：每月赠送30分钟免费接入人工服务平";
		    	note_info1+="台967956通话时长（赠送时长和超出赠送时长的计费，均不区分本地或漫游），超出赠送部分0.1";
		    	note_info1+="元/分钟，其中的人工定位服务不再另加收定位产生的费用。其它按照标准资费收取。|";	
		    	}*/
		    	if(resultPhoneFA.length!=0){
		    	note_info1+="取消授权定位人号码："+resultPhoneFA+"。|";
		  		}
		  		if(resultPhoneFA.length==0)
		  		{
		  			note_info1+="取消授权定位人号码：无。|";
		  		}
		  		
				retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
				retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
			  return retInfo;
			}		
				
</script>
	</head>
	<body>
		<form method="post" id="f1" name="f1" onKeyUp="chgFocus(f1)">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">亲情通业务基本信息</div>
			</div>
			<table cellspacing="0">
				<tr>
					<td width="10%" class="blue">套餐类型</td>
					<td width="20%" class="blue">
		      	<input type="text" value="" name="type_flag_del" id="type_flag_del" readonly  class="InputGrey" style="width:145px"/>
					</td>
					<td width="10%" class="blue">操作类型</td>
					<td width="20%" class="blue">
						<input type="text" value="亲情通业务" readonly class="InputGrey"/>
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">开通号码</td>
					<td width="20%" class="blue">
						<input class="InputGrey" readonly  type="text"  name="phoneNo" id="phoneNo" value="<%=phoneNo%>">
					</td>
					<td width="10%" class="blue">用户登录帐号</td>
					<td width="20%" class="blue">
						<input type="text"  id="userAccounts" name="userAccounts"  value="<%=phoneNo%>" readonly class="InputGrey" />
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
						<input type="text" value="" name="custSex" id="custSex" readonly class="InputGrey" />
					</td>
					<td width="10%" class="blue">出生日期</td>
					<td width="20%" class="blue">
						<input type="text" name="propBirthday" id="propBirthday" value="<%=propBirthday%>" readonly class="InputGrey"/>
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">行政区</td>
					<td width="20%" class="blue">
						<input type="text" name="propDistrict" id="propDistrict" readonly class="InputGrey"/>
					</td>
					<td width="10%" class="blue"><span id="sq" style="display:none">社区</span></td>
					<td width="20%" class="blue">
						<input type="text" name="propCommunity" onblur="checkElement(this)" id="propCommunity" readonly class="InputGrey" style="display:none"/>
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">常住地固话</td>
					<td width="20%" class="blue">
						<input type="text" name="propTelephone" id="propTelephone" readonly class="InputGrey"/>
					</td>
					<td width="10%" class="blue">常住地详细地址</td>
					<td width="20%" class="blue">
						<input type="text" name="propAddress" id="propAddress" size="40" readonly class="InputGrey"/>
					</td>
				</tr>
				<tr id="t3" style="display:none">
					<td width="10%" class="blue">急救车辆到达常住地的路线</td>
					<td width="20%" class="blue">
						<input type="text" name="propUrgentRoutes" id="propUrgentRoutes" readonly  class="InputGrey" />
					</td>
					<td width="10%" class="blue">申请人生活情况</td>
					<td width="20%" class="blue">
						<input type="text" value="" name="propLifestyle" id="propLifestyle" readonly  class="InputGrey" />
					</td>
				</tr>
				<tr id="t4" style="display:none">
					<td width="10%" class="blue">是否需要报平安服务</td>
					<td width="20%" class="blue">
						<input type="text" value="" name="isReportSafe" id="isReportSafe" readonly  class="InputGrey" />
					</td>
					<td width="10%" class="blue">&nbsp;</td>
					<td width="20%" class="blue">
							&nbsp;
					</td>
				</tr>
				<tr id="t1" style="display:none">
					<td width="10%" class="blue">报平安周期</td>
					<td width="20%" class="blue">
						<input type="text" name="reportCycle" id="reportCycle" readonly  class="InputGrey"/>天
					</td>
					<td width="10%" class="blue">接受者名称</td>
					<td width="20%" class="blue">
						<input type="text" name="reportName" id="reportName" readonly  class="InputGrey"/>
					</td>
				</tr>
				<tr id="t2" style="display:none">
					<td width="10%" class="blue">接受者移动电话</td>
					<td width="20%" class="blue">
						<input type="text" name="reportMobile" id="reportMobile" readonly  class="InputGrey"/>
					</td>
					<td width="10%" class="blue">接受方式</td>
					<td width="20%" class="blue">
						<input type="text" value="" name="reportWay" id="reportWay" readonly class="InputGrey" />
					</td>
				</tr>
				<tr style="display:none">
					<td width="10%" class="blue">是否设定付费号码</td>
					<td width="20%" class="blue" >
						<input type="text" value="" name="feeFlay" id="feeFlay" readonly  class="InputGrey" />
					</td>
					<td>&nbsp;</td><td>&nbsp;</td>
				</tr>


				<tr style="display:none" id="trd1">
					<td width="10%" class="blue">付费号码</td>
					<td width="20%" class="blue">
						<input type="text" name="feePhone1"  id="feePhone1" readonly  class="InputGrey"/>
					</td>
					<td>&nbsp;</td><td>&nbsp;</td>
				</tr>


				<tr>
					<td width="10%" class="blue">开始时间</td>
					<td width="20%" class="blue">
						<input type="text" v_must=1 id="startTime" value="<%=todayTime%>" name="startTime" readonly class="InputGrey" />
					</td>
					<td width="10%" class="blue">结束时间</td>
					<td width="20%" class="blue">
						<input type="text" v_must=1 id="endTime" value="20500101235959" name="endTime" readonly class="InputGrey"/>
					</td>
				</tr>
			</table>



			<table cellspacing="0">
				<tr>
					<td colspan="4" id="footer">
			           <div align="center">
	                 <input class="b_foot" name="print"  onClick="doCommit()" type=button id="confirm" value=确认> &nbsp;
						     	 <input class="b_foot" type="button" name="qryP" value="返回" onClick="history.go(-1)">
			            </div>
			        </td>
				</tr>
			</table>
			<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>"/>
			<input type="hidden" name="opName" id="opName" value="<%=opName%>"/>
			<input type="hidden" name="loginAccept" id="loginAccept" value="<%=PrintAccept%>"/>
			<%@ include file="/npage/include/footer.jsp" %>
		</form>
	</body>
</html>