<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="java.util.*"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%
	String meansId = request.getParameter("meansId");
	String phoneNo = request.getParameter("phoneNo");
	String xml = request.getParameter("sysPay");
	System.out.println("sysPay_________" + xml);
 	MapBean mb = new MapBean();
 %>
 <%@ include file="getMapBean.jsp"%>
 <%
	Iterator it =null;
	
	List paylist = null;
	if(null != mb){
		paylist = mb.getList("OUT_DATA.H04.SYSTEM_PAY_LIST.SYSTEM_PAY_INFO");
		
		if(null!=paylist)
			it =paylist.iterator();
	}
	
	
 %>
<html>
	<head>
	<title></title>
	</head>
	<body>
		<div id="operation">
		<form method="post" name="frm4938" action="">
				<div id="operation_table">
						<%
						if(null!=it){
							int num = 1;
							while(it.hasNext()){
								
								Map stMap = mb.isMap(it.next());
								if(null==stMap) continue;
								//�Ƿ������н���
								String GET_WINNING=(String)stMap.get("GET_WINNING") == null?"":(String)stMap.get("GET_WINNING");
								//�н���
								String WINNING_RATE=(String)stMap.get("WINNING_RATE") == null?"":(String)stMap.get("WINNING_RATE");
								//ר������
								String PAY_TYPE=(String)stMap.get("PAY_TYPE") == null?"":(String)stMap.get("PAY_TYPE");
								//�����ܽ��
								String RETURN_MONEY=(String)stMap.get("RETURN_MONEY") == null?"":(String)stMap.get("RETURN_MONEY");
								//��������
								String RETURN_MONTH=(String)stMap.get("RETURN_MONTH") == null?"":(String)stMap.get("RETURN_MONTH");
								//�������
								String PER_MONTH_MONEY=(String)stMap.get("PER_MONTH_MONEY") == null?"":(String)stMap.get("PER_MONTH_MONEY");
								//�������
								String LIMIT_MONEY=(String)stMap.get("LIMIT_MONEY") == null?"":(String)stMap.get("LIMIT_MONEY");
								//��������
								String RETURN_TYPE=(String)stMap.get("RETURN_TYPE") == null?"":(String)stMap.get("RETURN_TYPE");//�������� :1 ���·����ۼ� 2���  3���·����ۼƼӲ�� 4 ���·������ۼ�
								//������ʽ
								String RETURN_CLASS=(String)stMap.get("RETURN_CLASS") == null?"":(String)stMap.get("RETURN_CLASS");//������ʽ: 0 �Ԥ�� 1 ����Ԥ��
								//��������
								String CONSUME_TIME=(String)stMap.get("CONSUME_TIME") == null?"":(String)stMap.get("CONSUME_TIME");//��������2012-02-29
								//ϵͳ��ֵ���
								String PAY_FLAG=(String)stMap.get("PAY_FLAG") == null?"":(String)stMap.get("PAY_FLAG");
								//��Ч��ʽ
								String VALID_FLAG = (String)stMap.get("VALID_FLAG") == null?"":(String)stMap.get("VALID_FLAG");
					 %>
						 <div class="title">
							<div class="text">
								ϵͳ��ֵ<%=num %>
							</div>
						</div>
						<div class="input">
						 <table>
							<tr>
								<th>
									ר������
								</th>
								<td>
									<%= PAY_TYPE%>
									<input type="hidden" name = "PAY_TYPE"   value="<%=PAY_TYPE%>"/>					
								</td>
								<th>�����ܽ��</th>
								<td>
								   <%=RETURN_MONEY%>
								   <input type="hidden" name = "RETURN_MONEY"  value="<%=RETURN_MONEY%>"/>
								</td>
							</tr>
							<tr>
								<th>ÿ�·������</th>
								<td>
								 <%=PER_MONTH_MONEY%>
								 <input type="hidden" name = "PER_MONTH_MONEY"  value="<%=PER_MONTH_MONEY%>"/>
								</td>
								<th>��������</th>
								<td>
								<%if("1".equals(RETURN_CLASS)){
								out.print("���·����ۼ�");
								}else if("2".equals(RETURN_CLASS)){
								out.print("���");
								}else if("3".equals(RETURN_CLASS)){  
								out.print("���·����ۼƼӲ��");
								}else if("4".equals(RETURN_CLASS)){
								out.print("���·������ۼ�");
								} 
								%>
								<input type="hidden" name = "RETURN_CLASS"  value="<%=RETURN_CLASS%>"/>
								</td>
							</tr>
							<tr>
								<th>������ʽ</th>
								<td>
								<%if("0".equals(RETURN_TYPE)){
								out.print("�Ԥ��");
								}else{
								out.print("����Ԥ��");
								}
								%>
								<input type="hidden" name = "RETURN_TYPE"  value="<%=RETURN_TYPE%>"/>
								</td>
								<th>��������</th>
								<td>
								<%=RETURN_MONTH%>
								<input type="hidden" name = "RETURN_MONTH"  value="<%=RETURN_MONTH%>"/>
								</td>
							</tr>
							<tr>
								<th>�������</th>
								<td>
								<%=LIMIT_MONEY%>
								<input type="hidden" name = "LIMIT_MONEY"  value="<%=LIMIT_MONEY%>"/>
								</td>
								<th>ϵͳ��ֵר�����ʱ��</th>
								<td>
								<%=CONSUME_TIME%>
								<input type="hidden" name = "CONSUME_TIME"  value="<%=CONSUME_TIME%>"/>
								</td>
							</tr>
							<tr>
								<th>�Ƿ������н���</th>
								<td>
								<%if("0".equals(GET_WINNING)){
								 out.print("��");
								}else if("1".equals(GET_WINNING)){
								 out.print("��");
								} %>
								<input type="hidden" name = "GET_WINNING"  value="<%=GET_WINNING%>"/>
								</td>
								<th>�н���</th>
								<td>
								<%=WINNING_RATE%>
								<input type="hidden" name = "WINNING_RATE"  value="<%=WINNING_RATE%>"/>
								</td>
							</tr>
							<tr>
								<th>ϵͳ��ֵ���</th>
								<td>
								<%if("0".equals(PAY_FLAG) || "".equals(PAY_FLAG)){
								 out.print("����");
								}else if("1".equals(PAY_FLAG)){
								 out.print("����");
								} else if("2".equals(PAY_FLAG)){
								 out.print("�����͸���");
								} %>
								<input type="hidden" name = "PAY_FLAG"  value="<%=PAY_FLAG%>"/>
								</td>
								<th>
									����ʱ��
								</th>
								<td id="opr_date">
									<%
									java.text.SimpleDateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd");
									out.println(df.format(new java.util.Date()));
									%>
								</td>
								<input type="hidden" name = "verify_flag" id="verify_flag<%=num%>" value="0"/>
							</tr>
							<%if("1".equals(PAY_FLAG) || "2".equals(PAY_FLAG)){ %>
							<tr>
								<th>��������</th>
								<td>	<input type="text" name="assPhoneNo" id="assPhoneNo<%=num%>" value=""/>
											<input type="button" class="b_text" name="verify" id="verify<%=num%>" onclick="doVerify('<%=num%>')" value="��֤"/>
											<font style="color:red"><b>*</b></font>
											<div id="td1<%=num%>" align="left">
								</td>
								<th>��������</th>
								<td>	<input type="password" name="assPassWord" id="assPassWord<%=num %>" value=""/>
											<input type="button" class="b_text" name="verify" id="verify<%=num%>" onclick="doVerify('<%=num%>')" value="��֤"/>
											<div id="td2<%=num%>" align="left">
								</td>
							</tr>
							<tr>
								<th>�ͻ�����</th>
								<td><input type="text" name="assName" readonly="true" id="assName<%=num%>" value=""/>
								</td>
							
							<%}else{ %>
							  <input type="hidden" name="assPhoneNo" id="assPhoneNo<%=num%>" value=""/>
							<% } %>
							<tr>
								<th>��Ч��ʽ</th>
								<td>
								<%if("0".equals(VALID_FLAG)){
								 out.print("������Ч");
								}else if("1".equals(VALID_FLAG)){
								 out.print("������Ч");
								} else if("2".equals(VALID_FLAG)){
								 out.print("�Զ���ʱ��");
								} else if("4".equals(VALID_FLAG)){
								 out.print("���µ������Ч");
								} %>
								<input type="hidden" name = "VALID_FLAG"  value="<%=VALID_FLAG%>"/>
								</td>
							</tr>  
						  </table>
						</div>
						<%	 
						    num++;
						  }
						}%>
					<div id="operation_button">
						<input type="button" class="b_foot"   value="ȷ��" id="btnSubmit"
							name="btnSubmit" onclick="btnRsSubmit()" />
						<input type="button" class="b_foot" value="�ر�" id="btnCancel"
							name="btnCancel" onclick="closeWin()" />
					</div>
			</form>
		</div>
	</body>
	<script type="text/javascript">

	function closeWin(){
		closeDivWin();
	}

