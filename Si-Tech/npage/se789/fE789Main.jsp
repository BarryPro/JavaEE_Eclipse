<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

<%
String regCode	=(String)session.getAttribute("regCode");
String opCode="e789";
String opName="�籣ͨҵ������";

String iLoginAccept="0";
String iChnSource="01";
String iOpCode=opCode;
String iLoginNo=(String)session.getAttribute("workNo");
String iLoginPwd=(String)session.getAttribute("password");
String iPhoneNo=request.getParameter("activePhone");
String iUserPwd="";
String iIpAddr=(String)session.getAttribute("ipAddr");

/*��ȡϵͳʱ��*/
java.util.Date sysdate = new java.util.Date();
java.util.Calendar cal = java.util.Calendar.getInstance();
cal.setTime(sysdate);
cal.set(Calendar.DAY_OF_MONTH, 1);
cal.roll(Calendar.DAY_OF_MONTH, -1);
SimpleDateFormat sf2 = new SimpleDateFormat("yyyy-MM-dd");
String opTimeD = sf2.format(cal.getTime());
System.out.println("~~~"+opTimeD );
/*������ˮ*/
String printAccept=getMaxAccept();
%>
<wtc:service name="se787Qry"  outnum="11"
	routerKey="region" routerValue="<%=regCode%>" 
	retmsg="rmE787Qry" retcode="rcE787Qry">
	<wtc:param value="<%=iLoginAccept%>"/>
	<wtc:param value="<%=iChnSource%>"/>
	<wtc:param value="<%=iOpCode%>"/>
	<wtc:param value="<%=iLoginNo%>"/>
	<wtc:param value="<%=iLoginPwd%>"/>
	<wtc:param value="<%=iPhoneNo%>"/>
	<wtc:param value="<%=iUserPwd%>"/>
	<wtc:param value="<%=iIpAddr%>"/>
