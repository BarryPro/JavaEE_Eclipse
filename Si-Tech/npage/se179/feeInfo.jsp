<!-- --------���ʷѼ������ѡ�ʷ�------------ -->
<%
	String cancelRtnCode = "000000";
	String cancelRtnMsg = "";
	
	String codeTemp = "000000";
	String msgTemp = "";
	
	String idNoTemp = "";
	String custIdTemp = "";
	String brandIdTemp = "";//�û�Ʒ�ƴ�
	String groupIdTemp = "";
	String phoneNoTemp = "";//�ֻ����봮����������Ա
	String phoneTypeTemp = "";//�������ͣ���ʶ�������ǳ�Ա��P-�ֻ���Ա,B-����û�,T-TD�̻��û�,0-����
	String priFeeCodeTemp = "";//���ʷѴ��봮
	String priFeeNameTemp = "";//���ʷ����ƴ�
	String priFeeValidTemp = "";//���ʷ���Ч��ʶ��
	String distriFeeCodeTemp = "";//С���ʷѴ��봮
	String distriFeeNameTemp = "";//С���ʷ����ƴ�
	String CProdInstIdTemp = "";//�ʷ�ʵ�����봮
	String nextOfferInstIdTemp = "";//�¶����ʷ�instId �����ԤԼȡ����ʵ��id ����0
	String CurMOfferEffTimeTemp = "";//��ǰ�ʷ���Чʱ�䴮
	String CurMOfferExpTimeTemp = "";//��ǰ�ʷ�ʧЧʱ�� ��
	String NextMOfferIdTemp = "";//��һ���ʷѴ��봮
	String NextMOfferNameTemp = "";//��һ���ʷѴ������ƴ�
	String NextMOfferEffTimeTemp = "";//��һ���ʷ���Чʱ�䴮
	String NextMOfferExpTimeTemp = "";//��һ���ʷ�ʧЧʱ�䴮
	String priFeeOperateTypeTemp = "";//����ȡ����3 ԤԼ��2
	String nextFeeOperateTypeTemp = "";//��һ���ʷ���Ч��ʾ ������1 ԤԼ��2

	List extFeeMemberList = new ArrayList();//���ʷ������ʷ��û��б�			
	if("T".equals(showPriFee)){
		System.out.println("---------feeinfo----------priFee----------priFeeList.size()----------" + priFeeList.size());
		for(int t=0;t<priFeeList.size();t++ ){
			System.out.println("---------feeinfo----------priFee----------priFeeList----------" + priFeeList.get(t));
			Map priFeeMap = MapBean.isMap(priFeeList.get(t));
			String phoneType = (String)priFeeMap.get("PHONE_TYPE");
			String memPhoneNo = (String)priFeeMap.get("PHONE_NO");
			//���ʷ�
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
		 	String cProdnstId = "";//�ʷ�ʵ��
		 	String nextOfferInstId = "";
		 	//�û���Ϣ
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
			//--------------------------------------------------ȡ�û���Ϣ--------------------------------------------------
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
				cancelRtnMsg = "ȡ�û���Ϣʧ�ܣ�";
			}
			System.out.println("---------feeinfo----------sMKTGetUsrInf----------memPhoneNo----------" + memPhoneNo);
			System.out.println("---------feeinfo----------sMKTGetUsrInf----------idNo----------" + idNo);
			System.out.println("---------feeinfo----------sMKTGetUsrInf----------belongCode----------" + belongCode);
			System.out.println("---------feeinfo----------sMKTGetUsrInf----------custId----------" + custId);
			System.out.println("---------feeinfo----------sMKTGetUsrInf----------modeCode----------" + modeCode);
			//��ѡ�ʷѱ�����
			String[][] data = null;
			//--------------------------------------------------ԤԼȡ��--------------------------------------------------
			//ԤԼ�ʷѵ�ȡ����һ�ֻ�ԭ���߼� ���Կ������� ��ԭ���ʷѣ��ڶ���ʱԤԼ�˶��ˣ�����ʧЧʱ�仹ԭ��ȥ ��ԤԼ�������ʷѵĿ�ʼ����ʱ�����Ϊnow
			//��Ϊ��ҵ��ԭ�� �����ڲ��Էǿ����Ա��ԤԼ�ʷ�ȡ�� ������������߼�ֻ��Կ�������� ���� ���� ����  ������������һ����ɣ�Ĺ��°ɡ���
			//ԤԼȡ���߼��� ������ԤԼ�ʷ� ���¿�ʼ�ͽ���ʱ��Ϊsysdate
			//               ����ʱ�˶��ľ��ʷ� ���¿�ʼʱ��ͽ���ʱ��Ϊ���񷵻�ʱ��
			//               ����ʱѡ��Ŀ�ѡ�ʷ� ����ʽͬ������ԤԼ�ʷ�
			//               ����ʱ�˶��Ŀ�ѡ�ʷ� ����ʽͬ����ʱ�˶��ľ��ʷ�
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
						//�ʷ�ʵ������������ ������Ѿ����ڣ���ô��ȡ�����ıض��Ǿ��ʷ� Ҳ����Ҫ��������ԭ�����ʷ�
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
				//��ѡ�ʷ�
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
						String choicedStr = "ԤԼ��";
						String sendFlagStr = "���ԤԼ";
						String modeTypeName = "-";
						//ԤԼ���������˶�
						String start = today;
						String end = today;
						String checkedHtml = "onclick='return false'";
						String statusShowStr = "ԤԼ��ͨ";
						if("X".equals(statusStr)){//ԤԼȡ����������
							start = nextOfferEffTime;
							end = nextOfferExpTime;
							statusShowStr = "ԤԼȡ��";
							checkedHtml = "checked onclick='return false'";
						}
						data[i][0] = code;//����
						data[i][1] = name;//����
						data[i][2] = "";//��ѡ��ʽ
						data[i][3] = choicedStr;//��ѡ��ʽչ��
						data[i][4] = valid;//��Ч��ʽ
						data[i][5] = sendFlagStr;//��Ч��ʽչ��
						data[i][6] = modeTypeName;//�ײ����
						data[i][7] = statusStr;//��ͨ״̬
						data[i][8] = instId;//ʵ��
						data[i][9] = start;//��ʼʱ��
						data[i][10] = end;//����ʱ��
						data[i][11] = statusShowStr;//��ͨ״̬չ��
						data[i][12] = checkedHtml;//ѡ��״̬
						data[i][13] = instId+"#"+code+"#"+name+"#"+valid+"#"+statusStr+"#"+start+"#"+end;
						System.out.println("---------feeinfo----------ԤԼȡ��----------��ѡ----------" + data[i][13]);
					}
				}
			}
			//--------------------------------------------------����ȡ��--------------------------------------------------
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
						String statusShowStr = "δ��ͨ";
						String checkedHtml = "";
						if("Y".equals(statusStr)){
							statusShowStr = "�ѿ�ͨ";
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
						data[i][0] = code;//����
						data[i][1] = name;//����
						data[i][2] = choiced;//��ѡ��ʽ
						data[i][3] = choicedStr;//��ѡ��ʽչ��
						data[i][4] = sendFlag;//��Ч��ʽ
						data[i][5] = sendFlagStr;//��Ч��ʽչ��
						data[i][6] = modeTypeName;//�ײ����
						data[i][7] = statusStr;//��ͨ״̬
						data[i][8] = instId;//ʵ��
						data[i][9] = start;//��ʼʱ��
						data[i][10] = end;//����ʱ��
						data[i][11] = statusShowStr;//��ͨ״̬չ��
						data[i][12] = checkedHtml;//ѡ��״̬
						data[i][13] = instId+"#"+code+"#"+name+"#"+sendFlag+"#"+statusStr+"#"+start+"#"+end;
						data[i][14] = XQFlag;//��ѡ�ʷ���С���ʷѱ�ʶ
						data[i][15] = XQInfo;//��ѡ�ʷ���С���ʷ��б�
						System.out.println("---------feeinfo----------����ȡ��----------��ѡ----------" + data[i][13]);
						System.out.println("---------feeinfo----------����ȡ��----------��ѡ----------" + data[i][14]);
						System.out.println("---------feeinfo----------����ȡ��----------��ѡ----------" + data[i][15]);
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
			<div class="text">���ʷ�</div>
		</div>
		<div class="input">
			<table>
				<tr>
					<th>���ʷѱ���</th>
					<td><%=priFeeCode %></td>
					<th>���ʷ�����</th>
					<td><%=priFeeName %></td>
					<th>
					<%if("0".equals(phoneType)){%>�����ֻ�����<%}else{ %>��Ա�ֻ�����<%} %>
					</th>
					<td><%=memPhoneNo %></td>
				</tr>
				<tr>
					<th>С���ʷѱ���</th>
					<td><%=distriFeeCode %></td>
					<th>С���ʷ�����</th>
					<td><%=distriFeeName %></td>
					<th></th><td></td>
				</tr>
				<tr>
					<th>�����ʷѱ���</th>
					<td><%=nextMOfferId%></td>
					<th>�����ʷ�����</th>
					<td><%=nextMOfferName%></td>
					<th></th><td></td>
				</tr>
			</table>
		</div>
		<div class="title">
			<div class="text">�ײ���Ϣ</div>
		</div>
		<div class="input">
			<table id="table_feeExt_<%=memPhoneNo %>">
				<tr>
					<th nowrap>ѡ��</th>
					<th nowrap>��ѡ�ײ�����</th>
					<th nowrap>״̬</th>
					<th nowrap>��ʼʱ��</th>
					<th nowrap>����ʱ��</th>
					<th nowrap>�ײ����</th>
					<th nowrap>��Ч��ʽ</th>
					<th nowrap>��ѡ��ʽ</th>
					<th nowrap>С������ѡ��</th>
					<th nowrap>�ֻ�����</th>				
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
							<!-- �ж� extData[14],���С����ʶΪY������С���ʷѣ���չʾselect�б�����ΪN�����б�չʾ -->
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
								<td><a >��</a>
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
