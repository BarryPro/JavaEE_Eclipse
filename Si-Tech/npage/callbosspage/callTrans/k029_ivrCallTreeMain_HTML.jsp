<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
String flag=request.getParameter("flag");
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
%>
<html>

<head>
<title>�˹�ת�Զ�</title>

<!--add it here to log in logfile -->
<script language="JavaScript" src="<%= request.getContextPath() %>/njs/csp/CCcommonTool.js"></script>

<script language=javascript>
function closettt()
{
  window.close();
}
var globalFlag = '<%=flag%>';/**yanghy��Ӷ���ȫ��flag.ҳ�治ˢ����ת.20091029*/
function transToIvr(){
     var TransType='';
     //ȡ����·����
     var accessCode=document.getElementById("CalledNo").value;
     var DigitCode=document.getElementById("DigitCode").value;
     var typeId=document.getElementById("typeId").value;
     var userType=document.getElementById("userType").value;
     var UserClass=document.getElementById("UserClass").value;
     var ext2=document.getElementById("ext2").value;
     
     //ȡҳ��ѡ������
     var servicename=document.getElementById("node_Name").value; 
     var serviceid=document.getElementById("node_Id").value;
     var callerNo=document.getElementById("CallerNo").value;
     var cityCode=document.getElementById("CityCode").value;
   
//     cCcommonTool.DebugLog("node_Name:"+node_Name+"CallerNo:"+callerNo+"CityCode:"+cityCode);
     //alert(servicename+"_"+serviceid+"_"+callerNo+"_"+cityCode);
     //ת�Ʒ�ʽ
     var toIVRType=document.getElementById("toIVRType").checked;
     if(toIVRType==true){
          TransType=0;
     }
     else{
          TransType=1;
     }
     //�ֽ�ext2
     if(ext2==''){
     		rdShowMessageDialog("��ѡ�������ڵ�",1);
     		return;
     }
     var Ext2=getHuaWeiExt2(ext2,typeId);
     //alert("Ext2"+Ext2);
     //д���ݿ�
     window.parent.parent.opener.top.insertAllIvr(callerNo,TransType,DigitCode,"",cityCode,accessCode,UserClass,servicename,serviceid,"N",globalFlag);
     //תIVR
     window.parent.parent.opener.top.cCcommonTool.toIvr(accessCode,TransType,DigitCode,userType,Ext2,UserClass);
     window.top.close();
}
 
