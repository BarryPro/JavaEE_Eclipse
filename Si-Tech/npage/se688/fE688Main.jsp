<%
/*
 * ����: ʡ��Я��
 * �汾: 1.0
 * ����: 2012/3/9 14:19:13
 * ����: zhangyan
 * ��Ȩ: si-tech
 * update:
*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
String opCode="e688";
String opName="ʡ��Я��ȡ��";
String regCode=(String)session.getAttribute("regCode");
String phoneNo=request.getParameter("activePhone");
String workNo=(String)session.getAttribute("workNo");
String password=(String)session.getAttribute("password");

/*ҵ�����ʱ��*/
java.util.Date sysdate = new java.util.Date();
java.text.SimpleDateFormat sf2
	= new java.text.SimpleDateFormat("yyyy��MM��dd��");
String createTime2 = sf2.format(sysdate);

%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="sLoginAccept"/>
<%
String create_accept = sLoginAccept; 
System.out.println("zhangyan 1111111 create_accept" +create_accept);
%>
<!--��ͻ���Ϣ-->
<wtc:service name="sCustDocSmQry" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
  <wtc:param value="0"/>
  <wtc:param value="01"/>
  <wtc:param value="<%=opCode%>"/>
  <wtc:param value="<%=workNo%>"/>	
  <wtc:param value="<%=password%>"/>		
  <wtc:param value="<%=phoneNo%>"/>	
  <wtc:param value=""/>
</wtc:service>
<wtc:array id="rstCmsg" scope="end"/>
<%
String custName="";
String smName="";
if("000000".equals(retCode1)){
  if ( rstCmsg.length==0 )
  {
  	%>
  	<script>
  		rdShowMessageDialog	("��ͻ���Ϣ����" , 0);
  		removeCurrentTab();
  	</script>
  	<%
  }else
  {
  	custName=rstCmsg[0][0];
  	smName=rstCmsg[1][0];
  }
}else{
%>
  <script>
    rdShowMessageDialog	("������룺<%=retCode1%><br>������Ϣ��<%=retMsg1%>" , 0);
    removeCurrentTab();
  </script>
<%
}


