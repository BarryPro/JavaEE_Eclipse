
<%
	/*
	 * ���ܣ� ���·���ѡ��ҳ��
	 * �汾�� v1.0
	 * ���ڣ� 2009-12-30
	 */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="java.util.*"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%
	String xml = request.getParameter("assispecialfunds");
	String phoneNo = request.getParameter("phoneNo");
	System.out.println("specialfunds=xml===AAAAAAAAAAAAAAAAAAAAAA====" + xml);
 	MapBean mb = new MapBean();
 %>	
 <%@ include file="getMapBean.jsp"%>
 <%	
	List fundsList = null;
	Iterator it =null;
	if(null!= mb){
		fundsList = mb.getList("OUT_DATA.H03.SPECIAL_FUNDS_LIST.SPECIAL_FUNDS_INFO");
		if(null!=fundsList)
			it =fundsList.iterator();
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
					 <div class="title">
						<div class="text">
							����ר����ϸ��Ϣ
						</div>
					</div>
					<div class="input">
					<table>
					<%
						java.text.SimpleDateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd");
						java.text.SimpleDateFormat df2 = new java.text.SimpleDateFormat("yyyy-MM-dd");
						
						
						String meansId = request.getParameter("meansId");
						int i =0;
						if(null!=it){
						while(it.hasNext()){
						Map stMap = mb.isMap(it.next());
						if(null==stMap)continue;
					
						++i;
						String stagesIndex = (String)stMap.get("INDEX");
						String payType = (String)stMap.get("PAY_TYPE") == null ? "":(String)stMap.get("PAY_TYPE");
						String payMoney = (String)stMap.get("PAY_MONEY") == null ? "":(String)stMap.get("PAY_MONEY");
						String validFlag = (String)stMap.get("VALID_FLAG") == null ?"":(String)stMap.get("VALID_FLAG");
						String comsumeTime = (String)stMap.get("CONSUME_TIME") == null ? "" : (String)stMap.get("CONSUME_TIME");
						String startTime = (String)stMap.get("START_TIME") == null ? "" : (String)stMap.get("START_TIME");
						String returnType = (String)stMap.get("RETURN_TYPE") == null ? "" : (String)stMap.get("RETURN_TYPE");
						String returnClass = (String)stMap.get("RETURN_CLASS") == null ? "" : (String)stMap.get("RETURN_CLASS");
						String ALLOW_PAY = (String)stMap.get("ALLOW_PAY") == null ? "" : (String)stMap.get("ALLOW_PAY");
						System.out.println("startTime==============" + startTime);
						System.out.println("validFlag==============" + validFlag);
						System.out.println("returnType==============" + returnType);
						System.out.println("returnClass==============" + returnClass);
						System.out.println("ALLOW_PAY==============" + ALLOW_PAY);
						System.out.println("CONSUME_TIME==============" + comsumeTime);
					 %>
							<tr>
								
								<th>
									ר������
								</th>
								
								<td id="payType<%=i%>">
									<%= payType%>		
								<input type="hidden" id="returnType<%=i%>" value="<%=returnType%>"/>
								<input type="hidden" id="returnClass<%=i%>" value="<%=returnClass%>"/>
								<input type="hidden" id="ALLOW_PAY<%=i%>" value="<%=ALLOW_PAY%>"/>
								<input type="hidden" id="beginTime<%=i%>" value="<%=startTime%>"/>			
								</td>
								<th>�շѽ��</th>
								<td id="payMoney<%=i%>">
								<%= payMoney%>
								</td>
							</tr>
							<tr>
								
								<th>ר����Ч��ʶ</th>
								<td>
								<%if("0".equals(validFlag)){
									out.print("������Ч");
								}else if("1".equals(validFlag)){
									out.print("������Ч");
								}else if("2".equals(validFlag)) out.print("�Զ���ʱ��");
								%>
								<input type="hidden" id="validFlag<%=i%>" value="<%=validFlag%>"/>
								</td> 
								<th>��������</th>
								<td id="comsumeTime<%=i%>">
								<%=comsumeTime%>
								</td>
								
							</tr>
							<tr>
								<th>������ʽ</th>
								<td>
								<%if("0".equals(returnType)){
									out.print("�Ԥ��");
								}else if("1".equals(returnType)){
									out.print("����Ԥ��");
								}
								%>
								</td> 
								<th>��������</th>
								<td>
								<%
								if("1".equals(returnClass)){
									out.print("���·����ۼ�");
								}else if("2".equals(returnClass)){
									out.print("���");
								}else if("3".equals(returnClass)){
									out.print("���·����ۼƼӲ��");
								}else if("4".equals(returnClass)){
									out.print("���·������ۼ�");
								}
								%>
								</td>
								
							</tr>
							<% if("2".equals(validFlag)){ %>
							<tr>
								
								<th>��ʼʱ��</th>
								<td>
										<%
										
										java.util.Calendar calendar =java.util.Calendar.getInstance();// �������� 
										String beginTime="";
								 if("2".equals(validFlag)){
								 		beginTime=startTime;
										out.print(startTime);
								}
								%>
								<input type="hidden" id="beginTime<%=i%>" value="<%=beginTime%>"/>
								</td>
								<td>
									<%
								//	String endTime="";
								//	calendar.setTime(df.parse(beginTime));
								//	calendar.set(java.util.Calendar.MONTH, calendar.get(java.util.Calendar.MONTH) +  (int)(Double.parseDouble(comsumeTime))); 
								//	calendar.add(Calendar.DATE, -1);
								//	endTime = df.format(calendar.getTime());// �����ʽ
								//	out.print(endTime);
									%>
							
									</td>
							</tr>
						<%}}
						}%>
						</table>
						<div class="title">
						<div class="text">
							�����ֻ�������֤
						</div>
						</div>
							<table>
									<tr>
										<th>�ֻ�����</th>
										<td>	<input type="text" name="assPhoneNo" id="assPhoneNo" value=""/>
													<input type="button" class="b_text" name="verify" id="verify" onclick="doVerify()" value="��֤"/>
													<font style="color:red"><b>*</b></font>
													<div id="td1" align="left">
										</td>
										<th>�ͻ�����</th>
										<td><input type="text" name="assName" readonly="true" id="assName" value=""/>
									</td>
									</tr>
							</table>
						</div>
					 
					</div>
					<div id="operation_button">
						<input type="button" class="b_foot"   value="ȷ��" id="btnSubmit"
							name="btnSubmit" onclick="btnRsSubmit()" />
						<input type="button" class="b_foot" value="�ر�" id="btnCancel"
							name="btnCancel" onclick="closeWin()" />
					</div>
				</div>
			</form>
		</div>
	</body>
	<script type="text/javascript">
	
$(document).ready(function(){
		var options = document.getElementsByName("stagesIndex");
			for(var i=0;i<options.length;i++){
					options[i].disabled = "";
				}
			});
var verify_flag=false;
function doVerify(){
		var assPhoneNo = trim($("#assPhoneNo").val());
		if( assPhoneNo == <%=phoneNo%>){
			showDialog('��������͸�������һ�£����޸ģ���',1);
			document.getElementById("assPhoneNo").focus();
			return false;
		}
		if(isTel(assPhoneNo)==false){
			showDialog('�ֻ���������',1);
			document.getElementById("assPhoneNo").focus();
			return false;
		}
		var myPacket = null;
		myPacket = new AJAXPacket("checkSphoneNo.jsp","���Ժ�...");
		myPacket.data.add("assPhoneNo",assPhoneNo);
		core.ajax.sendPacket(myPacket,doPhoneCat);
		myPacket =null;
}
function doPhoneCat(packet){
			var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
			var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
			var CUST_NAME = packet.data.findValueByName("CUST_NAME");
			var FLAG = packet.data.findValueByName("FLAG");
			if(trim(FLAG)=="0")
			{
				var td1 = document.getElementById("td1");
		 		td1.innerHTML=trim(RETURN_MSG);
		 		$("#assName").attr("readonly",true);
				$("#assPhoneNo").attr("readonly",true);
				$("#btnSubmit").attr("disabled",false);
				$("#assName").val(trim(CUST_NAME));
				verify_flag=true;//��֤�ɹ�

			}else if(trim(FLAG)=="1")
			{
				var td1 = document.getElementById("td1");
		 		td1.innerHTML=trim(RETURN_MSG);
				$("#btnSubmit").attr("disabled",true);
				verify_flag=false;//��֤ʧ��
			}	
}
function btnRsSubmit(){
		var phoneNo = trim($("#assPhoneNo").val());
		if(isTel(phoneNo)==false)
		{
			showDialog("��������֤�ֻ�����!",0);
			return false;
		}
		if(verify_flag){		
			var showAssiSpe = parent.document.getElementById("showAssiSpe<%=meansId%>").innerHTML;
			if(showAssiSpe.indexOf("������")>0){
				showAssiSpe = showAssiSpe.substring(0,showAssiSpe.length-17);
			}
			parent.document.getElementById("showAssiSpe<%=meansId%>").innerHTML = showAssiSpe+"����������Ϊ"+phoneNo;
			parent.assispecialPhoneData(phoneNo);
		}	
		parent.payType_Checkfuc();
		closeDivWin();
}
function isTel(v)
{
	var mobilePatrn = /^((\(\d{3}\))|(\d{3}\-))?1[3,5,8]\d{9}$/;
//	var phonePatrn = /^((\(\d{2,3}\))|(\d{2,3}\-))?(\(0\d{2,3}\)|(0\d{2,3}-))?[1-9]\d{6,7}(\-\d{1,4})?$/;
	if(mobilePatrn.exec(v)) {
		return true;
	} else {
		return false;
}
}
	function closeWin(){
		closeDivWin();
	}
	
	
	</script>
</html>