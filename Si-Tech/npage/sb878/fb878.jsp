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
<%
//begin huangrong add 2011-3-25
	String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
	String IDType = WtcUtil.repNull(request.getParameter("IDType"));
	String custPWD = WtcUtil.repNull(request.getParameter("custPWD"));
	String cardType = WtcUtil.repNull(request.getParameter("cardType"));
	String cardID = WtcUtil.repNull(request.getParameter("cardID"));
	System.out.println("---------------------------"+cardID);
//end huangrong add

	String opCode = request.getParameter("opCode");
	String opName = "全球通VIP候车服务";
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String tri_detailMsg = "";
	java.util.Date date = new java.util.Date();
	java.text.DateFormat format = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
	String todayTime = format.format(date);
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
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
		%>
		<%
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
				//begin huangrong add
				if("<%=IDType%>"!="")
				{
					if("<%=IDType%>"=="03")
					{
						document.f1.cardType.value="00";
                    }
					else
					{
						document.f1.cardType.value="01";
					}

				}
				//end huangrong add
				//展示服务列表
				for(var i=0;i<servArr.length;i++){
					if(servArr[i][0] != "03"){
						tr1=dyntb.insertRow();
						tr1.id=i;
						tr1.insertCell().innerHTML = '<div align="center"><input type=checkBox size=4  value="'+i+'" checked ></input></div>';
						tr1.insertCell().innerHTML = '<div align="center"><input id="oneCode'+i+'" type=text size=8  value="'+ servArr[i][0]+'"  readonly></input><input id="oneName'+i+'" type="hidden" value="'+servArr[i][5]+'"/></div>';
						tr1.insertCell().innerHTML = '<div align="center"><input id="twoCode'+i+'" type=text size=8  value="'+ servArr[i][1]+'"  readonly></input></div>';
						tr1.insertCell().innerHTML = '<div align="center"><input id="twoNameCode'+i+'" type=text   value="'+ servArr[i][2]+'"  readonly></input></div>';
						tr1.insertCell().innerHTML = '<div align="center"><input type=text   value="'+ servArr[i][2]+'"  maxlength="200" readonly></input></div>';
						tr1.insertCell().innerHTML = '<div align="center"><input id="price'+i+'" type=text align="right" size=9  style="text-align:right" value="'+ servArr[i][3]+'"  v_type=cfloat v_maxlength="12.2"  v_name="金额" maxlength="9" readonly></input></div>';
						tr1.insertCell().innerHTML = '<div align="center"><input id="score'+i+'" type=text  align="right" size=12 style="text-align:right"  value="'+ servArr[i][4]+'"  v_type=0_9 v_minlength="1" v_name="折合应扣积分" maxlength="9" readonly></input></div>';
					}
				}

				//天气预报选择，控制条件展示
				$("input[type='radio']").bind("click",function(){
					if($(this).val()=="0"){
						$("#showTqyb").show();
					}else{
						$("#showTqyb").hide();
					}
				});
				//省市连动
				$("#provinceId").change(function(){
					var packet = new AJAXPacket("ajaxGetCity.jsp","请稍后...");
					packet.data.add("provinceVal",$(this).val());
					core.ajax.sendPacket(packet,function(packet){
							var str = packet.data.findValueByName("str");
							var jsonObj = eval("("+str+")");
							$("#cityId").empty();
							for(var i =0;i<jsonObj.citys.length;i++){
								$("#cityId").append("<option value="+jsonObj.citys[i].cityCode+">"+jsonObj.citys[i].cityName+"</option>");
							}
						});
					packet = null;
				});

				//根据服务级别展示服务
				$("#servLevel").bind("change",function(){
					for(var a = dyntb.rows.length-2 ;a>=0; a--)//删除从tr1开始，为第三行
					{
				            dyntb.deleteRow(a+1);
					}
					if($(this).val() == "1"){
						for(var i=0;i<servArr.length;i++){
							if(servArr[i][0] != "03"){
								tr1=dyntb.insertRow();
								tr1.id=i;
								tr1.insertCell().innerHTML = '<div align="center"><input type=checkBox size=4  value="'+i+'" checked ></input></div>';
						        tr1.insertCell().innerHTML = '<div align="center"><input id="oneCode'+i+'" type=text size=8  value="'+ servArr[i][0]+'"  readonly></input><input id="oneName'+i+'" type="hidden" value="'+servArr[i][5]+'"/></div>';
						        tr1.insertCell().innerHTML = '<div align="center"><input id="twoCode'+i+'" type=text size=8  value="'+ servArr[i][1]+'"  readonly></input></div>';
						        tr1.insertCell().innerHTML = '<div align="center"><input id="twoNameCode'+i+'" type=text   value="'+ servArr[i][2]+'"  readonly></input></div>';
						        tr1.insertCell().innerHTML = '<div align="center"><input type=text   value="'+ servArr[i][2]+'"  maxlength="200" readonly></input></div>';
						        tr1.insertCell().innerHTML = '<div align="center"><input id="price'+i+'" type=text align="right" size=9  style="text-align:right" value="'+ servArr[i][3]+'"  v_type=cfloat v_maxlength="12.2"  v_name="金额" maxlength="9" readonly></input></div>';
						        tr1.insertCell().innerHTML = '<div align="center"><input id="score'+i+'" type=text  align="right" size=12 style="text-align:right"  value="'+ servArr[i][4]+'"  v_type=0_9 v_minlength="1" v_name="折合应扣积分" maxlength="9" readonly></input></div>';
							}

						}
					}else if($(this).val() == "2"){
						for(var i=0;i<servArr.length;i++){
							tr1=dyntb.insertRow();
							tr1.id=i;
							tr1.insertCell().innerHTML = '<div align="center"><input type=checkBox size=4  value="'+i+'" checked ></input></div>';
						        tr1.insertCell().innerHTML = '<div align="center"><input id="oneCode'+i+'" type=text size=8  value="'+ servArr[i][0]+'"  readonly></input><input id="oneName'+i+'" type="hidden" value="'+servArr[i][5]+'"/></div>';
						        tr1.insertCell().innerHTML = '<div align="center"><input id="twoCode'+i+'" type=text size=8  value="'+ servArr[i][1]+'"  readonly></input></div>';
						        tr1.insertCell().innerHTML = '<div align="center"><input id="twoNameCode'+i+'" type=text   value="'+ servArr[i][2]+'"  readonly></input></div>';
						        tr1.insertCell().innerHTML = '<div align="center"><input type=text   value="'+ servArr[i][2]+'"  maxlength="200" readonly></input></div>';
						        tr1.insertCell().innerHTML = '<div align="center"><input id="price'+i+'" type=text align="right" size=9  style="text-align:right" value="'+ servArr[i][3]+'"  v_type=cfloat v_maxlength="12.2"  v_name="金额" maxlength="9" readonly></input></div>';
						        tr1.insertCell().innerHTML = '<div align="center"><input id="score'+i+'" type=text  align="right" size=12 style="text-align:right"  value="'+ servArr[i][4]+'"  v_type=0_9 v_minlength="1" v_name="折合应扣积分" maxlength="9" readonly></input></div>';
						}
					}
				});

				//查询使用积分总数
				$("#countBtn").bind("click",function(){
					var oneCodeArr = "";
					var oneNameArr = "";
					var twoCodeArr = "";
					var twoNameArr = "";
					var priceArr = "";
					var scoreArr = "";
					var totalPrice = 0;
					var totalScore = 0;
					$("input[type='checkbox']").each(function(){//迭代求出总数
 	  					if($(this).attr("checked")) {
 	  						// alert($(this));
							totalPrice += parseInt($("#price"+$(this).val()).val());
							totalScore += parseInt($("#score"+$(this).val()).val());
							oneCodeArr += $("#oneCode"+$(this).val()).val()+"|";
							oneNameArr += $("#oneName"+$(this).val()).val()+"|";
							twoCodeArr += $("#twoCode"+$(this).val()).val()+"~";
							twoNameArr += $("#twoNameCode"+$(this).val()).val()+"~";
							priceArr += $("#price"+$(this).val()).val()+"|";
							scoreArr += $("#score"+$(this).val()).val()+"|";
 	  					}
 	  				});


					if($("#servLevel").val() == "1"){//总积分需要加上所选服务*人数的积分
						totalScore += 2000 * (parseInt($("#personNum").val()) + 1);
					}else{
						totalScore += 3000 * (parseInt($("#personNum").val()) + 1);
					}
					if($("#servLevel").val() == "1"){//金额需要加上所选服务*人数的积分
						totalPrice += 30 * (parseInt($("#personNum").val()) + 1);
					}else{
						totalPrice += 50 * (parseInt($("#personNum").val()) + 1);
					}

					if(parseInt($("#personNum").val()) > 0){//增加随员人数的限定
						oneCodeArr += "06|";
						oneNameArr += $("#personNum").val()+"|";
						twoCodeArr += "01~";
						twoNameArr += "随员人数~";
						priceArr   += "0.00|";
						scoreArr   += "0|";
					}
					$("#totalScore").val(totalScore);
					$("#totalPrice").val(totalPrice);
					$("#oneCodeArr").val(oneCodeArr);
					$("#oneNameArr").val(oneNameArr);
					$("#twoCodeArr").val(twoCodeArr);
					$("#twoNameArr").val(twoNameArr);
					$("#priceArr").val(priceArr);
					$("#scoreArr").val(scoreArr);

				});

				//鉴权
				$("#vallidateBtn").bind("click",function(){
			
					if($("#custPhone").val()==""){
						rdShowMessageDialog("请输入客户标识！");
						return;
					}
					if($("#cardNo").val()==""){
						rdShowMessageDialog("请输入证件号码！");
						return;
					}
					var packet = new AJAXPacket("ajaxChkCust.jsp?sheng_flag=w","请稍后...");
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
							if(oRejectReason == "00"){
								$("#confirm").attr("disabled",false);
								$("#countBtn").attr("disabled",false);
							}else{
								$("#confirm").attr("disabled",true);
								$("#countBtn").attr("disabled",true);
							}
						});
					packet = null;
				});
				//确认提交
				$("#confirm").bind("click",function(){
					if(check(f1)){
						if($("#totalPrice").val()==""){
							rdShowMessageDialog("请查询总金额");
							return;
						}
						if($("#totalScore").val()==""){
							rdShowMessageDialog("请查询总积分");
							return ;
						}
						//选中天气预报时才验证抵达时间
						if($("input[type='radio'][checked]").val() == "0"){
							if($("#destDate").val() == ""){
								rdShowMessageDialog("抵达时间有误！");
								return ;
							}
						}

						$("#f1").submit();
					}
				});
			});

		</script>
	</head>
	<body>
		<form method="post" id="f1" name="f1" action="fb878Cfm.jsp?sheng_flag=w" onKeyUp="chgFocus(f1)">
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
						<input type="text" value="全球通VIP候车服务" readonly/>
					</td>
					<td width="20%" class="blue" colspan="2">
						&nbsp;
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">客户标识类型</td>
					<td width="20%" class="blue">
						<select disabled>
							<option>手机号码</option>
						</select>
					</td>
					<td width="10%" class="blue">客户标识</td>
					<td width="20%" class="blue">
						<input type="text" v_must=1 v_name="客户标识" id="custPhone" name="custPhone" value="<%=phoneNo%>" Class="InputGrey"  readonly maxlength="14" onblur="checkElement(this)"/>
						<font class="orange">*</font>
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">客户密码</td>
					<td width="20%" class="blue" colspan="3">
						<input type="password" v_must=1 id="custPwd" name="custPwd" value="<%=custPWD%>" v_name="客户密码" maxlength="6" />
						<!--<font class="orange">*</font>-->
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">证件类型</td>
					<td width="20%" class="blue">
						<select name="cardType" id="cardType">
							<option value="00">00--&gt;身份证</option>
			                <option value="01">01--&gt;VIP卡</option>
						</select>
					</td>
					<td width="10%" class="blue">证件号码</td>
					<td width="20%" class="blue">
						<input type="text" v_must=1 id="cardNo" name="cardNo" v_name="证件号码" value="<%=cardID%>" onblur="checkElement(this)"/>
						<font class="orange">*</font>
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">服务级别</td>
					<td width="20%" class="blue">
						<select id="servLevel" name="servLevel">
							<option value="1">一级服务</option>
							<option value="2">二级服务</option>
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
						<input type="text" readonly id="custName" name="custName"/>
					</td>
					<td width="10%" class="blue">证件类型及号码</td>
					<td width="20%" class="blue">
						<input type="text" readonly id="iccNo" name="iccNo"/>
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
					<td width="20%" class="blue" colspan="3">
						<input type="text" readonly id="oUserScore" name="oUserScore"/>
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">大客户经理电话</td>
					<td width="20%" class="blue">
						<input type="text" readonly id="oSvcPhNum" name="oSvcPhNum"/>
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
				<tr>
					<td width="10%" class="blue">进入时间</td>
					<td width="20%" class="blue" >
						<input type="text" value="<%=todayTime%>" name="enterTime" maxlength="14" v_type="dateTime" v_must=1  v_minlength=14  v_name="进入时间" />
						<font class="orange">*</font>
						(格式:YYYYMMDDHHMMSS)
					</td>
					<td width="10%" class="blue">离开时间</td>
					<td width="20%" class="blue">
						<input type="text" value="<%=todayTime%>" name="leaveTime" maxlength="14" v_type="dateTime" v_must=1  v_minlength=14  v_name="离开时间"/>
						<font class="orange">*</font>
						(格式:YYYYMMDDHHMMSS)
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">是否预定天气预报服务</td>
					<td width="10%" class="blue" colspan="3">
						选择:<input type="radio" name="tqyb" id="tqyb" value="0">&nbsp;&nbsp;
						不选择：<input type="radio" name="tqyb" id="tqyb" value="1" checked>
					</td>
				</tr>
				<tr id="showTqyb" style="display:none">
					<td class="blue">发送到</td>
					<td colspan="3" class="blue">
						省份:
						<select id="provinceId" name="proCode">
						<%
						for(int i=0;i<result.length;i++){
						%>
							<option value="<%=result[i][0]%>"><%=result[i][1]%></option>
						<%
						}
						%>
						</select>
						<font class="orange">*</font>
						地市:
						<select id="cityId" name="cityCode">
							<option value="010">北京</option>
						</select>
						<font class="orange">*</font>
						<br>
						&nbsp;时间:
						<input type="text" id="destDate" name="destDate" v_must=0 v_type = "date" onblur="checkElement(this)"/>
						<font class="orange">*(格式:YYYYMMDD)</font>
						是否预定第二天：
						<select id="morrowFlag" name="morrowFlag">
							<option value="0">否</option>
							<option value="1">是</option>
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
						<td class="blue">选择</td>
						<td class="blue">一级代码</td>
						<td class="blue">二级代码</td>
						<td class="blue">二级代码名称</td>
						<td class="blue">服务内容</td>
						<td class="blue">金额</td>
						<td class="blue">折合应扣积分</td>
					</tr>
				</table>
				<table>
					<tr>
						<td colspan="7">
							<input type="button" class="b_text" value="计算总额" id="countBtn" disabled />
						</td>
					</tr>
					<tr>
						<td>总计金额</td>
						<td colspan="2">
							<input type="text" readonly id="totalPrice" v_must=1 name="totalPrice"/>
							<font class="orange">*</font>
						</td>
						<td colspan="2">总扣积分</td>
						<td colspan="2">
							<input type="text" readonly id="totalScore" v_must=1 name="totalScore"/>
							<font class="orange">*</font>
						</td>
					</tr>
				</table>
			</div>
			<table cellspacing="0">
				<tr>
					<td colspan="4" id="footer">
			           <div align="center">
			              <input class="b_foot" type="button" id="confirm" name="confirm" value="确认" index="2" disabled >
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
			<%@ include file="/npage/include/footer.jsp" %>
		</form>
	</body>
</html>