out.println("custName="+custName+"--smName="+smName);
%>
<html>
	<head>
		<script src="../public/json2.js" type="text/javascript"></script>
		<script src="fE688OfferObj.js" type="text/javascript"></script>
		<script language="javascript">
			function doCfm()
			{
				
				if (	$("#checkFlag").val()=="0")
				{
					rdShowMessageDialog("������У�������ˮ!",0);
					return false;
				}
				
				$("#confirm").attr("disabled",false);
				var param1		= new	param();
				var business1	= new	business();
				var publicinfo1	= new	pubicinfo();
				var offerList1	= new	OfferList();
				
				publicinfo1.setCreate_accept( "<%=create_accept%>" );
				publicinfo1.setPhone_no( $("#phoneNo").val() );
				publicinfo1.setOpCode("e688");
				publicinfo1.setLoginNo("<%=workNo%>");
				publicinfo1.setOp_note("e688ʡ��Я�ų���");
				param1.setBack_accept(document.getElementById("old_accept").value);
				
				business1.setParam(param1);
				business1.setFuncname("pubChgCityRevs");
				
				offerList1.setBusiness(business1);
				offerList1.setPubicinfo(publicinfo1);
				
				var paramBelong		= new	param();
				var businessBelong	= new	business();	
				businessBelong.setFuncname("pubPhoneBelongChg");
				paramBelong.setOper("07");	
				paramBelong.setGroup_id("");
				paramBelong.setIn_group_id("");
				paramBelong.setSend_status("");
				paramBelong.setSms_release("");
				paramBelong.setBack_accept( document.getElementById("old_accept").value );
				businessBelong.setParam(paramBelong);
				offerList1.setBusiness(businessBelong);
				
				/*��ֵҵ��*/
				var paramAdd		= new	param();
				var businessAdd	= new	business();		
				businessAdd.setFuncname("platBusiOper");					
				paramAdd.setOper("07");
				//paramAdd.setBusitype(valueAddedServices[j][0]);
				businessAdd.setParam(paramAdd);	
					
				offerList1.setBusiness(businessAdd);	
				
				var businessAdd1	= new	business();	
				var paramAdd1		= new	param();
				businessAdd1.setFuncname("spBusiOper");					
				paramAdd1.setOper("07");

				businessAdd1.setParam(paramAdd1);	
				offerList1.setBusiness(businessAdd1);	
				
				var myJSONText = JSON.stringify(offerList1,function(key,value){
					return value;
				});
				document.getElementById("myJSONText").value=myJSONText;	
				//conf();
				//alert(myJSONText);
				
				var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
				if(typeof(ret)!="undefined")
				{ 
					if((ret=="confirm"))
					{
						if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
						{
							conf();
						}
					}
					if(ret=="continueSub")
					{
						if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
						{
							conf();
						}
					}
				}
				else
				{
					if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
					{
						conf();
					}
				}			
			}
			function showPrtDlg(printType,DlgMessage,submitCfm)
			{  //��ʾ��ӡ�Ի���
				var h=210;
				var w=400;
				var t=screen.availHeight/2-h/2;
				var l=screen.availWidth/2-w/2;
				var pType="subprint";
				var billType="1";
				//var sysAccept = document.all.login_accept.value;
				var printStr = printInfo(printType);
			
				var mode_code=null;
				var fav_code=null;
				var area_code=null
			
				var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
				var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg="+DlgMessage;
				var path = path  
					+"&mode_code="+mode_code
					+"&fav_code="+fav_code
					+"&area_code="+area_code
					+"&opCode=<%=opCode%>"
					+"&sysAccept=<%=create_accept%>"
					+"&phoneNo="+$("#phoneNo").val()
					+"&submitCfm=" + submitCfm
					+"&pType="+pType
					+"&billType="+billType
					+"&printInfo=" + printStr;
				var ret=window.showModalDialog(path,printStr,prop);
				return ret;
			}		
			
			/*��װ��ӡ��Ϣ*/		
			function printInfo(printType)
			{    
				/*�ͻ���Ϣ*/
				var cust_info="";
				/*ҵ����Ϣ*/
				var opr_info="";
				
				/*��ע��Ϣ*/
				var note_info1="";
				var note_info2="";
				var note_info3="";
				var note_info4="";
				
				var retInfo = "";
				
				/*�ͻ���Ϣ*/
				cust_info+= "�ֻ����룺     "+document.all.phoneNo.value+"|";
				cust_info+= "�ͻ�������     "+"<%=custName%>"+"|";
          
				/*ҵ����Ϣ*/
				opr_info+="�ͻ�Ʒ�ƣ�"+"<%=smName%>"+"     ����ҵ�� ȡ��ʡ��Я��ԤԼ"
					+"            ��Ч��ʽ��������Ч"+"|";
				opr_info+="������ˮ��"+"<%=create_accept%>"+"|"; 	
				opr_info+="ҵ�����ʱ�䣺"+"<%=createTime2%>"+"|";              
				opr_info+="	ԤԼЯ���أ�"+document.all.outRegNm.value
					+"      ԤԼЯ��أ�"+document.all.inRegNm.value+"|";              
				opr_info+="��ǰ���ʷѣ�("+document.all.curOi.value+"��"
					+document.all.curOn.value+")  "+"|";  
				opr_info+="ҵ��˵����"+"|";	
				opr_info+="����ǰ���ʷѡ���ֵҵ�񽫱���������շ�ԭ�򲻱䡣"+"|";	
				opr_info+="ȡ��Я��ԤԼҵ��������Ը�����Ҫ�����в���Ӫ�����"
					+"���������ʷѡ�����ҵ�����ֵҵ��"+"|";	
				
				/*��ע��Ϣ*/
				note_info1+="1. ���ɸ�����Ҫ���ٴΰ�����ԤԼʡ��Я��ҵ��ʱ��ȡ����ҵ��"+"|";		
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";    
				retInfo+=" "+"|";	
				retInfo+=" "+"|";
				
				//note_info1 =retInfo;
			
				retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
				retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
				return retInfo;
			}
			
				
			function conf()
			{
				document.e688MainForm.action="fE688Cfm.jsp";
				document.e688MainForm.submit();
			}
			
			function checkAccept1()
			{
				
				if ($("#old_accept").val()=="")
				{
					rdShowMessageDialog("�������������ˮ!",0);
					return false;
				}
				var packet = new AJAXPacket("fE688CheckAccept.jsp","���Ժ�...");
				packet.data.add("old_accept",$("#old_accept").val());
				packet.data.add("phoneNo",$("#phoneNo").val());
				core.ajax.sendPacket(packet,checkRst);
				packet =null;					
			}
			
			function checkRst(packet)
			{
				var errorCode 	= packet.data.findValueByName("errorCode");
				var errorMsg 	= packet.data.findValueByName("errorMsg");	
				var arrE688 	= packet.data.findValueByName("arrE688");	
				if (errorCode=="000000")
				{
					//rdShowMessageDialog(errorCode+":"+errorMsg);
					$("#confirm").attr("disabled",false);
					$("#old_accept").attr("disabled",true);
					$("#checkFlag").val("1");
					$("#phoneNo").val(arrE688[0]);
					$("#loginNo").val(arrE688[1]);
					$("#opTime").val(arrE688[2]);
					$("#outRegNm").val(arrE688[3]);
					$("#inRegNm").val(arrE688[4]);
					$("#curOi").val(arrE688[5]);
					$("#curOn").val(arrE688[6]);
					
				}			
				else
				{
					rdShowMessageDialog(errorCode+":"+errorMsg);
				}
			}
		</script>
	</head>
	<FORM name="e688MainForm" action="" method=post>
		<%@ include file="/npage/include/header.jsp" %>	

		<input type="hidden" id="opCode" name="opCode" value="<%=opCode%>">
		<input type="hidden" id="opName" name="opName" value="<%=opName%>">
		
		<input type="hidden" id="myJSONText" name="myJSONText" value="">
		<input type="hidden" id="checkFlag" name="checkFlag" value="0">
		<!--��ǰ�ʷѴ���-->
		<input type="hidden" id="curOi" name="checkFlag" value="0">
		<!--��ǰ�ʷ�����-->
		<input type="hidden" id="curOn" name="checkFlag" value="0">
		
		<div class="title" >
			<div id="title_zi">ʡ��Я��ȡ��</div>
		</div>	
		<table>
			<tr>
				<th align="center">������ˮ</th>
				<td  colspan="3" >
					<input type="text" id = "old_accept" name="old_accept" >
					<input type="button" id="checkAccept" name = "checkAccept" 
						onclick = "checkAccept1()" value="У��" class = "b_text">
				</td>
			</tr>
			<tr>
				<th align="center">�ֻ���</th>
				<td colspan="3" >
					<input type="text" class="InputGrey" 
						name="phoneNo" id="phoneNo" value="<%=phoneNo%>">
				</td>
			</tr>
			<tr>
				<th align="center">��������</th>
				<td>
					<input type="text" class="InputGrey" name="loginNo" id="loginNo">
				</td>
				<th align="center">����ʱ��</th>
				<td>
					<input type="text" class="InputGrey" name="opTime" id="opTime">
				</td>
			</tr>
			<tr>
				<th align="center">Я����</th>
				<td>
					<input type="text" class="InputGrey" name="outRegNm" id="outRegNm">
				</td>
				<th align="center">Я���</th>
				<td>
					<input type="text" class="InputGrey" name="inRegNm" id="inRegNm">
				</td>
			</tr>			
			
			<tr id="footer">
				<td colspan="4">
					<input class="b_foot" name=confirm id="confirm" type=button
						onClick="doCfm()" value="ȷ��" disabled >
					<input class="b_foot" name=back onClick="removeCurrentTab()"
						type=button value="�ر�">
				</td>				
			</tr>
		</table>
		
		<%@ include file="/npage/include/footer_new.jsp"%>
	</form>
</html>