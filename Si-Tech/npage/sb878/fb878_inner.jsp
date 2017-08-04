<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 全球通VIP候车服务
   * 版本: 2.0
   * 日期: 2011/11/16
   * 作者: weigp
   * 版权: si-tech
   * update:
   */
%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%
	String opCode = request.getParameter("opCode");
	String phoneNo = request.getParameter("phoneNo");	
	String IDType = request.getParameter("IDType");	
	String custPWD = request.getParameter("custPWD");	
	
	System.out.println("-------------custPWD-----------------"+custPWD);	
	String cardType = request.getParameter("cardType");		
	String cardID = request.getParameter("cardID");			

	String opName = "全球通VIP候车服务";
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String tri_detailMsg = "";
	String cust_attribute = "";
	String cust_breed = "";
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	//huangrong add 获取免密信息 2011-7-1 
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] temfavStr=(String[][])arrSession.get(3);
	String[] favStr=new String[temfavStr.length];
	for(int i=0;i<favStr.length;i++)
	favStr[i]=temfavStr[i][0].trim();
	boolean pwrf=false;
	if(Pub_lxd.haveStr(favStr,"a272"))
	pwrf=true;
	String ICCID = "";
	System.out.println("-------------pwrf-----------------"+pwrf);	
%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%!
		    public static String createArray(String aimArrayName, int xDimension) {
		        String stringArray = "var " + aimArrayName + " = new Array(";
		        int flag = 1;
		        for (int i = 0; i < xDimension; i++) {
		            if (flag == 1) {
		                stringArray = stringArray + "new Array()";
		                flag = 0;
		                continue;
		            }
		            if (flag == 0) {
		                stringArray = stringArray + ",new Array()";
		            }
		        }
		
		        stringArray = stringArray + ");";
		        return stringArray;
		    }
		%>
							
		<%
			//获取一级BOSS中所有省份
			String proSql = "select substr(node_code,0,3),node_name from oneboss.sobexchgnode where domain_id = 'BOSS' order by node_code";
		%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg" outnum="2">
		<wtc:sql><%=proSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />
		<%
		if(result.length > 0){
			for(int i=0;i<result.length;i++){
				System.out.println("node_code="+result[i][0]+"--------->node_name="+result[i][1]);
			}
		}else{
		%>
			rdShowMessageDialog("获取省份信息失败！");
		<%	
		}
				String printAccept="";
		%>
			<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone"  routerValue="<%=phoneNo%>" id="sLoginAccept"/>
		<%
			printAccept = sLoginAccept;
			//获取服务列表
			String servSql = "select a.avc_code,a.item_code,a.item_name,a.item_price,a.item_score,b.avc_name from SVIPSvcItemCode a,SVIPSvcCode b where a.avc_code = b.avc_code";
		%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="6">
		<wtc:sql><%=servSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result1" scope="end" />
		<%
			if(result1.length <= 0){
		%>
				rdShowMessageDialog("获取服务信息失败！");
		<%
			}else{
				tri_detailMsg = createArray("servArr", result1.length);
			}
		%>
		
		<%
			//查询客户属性
			String custSql = " select b.card_name, c.sm_name from dcustmsg a, sBigCardCode b, ssmcode c where a.sm_code = c.sm_code and substr(belong_code, 0, 2) = c.region_code and substr(attr_code, 3, 2) = b.card_type and a.phone_no = '"+phoneNo+"'" ;    
		%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
		<wtc:sql><%=custSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result_cust" scope="end" />
		<%
		if(retCode2.equals("000000"))
		{	
			if(result_cust.length <= 0){
		%>
		<script language='jscript'>
							rdShowMessageDialog("获取客户信息失败！");
    </script>
		<%
			}else{
				cust_attribute = result_cust[0][0];
				cust_breed = result_cust[0][1];
			}
		}
		%>
		
		<%
			//查询客户身份证号
			String custICCIDSql = "select a.id_iccid from dcustdoc a,dcustmsg b where a.cust_id = b.cust_id and b.phone_no=:phoneNoNew" ;
			String srv_param = "phoneNoNew=" + phoneNo;    
			
		%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  retcode="retICCIDCode" retmsg="retICCIDCMsg" outnum="1">
			<wtc:param value="<%=custICCIDSql%>"/>
			<wtc:param value="<%=srv_param%>"/>
		</wtc:service>
		<wtc:array id="result_ICCID" scope="end" />
		<%
		if(retICCIDCode.equals("000000"))
		{	
			if(result_ICCID.length <= 0){
		%>
		<script language='jscript'>
				rdShowMessageDialog("获取客户信息失败！");
    	</script>
		<%
			}else{
				ICCID = result_ICCID[0][0];
			}
		}
		%>
		
		
		<title>全球通VIP候车服务</title>
		<script type="text/javascript">
		<%=tri_detailMsg%>	
			<%
			    for (int p = 0; p < result1.length; p++) {
			        for (int q = 0; q < result1[p].length; q++) {
			%>
						servArr[<%=p%>][<%=q%>]="<%=result1[p][q]%>";
			<%
			        }
			    }
			%>
				
			$(document).ready(function () {
				document.all.IDType.value="<%=IDType%>";
				document.all.cardType.value="<%=cardType%>";
				
									
				if (""!="<%=custPWD%>")
				{
					document.all.cardNo.value="<%=ICCID%>"
				}

				//展示服务列表
				for(var i=0;i<servArr.length;i++){
					if(servArr[i][0] != "03"){
						tr1=dyntb.insertRow();
						tr1.id=i;
						tr1.insertCell().innerHTML = '<div align="center"><input id="oneCode'+i+'" type=text size=8  value="'+ servArr[i][0]+'"  readonly></input><input id="oneName'+i+'" type="hidden" value="'+servArr[i][5]+'"/></div>';
						tr1.insertCell().innerHTML = '<div align="center"><input id="twoCode'+i+'" type=text size=8  value="'+ servArr[i][1]+'"  readonly></input></div>';
						tr1.insertCell().innerHTML = '<div align="center"><input id="twoNameCode'+i+'" type=text   value="'+ servArr[i][2]+'"  readonly></input></div>';
						tr1.insertCell().innerHTML = '<div align="center"><input type=text   value="'+ servArr[i][2]+'"  maxlength="200" readonly></input></div>';
						tr1.insertCell().innerHTML = '<div align="center"><input id="price'+i+'" type=text align="right" size=9  style="text-align:right" value="'+ servArr[i][3]+'"  v_type=cfloat v_maxlength="12.2"  v_name="金额" maxlength="9" readonly></input></div>';
						tr1.insertCell().innerHTML = '<div align="center"><input id="score'+i+'" type=text  align="right" size=12 style="text-align:right"  value="'+ servArr[i][4]+'"  v_type=0_9 v_minlength="1" v_name="折合应扣积分" maxlength="9" readonly></input></div>';
					}
				}
				//鉴权
				$("#vallidateBtn").bind("click",function(){
					if($("#custPhone").val()==""){
						rdShowMessageDialog("请输入客户标识！");
						return;
					}
						
					/*
					//liujian 2013-4-2 16:44:40 去掉密码和身份证验证
					if("<%=pwrf%>"=="false")
					{
						if($("#custPwd").val()==""){
							rdShowMessageDialog("请输入客户密码！");
							return;
						}						
					}
					if($("#cardNo").val()==""){
						rdShowMessageDialog("请输入证件号码！");
						return;
					}
					*/
					var packet = new AJAXPacket("ajaxChkCust.jsp?sheng_flag=n","请稍后...");
					packet.data.add("custPhone",$("#custPhone").val());
					packet.data.add("cardType",$("#cardType").val());
					packet.data.add("custPwd",$("#custPwd").val());
					packet.data.add("cardNo",$("#cardNo").val());
					packet.data.add("servLevel",$("#servLevel").val());
					packet.data.add("personNum",$("#personNum").val());
					core.ajax.sendPacket(packet,function(packet){
							var	errCode = packet.data.findValueByName("errCode");
							var	errMsg = packet.data.findValueByName("errMsg");
							var	flag = packet.data.findValueByName("flag");
							var oRejectReason = packet.data.findValueByName("oRejectReason");
							if(flag == "false"){//不提供服务时
								rdShowMessageDialog("错误代码："+errCode+"，错误信息："+errMsg);
								$("#custPhone").val("");
								$("#cardNo").val("");
								$("#custPwd").val("");
								$("#personNum").val("0");
								return ;
							}
							$("#custName").val(packet.data.findValueByName("oCustName"));//客户名称
							$("#iccNo").val($("#cardNo").val());
							$("#oRejectReason").val(oRejectReason);//拒绝理由
							var oUserStatus = packet.data.findValueByName("oUserStatus");//客户状态
							$("#oUserStatus").val(oUserStatus);
							var oUserRank = packet.data.findValueByName("oUserRank");//客户级别
							$("#oUserRank").val(oUserRank);
							$("#oSvcPhNum").val(packet.data.findValueByName("oSvcPhNum"));//大客户经理联系电话
							$("#oUserScore").val(packet.data.findValueByName("oUserScore"));//客户可用积分余额
							var oUserScore=packet.data.findValueByName("oUserScore");
							if(oRejectReason == "00"){
								$("#confirm").attr("disabled",false);
								$("#countBtn").attr("disabled",false);
								var oRemainTimes= packet.data.findValueByName("oRemainTimes");//剩余免费次数
								var oUsedNu= packet.data.findValueByName("oUsedNu");//本次使用的免费次数
								var oUsedScor= packet.data.findValueByName("oUsedScor");//本次需要的积分数	
								document.all.oUsedScor.value=oUsedScor;
								document.all.oUsedNu.value=oUsedNu;							
							  /*
								if((oUsedNu=="0" || oUsedNu == null) &&  (oUsedScor=="0" || oUsedScor==null))
								{
		            				rdShowMessageDialog("特批VIP用户不进行积分扣减，可免费进行使用！");	
		            				document.all.oResultNu.value=oRemainTimes;									
								}else
									{*/
								  	var resultNu =Number(oRemainTimes)-Number(oUsedNu);
										var resultScor =Number(oUserScore)-Number(oUsedScor);
										document.all.oResultNu.value=oRemainTimes;
										rdShowMessageDialog("本次预计扣减的免费使用次数："+oUsedNu+"<br>本次预计扣减的积分数："+oUsedScor+"<br>本次使用后剩余免费次数："+resultNu+"<br>本次使用后剩余的积分数："+resultScor);			
									//}
							}else{
								rdShowMessageDialog("验证失败，失败原因请详见‘服务拒绝理由’");			
								$("#confirm").attr("disabled",true);
								$("#countBtn").attr("disabled",true);		
							}

						});
					packet = null;
				});
				//确认提交
				$("#confirm").bind("click",function(){
				  getAfterPrompt();
					document.all.servLeve.value=document.all.servLevel.value;
				  document.f1.confirm.disabled=true;//防止二次确认
					 //打印工单并提交表单
					if(check(f1)){
					  var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 			
					}

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
					  }else{
					     if(rdShowConfirmDialog('确认要提交信息吗？')==1)
					     {
						  	 frmCfm();
					     }
					  }
					  return true;
				});
			});
			
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框 
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="subprint";   
	var billType="1";  
	var sysAccept = document.all.login_accept.value;   
	var printStr = printInfo(printType);
	var mode_code=null;
	var fav_code=null;
	var area_code=null;   
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
	var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=<%=phoneNo%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	return ret;    
}

