<%
/*
 *转专席基地
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
<title>转专席基地</title>
<script type="text/javascript">
	function transToIvr(i){
		var userType = document.getElementById("userType").value;
  	var typeId = document.getElementById("typeId").value;

		//取得随路数据
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
		//分解ext2
  	var serviceNo = "<%=callerPhone%>";
		if (serviceNo == "") {
			serviceNo = "<%=callerPhone%>";
		}
		var ivrObj = document.getElementById("ivrData"+i);
		var inReg = '';
		var serviceFlag = ivrObj.serviceFlag;
		if (serviceFlag == '0') {/**转业务办理.*/
			inReg = "00";
		}
		if (serviceFlag == '1') {/**转业务咨询.*/
			inReg = "01";
		}
		/**获得ext2的数据.*/
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
			rdShowMessageDialog("请选择语音节点",1);
			return;
		}
		ext2 = ext2.substring(0,ext2.length-1);
		var Ext2 = getHuaWeiExt2(ext2,typeId);
		//转移方式
		var transType = '0';
		//转接信息入库
		//alert("accessCode:  "+accessCode+"  digitCodes:   "+digitCodes+"  digitCode:  "+digitCode+"  transType: "+transType+" userType: "+userType+"   Ext2: "+Ext2+"  userClass:   "+userClass);
		mainWin.insertAllIvr(callerNo,transType,digitCodes,"",cityCode,accessCode,userClass,serviceNames,serviceIds,"N",serviceFlags,"4");
		//转IVR
		var ret=mainWin.cCcommonTool.toIvr(accessCode,transType,digitCode,userType,Ext2,userClass);
		//add by lipf 2012-03-09 转接提示
		if (ret != 0) {
			var retmsg = mainWin.parPhone.getPromptByErrorCode(ret);
			if (!retmsg || retmsg == "") {
				retmsg = "失败";
			}
			rdShowMessageDialog("转接\""+$('#ivrData'+i).attr('serviceName')+"\"基地  : "+retmsg,1);
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
		List resultList = null; //结果集
		String acceptCityCode = null;
		String acceptUserType = null;

		String acceptSMCode = null;
		if (acceptPhone.equals("")) {
			acceptPhone = callerPhone; //积分专席时受理号码是空的，设为主叫号码
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
	  	//神州行
	  	acceptUserType="30";
		} else if (acceptSMCode.equals("dn")) {
			//动感地带
	  	acceptUserType="40";
		} else if (acceptSMCode.equals("gn")) {
			//全球通
	  	acceptUserType="50";
		} else if (isChinaMobile(acceptPhone)) {
			//跨区
			acceptUserType="35";
		} else {
			//它网
			acceptUserType="20";
		}

		String serviceNames = "'Iphone外呼业务','普通定制终端外呼','互联网专席外呼','积分专席外呼',"
									+ "'手机阅读外呼','手机游戏外呼','无线音乐外呼','统一门户客户端外呼'";
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
				<th style="text-align:center;padding-left:0;">操作</th>
				<th style="text-align:center;padding-left:0;">专席基地</th>
			</tr>
	<%
    /***知识库访问路径***begin***/
    String knowledgeId ="";    
    /***知识库访问路径***end***/
    
		//专席基地工作时间：8:00--23:00
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
				//积分专席外呼24小时均可转接
				//if ("积分专席外呼".equals(serviceName) || timeAble) {
				//	transAble = true;
				//} else {
				//	transAble = false;
				//}
	%>
				<tr>
					<td style="width:60px;text-align:center">
						<input type="button" class="b_text" <%=timeAble?"":"disabled='disabled'"%> value="释放转" onclick="transToIvr(<%=i%>)" />
					</td>
					<td>
						<input type="hidden" id="ivrData<%=i%>" value="<%=serviceId%>" cityCode="<%=acceptCityCode%>" userClass="<%=acceptUserType%>"
						  digitCode="<%=digitCode%>" serviceFlag="0" serviceName="<%=serviceName%>" userType="<%=userType%>" typeId="<%=typeId%>" />
				<!-- add by jiyk 2012-05-19 将专席基地中七项基地按钮名称统一调整为"*****专席" ,去掉"业务"、"外呼"等字样-->
					<%
					if(serviceName!=null&&serviceName.trim().equals("Iphone外呼业务"))
					{
					serviceName="Iphone专席";
					knowledgeId="20120227090129691397";
					}else if(serviceName!=null&&serviceName.trim().equals("互联网专席外呼"))
					{
					serviceName="互联网专席";
					knowledgeId="20120227091904691898";
					}else if(serviceName!=null&&serviceName.trim().equals("积分专席外呼"))
					{
					serviceName="积分专席";
					knowledgeId="20120224085410618469";
					}else if(serviceName!=null&&serviceName.trim().equals("普通定制终端外呼"))
					{
					serviceName="普通定制终端专席";
					knowledgeId="20120227090129691397";
					}else if(serviceName!=null&&serviceName.trim().equals("手机游戏外呼"))
					{
					serviceName="手机游戏专席";
					knowledgeId="20120227091904691898";
					}else if(serviceName!=null&&serviceName.trim().equals("手机阅读外呼"))
					{
					serviceName="手机阅读专席";
					knowledgeId="20120227091904691898";
					}else if(serviceName!=null&&serviceName.trim().equals("无线音乐外呼"))
					{
					serviceName="无线音乐专席";
					knowledgeId="20120227091904691898";
					}else if(serviceName!=null&&serviceName.trim().equals("统一门户客户端外呼")){
						serviceName="统一门户客户端专席";
						knowledgeId="";
					}else { //对于以后其他情况的处理
					String temp="",temp1="";
		         temp=serviceName.substring(0,serviceName.indexOf("外呼"));
		         temp+=serviceName.substring(serviceName.indexOf("外呼")+2);//去除外呼
		         temp1=temp;
		         temp=temp.substring(0,temp.indexOf("业务"));              //去除
		         temp+=temp1.substring(temp1.indexOf("业务")+2);
		         if(temp.indexOf("专席")==-1)
		         {
			        temp+="专席";
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