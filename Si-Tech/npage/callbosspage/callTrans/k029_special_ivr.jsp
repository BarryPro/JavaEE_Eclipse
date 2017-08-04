<%
/*
 *תרϯ����
 *created by tangsong 20110218
 */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.ws3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<%!
	boolean isChinaMobile(String telephone) {
		String[] CMStartNoArr = {"134","135","136","137","138","139","147",
		                         "150","151","152","157","158","159","182",
		                         "187","188","183"};
		if (telephone == null || telephone.length() < 11) {
			return false;
		}
		String startNo = telephone.substring(0,3);
		for (int i = 0; i < CMStartNoArr.length; i++) {
			if (startNo.equals(CMStartNoArr[i])) {
				return true;
			}
		}
		return false;
	}
%>

<%
	String acceptPhone = request.getParameter("acceptPhone")==null?"":request.getParameter("acceptPhone");
	String callerPhone = request.getParameter("callerPhone")==null?"":request.getParameter("callerPhone");
%>
<title>תרϯ����</title>
<script type="text/javascript">
	function transToIvr(i){
		var userType = document.getElementById("userType").value;
  	var typeId = document.getElementById("typeId").value;

		//ȡ����·����
		var mainWin = window.opener;
		var huaWeiUserClass = mainWin.document.getElementById("huaWeiUserClass").value;
		var callData = mainWin.cCcommonTool.QueryCallDataEx(5);
		var callDataArr = callData.split(",");
		var accessCode = '';
		if (callDataArr[0] != '' && callDataArr[0].substr(4) == '12580') {
			accessCode = callDataArr[0].substr(4);
		} else {
			accessCode = '10086';
		}
		var cityCode = callDataArr[1];
		if (huaWeiUserClass == '') {
			huaWeiUserClass = callDataArr[2];
		}
		var userClass = huaWeiUserClass;
		//var serviceNo = callDataArr[3];
		var digitCode = callDataArr[4];
		var callerNo = "<%=callerPhone%>";
		var userTypeBegin = callDataArr[6];
		//�ֽ�ext2
  	var serviceNo = "<%=callerPhone%>";
		if (serviceNo == "") {
			serviceNo = "<%=callerPhone%>";
		}
		var ivrObj = document.getElementById("ivrData"+i);
		var inReg = '';
		var serviceFlag = ivrObj.serviceFlag;
		if (serviceFlag == '0') {/**תҵ�����.*/
			inReg = "00";
		}
		if (serviceFlag == '1') {/**תҵ����ѯ.*/
			inReg = "01";
		}
		/**���ext2������.*/
		var ext2 = ivrObj.value + "~" + inReg + "^"
						+ ivrObj.cityCode + "^" + ivrObj.userClass + "^"
						+ userTypeBegin + "^" + ivrObj.digitCode+ "^"
						+ serviceNo + ",";
		var digitCodes = ivrObj.digitCode;
		var serviceIds = ivrObj.value;
		var serviceNames = ivrObj.serviceName;
		var serviceFlags = ivrObj.serviceFlag;
		//alert(digitCodes+"  "+serviceIds+"    "+serviceNames+"  "+serviceFlags);
		if(ext2 == ''){
			rdShowMessageDialog("��ѡ�������ڵ�",1);
			return;
		}
		ext2 = ext2.substring(0,ext2.length-1);
		var Ext2 = getHuaWeiExt2(ext2,typeId);
		//ת�Ʒ�ʽ
		var transType = '0';
		//ת����Ϣ���
		//alert("accessCode:  "+accessCode+"  digitCodes:   "+digitCodes+"  digitCode:  "+digitCode+"  transType: "+transType+" userType: "+userType+"   Ext2: "+Ext2+"  userClass:   "+userClass);
		mainWin.insertAllIvr(callerNo,transType,digitCodes,"",cityCode,accessCode,userClass,serviceNames,serviceIds,"N",serviceFlags,"4");
		//תIVR
		var ret=mainWin.cCcommonTool.toIvr(accessCode,transType,digitCode,userType,Ext2,userClass);
		//add by lipf 2012-03-09 ת����ʾ
		if (ret != 0) {
			var retmsg = mainWin.parPhone.getPromptByErrorCode(ret);
			if (!retmsg || retmsg == "") {
				retmsg = "ʧ��";
			}
			rdShowMessageDialog("ת��\""+$('#ivrData'+i).attr('serviceName')+"\"����  : "+retmsg,1);
		}
		window.close();
	}

	function getHuaWeiExt2(ext2,typeId){
		var Ext2="";
		var temp="";
		if(ext2==''||typeId==''||ext2==undefined||typeId==undefined) {
			return false;
		}
		var arrayStr=ext2.split(",");
		if(arrayStr.length==1){
		 	Ext2=typeId+arrayStr[0].substr(arrayStr[0].indexOf("~"));
		} else {
			for(var i=0;i<arrayStr.length;i++){
			  temp+=arrayStr[i].substr(arrayStr[i].indexOf("~"));
			}
			Ext2="2000"+temp;
		}
		return Ext2;
	}
	function clicklink(knowledgeId) {
		//alert(knowledgeId);
		if(knowledgeId!=""){
		   var pathhead = "http://10.110.45.10/csp/kbs/showKng.action?kngId=";
		   var pathend="&kngTblFlag=0&relativeKngFlag=true&buttonFlag=true&articleFlag=true&showType=1&clickingLogFlag=1&channelId=0";						
		   var features = "titlebar=no,resizable=yes";
		   window.open(pathhead+knowledgeId+pathend,"_blank",features);	
	  }	
	}
	
