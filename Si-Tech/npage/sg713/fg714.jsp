<%
  /*
   * 139������꣬������
   * ����: 2013-03-11
   * ����: zhouby
   */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<meta http-equiv="Expires" content="0">
<%
	request.setCharacterEncoding("GBK");
	response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0);
  
  String currentDate = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());
  
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
  String workNo = (String)session.getAttribute("workNo");
  String regionCode = (String)session.getAttribute("regCode");
  String phoneNo = (String)request.getParameter("activePhone");
  String password = (String)session.getAttribute("password");
%>
<%!
/*��������ʱ��֮�������*/
		public   int   nDaysBetweenTwoDate(String   firstString,String   secondString)   {  
		    SimpleDateFormat   df   =   new   SimpleDateFormat("yyyyMMdd");  
		    Date   firstDate=null;  
		    Date   secondDate=null;  
		    try {  
		        firstDate   =   df.parse(firstString);  
		        secondDate=df.parse(secondString);  
		    }
		    catch(Exception   e)   {  
		    }  
		
		    int nDay = (int)((secondDate.getTime()-firstDate.getTime())/(24*60*60*1000));  
		    return   nDay;  
		}
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="accept"/>
		
	  <wtc:service name="sg511Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="11">
				<wtc:param value="<%=accept%>"/>
				<wtc:param value="01"/> 
				<wtc:param value="g715"/>
				<wtc:param value="<%=workNo%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=phoneNo%>"/>
				<wtc:param value=""/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>

