<%
	/*
	 * ���ܣ��û���Ϣչ�֣�Ӫ���ִ�У�
	 * �汾�� v1.0
	 * ���ڣ� 2010-02-26
	 */
%>
	<%
						/* �û���Ϣ*/
					%>
					<div class="title">
						<div class="text">
							�û���Ϣ
						</div>
						<div class="title_tu" >
							<input type="button" class="butClose" id="picUserMsg" value=""/>
						</div>
					</div>
					
					<div id="userMsgDiv" style="display:block">
						<div class="input">
							<%
									if (null == UserInfoMap){ 
										out.print("�û���Ϣ������!");
									}else{
									java.text.NumberFormat  formater  =  java.text.DecimalFormat.getInstance();  
								  	formater.setMaximumFractionDigits(2);  
								  	formater.setMinimumFractionDigits(2); 
										//5.ҵ��Ʒ��
									String sm_name = (String) UserInfoMap.get("ELEMENT5")==null?"":(String) UserInfoMap.get("ELEMENT5");
									//7.�ͻ�����
									cust_name = (String) UserInfoMap.get("ELEMENT7")==null?"":(String) UserInfoMap.get("ELEMENT7");
									//17 ֤������
									String id_type = (String) UserInfoMap.get("ELEMENT17")==null?"":(String) UserInfoMap.get("ELEMENT17");
									//18 ֤������
									String id_name = (String) UserInfoMap.get("ELEMENT18")==null?"":(String) UserInfoMap.get("ELEMENT18");
									//15 �ͻ���ַ
									String cust_address = (String) UserInfoMap.get("ELEMENT15")==null?"":(String) UserInfoMap.get("ELEMENT15");
									//10 ����״̬
									String run_name = (String) UserInfoMap.get("ELEMENT10")==null?"":(String) UserInfoMap.get("ELEMENT10");
									
									//32 ��ǰ���ʷ�
									mode_name = (String) UserInfoMap.get("ELEMENT32")==null?"":(String) UserInfoMap.get("ELEMENT32");
									//31 ��ǰ���ʷ�code
									mode_code =(String) UserInfoMap.get("ELEMENT31")==null?"":(String) UserInfoMap.get("ELEMENT31");
									//0 �û�ID
									id_no=(String) UserInfoMap.get("ELEMENT0")==null?"":(String) UserInfoMap.get("ELEMENT0");
									// 3 �û�����
									belong_code=(String) UserInfoMap.get("ELEMENT3")==null?"":(String) UserInfoMap.get("ELEMENT3");
									//25��ǰԤ���
									String totalPrepay = (String) UserInfoMap.get("ELEMENT25")==null?"":(String) UserInfoMap.get("ELEMENT25");
									//cust_id
									cust_id=(String) UserInfoMap.get("ELEMENT1")==null?"":(String) UserInfoMap.get("ELEMENT1");
									 //��ǰ����
									vCurPoint=(String) UserInfoMap.get("ELEMENT36")==null?"":(String) UserInfoMap.get("ELEMENT36");
									System.out.println("vCurPoint===================================="+vCurPoint);
									String Sname_Status=(String) UserInfoMap.get("ELEMENT37")==null?"":(String) UserInfoMap.get("ELEMENT37");
									System.out.println("Sname_Status=========ʵ����=============="+Sname_Status);
									//
									//	vip����,û��
									//	��ǰ����û��
							%>
								<table>
									<tr>
										<th>�ͻ�����</th>
										<td id="user_phone_no"><%=svcNum%></td>
										<th>�ͻ�����</th>
										<td id="user_cust_name"><%=cust_name%></td>
										<th>ҵ��Ʒ��</th>
										<td  id="user_sm_name"><%=sm_name%></td>
									</tr>
									<tr>
										<th>֤������</th>
										<td><%=id_type%></td>
										<%if(!"2".equals(accountType) ){%>
										<th>֤������</th>
										<td id="user_cardId_no"><%=id_name%></td>
										<th>�ͻ���ַ</th>
										<td id="user_cust_addr"><%=cust_address%></td>
										<%} %>
									</tr>
									<tr> 
										<th>����״̬</th>
										<td><%=run_name%></td>
										<th>�ʷ�����</th>
										<td><%=mode_name%></td>
										<th>VIP����</th>
										<td>��ʱ��</td>
									</tr>
										<tr>  		
											<th>��ǰԤ���</th>
											<td><%=formater.format(Double.parseDouble(totalPrepay))%></td>
											<th>��ǰ����</th>
											<td><%=vCurPoint%></td>
											<th>ʵ����״̬</th>
											<%if("��ʵ��".equals(Sname_Status)){ System.out.println(Sname_Status+"============Sname_Status");%>
											<td class="red" ><strong><%=Sname_Status%></strong></td>
											<%}else{ System.out.println(Sname_Status+"============Sname_Status");%>
											<td ><%=Sname_Status%></td>
											<%} %>
									</tr>
								</table>
							<%}%>
						</div>
					</div>
						
					
					
					