function deleteChecked(){
     
     myFrame.location.href = "javaScript:unCheckBoxBySelect();";
     document.form1.node_Id.value="";
     document.form1.node_Name.value="";
     document.form1.show_Name.value="";
     document.getElementById("select_Name").options.length=0;
	//yanghy��Ӳ�ѯ���Ŵ���.2009.09.07 BEGIN
     myFrame.findMessegeByCheckedId();
     //yanghy��Ӳ�ѯ���Ŵ���.2009.09.07 END
}
function getHuaWeiExt2(ext2,typeId){
     var Ext2="";
     var temp="";
     if(ext2==''||typeId==''||ext2==undefined||typeId==undefined){return false;}
     var arrayStr=ext2.split(",");
     if(arrayStr.length==1){
          Ext2= typeId+arrayStr[0].substr(arrayStr[0].indexOf("~"));
     }
     else{
          for(var i=0;i<arrayStr.length;i++){
               temp+=arrayStr[i].substr(arrayStr[i].indexOf("~"));
          }
          Ext2="2000"+temp;
     }
     return Ext2;
}
function deleteShowName(node_id,node_name){
     var elsId=document.getElementById("node_Id").value;
     var elsName = document.getElementById("node_Name").value;
     var elsArray=elsId.split(",");
     var elsNameArray = elsName.split(",");
     
     if(elsId==null||elsId==undefined)return false;
     for(var i=1;i<elsArray.length;i++){
          if(elsArray[i]==node_id){
	       elsArray.splice(i,1);
	       document.form1.node_Id.value=elsArray.toString();
          }
     }
     for(var i=1;i<elsNameArray.length;i++){
          if(elsNameArray[i]==node_name){
	       elsNameArray.splice(i,1);
	       document.form1.node_Name.value=elsNameArray.toString();
	       document.form1.show_Name.value=elsNameArray.toString();
          }
     }
     
}
function removeExt(ext,id){
     var dataStr='';
     var str=ext.split(",");
     if(ext==''||id==''||ext==undefined ||id==undefined){return false;}
     for(var i=0;i<str.length;i++){
          if(str[i].substr(0,str[i].indexOf("~"))==id){
               dataStr=str.slice(0,i)+','+str.slice(i+1);
               return dataStr;   
          }
     }    
}
function right(value){
     var optionarr = value.options;
     if(value.selectedIndex!=-1){
          var node_id = optionarr[value.selectedIndex].value;
          var checkBoxItem = myFrame.document.getElementById("chk"+node_id);
          if(checkBoxItem!=null&&checkBoxItem!=undefined){
               checkBoxItem.checked = false;
          }
          var node_name = optionarr[value.selectedIndex].text;
          var par_object=document.getElementById("show_Name");
          var par_del_child= document.getElementById("node_id");
          var children = par_object.childNodes; 
          deleteShowName(node_id,node_name);  
          for(var i=0;i<children.length;i++){	
               if(children[i].id==node_id){	
                    par_object.removeChild(children[i]); 
               }
          }
          var ext2 = document.form1.ext2.value;
          ext2 = removeExt(ext2,node_id);
          document.form1.ext2.value=ext2;
	   var myselect=document.form1.select_Name.options;
	   for(var i=0;i<myselect.length;i++){
                if(myselect[i].value==node_id){
                     myselect.remove(i);
                     break;
                }
	   }
     }
     //yanghy��Ӳ�ѯ���Ŵ���.2009.09.07 BEGIN
     myFrame.findMessegeByCheckedId();
     //yanghy��Ӳ�ѯ���Ŵ���.2009.09.07 END
     //alert(document.form1.node_Id.value);
     //alert(document.form1.node_Name.value);
     //alert(document.form1.show_Name.value);
     //alert(document.form1.ext2.value);
}
</script>
</head>
<body>
<style>
body
{
	margin:0;
	padding:0;
	font:12px Verdana, Arial, Helvetica, sans-serif,"����"��"����";
	line-height:1.8em;
	text-align:left;
	color:#003399;
	background-color: #eef2f7;
}
html {
	scrollbar-face-color:#d5e1f7;
	scrollbar-highlight-color:#FFFFFF;
	scrollbar-shadow-color:#DEEBF7;
	scrollbar-3dlight-color:#89b3e3;
	scrollbar-arrow-color: #121f54;
	scrollbar-track-color:#F4F0EB;
	scrollbar-darkshadow-color:#89b3e3;
	overflow:hidden;
}
</style>
<div id="Operation_Table" style="width: 100% ; padding: 0px; height: 310px;"> 
<form name="form1" method="POST" style="padding: 0;" action="">
     <!-- ������ -->
		<input type="hidden" id="CalledNo" name="CalledNo" value=""/>	
		 <!--���д��� -->
		<input type="hidden" id="CityCode" name="CityCode" value=""/>
		<!--�û����� -->
		<input type="hidden" id="UserClass" name="UserClass" value=""/>
		<!--����·�� -->
		<input type="hidden" id="DigitCode" name="DigitCode" value=""/>
		<!--���� -->
		<input type="hidden" id="ttansfercode" name="ttansfercode" value=""/>
		<!--֦Ҷ -->
		<input type="hidden" id="typeId" name="typeId" value=""/>
		<!--�û�Ʒ�� -->
		<input type="hidden" id="userType" name="userType" value=""/>
		<!--�������-->
		<input type="hidden" id="ServiceNo" name="ServiceNo" value=""/>
		<!--��ѯ�����־-->
		<input type="hidden" id="inFlag" name="inFlag" value="<%=flag%>"/>
		<!--���к���-->
		<input type="hidden" id="CallerNo" name="CallerNo" value=""/>
		<!--��ʼ�û�Ʒ��-->
		<input type="hidden" id="userTypeBegin" name="userTypeBegin" value=""/>
		<!--������ext2-->
		<input type="hidden" id="ext2" name="ext2" value=""/>
	  <table  width="100%" height="350px" border="0" cellpadding="0" cellspacing="0">
		  	<tr><td colspan="3" width="65%">
		  		<iframe name="myFrame" src="" frameborder="0" width="99%" height="340px" 
		  		marginwidth="0" marginheight="0" scrolling="auto" src=""></iframe>	
		  	</td>
		  	<td width="35%"><!-- yanghy ��Ӷ��ŷ��͹���ʹ��K083ģ�����������. -->
		  			<iframe name="sendSMS" src="../K083/K083_msgSend4CallTrans.jsp"
		  			 frameborder="0" width="99%" height="340px" marginwidth="0" 
		  			 marginheight="0" scrolling="auto" src=""></iframe>	
		  	</td>
		  	
		  	</tr>
		  	
		  	<tr>
				<td colspan="4"><!--�������а�region_code������ liujied 20091026-->
				<div style="float: left;">
					�������
					<select id="searchType" name="searchType">
						<option value="0">תҵ�����</option>
						<option value="1">ת��ѯ����</option>
					</select>
					��������
<select id=city_code_2 name=city_code_2> 
<option value='0451'>������</option>
<option value='0467'>�������</option>
<option value='0464'>ĵ����</option>
<option value='0469'>��ľ˹</option>
<option value='0468'>˫Ѽɽ</option>
<option value='0454'>��̨��</option>
<option value='0453'>����</option>
<option value='0452'>�׸�</option>
<option value='0457'>����</option>
<option value='0455'>�ں�</option>
<option value='0456'>�绯</option>
<option value='0458'>���˰���</option>
<option value='0459'>����</option>
</select>
				 	����
<select id=user_class_2 name=user_class_2> 
<option value='10'>10 ���ƶ��û�</option>
<option value='30'>30 ��;����������ƶ��û�</option>
<option value='40'>40 �������û�</option>
<option value='50'>50 �������û�</option>
<option value='60'>60 ʡ��Ʒ���û�</option>
<option value='70'>70 ���еش��û�</option>
<option value='80'>80 ȫ��ͨ�û�</option>
<option value='90'>90 vip�û�</option>
</select>
		     		������
		     		<input type="text" id="accesscode_2" name="accesscode_2" value="" style="width: 80px;"  readonly/>
		     		�ڵ�����:
		     		<input type="text" id="searchName" name="searchName" value=""  onkeydown="onKeyDownSearch()"/>
		     		<input name="trans" type="button" class="b_foot" id="trans" value="��ѯ " 
		     		onClick="searchCallTransTree();">
		     		</div>
				</td>
			</tr>
			
			
			<tr>
				<td colspan="4"><div style="width: 99%;">
					<input  type="hidden" id="show_Name" align="left">
					<select id="select_Name" name="select_Name" style="width:100%;height:80px;border: 0;" multiple="true" onDblClick ="right(this)">
					</select>
					<input type="hidden" name="node_Id" id="node_Id" value="">
					<input type="hidden" name="node_Name" id="node_Name" value="">
					</div>				  
				</td>
			</tr>	
			<tr>
				<td colspan="4"><!--�������а�region_code������ liujied 20091026-->
				<div style="float: left;">
					��������
<select id=city_code name=city_code onchange="getCityCodeTree();"> 
<option value='0451'>������</option>
<option value='0467'>�������</option>
<option value='0464'>ĵ����</option>
<option value='0469'>��ľ˹</option>
<option value='0468'>˫Ѽɽ</option>
<option value='0454'>��̨��</option>
<option value='0453'>����</option>
<option value='0452'>�׸�</option>
<option value='0457'>����</option>
<option value='0455'>�ں�</option>
<option value='0456'>�绯</option>
<option value='0458'>���˰���</option>
<option value='0459'>����</option>
</select>
				 	����
<select id=user_class name=user_class onchange="getUserClassTree();"> 
<option value='10'>10 ���ƶ��û�</option>
<option value='30'>30 ��;����������ƶ��û�</option>
<option value='40'>40 �������û�</option>
<option value='50'>50 �������û�</option>
<option value='60'>60 ʡ��Ʒ���û�</option>
<option value='70'>70 ���еش��û�</option>
<option value='80'>80 ȫ��ͨ�û�</option>
<option value='90'>90 vip�û�</option>
</select>
		     		������
		     		<input type="text" id="accesscode" name="accesscode" style="width: 80px;" value="" readonly/>
				</div>
				<div style="float: right;">
					<input type="radio" name="toIVRType"  value="0" checked />
					�ͷ�ת
					<input type="radio" name="toIVRType" value="1"/>
					����ת
					<input name="trans" type="button" class="b_foot" 
					 id="trans" value="ת�� " onClick="transToIvr()">
					<input name="delete" type="button" class="b_foot" 
					id="delete" value="ȡ�� " onClick="deleteChecked()">	
					<input name="close" type="button" class="b_foot" 
					id="delete" value="�ر� " onClick="javascript:parent.parent.window.close();">
				</div>
		    	</td>
			</tr>
		</table>
  </form>