</wtc:service>
<wtc:array id="rstE787Qry" scope="end" />	
<%
if(!rcE787Qry.equals("000000"))
{
%>
	<script>
		rdShowMessageDialog("<%=rcE787Qry%>:<%=rmE787Qry%>");
		removeCurrentTab();
	</script>
<%
}
else
{%>
	
<html xmlns="http://www.w3.org/1999/xhtml"> 
	<head>
		<title>�籣ͨҵ����</title>
		<script src="/npage/public/json2.js" type="text/javascript"></script>
		<script src="socialInsurance.js" type="text/javascript"></script>
	</head>
	<body>
	<form name='frmE789' action='' method='POST'>
		
		<!--ȷ�ϱ�ʶ:
			0:ȫ��У��ͨ��,
			1:Ĭ������У�鶼��ͨ��.
			2:У��IMEI��ͨ��
			3:����У�鲻ͨ��-->
		<input type='hidden' id='cfmCode' value='1'>	
		<input type='hidden' id='opCode' name='opCode' value='<%=opCode%>'>	
		<input type='hidden' id='opName' name='opName' value='<%=opName%>'>	
		<input type='hidden' id='strIdIcd' name='strIdIcd' value=''>	
		<input type='hidden' id='strNId' name='strNId' value=''>	
		<input type='hidden' id='strName' name='strName' value=''>	
		
		<!--������ˮ-->
		<input type="hidden" id = "printAccept" 
			name="printAccept" value= "<%=printAccept%>">			
		<!--ȷ�ϱ�ʶ:0:ȫ��У��ͨ��,1:У�鲻ͨ��-->
		<input type='hidden' id='cfmMsg' value=''>	
		<div id="Operation_Title">
			<div class="icon"></div>
				<B><%=opName%></B>
		</div>
		
		<DIV id="Operation_Table">
			<div class="title">
				<div id="title_zi">��������Ϣ</div>
			</div>
			<table>
			<tr>
				<th>�ֻ�����</th>
				<td><input type='text' id='phoneNo' name="phoneNo" value='<%=iPhoneNo%>' class='InputGrey'></td>
				<th>IMEI��:</th>
				<td><input type='text' id='oldImeiNo' name='oldImeiNo' value='<%=rstE787Qry[0][1]%>'class='InputGrey'></td>
			</tr>

			</table>
			<div class="title">
				<div id="title_zi">������Ϣ</div>
			</div>
			<table id='addband'>
				<tr>
					<th>�������֤��</th>
					<th> �����籣����</th>
					<th>��������</th>
				</tr>
				<%
				/*zhangyan:��������д��Ϊ��,
				�ı��������ֱ���޸ı�������,��������չ*/
				int bindNum=2;
				String gIds[]=rstE787Qry[0][5].split("\\|");
				String nIds[]=rstE787Qry[0][6].split("\\|");
				String ngNames[]=rstE787Qry[0][7].split("\\|");

				for ( int i=0;i<gIds.length;i++ )
				{
				%>
					<tr>
						<td><input type="text" id='gId<%=i%>' name='gId<%=i%>' class='InputGrey'
							value="<%=gIds[i]%>"></td>
						<td><input type="text" id='nId<%=i%>' name='nId<%=i%>' class='InputGrey'
							value="<%=nIds[i]%>"></td>
						<td><input type="text" id='ngName<%=i%>' name='ngName<%=i%>' class='InputGrey'
							value="<%=ngNames[i]%>"></td>								
					</tr>			
				<%
				}
				%>
			</table>

			<!--������ť-->
			<table>
				<tr>
					<td  id="footer">
						<input type="button" id=cfmPage value="ȷ��"
							onClick="doCfm()" class="b_foot" >
						<input type="button" id=clsPage value="�ر�"
							onClick="removeCurrentTab();" class="b_foot">						
					</td>
				</tr>
			</table>	
			<!--����������-->
			<input type='hidden' id='maxBn' value="<%=bindNum%>">
			<input type='hidden' id='ofrId' name="ofrId" value="<%=rstE787Qry[0][2]%>">
			<!--�籣��ϢJSON��-->
			<input type="hidden" id = "jsonSI" name="jsonSI" value= "">
			
			<!--������Ϣjson��-->
			<input type="hidden" id = "jsonBind" name="jsonBind" value= "">				
			<!--��ǰ��������-->	
			<input type='hidden' id='curBn' value="<%=gIds.length%>">	
		</div>
	</form>
	<script>
		function setBindInfo(packet)
		{

			var	retCode=packet.data.findValueByName("retCode"); 
			var	retMsg=packet.data.findValueByName("retMsg"); 
			var	bindCode=packet.data.findValueByName("bindCode"); 

			if (retCode!="000000")
			{
				$("#gId"+bindCode).attr("disabled" , "");
				$("#nId"+bindCode).attr("disabled" , "");
				$("#ngName"+bindCode).attr("disabled" , "");					
				
				rdShowMessageDialog(retCode+":"+retMsg , 0);
				return false;
			}
			else
			{
				/*��Ԫ�ظ�ֵ*/
				var	bindJson=packet.data.findValueByName("oBindJson"); 

				/*json����ת��*/
				var bindInfo=eval('('+bindJson+')'); 
				/*���ñ�ֵ*/
				$("#gId"+bindCode).val(bindInfo.gid);
				$("#nId"+bindCode).val(bindInfo.nid);
				$("#ngName"+bindCode).val(bindInfo.name);
		
				/*��Ԫ���û�*/
				$("#gId"+bindCode).attr("disabled" , "disabled");
				$("#nId"+bindCode).attr("disabled" , "disabled");
				$("#ngName"+bindCode).attr("disabled" , "disabled");
				$("#cfmCode").val("0");
			}
		}		
		/*��ȡ������Ϣ*/
		function getBindInfo(i , obj)
		{
			if ($("#gId"+i).val()==""
				 && $("#nId"+i).val()=="" )
			{
				rdShowMessageDialog("���֤�ź��籣���������дһ��!",0);
				return false;
			}			
				
			var addBind = new bind();
			
			addBind.setGid($("#gId"+i).val());
			addBind.setNid($("#nId"+i).val());
			addBind.setName($("#ngName"+i).val());
			
			/*ƴjson��*/
			var jsonBind = JSON.stringify(addBind,function(key,value){
				return value;
			});
			
			
			$("#gId"+i).attr("disabled" , "disabled");
			$("#nId"+i).attr("disabled" , "disabled");
			$("#ngName"+i).attr("disabled" , "disabled");							
			
			var strBind="{bid:'"+obj.value+"'}";
			var packet = new AJAXPacket("fE789MainAjax.jsp"
				,"���Ժ�...");
			packet.data.add("jsonBind" ,strBind);
			packet.data.add("bindCode" ,i);
			packet.data.add("getType" ,"getBid");
			core.ajax.sendPacket(packet,setBindInfo,true);//�첽
			packet =null;
		}		
		function doCfm()
		{
		 	//��ӡ�������ύ��
		 	var jsonSI="{'deviceid':'"+document.all.oldImeiNo.value+"'}";
		 	document.all.jsonSI.value=jsonSI;
		 	
			var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
			if(typeof(ret)!="undefined")
			{ 
				if((ret=="confirm"))
				{
					if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
					{
						document.frmE789.action="fE789Cfm.jsp";
						document.frmE789.submit();
					}
				}
				if(ret=="continueSub")
				{
					if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
					{
						document.frmE789.action="fE789Cfm.jsp";
						document.frmE789.submit();
					}
				}
			}
			else
			{
				if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
				{
					document.frmE789.action="fE789Cfm.jsp";
					document.frmE789.submit();
				}
			}	
		}
		/*��ʾ��ӡ�Ի���*/
		function showPrtDlg(printType,DlgMessage,submitCfm)
		{
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var pType="subprint";
			var billType="1";
			var sysAccept = document.all.printAccept.value;
			var printStr = printInfo(printType);
		
			var mode_code=null;
			var fav_code=null;
			var area_code=null
		
			var prop="dialogHeight:"+h+"px; "
				+"dialogWidth:"+w+"px; "
				+"dialogLeft:"+l+"px; "
				+"dialogTop:"+t+"px;"
				+"toolbar:no; menubar:no; scrollbars:yes; "
				+"resizable:no;location:no;status:no;help:no";
			var path = "<%=request.getContextPath()%>"
				+"/npage/innet/hljBillPrint_jc.jsp?DlgMsg="+DlgMessage;
			var path = path  + "&mode_code="+mode_code
				+"&fav_code="+fav_code+"&area_code="+area_code
				+"&opCode=<%=opCode%>&sysAccept="+sysAccept
				+"&phoneNo=<%=iPhoneNo%>&submitCfm=" + submitCfm
				+"&pType="+pType+"&billType="+billType
				+ "&printInfo=" + printStr;
			var ret=window.showModalDialog(path,printStr,prop);
			return ret;
		}		
	
		/*ƴ�������*/
		function printInfo(printType)
		{   
			var cust_info="";
			cust_info+= "�ֻ����룺<%=iPhoneNo%>"+"|";
			cust_info+= "�ͻ�������     <%=rstE787Qry[0][10]%>"
				+"    ֤�����룺     <%=rstE787Qry[0][0]%>"+"|";
			cust_info+= "|";
			
			/*ҵ����Ϣ*/
			var opr_info="";
			opr_info+="����ҵ���籣ͨҵ������"+"|";
			/*�豸���*/

			opr_info+="������ţ�"+"<%=printAccept%>"+"|";
			opr_info+="������Чʱ�䣺"+"<%=opTimeD%>"+"|";		
			
			var note_info1="";
			var note_info2="	��ӭʹ���й��ƶ��籣ͨҵ��"
				+"�����κ������������Ŀͻ�������ϵ��";
			var note_info3="";
			var note_info4="";
			
			/*ƴװ�����Ϣ*/
			var retInfo = "";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";    
			retInfo+=" "+"|";	
			retInfo+=" "+"|";
				
			note_info1 =retInfo;
			
			retInfo = cust_info+"#"
				+opr_info+"#"
				+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		    return retInfo;
		}				
		
	</script>
</body>
</html>
<%}%>
