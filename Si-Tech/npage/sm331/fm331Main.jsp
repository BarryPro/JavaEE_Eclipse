<%
  /*
   * ����: ���ڿ�����ʡ������ǰ̨���ֶһ����ѹ��ܼ�ȡ���һ����Ƶ�����
   * �汾: 1.0
   * ����: 2015/10/21 17:28:43
   * ����: gaopeng
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    String regionCode = (String)session.getAttribute("regionCode");
    String loginNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
 		String opCode = (String)request.getParameter("opCode");
 		String opName = (String)request.getParameter("opName");
		String phoneNo = (String)request.getParameter("activePhone");
		String loginAccept = getMaxAccept();
		
		String ipAddrM = (String)session.getAttribute("ipAddr");
 		String inst = "ͨ��phoneNo[" + phoneNo + "]��ѯ";
		String custName = "";
		String canUseJfNum = "";
		
		String  inParamsJF [] = new String[2];
    inParamsJF[0] = "select a.favour_code, a.favour_name, a.favour_point"
+"  from dbcustadm.smarkfavcode a, dcustmsg b"
+" where b.phone_no =:phoneNo"
+"   and a.region_code = substr(b.belong_code, 1, 2)"
+"   and a.sm_code = b.sm_code"
+"   and a.favour_code in"
+"       ('2003', '2004', '2005', '2002', '2001', '2056', '2057', '2058') order by a.favour_point";
    inParamsJF[1] = "phoneNo="+phoneNo;
		
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_mail" retmsg="retMessage_mail" outnum="3"> 
    <wtc:param value="<%=inParamsJF[0]%>"/>
    <wtc:param value="<%=inParamsJF[1]%>"/> 
  </wtc:service>  
  <wtc:array id="result_mail"  scope="end"/>

<wtc:service name="sm004Qry" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="retCode22" retmsg="retMsg22" outnum="2" >
      <wtc:param value="<%=loginAccept%>"/>
      <wtc:param value="01"/>
      <wtc:param value="<%=opCode%>"/>
      <wtc:param value="<%=loginNo%>"/>
      <wtc:param value="<%=noPass%>"/>
      <wtc:param value="<%=phoneNo%>"/>
      <wtc:param value=""/>
      <wtc:param value="2003"/>
  </wtc:service>

	<wtc:array id="result22" scope="end" />

<wtc:service name="sUserCustInfo" outnum="41" >
      <wtc:param value="<%=loginAccept%>"/>
      <wtc:param value="01"/>
      <wtc:param value="<%=opCode%>"/>
      <wtc:param value="<%=loginNo%>"/>
      <wtc:param value="<%=noPass%>"/>
      <wtc:param value="<%=phoneNo%>"/>
      <wtc:param value=""/>
      <wtc:param value="<%=ipAddrM%>"/>
      <wtc:param value="<%=inst%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
  </wtc:service>

	<wtc:array id="result11" scope="end" />

<%
		if(result11.length <= 0)
		{
%>
<script language="JavaScript">
			rdShowMessageDialog("���û�״̬��������");
			removeCurrentTab();
</script>
<%
			return ;
		}
		else
		{
			custName = result11[0][5];
		}
%>

<%
	if(result22.length > 0 && "000000".equals(retCode22)){
		canUseJfNum = result22[0][0];
		System.out.println("gaopengSeeLogM331=========canUseJfNum="+canUseJfNum);
	}else{
	%>
	<script language="JavaScript">
			rdShowMessageDialog("������룺<%=retCode22%>��������Ϣ�����û�״̬��������");
			removeCurrentTab();
	</script>
	<%	
		
	}
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAccept" />

  	
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
	<script language="javascript">
		
		$(document).ready(function(){
			
		});
		
		
		

		
		
		function showPrtDlg(printType,DlgMessage,submitCfm)
		  {  //��ʾ��ӡ�Ի���
			var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
		  var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
			var sysAccept ="<%=sysAccept%>";                       // ��ˮ��
			var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
			var mode_code=null;                        //�ʷѴ���
			var fav_code=null;                         //�ط�����
			var area_code=null;                    //С������
			var opCode =   "<%=opCode%>";                         //��������
			var phoneNo = "<%=phoneNo%>";                           //�ͻ��绰

		   	var h=300;
		   	var w=400;
		   	var t=screen.availHeight/2-h/2;
		   	var l=screen.availWidth/2-w/2;

		   	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
			var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
			var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
			var ret=window.showModalDialog(path,printStr,prop);
		  }

		  function printInfo(printType)
		  {	
		  	var giftInfo = $.trim($("select[name='giftInfo']").find("option:selected").val());
				
				var giftArray = new Array();
				giftArray = giftInfo.split("|");
				
				var giftName = giftArray[2];
				var giftPoint = giftArray[1];
				
        var cust_info=""; //�ͻ���Ϣ
      	var opr_info=""; //������Ϣ
      	var retInfo = "";  //��ӡ����
      	var note_info1=""; //��ע1
      	var note_info2=""; //��ע2
      	var note_info3=""; //��ע3
      	var note_info4=""; //��ע4

				cust_info+=" "+"|";
				
				cust_info+="�ֻ����룺"+"<%=phoneNo%>"+"|";
      	cust_info+="�ͻ�������<%=custName%>|";
      	
				opr_info+="����ҵ��"+giftName+"|";
				opr_info+="�һ��ۼ���������"+giftPoint+"|";
				opr_info+="ҵ����ˮ��<%=sysAccept%>"+"|";
				note_info1+= "ע��������ֶһ����ѣ�һ���ҳ��������˻���|";
					
				retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ
				
	    	return retInfo;
		  }
		
	
		function doCfm(){
			
			var giftInfo = $.trim($("select[name='giftInfo']").find("option:selected").val());
			if(giftInfo.length == 0){
				rdShowMessageDialog("��ѡ����Ʒ��");
				return false;
			}
			
			var giftArray = new Array();
			giftArray = giftInfo.split("|");
			
			var giftPoint = giftArray[1];
			
			if(Number(giftPoint) > Number("<%=canUseJfNum%>")){
				rdShowMessageDialog("��ǰ���û���ֵ���㣬������һ���");
				return false;
			}
			
			var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
			if(typeof(ret)!="undefined")
			  {
			    if((ret=="confirm"))
			    {
			      if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
			      {
				   		formConfirm();
			      }
					}
				if(ret=="continueSub")
				{
			      if(rdShowConfirmDialog('ȷ���ύ��Ϣô��')==1)
			      {
				    	formConfirm();
			      }
				}
			  }
			else
			  {
			     if(rdShowConfirmDialog('ȷ���ύ��Ϣô��')==1)
			     {
				     formConfirm();
			     }
			  }	
			  return true;
			
			
			
			
		}
		function formConfirm(){
			
			var giftInfo = $.trim($("select[name='giftInfo']").find("option:selected").val());
			var giftArray = new Array();
			giftArray = giftInfo.split("|");
			
			var giftCode = giftArray[0];
			
			/*�ύ*/
				/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm331/fm331Cfm.jsp","���ڻ�����ݣ����Ժ�......");
			
			var printAccept = "<%=sysAccept%>";
			var iOpCode = "<%=opCode%>";
			var iPhoneNo = "<%=phoneNo%>";
			
			getdataPacket.data.add("printAccept",printAccept);
			getdataPacket.data.add("opCode",iOpCode);
			getdataPacket.data.add("phoneNo",iPhoneNo);
			getdataPacket.data.add("giftCode",giftCode);
			getdataPacket.data.add("giftNo",$("#giftNo").val());
			
			
			core.ajax.sendPacket(getdataPacket,doRetCfm);
			getdataPacket = null;
					
		
		}
		
		function doRetCfm(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			if(retCode == "000000"){
				rdShowMessageDialog("�����ɹ���",2);
				window.location.reload();
			}else{
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
				window.location.reload();
			}
			
		}
		
		
	
		
	</script>
	</head>