</div>
</body>
<script type="text/javascript">
/**�õ����ݲ�������.��ֵ����.*/
function getCallData() {
	// add lijin �����������룬�û�����ӦΪ��������
	var userBread = '';
	var huaWeiUserClass = window.parent.parent.opener.document
			.getElementById("huaWeiUserClass").value;
	// alert("huaWeiUserClass"+huaWeiUserClass);
	if (huaWeiUserClass == '' || huaWeiUserClass == undefined) {
		huaWeiUserClass = '';
	}
	if (huaWeiUserClass != '') {
		userBread = huaWeiUserClass;
	}
	// modifide by liujied :�ú���Ҫ��һ�����Ͳ���:ý������
	var callData = window.parent.parent.opener.top.cCcommonTool
			.QueryCallDataEx(5);
	// alert("callData:"+callData);
	if (callData == '' || callData == undefined) {
		rdShowMessageDialog('�Բ���û�в鵽��Ӧ������', 0);
	} else {
		var str = callData.split(",");
		var i = 0;
		if (str[i] != '' && str[i].substr(4) == '12580') {
			document.getElementById("CalledNo").value = str[i].substr(4);
		} else {
			document.getElementById("CalledNo").value = '10086';
		}
		document.getElementById("CityCode").value = str[i + 1];
		if (huaWeiUserClass == '') {
			huaWeiUserClass = str[i + 2];
		}
		document.getElementById("UserClass").value = huaWeiUserClass;
		document.getElementById("ServiceNo").value = str[i + 3];
		document.getElementById("DigitCode").value = str[i + 4];
		document.getElementById("CallerNo").value = str[i + 5];
		document.getElementById("userTypeBegin").value = str[i + 6];
		/***********************************************************************
		 * if(str[i+5] == ''||str[i+5] == undefined) {
		 * document.getElementById("CallerNo").value= "10086"; }
		 **********************************************************************/
	}
}
/***��һ�ν���ҳ���ʱ��select���ֵ����.*/
function initCallData(){
	if(document.getElementById("CityCode").value != ''){
	    document.getElementById("city_code").value = document.getElementById("CityCode").value;
	    document.getElementById("city_code_2").value = document.getElementById("CityCode").value;
	    /**����selectѡ��������.city_code_2 �ǲ�ѯ��selectѡ���.*/
	}
	//if(window.parent.parent.opener.top.parPhone.RoutPackage_UserClass != ''){
	if(document.getElementById("UserClass").value != ''){
		// ֱ�ӻ�ȡ��Ϊ����.
		document.getElementById("user_class").value = document.getElementById("UserClass").value;
		document.getElementById("user_class_2").value = document.getElementById("UserClass").value;
		/**����selectѡ��������.*/
	}
	if(document.getElementById("CalledNo").value != ''){
		document.getElementById("accesscode").value = document.getElementById("CalledNo").value;
		document.getElementById("accesscode_2").value = document.getElementById("CalledNo").value;
		/**accesscode_2Ϊ��ѯʱ��Ĳ���.*/
	}
}
getCallData();
/**��ҳ���ʼ��ʱ��ʹ��,�����Ҫ���table��ʱ��ı�select.��ӵ�getCallData()����.*/
initCallData();

