<%
   /*
   * ����: �û�������Ϣ
�� * �汾: v1.0
�� * ����: 2008/10/18
�� * ����: ranlf
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸����� 2009-05-29     �޸���  libina     �޸�Ŀ��  ����Ԥ����Ƿ����ʾ����
   * �޸����� 2009-06-04     �޸���  libina     �޸�Ŀ��  �����а�ȫ��������Ϣ
   * �޸����� 2009-06-06     �޸���  libina     �޸�Ŀ��  �Ż�ҳ��
 ��*/
%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.net.InetAddress"%>
<%
    String callPhone = request.getParameter("callPhone");
    String contactId = request.getParameter("contactId");
		String cust_name       = "";
		String contact_address = "";
		String phone_no        = "";
		String card_name       = "";
		String product_name    = "";
		String town_name       = "";
		String run_name        = "";
		//double prepay_fee      = 0.0;
		String prepay_fee      ="";
		String sm_name         = "";
		String prepay_fee_flag ="";
		
		String workNo = (String)session.getAttribute("workNo");
		String password = (String)session.getAttribute("password");
%>



<%
// ���ִ��뿪ʼ by fangyuan 20090801
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String params = "callPhone="+callPhone;
	//System.out.println("regionCode = "+regionCode);
	String sqlcustmsg="select to_char(id_no) from dcustmsg where phone_no=:callPhone";
 // System.out.println("sqlcustmsg:="+sqlcustmsg);
%>

	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
	  <wtc:param value="<%=sqlcustmsg%>"/>
		<wtc:param value="<%=params%>"/>
	</wtc:service>
	<wtc:array id="fee" scope="end"/>		

<%
if(fee.length>0){
String idNo  = fee[0][0];//ID��
//System.out.println("------ idNo = "+idNo);


%>
	<wtc:service name="s1500Qry"  routerKey="region" routerValue="<%=regionCode%>" outnum="8">
		<wtc:param value="<%=callPhone%>"/>
		<wtc:param value="<%=idNo%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="1500"/>
		<wtc:param value="<%=password%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end" />


<%
//System.out.println("------ result.length = "+result.length);

	ArrayList  arlist = new ArrayList();    
	StringTokenizer resToken = null;
    int i = 0;
    for(int count = 0; count < 8; count++)
    {
			String value;
			for(resToken = new StringTokenizer(result[0][i], "|"); resToken.hasMoreElements(); arlist.add(value))
			{			
			  value = (String)resToken.nextElement();
			}
			i++;
    }
	
	String return_code = (String)arlist.get(0);
	String return_message = (String)arlist.get(1);
/*
System.out.println("------ return_code = "+return_code+" \treturn_message= "+return_message);

System.out.println("------cust_name = "+(String)arlist.get(3));
System.out.println("------contact_address = "+(String)arlist.get(16));
System.out.println("------card_name = "+(String)arlist.get(7));
System.out.println("------town_name = "+(String)arlist.get(4));
System.out.println("------run_name = "+(String)arlist.get(33));
System.out.println("------sm_name = "+(String)arlist.get(26));
System.out.println("------preFee = "+(String)arlist.get(49));
System.out.println("------prepay_fee_flag = "+(String)arlist.get(52));
*/

if (return_code.equals("000000")){

		cust_name      = (String)arlist.get(3)==null?"":(String)arlist.get(3);
		contact_address= (String)arlist.get(16)==null?"":(String)arlist.get(16);
	
		phone_no       = callPhone;
		card_name      = (String)arlist.get(7)==null?"":(String)arlist.get(7);
		product_name   = (String)arlist.get(37)==null?"":(String)arlist.get(37);
		town_name      = (String)arlist.get(4)==null?"":(String)arlist.get(4);
		run_name       = (String)arlist.get(33)==null?"":(String)arlist.get(33);		
		sm_name		     = (String)arlist.get(26)==null?"":(String)arlist.get(26);
		String preFee = (String)arlist.get(49);
		if (  preFee.length()==3 && preFee.substring(0,1).equals(".") ) { preFee = "0"+preFee;  }
		prepay_fee     = preFee;
		
		prepay_fee_flag = (String)arlist.get(52)==null?"":(String)arlist.get(52);
		
		
}
}
//���ִ������
%>