</script>
</head>
<body>
	<iframe src="/npage/login/ssouse.jsp" style="display:none" width="100" height="100"></iframe>
	<%
		String orgCode = (String)session.getAttribute("orgCode");
		String myParams = null;
		String regionCode = orgCode.substring(0,2);
		List resultList = null; //�����
		String acceptCityCode = null;
		String acceptUserType = null;

		String acceptSMCode = null;
		if (acceptPhone.equals("")) {
			acceptPhone = callerPhone; //����רϯʱ��������ǿյģ���Ϊ���к���
		}
		if (!acceptPhone.equals("")) {
			StringBuffer sqlBuffer = new StringBuffer();
			sqlBuffer.append("select t.sm_code,");
			sqlBuffer.append("       (select s.city_code");
			sqlBuffer.append("          from scallregioncode s, dcustdoc d");
			sqlBuffer.append("         where d.cust_id = t.cust_id");
			sqlBuffer.append("           and d.region_code = s.region_code) city_code");
			sqlBuffer.append("  from dcustmsg t");
			sqlBuffer.append(" where t.phone_no = :acceptPhone");
			myParams = "acceptPhone=" + acceptPhone;
	%>
			<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				<wtc:param value="<%=sqlBuffer.toString()%>"/>
				<wtc:param value="<%=myParams%>"/>
			</wtc:service>
			<wtc:array id="resultArr" scope="end"/>
	<%
			if (resultArr != null && resultArr.length > 0) {
				acceptSMCode = resultArr[0][0];
				acceptCityCode = resultArr[0][1];
			}
		}
		acceptSMCode = acceptSMCode==null?"":acceptSMCode;
		acceptCityCode = acceptCityCode==null?"0451":acceptCityCode;
		if (acceptSMCode.equals("zn")||acceptSMCode.equals("z0")) {
	  	//������
	  	acceptUserType="30";
		} else if (acceptSMCode.equals("dn")) {
			//���еش�
	  	acceptUserType="40";
		} else if (acceptSMCode.equals("gn")) {
			//ȫ��ͨ
	  	acceptUserType="50";
		} else if (isChinaMobile(acceptPhone)) {
			//����
			acceptUserType="35";
		} else {
			//����
			acceptUserType="20";
		}

		String serviceNames = "'Iphone���ҵ��','��ͨ�����ն����','������רϯ���','����רϯ���',"
									+ "'�ֻ��Ķ����','�ֻ���Ϸ���','�����������','ͳһ�Ż��ͻ������'";
		String sqlStr="select a.id,a.servicename, ";
		sqlStr+="decode(a.typeid,'2002', decode((select count(*) from DSCETRANSFERTAB c where c.superid=a.id) ,'0','2002','2001'),a.typeid), ";
		sqlStr+="a.ttansfercode,a.digitcode,a.usertype from DSCETRANSFERTAB a where 1=1";
		sqlStr+="and a.accesscode='10086' ";
		sqlStr+="and a.userclass=:UserClass ";
		sqlStr+="and a.citycode=:CityCode ";
		sqlStr+="and a.servicename in ("+serviceNames+") ";
		sqlStr+="order by a.servicename";
		myParams = "UserClass="+acceptUserType+",CityCode="+acceptCityCode;
	%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="6">
			<wtc:param value="<%=sqlStr%>"/>
			<wtc:param value="<%=myParams%>"/>
		</wtc:service>
		<wtc:array id="resultArr2" scope="end"/>


	<div id="Operation_Table" style="width:100%">
		<table>
			<tr>
				<th style="text-align:center;padding-left:0;">����</th>
				<th style="text-align:center;padding-left:0;">רϯ����</th>
			</tr>
	<%
    /***֪ʶ�����·��***begin***/
    String knowledgeId ="";    
    /***֪ʶ�����·��***end***/
    
		//רϯ���ع���ʱ�䣺8:00--23:00
		Calendar c = Calendar.getInstance();
		int hour = c.get(Calendar.HOUR_OF_DAY);
		boolean timeAble = false;
		if (hour >= 8 && hour < 23) {
			timeAble = true;
		}
		
		String typeId = "";
		String userType = "";
		if (resultArr2 != null) {
			for (int i = 0; i < resultArr2.length; i++) {
				String serviceId = resultArr2[i][0];
				String digitCode = resultArr2[i][4];
				String serviceName = resultArr2[i][1];
				userType = resultArr2[i][5];
				typeId = resultArr2[i][2];
				boolean transAble = false;
				//����רϯ���24Сʱ����ת��
				//if ("����רϯ���".equals(serviceName) || timeAble) {
				//	transAble = true;
				//} else {
				//	transAble = false;
				//}
	%>
				<tr>
					<td style="width:60px;text-align:center">
						<input type="button" class="b_text" <%=timeAble?"":"disabled='disabled'"%> value="�ͷ�ת" onclick="transToIvr(<%=i%>)" />
					</td>
					<td>
						<input type="hidden" id="ivrData<%=i%>" value="<%=serviceId%>" cityCode="<%=acceptCityCode%>" userClass="<%=acceptUserType%>"
						  digitCode="<%=digitCode%>" serviceFlag="0" serviceName="<%=serviceName%>" userType="<%=userType%>" typeId="<%=typeId%>" />
				<!-- add by jiyk 2012-05-19 ��רϯ������������ذ�ť����ͳһ����Ϊ"*****רϯ" ,ȥ��"ҵ��"��"���"������-->
					<%
					if(serviceName!=null&&serviceName.trim().equals("Iphone���ҵ��"))
					{
					serviceName="Iphoneרϯ";
					knowledgeId="20120227090129691397";
					}else if(serviceName!=null&&serviceName.trim().equals("������רϯ���"))
					{
					serviceName="������רϯ";
					knowledgeId="20120227091904691898";
					}else if(serviceName!=null&&serviceName.trim().equals("����רϯ���"))
					{
					serviceName="����רϯ";
					knowledgeId="20120224085410618469";
					}else if(serviceName!=null&&serviceName.trim().equals("��ͨ�����ն����"))
					{
					serviceName="��ͨ�����ն�רϯ";
					knowledgeId="20120227090129691397";
					}else if(serviceName!=null&&serviceName.trim().equals("�ֻ���Ϸ���"))
					{
					serviceName="�ֻ���Ϸרϯ";
					knowledgeId="20120227091904691898";
					}else if(serviceName!=null&&serviceName.trim().equals("�ֻ��Ķ����"))
					{
					serviceName="�ֻ��Ķ�רϯ";
					knowledgeId="20120227091904691898";
					}else if(serviceName!=null&&serviceName.trim().equals("�����������"))
					{
					serviceName="��������רϯ";
					knowledgeId="20120227091904691898";
					}else if(serviceName!=null&&serviceName.trim().equals("ͳһ�Ż��ͻ������")){
						serviceName="ͳһ�Ż��ͻ���רϯ";
						knowledgeId="";
					}else { //�����Ժ���������Ĵ���
					String temp="",temp1="";
		         temp=serviceName.substring(0,serviceName.indexOf("���"));
		         temp+=serviceName.substring(serviceName.indexOf("���")+2);//ȥ�����
		         temp1=temp;
		         temp=temp.substring(0,temp.indexOf("ҵ��"));              //ȥ��
		         temp+=temp1.substring(temp1.indexOf("ҵ��")+2);
		         if(temp.indexOf("רϯ")==-1)
		         {
			        temp+="רϯ";
		         }
					}
					%>	  
						<a href="#" onclick="clicklink('<%=knowledgeId%>');return false;"><%=serviceName%></a>
					</td>
				</tr>
	<%
			}
		}
	%>
		</table>
		<input type="hidden" id="typeId" value="<%=typeId%>" />
		<input type="hidden" id="userType" value="<%=userType%>" />
	</div>
</body>
</html>