var selectTabBar = 0;
/**����ѡ���TabBar��ǩ���ĸ� .*/
function doChangeTabBar(changeNo){
	cleanSelectOption();/**ѡ������.*/
	getCallData();/**���¼��غ���.*/
	/*��selectѡ����״̬��¼.*/
	/**��select �ٸ�ֵ��input.hidden*/
	document.getElementById("CityCode").value = document.getElementById("city_code").value;
	document.getElementById("UserClass").value = document.getElementById("user_class").value;
	
	if(changeNo == 0){
		globalFlag = 0;
		document.getElementById("inFlag").value = 0;
		window.open(<%=request.getContextPath()%>"/npage/callbosspage/callTrans/k029_ivrCallTree_new.jsp","myFrame");
		selectTabBar = 0;
		document.getElementById("searchType").value = 0;
	}
	if(changeNo == 1){
		globalFlag = 1;
		document.getElementById("inFlag").value = 1;
		window.open(<%=request.getContextPath()%>"/npage/callbosspage/callTrans/k029_ivrCallTree_new.jsp","myFrame");
		selectTabBar = 1;
		document.getElementById("searchType").value = 1;
	}
	if(changeNo == 2){
		searchCallTransTree();
		selectTabBar = 2;
	}
	/**alert(changeNo);*/
}
/**ÿ�����л���ʱ��Ҫ���ѡ���б�.select_Name.options*/
function cleanSelectOption(){
	try{
		document.form1.node_Id.value="";
		document.form1.node_Name.value="";
		document.form1.show_Name.value="";
		document.getElementById("select_Name").options.length = 0;
		/*������Ͷ�������.*/
		sendSMS.document.getElementById("msg_content").value = "";
		sendSMS.document.getElementById("show_array_div").innerHTML = "";
		sendSMS.messageArray = new Array();
		sendSMS.onCharsChange("");
	}catch(Ex){}
}

function searchCallTransTree(){/*yanghy�������������.*/
	cleanSelectOption();/**ѡ������.*/
	getCallData();/**���¼��غ���.*/
	var searchName = document.getElementById("searchName").value;
	if(searchName == ''){
		//rdShowMessageDialog("������ڵ�����!",1);
		//return;
	}
	/*�ֱ�ȡ��ѯʱ��Ĳ���.*/
	var calledNo = document.getElementById("accesscode_2").value;
	var userClass = document.getElementById("user_class_2").value;
	var cityCode = document.getElementById("city_code_2").value;
	var searchTypeFlag = document.getElementById("searchType").value;
	window.parent.change_link3_style();/*���ø�ҳ��ķ���.�ı��3����ǩ����ʽ.*/
	var url = "k029_ivrCallSearch_rpc.jsp?flag="+searchTypeFlag+"&calledNo="+
	calledNo+"&calledNo="+calledNo+"&userClass="+userClass+"&cityCode="+cityCode+"&searchName="+searchName;
	window.open(url,"myFrame");
	selectTabBar = 2;
}
/**�����»س���ʱ���������.*/
function onKeyDownSearch(){
	if(event.keyCode==13){
		searchCallTransTree();
  	}
}

function getCityCodeTree(){
	myFrame.window.unCheckBoxBySelect();
	document.form1.node_Id.value="";
	document.form1.node_Name.value="";
	document.form1.show_Name.value="";
	document.getElementById("select_Name").options.length=0;
	/**���ѡ����Ŀ.*/
	var citycode = document.getElementById("city_code").value;
	document.getElementById("CityCode").value= citycode;
	document.getElementById("city_code_2").value = citycode;/**selectѡ������.*/
	if(selectTabBar == 0 || selectTabBar == 1 ){
		window.open(<%=request.getContextPath()%>"/npage/callbosspage/callTrans/k029_ivrCallTree_new.jsp","myFrame");
	}else{
		searchCallTransTree();
	}
	
}
function getUserClassTree(){
	// myFrame.window.unCheckBoxBySelect();
	// document.form1.node_Id.value="";
	// document.form1.node_Name.value="";
	// document.form1.show_Name.value="";
	// document.getElementById("select_Name").options.length=0;
	var userclass = document.getElementById("user_class").value;
	document.getElementById("UserClass").value = userclass;      
	document.getElementById("user_class_2").value = userclass;/**selectѡ������.*/
	if(selectTabBar == 0 || selectTabBar == 1 ){
		window.open(<%=request.getContextPath()%>"/npage/callbosspage/callTrans/k029_ivrCallTree_new.jsp","myFrame"); 
		window.parent.parent.opener.top.cCcommonTool.DebugLog("javascript *** getUserClassTree userclass:"+userclass);
	}else{
		searchCallTransTree();
	}
	
}
getUserClassTree();
</script>
</html>