<div class="functitle">�û�������ˮ</div>
				<table>
					<tr>
						<td colspan="3" onclick="copyToClipBoard(this)"><%=contactId%></td>					
					</tr>
					<tr>
						<th >���к���</th>
						<td colspan="2" id="caller_phone_no" onclick="copyToClipBoard(this)"></td>
					</tr>
					<tr>
						<th >���к���</th>
						<td colspan="2" id="called_phone_no" onclick="copyToClipBoard(this)"></td>
					</tr>
					<tr>
						<th >������</th>
						<td colspan="2" id="town" onclick="copyToClipBoard(this)"><%=town_name%></td>
					</tr>	
					<tr>
						<th>�ͻ�����</th>
						<td colspan="2" onclick="copyToClipBoard(this)"><%=cust_name%></td>				
					</tr>
					<tr>
						<th>�ͻ�����</th>
						<td colspan="2" onclick="copyToClipBoard(this)"><%=card_name%></td>
					</tr>
					<tr>
						<th>�ͻ�Ʒ��</th>
						<td colspan="2" onclick="copyToClipBoard(this)"><%=null == sm_name?"" : sm_name%></td>
					</tr>
					<tr>
						<th>����ʽ</th>
						<td colspan="2" id="handleType" onclick="copyToClipBoard(this)">�绰����</td>
					</tr>
					<tr>
						<th>�������</th>
						<td colspan="2" onclick="copyToClipBoard(this)"><%=phone_no%></td>
					</tr>
					<tr id="handleNo_town_tr" style="display:none">
						<th>������</th>
						<td colspan="2" id="handleNo_town" onclick="copyToClipBoard(this)"></td>
					</tr>	
					<tr>
						<th>��ϵ��ַ</th>
						<td colspan="2" onclick="copyToClipBoard(this)"><%=contact_address%></td>
					</tr>
					<tr>
						<th nowrap >�Ʒ�����</th>
  	  			<td colspan="2" nowrap onclick="copyToClipBoard(this)"><%=product_name.trim()%></td>
					</tr>
					<tr>
						<th>����״̬</th>
						<td colspan="2" onclick="copyToClipBoard(this)"><%=run_name%></td>
					</tr>
					<tr>
						<th>Ԥ���</th>
						<td colspan="2" onclick="copyToClipBoard(this)"><%=prepay_fee%></td>
					</tr>
					<tr>
						<th>Ƿ�ѱ�־</th>
						<td colspan="2" onclick="copyToClipBoard(this)"><%=prepay_fee_flag%></td>
					</tr>
				</table>
				<div class="visitorFunc">
					<div class="functitle">������IP��<%=InetAddress.getLocalHost().getHostAddress()%></div>
					<!--
					<div class="functitle">��ǰ�ڴ棺<span id="par_curMem"></span>M</div>	
					--> 
					<!--
					<div class="functitle">����Ա���ù���</div>
					<a href="javascript:addTab(true,'a03','�ۺϲ�ѯ','childTab_call.jsp?parentOpCode=K170')">�ۺϲ�ѯ</a>
					<a href="javascript:addTab(true,'a04','ý���ѯ','childTab_call.jsp?parentOpCode=K180')">ý���ѯ</a>
					<a href="javascript:addTab(true,'a05','�Ӵ���¼','childTab_call.jsp?parentOpCode=K190')">�Ӵ���¼</a>
					<br />
					<a href="javascript:addTab(true,'a06','������ѯ','childTab_call.jsp?parentOpCode=K220')">������ѯ</a>
					<a href="javascript:addTab(true,'a07','�ʼ��ѯ','childTab_call.jsp?parentOpCode=K200')">�ʼ��ѯ</a>
					<a href="javascript:addTab(true,'a08','�ʼ쿼��','childTab_call.jsp?parentOpCode=K210')">�ʼ쿼��</a>
				-->
				</div>

<script language="javaScript">

