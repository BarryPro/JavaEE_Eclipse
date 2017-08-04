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
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="accept"/>

<title><%=opName%></title>

<script language="javascript">
	
	
		   onload=function()
	   {
			getCustInfo();	
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
	 if(document.all.bigzame.value=="qxz") {
	 	 // rdShowMessageDialog("��ѡ��Ҫ������ʷѴ���!");
	 	  var tmpObj="";
	 	  tmpObj = "littleame";
	  	document.all(tmpObj).options.length=0;
	  return false;
	 }
		var getNote_Packet = new AJAXPacket("qryClassInfo.jsp","���ڻ��С����Ϣ�����Ժ�......");
		getNote_Packet.data.add("bigclasscode",document.all.bigzame.value);
		core.ajax.sendPacket(getNote_Packet,returnBigClass);
		getNote_Packet=null;
	 }
	 
 function returnBigClass(packet){
		var tmpObj="";
 		var errorCode = packet.data.findValueByName("retCode");
		var errorMsg =  packet.data.findValueByName("retMsg");
	  var	backArrMsg= packet.data.findValueByName("backArrMsg1");
	  if( errorCode == "000000"){
	  	 tmpObj = "littleame";
	  	 		document.all(tmpObj).options.length=0;
				  document.all(tmpObj).options.length=backArrMsg.length;
		        for(i=0;i<backArrMsg.length;i++)
			      {
				      document.all(tmpObj).options[i].text=backArrMsg[i][0];
				      document.all(tmpObj).options[i].value=backArrMsg[i][1]+"--"+backArrMsg[i][2]+"--"+backArrMsg[i][3]+"--"+backArrMsg[i][4]+"--"+backArrMsg[i][5];		        		        		        
			      }
	  }
		
		}
 
	
 function printInfo(){
			var cust_info="";
			var opr_info="";
			var note_info1="";
			var note_info2="";
			var note_info3="";
			var note_info4="";
			var baotime="";
			var baotimezhanshi="";
			var qianshu="";			
			var sm= new Array();
					sm =$('#littleame').val().split("--");
					//alert($('#littleame').val());
					baotime=sm[1];
					if(baotime=="B"){
					baotime="������";
					baotimezhanshi="����";
					}
					if(baotime=="Y"){
					baotime="����";
					baotimezhanshi="��";
					}
					else if (baotime=="150")
					{
						baotime="��ѧ��";
						baotimezhanshi="ѧ��";
					}
					else if (baotime=="360")
					{
						baotime="����";
						baotimezhanshi="��";						
					}
					qianshu=sm[2];

			var retInfo = "";
			/************�ͻ���Ϣ************/
			cust_info += "�ֻ����룺<%=phoneNo%>|";
			cust_info += "�ͻ�������"+$('#custName').text()+"|";
			
			/************��������************/

			if ( document.all.bigzame.value=="GXTC" || document.all.bigzame.value=="DZTC" )
			{
				opr_info += "ҵ�����ͣ�"+$('#littleame option:selected').text()+"|";
			}
			else
			{
				opr_info += "ҵ�����ͣ���ֵҵ��"+ $('#littleame option:selected').text()+"�������룬"
					+"�ʷ�"+qianshu+"Ԫ/"+baotimezhanshi+"��|";
			}			
			opr_info += "�������ͣ�����|";
			opr_info += "����ʱ�䣺<%=currentDate%>|";
						/************ע������************/
			if ( document.all.bigzame.value=="GXTC" || document.all.bigzame.value=="DZTC" )
			{
				note_info1 += "��ע��"+"|"+"1. ��ѧ��/�����ʷѵ�������������Ч����ѧ��/�����һ���Ի�Ϊר��"+"|"
					+"2. WLANУ԰��ѧ�ڡ������ʷѺͰ����ʷѲ����ظ�����"+"|"
					+"3. WLAN���ڰ����ʷ�������ʷѲ����ظ�����"+"|"
					+"4. ��ѧ��/�����ʷ���;���ܱ���������˶�������Ч�������ϵͳһ���Ի��գ����˻�"+"|"
					+"5. ��ѧ��/�����ʷѵ��ں󣬲��˶��Զ�תΪ��Ӧ�����ʷ�."+"|"
					+"|";

			}
			else if(document.all.bigzame.value=="CYZL"){
				note_info1 += "��ע��������ֵҵ��"+baotime+"���ʷѵ��ڵ���15��ϵͳ���·�����������"+baotime+"�ʷѼ������ڣ����Ƿ���ҪתΪ��������10Ԫ/�£����˶�ҵ���������ݶ�����ʾ���в������й��ƶ���|";
			}
			else if(document.all.bigzame.value=="HLY"){
				note_info1 += "��ע��������ֵҵ��"+baotime+"���ʷѵ��ڵ���15��ϵͳ���·�����������"+baotime+"�ʷѼ������ڣ����Ƿ���ҪתΪ�����԰��£�3Ԫ/�£����˶�ҵ���������ݶ�����ʾ���в������й��ƶ���|";
			}
			else
			{
				/*2014/02/19 9:08:02 gaopeng R_CMI_HLJ_xueyz_2014_1334133@�����Ż�����ҵ����ꡢ�������ʷѵĺ� */
				note_info1 += "��ע��������ֵҵ��" +baotime+ 
				"���ʷѵ��ڵ���25��ϵͳ�Զ�Ϊ���˶�ҵ����Ҳ������Ӫҵ�����Ͷ���0000��10086���ݶ�����ʾ�����˶����й��ƶ���|";
				/*2014/02/19 9:08:02 gaopeng R_CMI_HLJ_xueyz_2014_1334133@�����Ż�����ҵ����ꡢ�������ʷѵĺ� */
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
  	 if(document.all.bigzame.value=="qxz") {
	 	  rdShowMessageDialog("��ѡ��Ҫ������ʷѴ���!");
	 		 return false;
	 		}
	 				var sm= new Array();
					sm =$('#littleame').val().split("--");
					$('#qiyedaima').val(sm[3]);
					$('#yewudaima').val(sm[4]);
					var	chuanbaotime="";
					var baotime=sm[1];
					if(baotime=="B"){
						chuanbaotime="180";
					} else if(baotime=="Y"){
						chuanbaotime="360";
					} else {
						chuanbaotime = baotime;
					}
					$('#shijianxianzhi').val(chuanbaotime);
					
			var ret = showPrtDlg("ȷʵҪ���е��������ӡ��", "Yes");
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
	<input type="hidden" name="shijianxianzhi" id="shijianxianzhi" value="">
	<input type="hidden" name="qiyedaima" id="qiyedaima" value="">
	<input type="hidden" name="yewudaima" id="yewudaima" value="">
  <input type="hidden" name="selectvalues" id="selectvalues" value="06">
  <input type="hidden" name="locatiurl" id="locatiurl" value="fg713.jsp">
  
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
  	

  	
    <tr class="detailsLine">
  		<td class="blue">ҵ�����</td>
      <td>
      	<select id="bigzame" name="bigzame" style="width: 140px;" onChange="queryBigClass()">
      	<option value='qxz'>--��ѡ��--</option>
				<option value='YXWJ'>��Ϸ���</option>
				<option value='SJSP'>�ֻ���Ƶ</option>
				<option value='SJDM'>�ֻ���������</option>
				<option value='WXYY'>�������־��ֲ�</option>
				<option value='GXTC'>��УWLAN�ײ�</option>
				<option value='SJB'>�ֻ���</option>
				<!-- <option value='CYZL'>��������</option> -->
				<option value='HLY'>������</option>
        </select>

      </td>
      
        		<td class="blue">ҵ��С��</td>
      <td>
      	<select id="littleame" name="littleame" style="width: 200px;">

        </select>

      </td>
    </tr>
    
    
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