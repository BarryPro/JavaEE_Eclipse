<%
  /* *********************
   * 功能: 家庭业务公共校验
   * 版本: 1.0
   * 日期: 2011/10/03
   * 作者: ningtn
   * 版权: si-tech
   * *********************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
		//liujian  变量
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		String opCode = request.getParameter("opCode") == null ? "":request.getParameter("opCode");
		String loginAccept = "";
		String sourcePhone = request.getParameter("sourcePhone") == null ? "":request.getParameter("sourcePhone");
		String sourcePwd = request.getParameter("sourcePwd") == null ? "":request.getParameter("sourcePwd");
		String famCode = request.getParameter("famCode") == null ? "":request.getParameter("famCode");
		String prodCode = request.getParameter("prodCode") == null ? "":request.getParameter("prodCode");
		String destPhone = request.getParameter("destPhone") == null ? "":request.getParameter("destPhone");
		System.out.println("-----liujian-----opCode=" + opCode);
		System.out.println("-----liujian-----sourcePhone=" + sourcePhone);
		System.out.println("-----liujian-----sourcePwd=" + sourcePwd);
		System.out.println("-----liujian-----famCode=" + famCode);
		System.out.println("-----liujian-----prodCode=" + prodCode);
		System.out.println("-----liujian-----destPhone=" + destPhone);
		
%>
		<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" 
		 	 routerValue="<%=regionCode%>"  id="seq"/>
<%
		loginAccept = seq;
%>
		<wtc:service name="sFamChgCheck" routerKey="region" 
			 routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="11">
			<wtc:param value="<%=loginAccept%>"/>
			<wtc:param value="01"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="<%=password%>"/>
			<wtc:param value="<%=sourcePhone%>"/>
			<wtc:param value="<%=sourcePwd%>"/>
			<wtc:param value="0"/>
			<wtc:param value="<%=famCode%>"/>
			<wtc:param value="<%=prodCode%>"/>
			<wtc:param value="<%=destPhone%>"/>
		</wtc:service>
		<wtc:array id="result" start="0" length="2" scope="end"/>
		<wtc:array id="result1" start="2" length="9" scope="end"/>

<%	
	System.out.println("-------liujian---------result.length=" + result.length);
	System.out.println("-------liujian---------result1.length=" + result1.length);
%>
		var response = new AJAXPacket();
		response.data.add("retcode","<%= retCode %>");
		response.data.add("retmsg","<%= retMsg %>");
<%	
	if(retCode.equals("000000")) {
%>	
		response.data.add("chgFlag","<%= result[0][0] %>");
<%		
		for(int i=0;i<result1.length;i++) {
				String phone_no_subordinate = result1[i][0];
				String business_id = result1[i][1];
				String exec_order = result1[i][2];
				String member_role_id = result1[i][3]; 
				String family_role = result1[i][4];
				String pay_type = result1[i][5];
				String family_role_name = result1[i][6];
				String newofferid = result1[i][7];
				String busitype = result1[i][8];
				System.out.println("-------liujian---------phone_no_subordinate=" + phone_no_subordinate);
				System.out.println("-------liujian---------business_id=" + business_id);
				System.out.println("-------liujian---------exec_order=" + exec_order);
				System.out.println("-------liujian---------member_role_id=" + member_role_id);
				System.out.println("-------liujian---------family_role=" + family_role);
				System.out.println("-------liujian---------pay_type=" + pay_type);
				System.out.println("-------liujian---------family_role_name=" + family_role_name);
				System.out.println("-------liujian---------newofferid=" + newofferid);
				System.out.println("-------liujian---------busitype=" + busitype);
				System.out.println("-------liujian---------------------------------------------------------");
%>
				var _flag = false;
				//TODO 暂时先不判断resulFamUsertArr中是否存在此phone
				//判断tempFamUserArray中是否存在此phone
				//存在的话，只添加规则对象
				//不存在的话，则添加FamUser对象
				//通过exec_order分组
				var exec_order =  '<%=exec_order%>';
				var busi = new Busi('<%=business_id%>','<%=exec_order%>','<%=newofferid%>','<%=busitype%>');
				for(var i=0,len=tempFamUserArray.length;i<len;i++) {
					var user = 	tempFamUserArray[i];
					//1. 通过手机号码查找
					if(user.phone_no_subordinate == '<%=phone_no_subordinate%>') {
						//2. 通过exec_order查找，有push；没有新建tempFamUser
						for(var j=0,len2=user.businesses.length;j<len2;j++) {
							var busiEl = user.businesses[j];
							if(busiEl.exec_order == exec_order) {
								_flag = true;
								user.length = parseInt(user.length) + 1;
								user.businesses.push(busi);
							}
							break;
						}
					}
				}
				
				if(!_flag) {
					var busiTempArr = new Array();
					busiTempArr.push(busi);
					tempFamUserArray.push(new FamUser('1',busiTempArr,'<%=phone_no_subordinate%>','<%=family_role%>','<%=family_role_name%>','<%=member_role_id%>','<%=pay_type%>'));
				}
				
				 
<%			
			}			
		}
%>
	core.ajax.receivePacket(response);