//��ѯ���ĵ绰����
var searchPhoneNo = "<%=callPhone%>";
var callerNo = cCcommonTool.getCaller();
var calledNo = cCcommonTool.getCalled()

//alert('searchPhoneNo='+searchPhoneNo);
//alert('calledNo='+calledNo);
//�������������ͨ���û����벻ͬ(����/����)������������������
if(searchPhoneNo!=callerNo&&searchPhoneNo!=calledNo){
	//show el
	document.getElementById('handleNo_town_tr').style.display = 'block';
	//��չ��ѯ����������������������
	getLocationEx(searchPhoneNo,updateHandleNoRegion);
}

  var workMyNo=cCcommonTool.getWorkNo();
  var curState=0;
  /*
  if(parPhone.QueryAgentStatusEx(workMyNo)==0){
    curState=parPhone.AgentInfoEx_CurState;
  }
  */
  if(curState==5){
  	//20090311tancfȥ��ͨ����Ϣ
	//document.getElementById('contactingMsg').innerHTML="������ͻ���<%=cust_name%>ͨ��";
  }
  
  document.getElementById('caller_phone_no').innerHTML=cCcommonTool.getCaller();
  document.getElementById('called_phone_no').innerHTML=cCcommonTool.getCalled();
  document.getElementById('custName').value="<%=cust_name%>";
  cCcommonTool.setCallerUserName("<%=cust_name%>");
  if(cCcommonTool.getOp_code()=="K025"){
  	//20090312 fangyuan ����ʱ����ʽΪ�绰����
  	document.getElementById("handleType").innerHTML = "�绰����";
  	// by fangyuan 090324 ������кŶθ��¹�������Ϣ
  	getLocation(cCcommonTool.getCalled());
  }else{
  	// by fangyuan 090324 ������кŶθ��¹�������Ϣ
  	getLocation(cCcommonTool.getCaller());
  }
  
  
  //-----methods collection---------- begin
  
  //��ѯ�����������صĶ�̬�ص�����
  function updateHandleNoRegion(packet){
    	var retCode = packet.data.findValueByName("retCode");	
			if (retCode == "000000") {
				var townName ="";
				townName = packet.data.findValueByName("townName");
				var provice=packet.data.findValueByName("provice");
				
				// ����������������
				document.getElementById('handleNo_town').innerHTML = townName;
				//��ʡ�ݼ�¼��callPanle��������
				document.getElementById('provice').value=provice;
				return;
			}	
  }
  
  //getLocation ��չ����
  function getLocationEx(phoneNo,callback){
  	if(phoneNo==''||phoneNo=='undefined'){
  		return;
  	}
  	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/portal/getLocation.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
		packet.data.add("callPhone",phoneNo);
		core.ajax.sendPacket(packet,callback,true);
		packet=null;
  }
  // ��ѯ�����ط���
  function getLocation(phoneNo){
  	if(phoneNo==''||phoneNo=='undefined'){
  		return;
  	}
  	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/portal/getLocation.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("callPhone",phoneNo);
	core.ajax.sendPacket(packet,doGetLocation,true);
	packet=null;
  }
  //��ͨ���롢������������ز�ѯ�Ļص�����
  function doGetLocation(packet){
  	var retCode = packet.data.findValueByName("retCode");	
	  if (retCode == "000000") {
		var townName ="";
		townName = packet.data.findValueByName("townName");
		// �����޸Ľڵ������
		document.getElementById('town').innerHTML = townName;
		return;
	}	
  }
  
  //-----methods collection---------- end 
  
  //��������ѡ������ by libin 2009/04/28
  function copyToClipBoard(obj){
  //alert("-------------------");
		var clipBoardContent = obj.innerHTML; 		
		window.clipboardData.setData('Text',clipBoardContent);		
	}
</script>
<script>
	//by zwy 20090617 ��ʾ�ڴ�
	/*
	function displayIEMem(){
		document.getElementById("par_curMem").innerHTML=cCcommonTool.getCurrentIEMemUsed();
	}	
	setInterval("displayIEMem()",2000);
	*/
</script>	