<body>
	<form action="" method="post" name="f1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<div>
		<table>
	    <tr>
	  		<td width="20%" class="blue">�������</td>
	  		<td width="30%">
	  			<input type="text" id="phoneNo" name="phoneNo" value="<%=phoneNo%>" class="InputGrey" readonly />
	  		</td>
	  		<td width="20%" class="blue">�ͻ�����</td>
	  		<td width="30%">
	  			<input type="text" id="custName" name="custName" value="<%=custName%>" class="InputGrey" readonly />
	  		</td>
	  	</tr>
	  	<tr >
	  		<td width="20%" class="blue">���û���ֵ</td>
	  		<td width="30%">
	  			<input type="text" id="canUseJfNum" name="canUseJfNum" value="<%=canUseJfNum%>"  class="InputGrey" readonly/>
	  		</td>
	  		<td width="20%" class="blue">��Ʒ����</td>
	  		<td width="30%">
	  			<input type="text" id="giftNo" name="giftNo" value="1" class="InputGrey" readonly />
	  		</td>
	  	</tr>
		  <tr >
	  		<td width="20%" class="blue">��Ʒ��Ϣ</td>
	  		<td width="80%" colspan="3">
	  			<select name="giftInfo" style="width:260px">
	  				<option value="">-��ѡ��-</option>	
	  				<%
	  					if(result_mail.length > 0 && "000000".equals(retCode_mail)){
	  						for(int i=0;i<result_mail.length;i++){
	  				%>
	  					<option value="<%=result_mail[i][0]%>|<%=result_mail[i][2]%>|<%=result_mail[i][1]%>"><%=result_mail[i][1]%>--><%=result_mail[i][2]%>����</option>
	  				<%
	  						}
	  					}
	  				%>
	  			</select>
	  		</td>
	  		
	  	</tr>
	  	
	  </table>
	  <table>	
	  	<tr>
				<td align=center colspan="4" id="footer">
					<input class="b_foot" name="sure"  type="button" value="ȷ��&��ӡ"  onclick="doCfm();">&nbsp;&nbsp;
					<input class="b_foot" name="sure"  type="button" value="����"  onclick="javascript:window.location.reload();">&nbsp;&nbsp;
					<input class="b_foot" name="close"  onClick="removeCurrentTab()" type=button value=�ر�>
				</td>
			</tr>
		</table>
	</div>
	<div id="OfferAttribute"></div><!--����Ʒ����-->
	<!-- ��ѯ����б� -->
	<div id="resultContent" style="display:none">
		<div class="title">
			<div id="title_zi">��ѯ����б�</div>
		</div>
		<table id="exportExcel" name="exportExcel">
			<tbody id="appendBody">
				
			
			</tbody>
		</table>
		<table>
			<tr>
				<td align=center colspan="4" id="footer">
					<input class="b_foot" name="sure"  type="button" value="ȷ��"  onclick="doCfm();">&nbsp;&nbsp;
					<input class="b_foot" name="close"  onClick="removeCurrentTab()" type=button value=�ر�>
				</td>
			</tr>
		</table>
	</div>

	<%@ include file="/npage/include/footer.jsp" %>
</form>
<script>
var excelObj;
function printTable(object)
{
	var obj=document.all.exportExcel;
	rows=obj.rows.length;
	if(rows>0){
		try{
			excelObj = new ActiveXObject("excel.Application");
			excelObj.Visible = true;
			excelObj.WorkBooks.Add;
			  for(i=0;i<rows;i++){
			    cells=obj.rows[i].cells.length;
			    for(j=0;j<cells;j++)
			      excelObj.Cells(i+1,j+1).Value="'" + obj.rows[i].cells[j].innerText;
			}
		}
		catch(e){}
	} else {
		
	}
}
</script>
</body>


</html>
