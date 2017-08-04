<!-- --------主资费及捆绑可选资费------------ -->
<%
	String cancelRtnCode = "000000";
	String cancelRtnMsg = "";
	
	String codeTemp = "000000";
	String msgTemp = "";
	
	String idNoTemp = "";
	String custIdTemp = "";
	String brandIdTemp = "";//用户品牌串
	String groupIdTemp = "";
	String phoneNoTemp = "";//手机号码串，主卡及成员
	String phoneTypeTemp = "";//号码类型，标识主卡还是成员，P-手机成员,B-宽带用户,T-TD固话用户,0-主卡
	String priFeeCodeTemp = "";//主资费代码串
	String priFeeNameTemp = "";//主资费名称串
	String priFeeValidTemp = "";//主资费生效标识串
	String distriFeeCodeTemp = "";//小区资费代码串
	String distriFeeNameTemp = "";//小区资费名称串
	String CProdInstIdTemp = "";//资费实例代码串
	String nextOfferInstIdTemp = "";//新订购资费instId 如果是预约取消传实例id 否则传0
	String CurMOfferEffTimeTemp = "";//当前资费生效时间串
	String CurMOfferExpTimeTemp = "";//当前资费失效时间 串
	String NextMOfferIdTemp = "";//下一档资费代码串
	String NextMOfferNameTemp = "";//下一档资费代码名称串
	String NextMOfferEffTimeTemp = "";//下一档资费生效时间串
	String NextMOfferExpTimeTemp = "";//下一档资费失效时间串
	String priFeeOperateTypeTemp = "";//正常取消传3 预约传2
	String nextFeeOperateTypeTemp = "";//下一档资费生效标示 正常传1 预约传2

	List extFeeMemberList = new ArrayList();//主资费捆绑资费用户列表			
	if("T".equals(showPriFee)){
		System.out.println("---------feeinfo----------priFee----------priFeeList.size()----------" + priFeeList.size());
		for(int t=0;t<priFeeList.size();t++ ){
			System.out.println("---------feeinfo----------priFee----------priFeeList----------" + priFeeList.get(t));
			Map priFeeMap = MapBean.isMap(priFeeList.get(t));
			String phoneType = (String)priFeeMap.get("PHONE_TYPE");
			String memPhoneNo = (String)priFeeMap.get("PHONE_NO");
			//主资费
			String priFeeCode = (String)priFeeMap.get("CODE");
			String priFeeName = (String)priFeeMap.get("NAME");
			String priFeeValid = (String)priFeeMap.get("VALID");
			String prcEffTime = (String)priFeeMap.get("PRC_EFF_TIME");
			String distriFeeCode = (String)priFeeMap.get("DISTRIFEE_CODE");
			String distriFeeName = (String)priFeeMap.get("DISTRIFEE_NAME");
			String status = (String)priFeeMap.get("STATUS");
			String curOfferEffTime = "";
			String curOfferExpTime = "";
			String nextMOfferId = "";
		 	String nextMOfferName = "";
		 	String nextOfferEffTime = "";
		 	String nextOfferExpTime = "";
		 	String cProdnstId = "";//资费实例
		 	String nextOfferInstId = "";
		 	//用户信息
		 	String idNo = "";
		 	String custId = "";
		 	String belongCode = "";
		 	String smCode = "";
		 	String modeCode = "";
		 	String memgroupId = "";
		 	String brandId = "";
			System.out.println("---------feeinfo----------priFee----------phoneType----------" + phoneType);
			System.out.println("---------feeinfo----------priFee----------phoneNo----------" + memPhoneNo);
			System.out.println("---------feeinfo----------priFee----------priFeeCode----------" + priFeeCode);
			System.out.println("---------feeinfo----------priFee----------priFeeName----------" + priFeeName);
			System.out.println("---------feeinfo----------priFee----------priFeeValid----------" + priFeeValid);
			System.out.println("---------feeinfo----------priFee----------status----------" + status);
			//--------------------------------------------------取用户信息--------------------------------------------------
			if(!"B".equals(phoneType)){
			%>
				<s:service name="sMKTGetUsrInf">
					<s:param name="ROOT">
						<s:param name="PHONE_NO" type="string" value="<%=memPhoneNo%>" />
					</s:param>
				</s:service>				
				<%
				idNo = result.getString("OUT_DATA.USER_INFO.ELEMENT0");
				custId = result.getString("OUT_DATA.USER_INFO.ELEMENT1");
				belongCode = result.getString("OUT_DATA.USER_INFO.ELEMENT3");
				memgroupId = result.getString("OUT_DATA.USER_INFO.ELEMENT27");
				brandId = result.getString("OUT_DATA.USER_INFO.ELEMENT4");
				modeCode = result.getString("OUT_DATA.USER_INFO.ELEMENT31");
			}else{
				idNo = netIdNo;
				custId = netCustId;
				memgroupId = netGroupId;
				brandId = netBrandId;
				modeCode = netFeeCode;
				belongCode = "";
			}
			if(idNo == null || "N/A".equals(idNo)){
				cancelRtnCode = "999999";
				cancelRtnMsg = "取用户信息失败！";
			}
			System.out.println("---------feeinfo----------sMKTGetUsrInf----------memPhoneNo----------" + memPhoneNo);
			System.out.println("---------feeinfo----------sMKTGetUsrInf----------idNo----------" + idNo);
			System.out.println("---------feeinfo----------sMKTGetUsrInf----------belongCode----------" + belongCode);
			System.out.println("---------feeinfo----------sMKTGetUsrInf----------custId----------" + custId);
			System.out.println("---------feeinfo----------sMKTGetUsrInf----------modeCode----------" + modeCode);
			//可选资费变量组
			String[][] data = null;
			//--------------------------------------------------预约取消--------------------------------------------------
			//预约资费的取消是一种还原的逻辑 可以看做冲正 将原来资费（在订购时预约退订了）的生失效时间还原回去 将预约订购的资费的开始结束时间更改为now
			//因为行业部原因 不会在测试非宽带成员的预约资费取消 所以下面这段逻辑只会对宽带起作用 …… …… ……  于是让我来讲一个悲桑的故事吧……
			//预约取消逻辑： 订购的预约资费 更新开始和结束时间为sysdate
			//               订购时退订的旧资费 更新开始时间和结束时间为服务返回时间
			//               订购时选择的可选资费 处理方式同订购的预约资费
			//               订购时退订的可选资费 处理方式同订购时退订的旧资费
			if("1".equals(validType)){
				priFeeValid = "0";
				priFeeOperateTypeTemp += "2" + split;
				nextFeeOperateTypeTemp += "2" + split;
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd HH:mm:ss");
				String today = sdf.format(calendar.getTime());
				%>
					<s:service name="sMktPreCancleWS_XML">
						<s:param name="ROOT">
							<s:param name="LOGIN_ACCEPT" type="string" value="0" />
							<s:param name="CHN_CODE" type="string" value="0" />
							<s:param name="OP_CODE" type="string" value="<%=opCode%>" />
							<s:param name="LOGIN_NO" type="string" value="<%=loginNo%>" />
							<s:param name="LOGIN_PWD" type="string" value="<%=password%>" />
							<s:param name="PHONE_NO" type="string" value="<%=memPhoneNo%>" />
							<s:param name="USER_PWD" type="string" value="" />
							<s:param name="OPR_ACCEPT" type="string" value="<%=printAccept%>" />
							<s:param name="OFFER_ID" type="string" value="<%=priFeeCode %>" />
						</s:param>
					</s:service>
				<%
				String returnCode = result.getString("RETURN_CODE");
				String returnMsg = result.getString("RETURN_MSG");
				if(!"000000".equals(returnCode)){
					cancelRtnCode = returnCode;
					cancelRtnMsg = returnMsg;
					break;
				}
				curOfferEffTime = prcEffTime;
				curOfferExpTime = today;
				nextMOfferId = result.getString("NEXT_OFFER_ID");
				nextMOfferName = result.getString("NEXT_OFFER_NAME");
				nextOfferEffTime = result.getString("NEXT_EFF_TIME");
				nextOfferExpTime = result.getString("NEXT_EXP_TIME");
				System.out.println("--------------------------curOfferEffTime:"+curOfferEffTime);
				System.out.println("--------------------------curOfferExpTime:"+curOfferExpTime);
				System.out.println("--------------------------nextMOfferId:"+nextMOfferId);
				System.out.println("--------------------------nextMOfferName:"+nextMOfferName);
				System.out.println("--------------------------nextOfferEffTime:"+nextOfferEffTime);
				System.out.println("--------------------------nextOfferExpTime:"+nextOfferExpTime);
				
				List instList = result.getList("INSITS.INSIT");
				Map insitsMap = new HashMap();
				if(!"N/A".equals(instList)){
					for(int i=0; i<instList.size(); i++){
						Map instMap =  MapBean.isMap(instList.get(i));
						String offerId = (String)instMap.get("OFFER_ID");
						String insitsId = (String)instMap.get("OFFER_INSIT");
						System.out.println("--------------------------offerId:"+offerId);
						System.out.println("--------------------------insitsId:"+insitsId);
						//资费实例按升序排序 ，如果已经存在，那么先取出来的必定是旧资费 也就是要订购（还原）的资费
						if(insitsMap.containsKey(offerId)){
							System.out.println("--------------------------contains  insitsId:"+insitsId);
							if(offerId.equals(nextMOfferId)){
								nextOfferInstId = (String)insitsMap.get(nextMOfferId);
							}
						}
						insitsMap.put(offerId, insitsId);
					}
				}
				
				cProdnstId = (String)insitsMap.get(priFeeCode);
				if("".equals(nextOfferInstId)){
					nextOfferInstId = (String)insitsMap.get(nextMOfferId);
				}
				//可选资费
				if("T".equals(showExtFee)){
					data = new String[extFeeList.size()][15];
					extFeeMemberList.add(memPhoneNo);					
					for(int i=0; i<extFeeList.size(); i++){
						Map feeExtMap = MapBean.isMap(extFeeList.get(i));
						String extPhoneNo = feeExtMap.get("PHONE_NO")== null?"":(String)feeExtMap.get("PHONE_NO");
						if(!extPhoneNo.equals(memPhoneNo)){
							continue;
						}
						String code = feeExtMap.get("EXTFEE_CODE")== null?"":(String)feeExtMap.get("EXTFEE_CODE");
						String name = feeExtMap.get("EXTFEE_NAME")== null?"":(String)feeExtMap.get("EXTFEE_NAME");
						String statusStr = feeExtMap.get("STATUS")== null?"":(String)feeExtMap.get("STATUS");
						String valid = feeExtMap.get("VALID")== null?"":(String)feeExtMap.get("VALID");
						String instId = (String)insitsMap.get(code);
						String choicedStr = "预约绑定";
						String sendFlagStr = "宽带预约";
						String modeTypeName = "-";
						//预约订购的做退订
						String start = today;
						String end = today;
						String checkedHtml = "onclick='return false'";
						String statusShowStr = "预约开通";
						if("X".equals(statusStr)){//预约取消的做更新
							start = nextOfferEffTime;
							end = nextOfferExpTime;
							statusShowStr = "预约取消";
							checkedHtml = "checked onclick='return false'";
						}
						data[i][0] = code;//编码
						data[i][1] = name;//名称
						data[i][2] = "";//可选方式
						data[i][3] = choicedStr;//可选方式展现
						data[i][4] = valid;//生效方式
						data[i][5] = sendFlagStr;//生效方式展现
						data[i][6] = modeTypeName;//套餐类别
						data[i][7] = statusStr;//开通状态
						data[i][8] = instId;//实例
						data[i][9] = start;//开始时间
						data[i][10] = end;//结束时间
						data[i][11] = statusShowStr;//开通状态展现
						data[i][12] = checkedHtml;//选择状态
						data[i][13] = instId+"#"+code+"#"+name+"#"+valid+"#"+statusStr+"#"+start+"#"+end;
						System.out.println("---------feeinfo----------预约取消----------可选----------" + data[i][13]);
					}
				}
			}
			//--------------------------------------------------正常取消--------------------------------------------------
			if(!"1".equals(validType)){
				if("X".equals(status)){
					continue;
				}
				priFeeOperateTypeTemp += "3" + split;
				nextFeeOperateTypeTemp += "1" + split;
				nextOfferInstId = "0";
				%>
					<s:service name="sProdMCancleWS_XML">
						<s:param name="ROOT">
							<s:param name="iLoginAccept" type="string" value="0" />
							<s:param name="iChnSource" type="string" value="0" />
							<s:param name="iOpCode" type="string" value="g796" />
							<s:param name="iLoginNo" type="string" value="<%=loginNo%>" />
							<s:param name="iLoginPWD" type="string" value="<%=password%>" />
							<s:param name="iPhoneNo" type="string" value="<%=memPhoneNo%>" />
							<s:param name="iUserPwd" type="string" value="" />
							<s:param name="iOprAccept" type="string" value="<%=printAccept%>" />
							<s:param name="iCurMOfferId" type="string" value="<%=priFeeCode %>" />
							<s:param name="iNextMOfferId" type="string" value="<%=newPriFeeCode %>" />
							<s:param name="iExpType" type="string" value="<%=expType %>" />
						</s:param>
					</s:service>   
				<%
				String returnCode = result.getString("RETURN_CODE");
				String returnMsg = result.getString("RETURN_MSG");
				System.out.println("========================returnCode=======returnCode==========returnCode========returnCode======================================"+returnCode);
				if("460000".equals(returnCode)){
					showPriFee = "F";
					break;
				}
				if(!"000000".equals(returnCode) && !"460000".equals(returnCode)){
					cancelRtnCode = returnCode;
					cancelRtnMsg = returnMsg;
					break;
				}
				curOfferEffTime = result.getString("OUT_DATA.CurMOfferEffTime");
				curOfferExpTime = result.getString("OUT_DATA.CurMOfferExpTime");
				nextMOfferId = result.getString("OUT_DATA.NextMOfferId");
				nextMOfferName = result.getString("OUT_DATA.NextMOfferId");
				nextOfferEffTime = result.getString("OUT_DATA.NextMOfferEffTime");
				nextOfferExpTime = result.getString("OUT_DATA.NextMOfferExpTime");
				List instList = result.getList("OUT_DATA.INST_INFO");
				if(!"N/A".equals(instList.get(0))){
					for(int i=0; i<instList.size(); i++){
						Map instMap =  MapBean.isMap(instList.get(i));
						String offerId = (String)instMap.get("OfferId");
						String instId = (String)instMap.get("InsiId");
						System.out.println("---------feeinfo----------sProdMCancleWS_XML----------offerId----------" + offerId);
						System.out.println("---------feeinfo----------sProdMCancleWS_XML----------instId----------" + instId);
						if(priFeeCode.equals(offerId)){
							cProdnstId = instId;
						}
					}
				}
				if(!"".equals(modeCode)&&null!=modeCode&&!"null".equals(modeCode)){
				%>
					<s:service name="s1270Must">
						<s:param name="ROOT">
						 		<s:param name="LoginAccept" type="string" value="" />
								<s:param name="ChnSource" type="string" value="01" />
						   		<s:param name="OpCode" type="string" value="g796" />
								<s:param name="LoginNo" type="string" value="<%=loginNo %>" />
								<s:param name="LoginPwd" type="string" value="<%=password %>" />
								<s:param name="PhoneNo" type="string" value="" />
								<s:param name="UserPwd" type="string" value="" />
								<s:param name="LoginRight" type="string" value="<%=powerRight %>" />
								<s:param name="IdNo" type="string" value="<%=idNo %>" />
								<s:param name="OldMode" type="string" value="<%=modeCode %>" />
								<s:param name="NewMode" type="string" value="<%=nextMOfferId%>" />
								<s:param name="BelongCode" type="string" value="<%=belongCode %>" />
						</s:param>
					</s:service>				
				<%
				String returnCode1 = result.getString("RETURN_CODE");
				String returnMsg1 = result.getString("RETURN_MSG");
				System.out.println("========================returnCode1=======returnCode1==========returnCode1========returnCode1======================================"+returnCode1);
				if(!"000000".equals(returnCode1)){
					cancelRtnCode = returnCode;
					cancelRtnMsg = returnMsg;
					codeTemp = returnCode1;
					msgTemp = returnMsg1;
					break;
				}
				List feeExts = result.getList("OUT_DATA.BUSI_INFO");
				if(!"N/A".equals(feeExts.get(0))){
					data = new String[feeExts.size()][16];
					extFeeMemberList.add(memPhoneNo);
					for(int i=0; i<feeExts.size(); i++){
						Map feeExtMap = MapBean.isMap(feeExts.get(i));
						String code = feeExtMap.get("mode_code")== null?"":(String)feeExtMap.get("mode_code");
						String name = feeExtMap.get("ModeName")== null?"":(String)feeExtMap.get("ModeName");
						String choiced = feeExtMap.get("ModeChoiced")== null?"":(String)feeExtMap.get("ModeChoiced");
						String choicedStr = feeExtMap.get("ModeChoicedName")== null?"":(String)feeExtMap.get("ModeChoicedName");
						String sendFlag = feeExtMap.get("SendFlag")== null?"":(String)feeExtMap.get("SendFlag");
						String sendFlagStr = feeExtMap.get("SendFlagName")== null?"":(String)feeExtMap.get("SendFlagName");
						String modeTypeName = feeExtMap.get("ModeTypeName")== null?"":(String)feeExtMap.get("ModeTypeName");
						String statusStr = feeExtMap.get("ModeStatus")== null?"":(String)feeExtMap.get("ModeStatus");
						String instId = feeExtMap.get("login_accept")== null?"":(String)feeExtMap.get("login_accept");
						String start = feeExtMap.get("begin_time")== null?"":(String)feeExtMap.get("begin_time");
						String end= feeExtMap.get("end_time")== null?"":(String)feeExtMap.get("end_time");
						String XQFlag= feeExtMap.get("XQFlag")== null?"":(String)feeExtMap.get("XQFlag");
						String XQInfo= feeExtMap.get("XQInfo")== null?"":(String)feeExtMap.get("XQInfo");
						System.out.println("+++++++++++++++++++++++++code++++++++++++++++++"+code);
						System.out.println("+++++++++++++++++++++++++name++++++++++++++++++"+name);
						System.out.println("+++++++++++++++++++++++++choiced++++++++++++++++++"+choiced);
						System.out.println("+++++++++++++++++++++++++choicedStr++++++++++++++++++"+choicedStr);
						System.out.println("+++++++++++++++++++++++++sendFlag++++++++++++++++++"+sendFlag);
						System.out.println("+++++++++++++++++++++++++sendFlagStr++++++++++++++++++"+sendFlagStr);
						System.out.println("+++++++++++++++++++++++++modeTypeName++++++++++++++++++"+modeTypeName);
						System.out.println("+++++++++++++++++++++++++statusStr++++++++++++"+statusStr);
						System.out.println("+++++++++++++++++++++++++instId++++++++++++++++++"+instId);
						System.out.println("+++++++++++++++++++++++++start++++++++++++++++++"+start);
						System.out.println("+++++++++++++++++++++++++end++++++++++++++++++"+end);
						System.out.println("+++++++++++++++++++++++++XQFlag++++++++++++++++++"+XQFlag);		
						System.out.println("+++++++++++++++++++++++++XQInfo++++++++++++++++++"+XQInfo);	
						String statusShowStr = "未开通";
						String checkedHtml = "";
						if("Y".equals(statusStr)){
							statusShowStr = "已开通";
							statusStr = "A";
						}else{
							statusStr = "X";
						}
						if("0".equals(choiced)||"1".equals(choiced)||"4".equals(choiced)){
							checkedHtml = "checked";
						}
						if("2".equals(choiced)||"9".equals(choiced)){
							checkedHtml = "checked onclick='return false'";
						}
						if("a".equals(choiced)||"b".equals(choiced)||"d".equals(choiced)){
							checkedHtml = "onclick='return false'";
						}
						data[i][0] = code;//编码
						data[i][1] = name;//名称
						data[i][2] = choiced;//可选方式
						data[i][3] = choicedStr;//可选方式展现
						data[i][4] = sendFlag;//生效方式
						data[i][5] = sendFlagStr;//生效方式展现
						data[i][6] = modeTypeName;//套餐类别
						data[i][7] = statusStr;//开通状态
						data[i][8] = instId;//实例
						data[i][9] = start;//开始时间
						data[i][10] = end;//结束时间
						data[i][11] = statusShowStr;//开通状态展现
						data[i][12] = checkedHtml;//选择状态
						data[i][13] = instId+"#"+code+"#"+name+"#"+sendFlag+"#"+statusStr+"#"+start+"#"+end;
						data[i][14] = XQFlag;//可选资费下小区资费标识
						data[i][15] = XQInfo;//可选资费下小区资费列表
						System.out.println("---------feeinfo----------正常取消----------可选----------" + data[i][13]);
						System.out.println("---------feeinfo----------正常取消----------可选----------" + data[i][14]);
						System.out.println("---------feeinfo----------正常取消----------可选----------" + data[i][15]);
					}
				}
			}
			}
			idNoTemp += idNo + split;
			custIdTemp += custId + split;
			brandIdTemp += brandId + split;
			groupIdTemp += memgroupId + split;
			phoneNoTemp += memPhoneNo + split;
			phoneTypeTemp += phoneType + split;
			priFeeCodeTemp += priFeeCode + split;
			priFeeNameTemp += priFeeName + split;
			priFeeValidTemp += priFeeValid + split;
			distriFeeCodeTemp += distriFeeCode + split;
			distriFeeNameTemp += distriFeeName + split;
			CProdInstIdTemp += cProdnstId + split;
			nextOfferInstIdTemp += nextOfferInstId + split;
			CurMOfferEffTimeTemp += curOfferEffTime + split;
			CurMOfferExpTimeTemp += curOfferExpTime + split;
			NextMOfferIdTemp += nextMOfferId + split;
			NextMOfferNameTemp += nextMOfferName + split;
			NextMOfferEffTimeTemp += nextOfferEffTime + split;
			NextMOfferExpTimeTemp += nextOfferExpTime + split;
			System.out.println("---------priFeeOperateTypeTemp--------------------" + priFeeOperateTypeTemp);
%>
	<div id="Operation_Table">
		<div class="title">
			<div class="text">主资费</div>
		</div>
		<div class="input">
			<table>
				<tr>
					<th>主资费编码</th>
					<td><%=priFeeCode %></td>
					<th>主资费名称</th>
					<td><%=priFeeName %></td>
					<th>
					<%if("0".equals(phoneType)){%>主卡手机号码<%}else{ %>成员手机号码<%} %>
					</th>
					<td><%=memPhoneNo %></td>
				</tr>
				<tr>
					<th>小区资费编码</th>
					<td><%=distriFeeCode %></td>
					<th>小区资费名称</th>
					<td><%=distriFeeName %></td>
					<th></th><td></td>
				</tr>
				<tr>
					<th>新主资费编码</th>
					<td><%=nextMOfferId%></td>
					<th>新主资费名称</th>
					<td><%=nextMOfferName%></td>
					<th></th><td></td>
				</tr>
			</table>
		</div>
		<div class="title">
			<div class="text">套餐信息</div>
		</div>
		<div class="input">
			<table id="table_feeExt_<%=memPhoneNo %>">
				<tr>
					<th nowrap>选择</th>
					<th nowrap>可选套餐名称</th>
					<th nowrap>状态</th>
					<th nowrap>开始时间</th>
					<th nowrap>结束时间</th>
					<th nowrap>套餐类别</th>
					<th nowrap>生效方式</th>
					<th nowrap>可选方式</th>
					<th nowrap>小区代码选择</th>
					<th nowrap>手机号码</th>				
				</tr>
				<%if(data != null){
					for(int i=0; i< data.length; i++){ 
						String[] extData = data[i];
						if(extData[0] == null)continue;%>
						<tr>
							<td>
								<input type='checkbox' value='<%=extData[13]%>' <%=extData[12] %>/>
							</td>
							<td><%=extData[1]%></td>
							<td><%=extData[11]%></td>
							<td><%=extData[9]%></td>
							<td><%=extData[10]%></td>
							<td><%=extData[6]%></td>
							<td><%=extData[5]%></td>
							<td><%=extData[3]%></td>
							<!-- 判断 extData[14],如果小区标识为Y，则有小区资费，则展示select列表，否则为N，无列表不展示 -->
							<%
							if("Y".equals(extData[14])){
							   String[] infoArr = extData[15].split(",");
							   %>
							   <td width="25%">
							   		<select style=''WIDTH: 50px' id='R13_<%=extData[0]%>' name='R13_<%=extData[0]%>'>
							   		<!-- width="25%"><select style="WIDTH: 50px"  -->
							   <%
							   for(int m=0;m<infoArr.length;m++){
									String[] info = infoArr[m].split("~");
									System.out.println("+++++++++++info[0]="+info[0]);
									System.out.println("+++++++++++++info[1]="+info[1]);
								%>
										<option value='<%=infoArr[m] %>' ><%=infoArr[m] %></option>
									
								<%
								}
							   %>
							   		</select>
								</td>
							   <%
							}else{
							%>
								<td><a >无</a>
								    <input type='hidden' id='R13_<%=extData[0]%>' name='R13_<%=extData[0]%>' value=''></input>
								</td>
							<%
							}
							%>
					
							<td><%=memPhoneNo %></td>
						</tr>
					<%} 
				  }%>
			</table>
		</div>	
	</div>		
<%			
		}
	}
		
%>
