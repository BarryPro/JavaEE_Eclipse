<%
	/*
	 * 功能：用户信息展现（营销活动执行）
	 * 版本： v1.0
	 * 日期： 2010-02-26
	 */
%>
	<%
						/* 用户信息*/
					%>
					<div class="title">
						<div class="text">
							用户信息
						</div>
						<div class="title_tu" >
							<input type="button" class="butClose" id="picUserMsg" value=""/>
						</div>
					</div>
					
					<div id="userMsgDiv" style="display:block">
						<div class="input">
							<%
									if (null == UserInfoMap){ 
										out.print("用户信息不存在!");
									}else{
									java.text.NumberFormat  formater  =  java.text.DecimalFormat.getInstance();  
								  	formater.setMaximumFractionDigits(2);  
								  	formater.setMinimumFractionDigits(2); 
										//5.业务品牌
									String sm_name = (String) UserInfoMap.get("ELEMENT5")==null?"":(String) UserInfoMap.get("ELEMENT5");
									//7.客户名称
									cust_name = (String) UserInfoMap.get("ELEMENT7")==null?"":(String) UserInfoMap.get("ELEMENT7");
									//17 证件类型
									String id_type = (String) UserInfoMap.get("ELEMENT17")==null?"":(String) UserInfoMap.get("ELEMENT17");
									//18 证件号码
									String id_name = (String) UserInfoMap.get("ELEMENT18")==null?"":(String) UserInfoMap.get("ELEMENT18");
									//15 客户地址
									String cust_address = (String) UserInfoMap.get("ELEMENT15")==null?"":(String) UserInfoMap.get("ELEMENT15");
									//10 运行状态
									String run_name = (String) UserInfoMap.get("ELEMENT10")==null?"":(String) UserInfoMap.get("ELEMENT10");
									
									//32 当前主资费
									mode_name = (String) UserInfoMap.get("ELEMENT32")==null?"":(String) UserInfoMap.get("ELEMENT32");
									//31 当前主资费code
									mode_code =(String) UserInfoMap.get("ELEMENT31")==null?"":(String) UserInfoMap.get("ELEMENT31");
									//0 用户ID
									id_no=(String) UserInfoMap.get("ELEMENT0")==null?"":(String) UserInfoMap.get("ELEMENT0");
									// 3 用户归属
									belong_code=(String) UserInfoMap.get("ELEMENT3")==null?"":(String) UserInfoMap.get("ELEMENT3");
									//25当前预存款
									String totalPrepay = (String) UserInfoMap.get("ELEMENT25")==null?"":(String) UserInfoMap.get("ELEMENT25");
									//cust_id
									cust_id=(String) UserInfoMap.get("ELEMENT1")==null?"":(String) UserInfoMap.get("ELEMENT1");
									 //当前积分
									vCurPoint=(String) UserInfoMap.get("ELEMENT36")==null?"":(String) UserInfoMap.get("ELEMENT36");
									System.out.println("vCurPoint===================================="+vCurPoint);
									String Sname_Status=(String) UserInfoMap.get("ELEMENT37")==null?"":(String) UserInfoMap.get("ELEMENT37");
									System.out.println("Sname_Status=========实名制=============="+Sname_Status);
									//
									//	vip级别,没有
									//	当前积分没有
							%>
								<table>
									<tr>
										<th>客户号码</th>
										<td id="user_phone_no"><%=svcNum%></td>
										<th>客户名称</th>
										<td id="user_cust_name"><%=cust_name%></td>
										<th>业务品牌</th>
										<td  id="user_sm_name"><%=sm_name%></td>
									</tr>
									<tr>
										<th>证件类型</th>
										<td><%=id_type%></td>
										<%if(!"2".equals(accountType) ){%>
										<th>证件号码</th>
										<td id="user_cardId_no"><%=id_name%></td>
										<th>客户地址</th>
										<td id="user_cust_addr"><%=cust_address%></td>
										<%} %>
									</tr>
									<tr> 
										<th>运行状态</th>
										<td><%=run_name%></td>
										<th>资费名称</th>
										<td><%=mode_name%></td>
										<th>VIP级别</th>
										<td>暂时无</td>
									</tr>
										<tr>  		
											<th>当前预存款</th>
											<td><%=formater.format(Double.parseDouble(totalPrepay))%></td>
											<th>当前积分</th>
											<td><%=vCurPoint%></td>
											<th>实名制状态</th>
											<%if("非实名".equals(Sname_Status)){ System.out.println(Sname_Status+"============Sname_Status");%>
											<td class="red" ><strong><%=Sname_Status%></strong></td>
											<%}else{ System.out.println(Sname_Status+"============Sname_Status");%>
											<td ><%=Sname_Status%></td>
											<%} %>
									</tr>
								</table>
							<%}%>
						</div>
					</div>
						
					
					
					