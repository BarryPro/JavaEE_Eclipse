<%
/********************
 * version v2.0
 * ������: si-tech
 * update by wangwg @ 20160308
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
	String opCode = "G897";
	String opName = "���������¼��ѯ";
	String workNo = (String)session.getAttribute("workNo");
    String workName = (String)session.getAttribute("workName");
    String regionCode=(String)session.getAttribute("regCode");
    String op_name =  "���������¼��ѯ";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
		<TITLE><%=op_name%></TITLE>
		<script language=javascript>
		function isNumberString (InString,RefString)
		{
				if(InString.length==0) return (false);
				for (Count=0; Count < InString.length; Count++)  {
					TempChar= InString.substring (Count, Count+1);
					if (RefString.indexOf (TempChar, 0)==-1)  
					return (false);
				}
				return (true);
		}
		
		function trim(str){ //ɾ���������˵Ŀո�
			return str.replace(/(^\s*)|(\s*$)/g, "");
		}

		
		function doProcess(packet)
		{
			document.form.sure.disabled=false;
			document.form.reset.disabled=false;
			var error_code = packet.data.findValueByName("errorCode");
			var error_msg =  packet.data.findValueByName("errorMsg");
			var verifyType = packet.data.findValueByName("verifyType");
			if(verifyType=="phoneno")
			{
				if( parseInt(error_code) == 0 )
				{
					var als = document.getElementById("ViewMsg").children[0];
					if(als.firstChild!=null)
						als.removeChild(als.firstChild);
					var backArrMsg  =       packet.data.findValueByName("backArrMsg");
					var trTemp = document.getElementById("ViewMsg").children[0].insertRow();
					trTemp.insertCell().innerHTML ="<input class='InputGrey' size='5' readonly value='�۷��ֻ���' style='width:70px;'></input>";
					trTemp.insertCell().innerHTML ="<input class='InputGrey' readonly value='�����ֻ���' style='width:70px;'></input>";
					trTemp.insertCell().innerHTML ="<input class='InputGrey' readonly value='�ʷѴ���' style='width:50;'></input>";
					trTemp.insertCell().innerHTML ="<input class='InputGrey' readonly value='�ʷ��·�' style='width:50px;'></input>";
					trTemp.insertCell().innerHTML ="<input class='InputGrey' readonly value='��������' style='width:50px;'></input>";
					trTemp.insertCell().innerHTML ="<input class='InputGrey' readonly value='����ܼ�' style='width:50px;'></input>";
					trTemp.insertCell().innerHTML ="<input class='InputGrey' readonly value='����˵��' style='width:50px;'></input>";
					trTemp.insertCell().innerHTML ="<input class='InputGrey' readonly value='����ʱ��'></input>";
					trTemp.insertCell().innerHTML ="<input class='InputGrey' readonly value='�ʷѵ���ʱ��'></input>";
					trTemp.insertCell().innerHTML ="<input class='InputGrey' readonly value='��������' style='width:70px;'></input>";
					trTemp.insertCell().innerHTML ="<input class='InputGrey' readonly value='�ʷ�����'></input>";
					for(var i=0;i <backArrMsg.length;i++)
                    {
						var trTemp = document.getElementById("ViewMsg").children[0].insertRow();
						trTemp.insertCell().innerHTML = 
							"<input type='text' class='InputGrey' size='5' readonly value='"+backArrMsg[i][0]+"'  style='width:70px;' />";
						trTemp.insertCell().innerHTML = 
							"<input type='text' class='InputGrey' size='10' readonly value='"+backArrMsg[i][1]+"' style='width:70px;' />";
						trTemp.insertCell().innerHTML = 
							"<input type='text' class='InputGrey' size='10' readonly value='"+backArrMsg[i][2]+"' style='width:50px;' />";
						trTemp.insertCell().innerHTML = 
							"<input type='text' class='InputGrey' size='10' readonly value='"+backArrMsg[i][3]+"Ԫ/��' style='width:50px;'/>";
						trTemp.insertCell().innerHTML = 
							"<input type='text' class='InputGrey' size='10' readonly value='"+backArrMsg[i][4]+"' style='width:50px;'/>";
						trTemp.insertCell().innerHTML = 
							"<input type='text' class='InputGrey' size='10' readonly value='"+backArrMsg[i][5]+"Ԫ' style='width:50px;'/>";
						trTemp.insertCell().innerHTML = 
							"<input type='text' class='InputGrey' size='10' readonly value='"+backArrMsg[i][6]+"' style='width:50px;'/>";
						trTemp.insertCell().innerHTML = 
							"<input type='text' class='InputGrey' size='10' readonly value='"
							+backArrMsg[i][7].substr(0,4)+"/"
							+backArrMsg[i][7].substr(4,2)+"/"
							+backArrMsg[i][7].substr(6,2)+" "
							+backArrMsg[i][7].substr(8,2)+":"
							+backArrMsg[i][7].substr(10,2)+":"
							+backArrMsg[i][7].substr(12,2)+
							"' />";
						trTemp.insertCell().innerHTML = 
							"<input type='text' class='InputGrey' size='10' readonly value='"
							+backArrMsg[i][8].substr(0,4)+"/"
							+backArrMsg[i][8].substr(4,2)+"/"
							+backArrMsg[i][8].substr(6,2)+" "
							+backArrMsg[i][8].substr(8,2)+":"
							+backArrMsg[i][8].substr(10,2)+":"
							+backArrMsg[i][8].substr(12,2)+
							"' />";
						trTemp.insertCell().innerHTML = 
							"<input type='text' class='InputGrey' size='10' readonly value='"+backArrMsg[i][9]+"' style='width:70px;'/>";
						trTemp.insertCell().innerHTML = 
							"<input type='text' class='InputGrey' readonly value='"+backArrMsg[i][10]+"' />";
					}
				}
				else
				{
					rdShowMessageDialog("<br>�������:["+error_code+"]</br>������Ϣ:["+error_msg+"]",0);
				}
			}
			else
			{
				rdShowMessageDialog("<br>�������:[A00001]</br>������Ϣ:[�첽���÷����ǩ�뷵�ر�ǩ����]",0);
			}
		}

		function doCfm()
		{
			var queryvalue = trim(document.form.qryvalue.value);
			
			if(queryvalue<11 || 
				isNumberString(queryvalue,"1234567890")!=1) {
					rdShowMessageDialog("�������ֻ�����,����Ϊ11λ����!!");
					document.form.phoneno.focus();
					return false;
			}
			else
			{
				
				document.form.sure.disabled=true;
				document.form.reset.disabled=true;
				var myPacket = new AJAXPacket("fg897_2.jsp","����ȷ�ϣ����Ժ�......");
				myPacket.data.add("verifyType","phoneno");
				myPacket.data.add("queryvalue",queryvalue);
				core.ajax.sendPacket(myPacket);
				myPacket=null;
			}
		}
		</script>
	</HEAD>
	<BODY>
		<FORM action="#" method=post name=form>
			<%@ include file="/npage/include/header.jsp"%>
			<div class="title">
				<div id="title_zi"><%=op_name%></div>
			</div>
			<table cellspacing="0">
				<tbody>
					<tr>
						<td class="blue" width="15%">�ֻ���</td>
						<td   width="15%">
							<input name=qryvalue size=60 maxlength="60" >
						</td>
						<td class="blue">
							<input class="b_foot" name=sure type=button value=��ѯ onClick="doCfm()">
							<input class="b_foot" name=reset type=reset value=����>
						</td>
					</tr>
				</tbody>
			</table>
			<div id="MemDiv">
				<div class="title">
					<div id="title_zi">��ѯ���</div>
				</div>
				<div id="ViewMsg">
					<table cellSpacing="0">
					</table>
				</div>
			</div>
			<table  cellspacing="0">
				<tbody> 
					<tr> 
						<td id="footer" > 
							<input class="b_foot" name=reset type=reset value=�ر� onClick="removeCurrentTab()">
						</td>
					</tr>
				</tbody>
			</table>
		</FORM>
	</BODY>
</html>