<%
if(retCode.equals("000000")) {
		if(result.length <= 0)
		{
%>
<script language="JavaScript">
			rdShowMessageDialog("δ��ѯ���û���������ֵҵ����Ϣ��);
			removeCurrentTab();
</script>
<%
			return ;
		}
}
else {
	%>
<script language="JavaScript">
			rdShowMessageDialog("δ��ѯ���û���������ֵҵ����Ϣ��������룺"+retCode+"������ԭ��"+retMsg);
			removeCurrentTab();
</script>
<%
	}
%>


			
<title><%=opName%></title>


<script language="javascript">
	var zengzhiyewumingcheng="";
	
		   onload=function()
	   {
			getCustInfo();	
			//queryBigClass();
	   }
	
		function getCustInfo(){
			
			var packet = new AJAXPacket("../public/pubGetUserBaseInfo.jsp","���ڻ�ȡ���ݣ����Ժ�......");
      packet.data.add("opCode", "<%=opCode%>");
      packet.data.add("phoneNo", "<%=phoneNo%>");
      core.ajax.sendPacket(packet, function(packet){
      		var CUST_NAME = packet.data.findValueByName('stPMcust_name');
      		$('#custName').text(CUST_NAME);
      });
      packet = null;
	}
	
	 function queryBigClass(){
		var getNote_Packet = new AJAXPacket("qryUserClassInfo.jsp","���ڻ��С����Ϣ�����Ժ�......");
		//getNote_Packet.data.add("bigclasscode",document.all.bigzame.value);
		core.ajax.sendPacket(getNote_Packet,returnBigClass);
		getNote_Packet=null;
	 }
	 
 function returnBigClass(packet){
		var tmpObj="";
		var tmpObjbig="";
 		var errorCode = packet.data.findValueByName("retCode");
		var errorMsg =  packet.data.findValueByName("retMsg");
	  var	backArrMsg= packet.data.findValueByName("backArrMsg1");
	  if( errorCode == "000000"){
	  	 tmpObj = "littleame";
	  	 tmpObjbig = "bigzame";
	  	 		document.all(tmpObj).options.length=0;
				  document.all(tmpObj).options.length=backArrMsg.length;
				  
				  document.all(tmpObjbig).options.length=0;
				  document.all(tmpObjbig).options.length=backArrMsg.length;
				  <%
				 // String smallcodeclass ="SJSPV3BN|WXYYBN|YXWJBN"; 
				 	String smallcodeclass =result[0][0];
				  String[] insCompStrArr=smallcodeclass.split("|");
				  %>
				  var smallcodecla="<%=smallcodeclass%>";
				  var id_Ojbect=(smallcodecla).split("|");//�ָ�ΪOjbect���顣 
				  var snds=0;
				  for(var c=0;c<id_Ojbect.length;c++){	
		        for(i=0;i<backArrMsg.length;i++)
			      {			      
			      if(id_Ojbect[c]==backArrMsg[i][1]) {		     			      
				      document.all(tmpObj).options[snds].text=backArrMsg[i][0];
				      document.all(tmpObj).options[snds].value=backArrMsg[i][1]+"--"+backArrMsg[i][2]+"--"+backArrMsg[i][3];
				      
				      snds++		
				      }        		        		        
			      }
			      
			    }
			    
			    var snds2=0;
				  for(var c2=0;c2<id_Ojbect.length;c2++){	
		        for(i2=0;i2<backArrMsg.length;i2++)
			      {			      
			      if(id_Ojbect[c2]==backArrMsg[i2][1]) {		     			      
				      document.all(tmpObjbig).options[snds2].text=backArrMsg[i2][5];
				      document.all(tmpObjbig).options[snds2].value=backArrMsg[i2][4];
			
				      snds2++		
				      }        		        		        
			      }
			      
			    }
			    
			    
	  }
		
		}
 
	
 function printInfo(){
 
 	 	var o = document.getElementById("lingyinheradio");  
  	var str = "";  
	 		  for(i=0;i<o.length;i++){     
                if(o.options[i].selected){  
                    str+=o.options[i].value+",";  
                    
                }  
            }  
			var cust_info="";
			var opr_info="";
			var note_info1="";
			var note_info2="";
			var note_info3="";
			var note_info4="";

			var retInfo = "";
			/************�ͻ���Ϣ************/
			cust_info += "�ֻ����룺<%=phoneNo%>|";
			cust_info += "�ͻ�������"+$('#custName').text()+"|";
			
			/************��������************/
			if($("#qiyedaima").val()=="WLAN05" || $("#qiyedaima").val()=="WLAN01") 
			{
				opr_info += "ҵ�����ͣ�"+ zengzhiyewumingcheng+"|";
			}
			else
			{
				opr_info += "ҵ�����ͣ���ֵҵ��"+ zengzhiyewumingcheng+"�����˶���|";
			}
			opr_info += "��������: �˶�|";
			opr_info += "����ʱ�䣺<%=currentDate%>|";
			
			if($("#qiyedaima").val()=="WLAN05" || $("#qiyedaima").val()=="WLAN01") {
				note_info1 += "��ע��"+"|"+"1. ��ѧ��/�����ʷѵ�������������Ч����ѧ��/�����һ���Ի�Ϊר��"+"|"
					+"2. WLANУ԰��ѧ�ڡ������ʷѺͰ����ʷѲ����ظ�����"+"|"
					+"3. WLAN���ڰ����ʷ�������ʷѲ����ظ�����"+"|"
					+"4. ��ѧ��/�����ʷ���;���ܱ���������˶�������Ч�������ϵͳһ���Ի��գ����˻�"+"|"
					+"5. ��ѧ��/�����ʷѵ��ں󣬲��˶��Զ�תΪ��Ӧ�����ʷ�."+"|"
					+"|";
			}
			if($("#qiyedaima").val()=="698025"){
			note_info1 += "��ע��"+"|"+"�𾴵Ŀͻ��������˶��ֻ�"+zengzhiyewumingcheng+"�ʷѣ��ʷ�ר��ڱ���ĩȫ���ջء��й��ƶ���"
					+"|";
			}
			retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
			
			return retInfo;
	}
  
  //��ʾ��ӡ�Ի���
function showPrtDlg(DlgMessage, submitCfm){
			var h=180;
			var w=350;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			
			var pType = "subprint";             				 		//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
			var billType = "1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
			var sysAccept = "<%=accept%>";       						//��ˮ��
			var printStr = printInfo();   				//����printinfo()���صĴ�ӡ����
			var opcode="g713";
			var mode_code=null;           							  	//�ʷѴ���
			var fav_code=null;                				 			//�ط�����
			var area_code=null;             				 		  	//С������
			var phoneNo = <%=phoneNo%>;     					    	//�ͻ��绰
			var prop = "dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+
				"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
															 
			var path = "/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
			path += "&mode_code="+mode_code+
				"&fav_code="+fav_code+"&area_code="+area_code+
				"&opCode="+opcode+"&sysAccept="+sysAccept+
				"&phoneNo=" + phoneNo+
				"&submitCfm="+submitCfm+"&pType="+
				pType+"&billType="+billType+ "&printInfo=" + printStr;
				
			var ret = window.showModalDialog(path,printStr,prop);
			return ret;
	}
  
  function printCommit(){

		var sm= new Array();
		var qiyedaima="";
		var yewudaima="";
		var yewumingcheng="";
		var shengxiaoshijian="";
		var shixiaoshijian="";
		var shijianshulian="";
		zengzhiyewumingcheng="";
		var qianshuss=0;
		var a=document.getElementsByName("lingyinheradio");
				for(i=0;i <a.length;i++) 
				{ 
						if(a[i].checked) {
						//alert(a[i].value); 
						sm =a[i].value.split("|");
					$('#qiyedaima').val(sm[0].trim());
					$('#yewudaima').val(sm[1].trim());
						qiyedaima=sm[0].trim();
						yewudaima=sm[1].trim();
						yewumingcheng=sm[2];
						shengxiaoshijian=sm[3];
						shixiaoshijian=sm[4];
						shijianshulian=sm[5];
						$('#shijianxianzhi').val("0");
						}	  	
				}
				if(qiyedaima=="") {
					rdShowMessageDialog("��ѡ��Ҫ�˶�����ֵҵ��");
					return ;
				}
				
				if(qiyedaima=="701001" && yewudaima=="500230544000") {
						qianshuss=5;
				}
				if(qiyedaima=="699019" && yewudaima=="30830001") {
						qianshuss=3;
				}
				if(qiyedaima=="699019" && yewudaima=="30830003") {
						qianshuss=5;
				}
				if(qiyedaima=="wxyybn" && yewudaima=="FK") {
						qianshuss=6;
				}
				if(qiyedaima=="801234" && yewudaima=="110301") {
						qianshuss=3;
				}
				if(qiyedaima=="WLAN05" && yewudaima=="10001") {
						qianshuss=10;
				}	
				if(qiyedaima=="698025" && yewudaima=="2300000005"){
					qianshuss=5;
				}
				if(shijianshulian>0 && shijianshulian<200) {
						zengzhiyewumingcheng=yewumingcheng+"�����"+(6*qianshuss)+"Ԫ/����";
				}	
	
				else{
						zengzhiyewumingcheng=yewumingcheng+"����"+(12*qianshuss)+"Ԫ/��";
				}
				
				if(qiyedaima=="WLAN05" && yewudaima=="10001" 
					&& shijianshulian>120 && shijianshulian<180 ) 
				{
					zengzhiyewumingcheng="WLANУ԰50Ԫ��ѧ��(5����)";
				}	  
				else if(qiyedaima=="WLAN05" && yewudaima=="10002"
					&& shijianshulian>120 && shijianshulian<180 ) {
					zengzhiyewumingcheng="WLANУ԰100Ԫ��ѧ��(5����)";
				}	
				else if(qiyedaima=="WLAN05" && yewudaima=="10003"
					&& shijianshulian>120 && shijianshulian<180 ) {
					zengzhiyewumingcheng="WLANУ԰200Ԫ��ѧ��(5����)";
				}					
				else if(qiyedaima=="WLAN05" && yewudaima=="10001"
					&& shijianshulian>200 && shijianshulian<400 ) {
					zengzhiyewumingcheng="WLANУ԰����120Ԫ����";
				}					
				else if(qiyedaima=="WLAN05" && yewudaima=="10002"
						&& shijianshulian>200 && shijianshulian<400 ) {
					zengzhiyewumingcheng="WLANУ԰����240Ԫ����";
				}				
				else if(qiyedaima=="WLAN05" && yewudaima=="10003"
						&& shijianshulian>200 && shijianshulian<400 ) {
					zengzhiyewumingcheng="WLANУ԰����480Ԫ����";
				}	
				else if(qiyedaima=="WLAN01" && yewudaima=="00006"
						&& shijianshulian>200 && shijianshulian<400 ) {
					zengzhiyewumingcheng="WLAN���ڰ���240Ԫ����";
				}					
				else if(qiyedaima=="WLAN01" && yewudaima=="00001"
						&& shijianshulian>200 && shijianshulian<400 ) {
					zengzhiyewumingcheng="WLAN���ڰ���360Ԫ����";
				}		
				else if(qiyedaima=="WLAN01" && yewudaima=="00002"
						&& shijianshulian>200 && shijianshulian<400 ) {
					zengzhiyewumingcheng="WLAN���ڰ���600Ԫ����";
				}					
				else if(qiyedaima=="WLAN01" && yewudaima=="00003"
						&& shijianshulian>200 && shijianshulian<400 ) {
					zengzhiyewumingcheng="WLAN���ڰ���1200Ԫ����";
				}	
				
				var ret ="";
				if((qiyedaima=="919015" && yewudaima=="YYXX2013")||(qiyedaima=="300008" && yewudaima=="20140103")){
					ret="continueSub";
				}
				else{
					ret = showPrtDlg("ȷʵҪ���е��������ӡ��", "Yes");
				}
			if ((typeof(ret) == "undefined") || (ret=="continueSub")){
					if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��') == 1){
							frmCfm();
					}
			} else if(ret == "confirm"){
					if(rdShowConfirmDialog('ȷ�ϵ��������') == 1){
							frmCfm();
					}
			}
	}
	
	//���������ṩ�˷�ֹ�ظ������ť�Ŀ���
	function frmCfm(){
			showLightBox();
			$('form').attr('action', 'fg713Cfm.jsp');
			if (!$('form').data('alreadySubmit')){
					$('form').data('alreadySubmit', true).submit();
			}
	}