function doVerify(num){
		
		var assPhoneNo = trim($("#assPhoneNo"+num).val());
		var assPhoneNo_sub = assPhoneNo.substring(0,2);
		var mainPhone = <%=phoneNo%>+"";
		var myPacket = null;
		var phoneNo_sub = mainPhone.substring(0,2);
		var assPassWord = trim($("#assPassWord"+num).val());
		if("20" == phoneNo_sub){
			myPacket = new AJAXPacket("checkMphoneNo.jsp","���Ժ�...");
			myPacket.data.add("phoneNoB",assPhoneNo);
			myPacket.data.add("phoneNo",mainPhone);
			myPacket.data.add("num",num);
			myPacket.data.add("assPassWord",assPassWord);
			core.ajax.sendPacket(myPacket,checkPhoneNo);
			myPacket =null;
		}else{
			if( assPhoneNo == <%=phoneNo%>){
				showDialog('��������͸�������һ�£����޸ģ���',1);
				document.getElementById("assPhoneNo"+num).focus();
				return false;
			}
			/* if(isTel(assPhoneNo)==false ){
				showDialog('�ֻ���������',1);
				document.getElementById("assPhoneNo"+num).focus();
				return false;
		    } */
			myPacket = new AJAXPacket("checkSphoneNo.jsp","���Ժ�...");
			myPacket.data.add("assPhoneNo",assPhoneNo);
			myPacket.data.add("num",num);
			myPacket.data.add("phoneNo",mainPhone);
			myPacket.data.add("assPassWord",assPassWord);
			core.ajax.sendPacket(myPacket,doPhoneCat);
			myPacket =null;
		}
		
		//����У��
		/* if("20" == assPhoneNo_sub){
			myPacket = new AJAXPacket("checkMphoneNo.jsp","���Ժ�...");
			myPacket.data.add("phoneNoB",assPhoneNo);
			myPacket.data.add("phoneNo",mainPhone);
			myPacket.data.add("assPassWord",assPassWord);
			myPacket.data.add("num",num);
			core.ajax.sendPacket(myPacket,checkPhoneNo);
			myPacket =null;
		}else{
			myPacket = new AJAXPacket("checkSphoneNo.jsp","���Ժ�...");
			myPacket.data.add("assPhoneNo",assPhoneNo);
			myPacket.data.add("assPassWord",assPassWord);
			myPacket.data.add("num",num);
			myPacket.data.add("phoneNo",mainPhone);
			core.ajax.sendPacket(myPacket,doPhoneCat);
			myPacket =null;
		} */
		
}
function checkPhoneNo(packet){
			var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
			var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
			var CUST_NAME = packet.data.findValueByName("CUST_NAME");
			var num = packet.data.findValueByName("num");
			$("#assName"+num).attr("readonly",true);
			$("#assName"+num).val(trim(CUST_NAME));
			$("#verify_flag"+num).val("1");
			if(RETURN_CODE != "000000"){
				showDialog(RETURN_MSG,1);
			   return false;
			}else{
				showDialog("��֤�ɹ�!",2);
			}
}

