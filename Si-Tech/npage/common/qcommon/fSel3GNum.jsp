<%
/*
author:zhouyg
date:2009-2-11
*/

    String opName = WtcUtil.repNull(request.getParameter("opName"));
  String opCode = WtcUtil.repNull(request.getParameter("opCode"));
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
  response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	System.out.println("==========start=============");
	//���ܴ�ֵ
		opName = "�ƶ�ѡ�Ž���";
%>
<script>
	function g3fun(packet){
	
	var retType = packet.data.findValueByName("errCode");	
	if(retType=="000000")
{
	var result = packet.data.findValueByName("tri_list");
	if(!!result&&!!result.length)
	{			
		for(var i=0;i<result.length;i++)
			{		
			 document.all.select7.options.add(new Option(result[i][0],result[i][0])); 
			}			
	}		
}
else
	{
		alert("ѡ��ʧ�ܣ��������Ա��ϵ��");
		}	
	
}
var cancelState=1;
function stateCancel(packet)
{
		var retType = packet.data.findValueByName("errCode");	
		if(retType=="000000")
			cancelState=1;
		else
			cancelState=0;
		if(!window.returnValue) window.returnValue="";
	}
function threeGcancel()
{
	if(document.all.select7.options.length>0)
	{
		var numStrArr=[];
		for(i=0;i<document.all.select7.options.length;i++)
		{
				numStrArr.push(document.all.select7.options[i].innerHTML);
			}
		var numStr=numStrArr.join("~")+"~";
		var myPacket = new AJAXPacket("3GmiddleCancel.jsp","�����ͷź�����Ϣ�����Ժ�......");	
		myPacket.data.add("cancelStr",numStr);
		core.ajax.sendPacket(myPacket,stateCancel);
		myPacket=null;
	}
	else
		!window.returnValue&&(window.returnValue="");
}
function qry_number()
{					
			document.all.select7.options.length&&(threeGcancel)();
			if(cancelState)
			{
				document.all.select7.options.length=0;
				var myPacket = new AJAXPacket("3Gmiddle.jsp","���ڻ�ú�����Ϣ�����Ժ�......");	
				core.ajax.sendPacket(myPacket,g3fun);
				myPacket=null;
			}
			else
			{
				alert("�ͷ�ʧ�ܣ�����ϵ����Ա!");
				return false;		
			}
		
}



function quxiao()
{
	window.close();
}
function selNum()
{
	document.all.SEL_NUM.value=document.all.select7.options[document.all.select7.selectedIndex].value;
  g("numChoose").value = document.all.select7.options[document.all.select7.selectedIndex].text.trim();
}
function checkSelect()
{
			for(var i = 0;i < document.all.select7.options.length;i++ )
			{
				if(document.all.select7.options[i].selected==true)
				{
					return true;
				}
			}
    	return false;
			
	}
function choose()
{
	if(!(document.all.select7.options.length&&checkSelect())){ alert("��ѡ�����");return;}
		var myPacket = new AJAXPacket("3Gmiddle.jsp","�����ͷź�����Ϣ�����Ժ�......");	
		myPacket.data.add("handNum",document.all.select7.options[document.all.select7.selectedIndex].value);
		myPacket.data.add("type","sim");		
		core.ajax.sendPacket(myPacket,simState);
		myPacket=null;
}
 function simState(packet)
 {
 	if(packet.data.findValueByName('errCode')=='000000')
 	{
 		var numStr=packet.data.findValueByName('tri_list')[0].join("~");
	if(document.all.select7.options.length!=0)
	{
		window.returnValue =numStr;
		document.all.select7.options.remove(document.all.select7.selectedIndex);
		window.close();
	}
 		}
 			else alert("ѡ��sim����Ϣʧ�ܣ�");
 	}
function checkNum()
{
			threeGcancel();
			if(cancelState==1)
			{
				var myPacket = new AJAXPacket("3Gmiddle.jsp","���ڻ�ú�����Ϣ�����Ժ�......");	
				myPacket.data.add("handNum",document.getElementById('handNum').value);
				myPacket.data.add("type","checkNum");
				core.ajax.sendPacket(myPacket,midCheck);
				myPacket=null;
			}
			else
				alert("�����ͷ�ʧ�ܣ�");
	}
function midCheck(packet)
{
	if(packet.data.findValueByName('errCode')=='000000')
	{
		threeGcancel();
			if(cancelState==1)
			{
				$(document.all.select7).empty();
				document.all.select7.options.add(new Option(document.getElementById('handNum').value,document.getElementById('handNum').value));
				$(document.all.select7).val(document.getElementById('handNum').value);
			}
			else
				alert("�����ͷ�ʧ��!");
		}
		else
			{
				alert('�˺Ų�����');
				}
	}
window.onbeforeunload=function LeaveWin()
{ 
	threeGcancel();
}
</script>

<html>
	<head>
		<title>�ƶ�ѡ�Ž���</title>
	</head>
	<body>
		<div id="operation">
				<%@ include file="/npage/include/header_pop.jsp"%>
				<div id="operation_table">
					<div class="input">	
						<table rules="rows" id="tabCustInfoQry">
							<tr>
								<td style="width:33%;vertical-align:top;padding:0;">
									<div class="title">
										<div class="text"> ����ѡ��</div>
									</div>
									<div style="border:1px solid #95cbdd;padding:5px; border-bottom:none">							
										<input id="handNum" type="text" onKeyDown="if(event.keyCode==13) checkNum();returnValue=false"/><label class="red">���س�ȷ����</label>
									</div>
									<div class="title">
										<div class="text">��ǰѡ��</div>
									</div>							
									<div style="border:1px solid #95cbdd;padding:5px;">
										<input id="numChoose" readonly="readonly" type="text" />
									</div>
								 </td>
								<td>
									<select name="select7" multiple="multiple" size="6"
										style="font-size: 30px; color: blue; width: 100%"
										onChange="selNum()" ondblclick="choose()">
									</select>
								</td>
							</tr>
						</table>
					</div>		
				</div>				
				<div id="operation_button">
					<input name="qry_num" type="button" class="b_foot" value="���ѡ��" onClick="qry_number()">
					&nbsp;
					<input name="sel_num" type="button" class="b_foot" value="ȷ&nbsp;��" onClick="choose()">
					&nbsp;
					<input name="cancel" type="button" class="b_foot" value="ȡ&nbsp;��" onClick="quxiao()">
				</div>
						<input type="hidden" name="opFlag" value="1">
						<input type="hidden" name="SEL_NUM" value="">
						<!-- ����ֵ: ����~С��ͨ���ѵȼ�(����Ϊ�մ�)~��������~��������� -->
				<%@ include file="/npage/include/footer.jsp"%>
		</div>
	</body>
</html>