</script>
</head>
<body>
<form name="frm" method="post" action="">
  <input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
  <input type="hidden" name="opName" id="opName" value="<%=opName%>">
  <input type="hidden" name="sysAccept" value="<%=accept%>">
  <input type="hidden" name="phoneNo" value="<%=phoneNo%>">
	<input type="hidden" name="qiyedaima" id="qiyedaima" value="">
	<input type="hidden" name="yewudaima" id="yewudaima" value="">
  <input type="hidden" name="selectvalues" id="selectvalues" value="07">
  <input type="hidden" name="shijianxianzhi" id="shijianxianzhi" value="">
  <input type="hidden" name="locatiurl" id="locatiurl" value="fg714.jsp">
  
  <%@ include file="/npage/include/header.jsp" %>
  <div class="title">
    <div id="title_zi"><%=opName%></div>
  </div>
  
  <table cellspacing="0">
  	<tr>
      <td class="blue" width="14%">�ͻ�����</td>
      <td width="36%" id="custName">
      </td>
      <td class="blue" width="14%">�ֻ���</td>
      <td width="36%" id="phoneNo"><%=phoneNo%>
      </td>
    </tr>
  	</table>
  	
  	  <table cellspacing="0">
  	  					<th></th>
  	  					<th>ԭ��ˮ</th>
								<th>��ҵ����</th>
								<th>��ҵ����</th>
								<th>ҵ�����</th>
								<th>ҵ������</th>
								<th>��Чʱ��</th>
								<th>ʧЧʱ��</th>
								<th>��������</th>
								<th>����ʱ��</th>