function printInfo(printType)
{
	var retInfo = "";
	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";
	cust_info+="客户姓名："+document.all.custName.value+"|";
	cust_info+="手机号码："+document.all.custPhone.value+"|";
	
	opr_info+="客户属性：<%=cust_attribute%>"+"|";
	opr_info+="客户品牌：<%=cust_breed%>"+"|";	
	opr_info+="本次扣减免费次数："+document.all.oUsedNu.value+"|";
	opr_info+="本次扣减积分："+document.all.oUsedScor.value+"|";
	opr_info+="业务流水："+document.all.login_accept.value+"|";
	opr_info+="业务名称：火车站贵宾厅服务"+"|";
  
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
  return retInfo;	
}	

function frmCfm()
{
  var personNum = $("#personNum").val(); //随行人数
  if($("#servLevel").val()=="1"){ //服务折扣金额：一类服务30元/人次
    $("#priceArr").val("30");
  }else{    //二类服务50元/人次。
    $("#priceArr").val("50");
  }
  //总金额 = 服务折扣金额 * (随行人数+本人)
  var v_totalPrice = parseFloat($("#priceArr").val())*(parseFloat(personNum)+1);
  //alert(v_totalPrice+"="+parseFloat($("#priceArr").val())+"*"+(parseFloat(personNum)+1));
  $("#totalPrice").val(v_totalPrice);
	$("#f1").submit(); 
}
		</script>
	</head>
	<body>
		<form method="post" id="f1" name="f1" action="fb878Cfm.jsp?sheng_flag=n" onKeyUp="chgFocus(f1)">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">全球通VIP候车服务</div>
			</div>
			<table cellspacing="0">
				<tr>
					<td width="10%" class="blue">开通方式</td>
					<td width="20%" class="blue" colspan="3">
						<select disabled>
							<option checked>正式</option>	
							<option>测试</option>	
						</select>	
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">操作类型</td>
					<td width="20%" class="blue">
						<input type="text" value="全球通VIP候车服务" Class="InputGrey"  readonly/>
					</td>
					<td width="20%" class="blue" colspan="2">
						&nbsp;
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">客户标识类型</td>
					<td width="20%" class="blue">
						<select name="IDType" disabled>
            <option value="01">01--&gt;电子卡认证</option>
            <option value="02">02--&gt;vip实体卡认证</option>
            <option value="03">03--&gt;手机号码+身份证号码认证</option>
            </select>
					</td>
					<td width="10%" class="blue">手机号码</td>
					<td width="20%" class="blue">
						<input type="text" v_must=1 v_name="客户标识" value="<%=phoneNo%>" id="custPhone" name="custPhone" Class="InputGrey"  readonly/>
						<font class="orange">*</font>	
					</td>	
				</tr>
				<tr>
					<td width="10%" class="blue">客户密码</td>
					<td width="20%" class="blue" colspan="3">
					<!-- liujian 2013-4-2 16:45:37 密码和身份证不可更改 -->
						
            <%if(pwrf) {%>
						<input type="password" id="custPwd" name="custPwd" v_name="客户密码" value="<%=custPWD%>" disabled/>	
			 <% } else { %>

						<input type="password" id="custPwd" name="custPwd" v_name="客户密码" value="<%=custPWD%>" disabled/>	
					<!--	<font class="orange">*</font> -->
			 <%}%>						
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">证件类型</td>
					<td width="20%" class="blue">
						<select name="cardType" id="cardType" disabled>
							<option value="00">00--&gt;身份证</option>
			        <option value="01">01--&gt;VIP卡</option>	
						</select>	
					</td>
					<td width="10%" class="blue">证件号码</td>
					<td width="20%" class="blue">
						<input type="text" id="cardNo" name="cardNo" v_name="证件号码" value="<%=cardID%>" disabled/>
						<!-- <font class="orange">*</font> -->
					</td>	
				</tr>
				<tr>
					<td width="10%" class="blue">服务级别</td>
					<td width="20%" class="blue">
						<select id="servLevel" name="servLevel">
							<!--huangrong 删除对哈尔滨服务级别限制为只能是二级服务的限制条件-->
							<!--liujian 2013-2-26 10:21:43 
								本省用户在哈尔滨候车室只可以选择二类服务，二类服务扣减500积分；
								本省用户在非哈尔滨候车室可以选择一类服务和二类服务(默认)，一类服务扣减300积分，二类服务扣减500积分；
							-->
							<!--diling update for 关于转发市场部“关于优化机场、火车站贵宾厅服务规范的通知”的通知@ 2013-9-24 
								本省用户在哈尔滨候车室，一类服务和二类服务都可以选择（说明：现在系统只可以选择一类服务），
                一类服务扣减300分/人次，二类服务扣减500分/人次；
							-->
								<option value="1">一级服务</option>	
								<option value="2" selected>二级服务</option>	
						</select>	
					</td>
					<td width="10%" class="blue">随员个数</td>
					<td width="20%" class="blue">
						<input type="text" value="0" id="personNum" name="personNum"/>(不含本人)
						<input type="button" class="b_text"  value="验证" id="vallidateBtn"/>	
					</td>	
				</tr>
				<tr>
					<td width="10%" class="blue">客户姓名</td>
					<td width="20%" class="blue">
						<input type="text" readonly Class="InputGrey"  id="custName" name="custName"/>	
					</td>
					<td width="10%" class="blue">证件类型及号码</td>
					<td width="20%" class="blue">
						<input type="text" readonly Class="InputGrey"  id="iccNo" name="iccNo"/>	
					</td>	
				</tr>
				<tr>
					<td width="10%" class="blue">用户状态</td>
					<td width="20%" class="blue">
						<select id="oUserStatus" disabled name="oUserStatus">
							<option value="00">正常</option>	
							<option value="01">单向停机</option>	
							<option value="02">停机</option>	
							<option value="03">预销户</option>	
							<option value="04">销户</option>	
							<option value="05">过户</option>	
							<option value="06">改号</option>	
							<option value="90">神舟行用户</option>	
							<option value="99">此号码不存在</option>	
						</select>	
					</td>
					<td width="10%" class="blue">客户级别</td>
					<td width="20%" class="blue">
						<select id="oUserRank" disabled name="oUserRank">
							<option value="000">保留</option>	
							<option value="100">普通客户</option>	
							<option value="200">重要客户</option>	
							<option value="201">党政机关客户</option>	
							<option value="202">军、警、安全机关客户</option>	
							<option value="203">联通合作伙伴客户</option>	
							<option value="204">英雄、模范、名星类客户</option>	
							<option value="300">普通大客户</option>	
							<option value="301">钻石卡大客户</option>	
							<option value="302">金卡大客户</option>
							<option value="303">银卡大客户</option>	
							<option value="304">贵宾卡大客户</option>		
						</select>	
					</td>	
				</tr>
				<tr>
					<td width="10%" class="blue">客户积分</td>
					<td width="20%" class="blue">
						<input type="text" readonly Class="InputGrey"  id="oUserScore" name="oUserScore"/>	
					</td>
					<td width="10%" class="blue">剩余免费次数</td>
					<td width="20%" class="blue">
						<input type="text" readonly Class="InputGrey"  id="oResultNu" name="oResultNu"/>	
					</td>					
				</tr>
				<tr>
					<td width="10%" class="blue">大客户经理电话</td>
					<td width="20%" class="blue">
						<input type="text" readonly Class="InputGrey"  id="oSvcPhNum" name="oSvcPhNum"/>
					</td>
					<td width="10%" class="blue">服务拒绝理由</td>
					<td width="20%" class="blue">
						<select id="oRejectReason" name="oRejectReason" style="width:200px" disabled>	
							<option value="00">鉴权成功</option>
							<option value="01">客户积分不够</option>
							<option value="02">客户级别不够</option>
							<option value="03">客户密码错误</option>
							<option value="04">客户身份证号码或vip卡号错误</option>
							<option value="05">无此用户</option>
							<option value="06">客户状态不正常,无法提供服务</option>
							<option value="07">集团客户,无个人身份信息,请用VIP卡号确认</option>
							<option value="99">其它错误,由省公司自行解释</option>
						</select>
					</td>
				</tr>
			</table>
			<div id="serviceList">
				<div class="title">
					<div id="title_zi">服务列表</div>
				</div>
				<table id="dyntb" name="dyntb">
					<tr>
						<td class="blue">一级代码</td>
						<td class="blue">二级代码</td>
						<td class="blue">二级代码名称</td>
						<td class="blue">服务内容</td>
						<td class="blue">金额</td>
						<td class="blue">折合应扣积分</td>	
					</tr>	
				</table>
			</div>
			<table cellspacing="0">
				<tr>
					<td colspan="4" id="footer"> 
			           <div align="center"> 
			              <input class="b_foot" type="button" id="confirm" name="confirm" value="确认&打印" index="2" disabled >    
			              <input class="b_foot" type="button" name=back value="清除" onClick="f1.reset()">
					          <input class="b_foot" type="button" name=qryP value="关闭" onClick="parent.removeTab('<%=opCode%>');">
					          <input class="b_foot" type="button" name=comeback value="返回" onClick="history.go(-1);">
			            </div>
			        </td>	
				</tr>
			</table>
			<input type="hidden" name="oneCodeArr" id="oneCodeArr" />
			<input type="hidden" name="oneNameArr" id="oneNameArr" />
			<input type="hidden" name="twoCodeArr" id="twoCodeArr" />
			<input type="hidden" name="twoNameArr" id="twoNameArr" />
			<input type="hidden" name="priceArr" id="priceArr" />
			<input type="hidden" name="scoreArr" id="scoreArr" />
			<input type="hidden" name="flag" id="scoreArr" value="inner"/>
			<input type="hidden" id="totalPrice" v_must=1 name="totalPrice"/> <!--总计金额-->
			<input type="hidden" id="totalScore" v_must=1 name="totalScore"/>	 <!--总扣积分-->
			<input type="hidden" name="enterTime"/>	<!--进入时间-->
			<input type="hidden" name="leaveTime" />	<!--离开时间-->
			<input type="hidden" name="proCode" />	<!--省份-->
			<input type="hidden" name="cityCode" />	<!--地市-->						
			<input type="hidden" name="destDate" />	<!--目的地当天天气预报日期-->			
			<input type="hidden" name="morrowFlag" />	<!--是否预定第二天天气预报标识-->		
			<input type="hidden" name="servLeve" />	<!--是否预定第二天天气预报标识-->		
			<input type="hidden" name="oUsedScor" />	<!--本次需要的积分数	-->			
			<input type="hidden" name="oUsedNu" />	<!-- 本省用户增加本次使用的免费次数	-->						
			
			
		  <input type="hidden" name="login_accept" value="<%=printAccept%>">
			
												

			<%@ include file="/npage/include/footer.jsp" %>
		</form>
	</body>
</html>