function doPhoneCat(packet){
			var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
			var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
			var CUST_NAME = packet.data.findValueByName("CUST_NAME");
			var FLAG = packet.data.findValueByName("FLAG");
			var num = packet.data.findValueByName("num");
			if(RETURN_CODE != "000000"){
				showDialog(RETURN_MSG,1);
			   //return false;
			}
			if(trim(FLAG)=="0")
			{
				var td1 = document.getElementById("td1"+num);
		 		td1.innerHTML=trim(RETURN_MSG);
		 		$("#assName"+num).attr("readonly",true);
				$("#assPhoneNo"+num).attr("readonly",true);
				$("#assName"+num).val(trim(CUST_NAME));
				$("#verify_flag"+num).val("1");
			}else if(trim(FLAG)=="1")
			{
				var td1 = document.getElementById("td1");
		 		td1.innerHTML=trim(RETURN_MSG);
			}	
			
}
function btnRsSubmit(){

		var getWinningStr ="";
		var winningRateStr ="";
		var payTypeStr ="";
		var returnMoneyStr ="";
		var returnMonthStr ="";
		var perMonthMoneyStr ="";
		var limitMoneyStr ="";
		var returnTypeSTr ="";
		var returnClassStr ="";
		var consumeTimeStr ="";
		var payFlagStr ="";
		var assPhoneNoStr ="";
		var spSystemStr ="";//������ϵͳ��ֵ������sp����ʱ�д��ģ�Ĭ����"0"ƴ�Ĵ�
		var validFlagStr = "";
		
		var assPhoneNo  = document.getElementsByName("assPhoneNo");
		var payFlag  = document.getElementsByName("PAY_FLAG");
		var verifyFlag  = document.getElementsByName("verify_flag");
		
		for(var i=0;i<payFlag.length;i++){
			//alert("payFlag"+i+":"+payFlag[i].value+";assPhoneNo"+i+":"+assPhoneNo[i].value);
			if(payFlag[i].value!=0 && verifyFlag[i].value =="0" && (assPhoneNo[i].value==""|| isNaN(assPhoneNo[i].value)|| assPhoneNo[i].value.length!=11))
			{
				showDialog("������ĸ������������û�����븱�����룬��������֤����",0);
				return false;
			}
		}
//=====================================================================
		//�Ƿ������н���
		var GET_WINNING = document.getElementsByName("GET_WINNING");
		//�н���  
		var WINNING_RATE = document.getElementsByName("WINNING_RATE");
		//ר������
		var PAY_TYPE = document.getElementsByName("PAY_TYPE");
		//�����ܽ��
		var RETURN_MONEY = document.getElementsByName("RETURN_MONEY");
		//��������
		var RETURN_MONTH = document.getElementsByName("RETURN_MONTH");
		//�������
		var PER_MONTH_MONEY = document.getElementsByName("PER_MONTH_MONEY");
		//�������
		var LIMIT_MONEY = document.getElementsByName("LIMIT_MONEY");
		//��������
		var RETURN_TYPE = document.getElementsByName("RETURN_TYPE");
		//������ʽ
		var RETURN_CLASS = document.getElementsByName("RETURN_CLASS");
		//��������
		var CONSUME_TIME = document.getElementsByName("CONSUME_TIME");
		//ϵͳ��ֵ���
		var PAY_FLAG = document.getElementsByName("PAY_FLAG");
		//��Ч��ʽ
		var VALID_FLAG = document.getElementsByName("VALID_FLAG");
		
		for(var j =0;j<PAY_TYPE.length;j++){
			getWinningStr = getWinningStr +"#"+ GET_WINNING[j].value;
			winningRateStr = winningRateStr +"#"+ WINNING_RATE[j].value;
			payTypeStr = payTypeStr +"#"+ PAY_TYPE[j].value;
			returnMoneyStr = returnMoneyStr +"#"+ RETURN_MONEY[j].value;
			returnMonthStr = returnMonthStr +"#"+ RETURN_MONTH[j].value;
			perMonthMoneyStr = perMonthMoneyStr +"#"+ PER_MONTH_MONEY[j].value;
			limitMoneyStr = limitMoneyStr +"#"+ LIMIT_MONEY[j].value;
			returnTypeSTr = returnTypeSTr +"#"+ RETURN_TYPE[j].value;
			returnClassStr = returnClassStr +"#"+ RETURN_CLASS[j].value;
			consumeTimeStr = consumeTimeStr +"#"+ CONSUME_TIME[j].value;
			payFlagStr = payFlagStr +"#"+ PAY_FLAG[j].value;
			assPhoneNoStr = assPhoneNoStr +"#"+ assPhoneNo[j].value;
			spSystemStr =  spSystemStr + "#" + "0";
			validFlagStr = validFlagStr +"#"+VALID_FLAG[j].value;
		}
		getWinningStr = getWinningStr.substring(1,getWinningStr.length);
		winningRateStr = winningRateStr.substring(1,winningRateStr.length);
		payTypeStr = payTypeStr.substring(1,payTypeStr.length);
		returnMoneyStr = returnMoneyStr.substring(1,returnMoneyStr.length);
		returnMonthStr = returnMonthStr.substring(1,returnMonthStr.length);
		perMonthMoneyStr = perMonthMoneyStr.substring(1,perMonthMoneyStr.length);
		limitMoneyStr = limitMoneyStr.substring(1,limitMoneyStr.length);
		returnTypeSTr = returnTypeSTr.substring(1,returnTypeSTr.length);
		returnClassStr = returnClassStr.substring(1,returnClassStr.length);
		consumeTimeStr = consumeTimeStr.substring(1,consumeTimeStr.length);
		payFlagStr = payFlagStr.substring(1,payFlagStr.length);
		assPhoneNoStr = assPhoneNoStr.substring(1,assPhoneNoStr.length);
		spSystemStr = spSystemStr.substring(1,spSystemStr.length);
		validFlagStr = validFlagStr.substring(1,validFlagStr.length);
		
		//alert(payTypeStr);
		//alert(assPhoneNoStr);
//=======================================================================
		parent.addSystemPayData(getWinningStr,winningRateStr,payTypeStr,returnMoneyStr,returnMonthStr,perMonthMoneyStr,limitMoneyStr,returnTypeSTr,returnClassStr,consumeTimeStr,payFlagStr,assPhoneNoStr,spSystemStr,validFlagStr);	
		parent.viceSysPay_Checkfuc();
		closeDivWin();
		
}
function isTel(v)
{
	var mobilePatrn = /^((\(\d{3}\))|(\d{3}\-))?1[3,5,8]\d{9}$/;
	if(mobilePatrn.exec(v)) {
		return true;
	} else {
		return false;
	}
}
	
	
	</script>
</html>