<%
				if(result.length>0) {
						 String[] qiyedaima=result[0][2].split("\\|");
						 String[] qiyemingcheng=result[0][3].split("\\|");
						 String[] yewudaima=result[0][4].split("\\|");
						 String[] yewumingcheng=result[0][5].split("\\|");
						 String[] shengxiaoshijian=result[0][6].split("\\|");
						 String[] shixiaoshijian=result[0][7].split("\\|");
						 String[] yuanliushui=result[0][8].split("\\|");
						 String[] caozuogonghao=result[0][9].split("\\|");
						 String[] caozuoshijian=result[0][10].split("\\|");
						
						 for(int i=0; i<qiyedaima.length; i++){
						 //out.println(qiyedaima.length+"--qiyedaima");
						  int tinahu =0;
						  if(!shengxiaoshijian[i].equals("") && !shixiaoshijian[i].equals("")) {
							  tinahu = nDaysBetweenTwoDate(shengxiaoshijian[i], shixiaoshijian[i]);
							}
					 %>
					 <tr> 
								<td width="2%"><input type="radio" name="lingyinheradio" value="<%=qiyedaima[i]%>|<%=yewudaima[i]%>|<%=yewumingcheng[i]%>|<%=shengxiaoshijian[i]%>|<%=shixiaoshijian[i]%>|<%=tinahu%>"  ></td>
								<td width="8%"><%=yuanliushui[i]%></td>
								<td width="5%"><%=qiyedaima[i]%></td>
								<td width="14%"><%=qiyemingcheng[i]%></td>
								<td width="5%"><%=yewudaima[i]%></td>
								<td width="14%"><%=yewumingcheng[i]%></td>
								<td width="10%"><%=shengxiaoshijian[i]%></td>
								<td width="10%"><%=shixiaoshijian[i]%></td>
								<td width="6%"><%=caozuogonghao[i]%></td>
								<td width="10%"><%=caozuoshijian[i]%></td>
							</tr>
					 <%
				}
				}
 %>   
  	</table>
    
      <table cellspacing="0">
    <tr>
      <td colspan="4" align="center" id="footer">
        <input class="b_foot" type=button name="submitBtn" id="submitBtn" value="ȷ��" onClick="printCommit()">    
        <input class="b_foot" type=button name="closeBtn" id="closeBtn" value="�ر�">
      </td>
    </tr>
  </table>
  <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
<%@ include file="/npage/include/pubLightBox.jsp" %>
</body>
</html>