<%
/********************
 version v1.0
������: si-tech
*
*songjia 2010/10/28
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@ page import="java.util.HashMap"%>
<HTML>
	<HEAD>
		<TITLE>���ŷ���</TITLE>
<%
  String opCode = "K085";
  String opName = "���ŷ���";
  String workNo = (String)session.getAttribute("workNo");
  String workName=(String)session.getAttribute("workName");
  String Department=(String)session.getAttribute("orgCode");
  String phone_no=(String)session.getAttribute("phone_no");
  String regionCode = Department.substring(0,2);	
%>
</HEAD>

<body onload="doFresh()">
<SCRIPT language="JavaScript">
//����һ�ң��ǳ�����
function showList(flag){
	var time     = new Date();
	var winParam = 'dialogWidth=550px;dialogHeight=480px';
	window.showModalDialog("./K085_showList.jsp?time="+time+"&flag="+flag,window, winParam);
}

//����������ź���
function writePhoneNo(msg){
	var time     = new Date();
	var winParam = 'dialogWidth=265px;dialogHeight=240px';
	window.showModalDialog("./writePhoneNo.jsp?time="+time+"&msg="+msg,window, winParam);
}
function do_back(packet)
{
	var retCode=packet.data.findValueByName("retCode");
	var msg_name = packet.data.findValueByName("msg_name");
	var phone_no = packet.data.findValueByName("phone_no");
	if(retCode == "0")
	{
		
		window.top.similarMSNPop("���ͳɹ�:"+"~"+phone_no+"~"+msg_name);
	}else{
		window.top.similarMSNPop("����ʧ��:"+"~"+phone_no+"~"+msg_name);
	}
}
function SendDi(msg_code,msg_name)
{

	var contactId =  window.top.document.getElementById("contactId").value;
	var phone_no = window.top.cCcommonTool.getCaller();   //�µĺ���
	var mobile= document.getElementById("condText").value;//�������
	if(!checkphone(mobile))
	{
		return;
	}
	//update by wench 20111103
	if(parent.parent.current_CurState !=5){
				rdShowMessageDialog("�ǽ���״̬�����ܷ���!",0);
				return;
		}
	var chkInfoPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K085/K085_msgDi_do.jsp","���ڷ���,���Ժ�...");
	chkInfoPacket.data.add("msg_code" ,  msg_code);
	chkInfoPacket.data.add("mobile" ,  mobile);
	chkInfoPacket.data.add("msg_name" ,  msg_name);
	chkInfoPacket.data.add("contactId" ,  contactId);
	chkInfoPacket.data.add("phone_no" ,  phone_no);
	core.ajax.sendPacket(chkInfoPacket,do_back);
	chkInfoPacket =null;
}

function doFresh(){

		document.getElementById("condText").value=window.top.document.getElementById("acceptPhoneNo").value;
}
function getPhoneNo(){
	var caller = window.top.cCcommonTool.getCaller();
	if(caller.length != 11)
  {
		caller= window.top.cCcommonTool.getCalled();
  }
  document.getElementById("condText").value = caller;
}
function checkphone(phoneNumber)
{
  // alert(phoneNumber);
  if(phoneNumber.length != 11)
  {
   rdShowMessageDialog("��������ֻ����볤�Ȳ���11λ��");
   return false;
  }
  else if(!isMatch(phoneNumber, "^[0-9-]+$"))
  {
   rdShowMessageDialog("���������֣�");
   return false;
  }else return true;
 }
 
 function isMatch(Str, Patrn)
 {
   var re = new RegExp(Patrn,"gim");
   return re.test(Str);
 }
 //����� ���� 0Ϊչ�� 1Ϊ����
var flag='0';
function showContent(){
	document.getElementById('hidenPhone').style.display='none';
	if(flag==0){
		document.getElementById('hidenSection').style.display='block';
		document.getElementById('hidenSection1').style.display='block';
		flag='1';
	}else{
		document.getElementById('hidenSection').style.display='none';
		document.getElementById('hidenSection1').style.display='none';
		flag='0';
	}
}
//�ֻ��̽� չ�� 0Ϊչ�� 1Ϊ����
var flag_phone='0';
function showPhone(){
	if(flag_phone==0){
		document.getElementById('hidenPhone').style.display='block';
		flag_phone='1';
	}else{
		document.getElementById('hidenPhone').style.display='none';
		flag_phone='0';
	}
	
}
	
</SCRIPT>

<FORM method=post name="frmK085">
<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">������Ϣ</div>
			</div>
			<table cellspacing="0">
        <tr>
          <td class="blue" align="center" nowrap> �ֻ�����</td>
          <td>
          	<input type="text" name="condText" size="20" maxlength="60">
          	<input type="button" name="Button1" class="b_text" value="ˢ�����к���" onclick="getPhoneNo()">
          </td>
        </tr>
    	</table>

<script>
	x = screen.availWidth;
	y = screen.availHeight;
	window.innerWidth = x;
	window.innerHeight = y;
</script>
<!------------------------>

	</div>
<%
    HashMap hashMap = new HashMap();
List queryList =(List)KFEjbClient.queryForList("query_K085_selectdxfl",hashMap);
			if (queryList != null) {                    
%>
	<div id="Operation_Table">
		<div class="title">
				<div id="title_zi">���Ѳ�ѯ</div>
		</div>
    <table cellspacing="0">
      <tr align="center">
				<td class="">
					<a href="javascript:void(0)" onClick="SendDi('101','��ѯ����');"  
						title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						if("101".equals(map.get("SENDCODE").toString())){
						out.println(map.get("SENDCONTENT").toString());
						}
						}%>">��ѯ����</a>
				</td>
				<td nowrap>
					<a href="javascript:void(0)"
						onClick="SendDi('102','��ѯ���');return false;"
						title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("102".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
						>��ѯ���</a>
				</td>
								
					<!--			<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('103','��ѯ�ʵ�');return false;" 
							title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						if("103".equals(map.get("SENDCODE").toString())){
						out.println(map.get("SENDCONTENT").toString());
						}
						}%>">��ѯ�ʵ�</a>
								</td>  -->
								
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('106001','���ƶ����ʵ�����');return false;"
										title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("106001".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>���ƶ����ʵ�����</a>
								</td>
								
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('107','�ʻ��������');return false;"  
							title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("107".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>">�ʻ��������</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('403','��ѯ������');return false;"
										title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("403".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										
										>��ѯ������</a>
								</td>							
			</tr>
			<tr align="center">								
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('106003','���Ʋ����ʵ�����');return false;"
										title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("106003".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>���Ʋ����ʵ�����</a>
								</td>
								
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('106002','ȡ�������˵�����');return false;"
										title="<%
							   for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("106002".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>ȡ�������˵�����</a>
								</td>
								
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('106004','ȡ�������˵�����');return false;"
										title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("106004".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>ȡ�������˵�����</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('109005','��ѯGPRS����');return false;"
										title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("109005".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>��ѯGPRS����</a>
								</td>	
								<td nowrap ></td>
			</tr>	
							
    </table>
  </div>
    	<div id="Operation_Table">
    <div class="title">
				<div id="title_zi">�ȵ��Ƽ�</div>
		</div>
    <table cellspacing="0">
      <tr align="center">
								<td nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('901003','���š������������ҵ��');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("901003".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>���š������������ҵ��</a>
								</td>
								<td nowrap ></td>
			</tr>
    </table>
     </div>
    	<div id="Operation_Table">
    <div class="title">
				<div id="title_zi">ҵ�����</div>
		</div>
    <table cellspacing="0">
      <tr align="center">

								<td  nowrap>
									<a href="javascript:void(0)"
										onClick="SendDi('306','����');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("306".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>����</a>
								</td>
								
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('258','���鳤���������ȡ������������ҵ��');return false;"
										title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("258".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>���鳤���������ȡ������������ҵ��</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('310','�Ų��ܼ�(PIM)');return false;"
																title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("310".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>�Ų��ܼ�(PIM)</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('303','WLAN');return false;"
																				title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("303".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"										
										>WLAN</a>
								</td>								
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('311001','�������־��ֲ���ͨ��Ա');return false;"
																				title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("311001".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>�������־��ֲ���ͨ��Ա</a>
								</td>								
							</tr>
							<tr align="center">								
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('311002','�������־��ֲ��߼���Ա');return false;"
																				title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("311002".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>�������־��ֲ��߼���Ա</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('307','�������ҵ��');return false;"
																				title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("307".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>�������ҵ��</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('326001','��������');return false;"
																				title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("326001".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>��������</a>
								</td>
								
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('309016','����');return false;"
																				title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("309016".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>����</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('308','139����');return false;"
																				title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("308".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>139����</a>
								</td>																								
							</tr>
							<tr align="center">																				
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('305','��������');return false;"
																				title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("305".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>��������</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('302','GPRS���ܼ��ײ�');return false;"
																				title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("302".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>GPRS���ܼ��ײ�</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('302004','GPRS��������');return false;"
																				title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("302004".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>GPRS��������</a>
								</td>
     					<td   nowrap ><a href="javascript:void(0)"
							onClick="SendDi('KTRMRB','��ͨ�����ձ�');return false;"
		                    title="<%
							for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("KTRMRB".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>" >��ͨ�����ձ�</a></td> 											
								</td>
					<td   colspan="1" nowrap ><a href="javascript:void(0)"
							onClick="SendDi('QXRMRB','ȡ�������ձ�');return false;"
		                    title="<%
							for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("QXRMRB".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>" >ȡ�������ձ�</a></td>																														
							</tr>
							<tr align="center">									            			
                     <td nowrap ><a href="javascript:void(0)"
							onClick="SendDi('KTCXP','��ͨ��������');return false;"
		                    title="<%
							for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("KTCXP".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>"
										>��ͨ��������</a></td>	
         <td  nowrap ><a href="javascript:void(0)"
							onClick="SendDi('QXCXP','ȡ����������');return false;"
		                    title="<%
							for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("QXCXP".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>" >ȡ����������</a></td>  
          <td  nowrap ><a href="javascript:void(0)"
							onClick="SendDi('KTLDXS','��ͨ������ʾ');return false;"
		                    title="<%
							for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("KTLDXS".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>" >��ͨ������ʾ</a></td>	
              <td nowrap ><a href="javascript:void(0)"
							onClick="SendDi('330001','ȫ������');return false;"
		                    title="<%
							for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("330001".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>"
										>ȫ������</a></td>
                 <td nowrap ><a href="javascript:void(0)"
							onClick="SendDi('361','�������輰���ҵ��');return false;"
		                    title="<%
							for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("361".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>"
										>�������輰���ҵ��</a></td>																         														         							
			</tr>		
            		<tr align="center">           			                                        			
             <td nowrap ><a href="javascript:void(0)"
							onClick="SendDi('KTBIS98','��ͨ��ݮ��������ҵ��98Ԫ�ײͣ�');return false;"
		                    title="<%
							for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("KTBIS98".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>"
										>��ͨ��ݮ��������ҵ��98Ԫ�ײͣ�</a></td>
                <td  nowrap ><a href="javascript:void(0)"
							onClick="SendDi('KTBIS108','��ͨ��ݮ��������ҵ��108Ԫ�ײͣ�');return false;"
		                    title="<%
							for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("KTBIS108".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>" >��ͨ��ݮ��������ҵ��108Ԫ�ײͣ�</a></td>  
              <td  nowrap ><a href="javascript:void(0)"
							onClick="SendDi('QXBIS','ȡ����ݮ��������ҵ��');return false;"
		                    title="<%
							for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("QXBIS".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>" >ȡ����ݮ��������ҵ��</a></td>  
							<td  nowrap ><a href="javascript:void(0)"
							onClick=showPhone();return false;"
							title="<%
           		for(int i = 0; i < queryList.size(); i++){   
					    	Map map = (Map)queryList.get(i);  
						    if("CXJXD".equals(map.get("SENDCODE").toString())){
						    	out.println(map.get("SENDCONTENT").toString());
						    }
						  }						
							%>">�ֻ��̽�</a></td>		
							<td nowrap ></td>					         					         																							         					         
                    </tr>
                   <tbody id='hidenSection' style="display:none">    
                  </tbody>
         <tbody id='hidenPhone' style="display:none">           	    
          <tr align="center">
          <td nowrap ><a href="javascript:void(0)"
							onClick="SendDi('325001','�ƶ��̻�WAPҵ��');return false;"
		               title="<%for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("325001".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>"
										>�ƶ��̻�WAPҵ��</a></td>
            <td  nowrap ><a href="javascript:void(0)"
							onClick="SendDi('325002','����ר������ҵ��');return false;"
		                    title="<%
							for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("325002".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>" >����ר������ҵ��</a></td>
                                 
           <td  nowrap ><a href="javascript:void(0)"
							onClick="SendDi('325003','����ר����������');return false;"
		                    title="<%
							for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("325003".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>" >����ר����������</a></td>
                                 <td  nowrap ><a href="javascript:void(0)"
							onClick="SendDi('325004','�����Ѷ����ҵ��');return false;"
		                    title="<%
							for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("325004".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>" >�����Ѷ����ҵ��</a></td>
                                    <td  nowrap ><a href="javascript:void(0)"
							onClick="SendDi('325005','�����Ѷ��������');return false;"
							title="<%for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("325005".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }                 }
						         %>"
		                    >�����Ѷ��������</a></td>                
           </tr>
         <tr align="center">
          <td nowrap ><a href="javascript:void(0)"
							onClick="SendDi('325006','������۶���ҵ��');return false;"
		               title="<%for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("325006".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>"
										>������۶���ҵ��</a></td>
            <td  nowrap ><a href="javascript:void(0)"
							onClick="SendDi('325007','��ҵ�`����ҵ��');return false;"
		                    title="<%
							for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("325007".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>" >��ҵ�`����ҵ��</a></td>
                                 
           <td  nowrap ><a href="javascript:void(0)"
							onClick="SendDi('325008','�¸���Ѷ');return false;"
		                    title="<%
							for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("325008".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>" >�¸���Ѷ</a></td>
                                 <td  nowrap ><a href="javascript:void(0)"
							onClick="SendDi('325009','�����챨');return false;"
		                    title="<%
							for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("325009".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>" >�����챨</a></td>
                                    <td  nowrap ><a href="javascript:void(0)"
							onClick="SendDi('325010','�����챨');return false;"
							         title="<%for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("325010".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>"
		                    >�����챨</a></td>                
           </tr>
         </tbody>
              
    </table>
     </div>
    	<div id="Operation_Table">
  <div class="title">
				<div id="title_zi">�ײͰ���</div>
		</div>
    <table cellspacing="0">
      <tr align="center">
									<td  nowrap>
									<a href="javascript:void(0)"
										onClick="showList(1);return false;"
																				title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTLCYJ".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>����һ��</a>
								</td>
								
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="showList(2);return false;"
																				title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTFCJQ".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>�ǳ�����</a>
								</td>
								
								<!-- update by liuhaoa -->
           <td nowrap="nowrap"><a href="javascript:void(0)" onclick="showList(3);return false;" title="<%
           		for(int i = 0; i < queryList.size(); i++){   
					    	Map map = (Map)queryList.get(i);  
						    if("QXLCYJ".equals(map.get("SENDCODE").toString())){
						    	out.println(map.get("SENDCONTENT").toString());
						    }
						  }
           	%>"
           	>
           	ȡ������һ��</a></td>
								
								<td nowrap="nowrap" ><a href="javascript:void(0)" onclick="showList(4);return false;" title="<%
           		for(int i = 0; i < queryList.size(); i++){   
					    	Map map = (Map)queryList.get(i);  
						    if("QXFCJQ".equals(map.get("SENDCODE").toString())){
						    	out.println(map.get("SENDCONTENT").toString());
						    } 
						  }
           	%>"
           	>
           	ȡ���ǳ�����</a></td>
								
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQSW58','ȫ��ͨ����58�ײ�');return false;"
																				title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQSW58".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>ȫ��ͨ����58�ײ�</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQSW88','ȫ��ͨ����88�ײ�');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQSW88".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>ȫ��ͨ����88�ײ�</a>
								</td>
			</tr>
			 <tr align="center">
			 					<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQSW128','ȫ��ͨ����128�ײ�');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQSW128".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>ȫ��ͨ����128�ײ�</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQSL58','ȫ��ͨ����58�ײ�');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQSL58".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>ȫ��ͨ����58�ײ�</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQSL88','ȫ��ͨ����88�ײ�');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQSL88".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>ȫ��ͨ����88�ײ�</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQSL128','ȫ��ͨ����128�ײ�');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQSL128".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>ȫ��ͨ����128�ײ�</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQSL158','ȫ��ͨ����158�ײ�');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQSL158".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>ȫ��ͨ����158�ײ�</a>
								</td>
									<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQSL188','ȫ��ͨ����188�ײ�');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQSL188".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>ȫ��ͨ����188�ײ�</a>
								</td>
			</tr>
			 <tr align="center">
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQSL288','ȫ��ͨ����288�ײ�');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQSL288".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>ȫ��ͨ����288�ײ�</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQSL388','ȫ��ͨ����388�ײ�');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQSL388".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>ȫ��ͨ����388�ײ�</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQSL588','ȫ��ͨ����588�ײ�');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQSL588".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>ȫ��ͨ����588�ײ�</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQSL888','ȫ��ͨ����888�ײ�');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQSL888".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>ȫ��ͨ����888�ײ�</a>
								</td>
												<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQBD58','ȫ��ͨ����58�ײ�');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQBD58".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>ȫ��ͨ����58�ײ�</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQBD88','ȫ��ͨ����88�ײ�');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQBD88".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>ȫ��ͨ����88�ײ�</a>
								</td>
			</tr>
		  <tr align="center">
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQBD128','ȫ��ͨ����128�ײ�');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQBD128".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>ȫ��ͨ����128�ײ�</a>
								</td>
								
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQDXB','ȫ��ͨ�ײ�ר�����Ű�');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQDXB".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>ȫ��ͨ�ײ�ר�����Ű�</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQCXB','ȫ��ͨ�ײ�ר�����ű�');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQCXB".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>ȫ��ͨ�ײ�ר�����ű�</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQZXB','ȫ��ͨ�����');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQZXB".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>ȫ��ͨ�����</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQYDB','ȫ��ͨ�Ķ���');return false;"
										
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQYDB".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>ȫ��ͨ�Ķ���</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQYYB','ȫ��ͨ���ְ�');return false;"
										
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQYYB".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>ȫ��ͨ���ְ�</a>
								</td>
			</tr>
					  <tr align="center">
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQFHZXB','ȫ��ͨ�����Ѷ��');return false;"
										
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQFHZXB".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>ȫ��ͨ�����Ѷ��</a>
								</td>
                                <td  nowrap ><a href="javascript:void(0)"
										onClick="SendDi('KTQQDX','��ͨ�������');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQQDX".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>��ͨ�������</a></td>
                                         <td nowrap ><a href="javascript:void(0)"
										onClick="SendDi('QXQQDX','ȡ���������');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("QXQQDX".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>ȡ���������</a></td>
         <td  nowrap><a  href="javascript:void(0)"  
             onClick="writePhoneNo('��ͨ������ڳ�;')"    
             title='<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("DXCT".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>'
             
             >��ͨ������ڳ�;</a></td>
        <td  nowrap="nowrap" ><a  href="javascript:void(0)"
             onClick="writePhoneNo('���������ڳ�;')" 
              title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("BGDXCT".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
             
             
             >���������ڳ�;</a></td>
      <td nowrap="nowrap" ><a  href="javascript:void(0)"
             onClick="writePhoneNo('ȡ��������ڳ�;')" 
             
            title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("QXDXCT".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
             
             >ȡ��������ڳ�;</a></td>
             </tr>
          <!-- add by jiyk 2012-05-28 -->
          <tr align="center">
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('CXQQDXHM','��ѯ������ź���');return false;"
										
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("CXQQDXHM".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>��ѯ������ź���</a>
								</td>
                                <td  nowrap ><a href="javascript:void(0)"
										onClick="SendDi('SZQQDXHM','����������ź���');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("SZQQDXHM".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>����������ź���</a></td>
                                         <td nowrap ><a href="javascript:void(0)"
										onClick="SendDi('XGQQDXHM','�޸�������ź���');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("XGQQDXHM".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>�޸�������ź���</a></td>
         <td  nowrap><a  href="javascript:void(0)"  
             onClick="SendDi('CXDXCT','��ѯ������ڳ�;');return false;" 
             title='<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("CXDXCT".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>'
             
             >��ѯ������ڳ�;</a></td>
        <td  nowrap="nowrap" ><a  href="javascript:void(0)"
            onClick="SendDi('JSDXCT','���ܶ�����ڳ�;');return false;" 
              title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("JSDXCT".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
             
             
             >���ܶ�����ڳ�;</a></td>
            <td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('245007','���Ű���');return false;"
																				title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("245007".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>���Ű���</a>
								</td>
       <tbody id='hidenSection1' style="display:none">
					  <tr align="center">
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTDX3','��ͨ����3Ԫ����');return false;"
										
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTDX3".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>��ͨ����3Ԫ����</a>
								</td>
                                <td  nowrap ><a href="javascript:void(0)"
										onClick="SendDi('QXDX3','ȡ������3Ԫ����');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("QXDX3".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>ȡ������3Ԫ����</a></td>
                                         <td nowrap ><a href="javascript:void(0)"
										onClick="SendDi('KTDX5','��ͨ����5Ԫ����');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTDX5".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>��ͨ����5Ԫ����</a></td>
         <td  nowrap><a  href="javascript:void(0)"  
             onClick="SendDi('QXDX5','ȡ������5Ԫ����')"    
             title='<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("QXDX5".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>'
             
             >ȡ������5Ԫ����</a></td>
        <td  nowrap="nowrap" ><a  href="javascript:void(0)"
             onClick="SendDi('KTDX10','��ͨ����10Ԫ����')" 
              title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTDX10".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
             
             
             >��ͨ����10Ԫ����</a></td>
      <td nowrap="nowrap" ><a  href="javascript:void(0)"
             onClick="SendDi('QXDX10','ȡ������10Ԫ����')" 
             
            title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("QXDX10".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
             
             >ȡ������10Ԫ����</a></td>
						
			</tr>
		
					  <tr align="center">
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTDX15','��ͨ����15Ԫ����');return false;"
										
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTDX15".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>��ͨ����15Ԫ����</a>
								</td>
                                <td  nowrap ><a href="javascript:void(0)"
										onClick="SendDi('QXDX15','ȡ������15Ԫ����');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("QXDX15".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>ȡ������15Ԫ����</a></td>
                                         <td nowrap ><a href="javascript:void(0)"
										onClick="SendDi('KTDX20','��ͨ����20Ԫ����');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTDX20".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>��ͨ����20Ԫ����</a></td>
         <td  nowrap><a  href="javascript:void(0)"  
             onClick="SendDi('QXDX20','ȡ������20Ԫ����')"    
             title='<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("QXDX20".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>'
             
             >ȡ������20Ԫ����</a></td>
<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('SQQQ','�������鳩��');return false;"
										
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("SQQQ".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>�������鳩��</a>
								</td> 
 <td  nowrap ><a href="javascript:void(0)"
										onClick="SendDi('QXQQ','ȡ�����鳩��');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("QXQQ".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>ȡ�����鳩��</a></td>								            						
			</tr>
				<!-- add by jiyk 2012-05-28 -->			
			<tr align="center">              
        <td nowrap ><a href="javascript:void(0)"
										onClick="SendDi('SZQQCL','�������鳩��');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("SZQQCL".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>�������鳩��</a></td>
         <td  nowrap><a  href="javascript:void(0)"  
             onClick="SendDi('XGQQHM','������鳩��')"    
             title='<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("XGQQHM".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>'
              
             >������鳩��</a></td>
        <td  nowrap="nowrap" ><a  href="javascript:void(0)"
             onClick="SendDi('CXQQCL','��ѯ���鳩��')" 
              title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("CXQQCL".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
             
             
             >��ѯ���鳩��</a></td>
      <td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('245006','IP�Ż����');return false;"
																				title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("245006".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>IP�Ż����</a>
								</td>
			<td  nowrap ></td>	
      <td  nowrap ></td>				
			</tr>
		<!-- end of jiyk add-->
		</tbody>				
			
    </table>
     </div>
    	<div id="Operation_Table">
      <div class="title">
				<div id="title_zi">�������������</div>
		</div>
    <table cellspacing="0">
      <tr align="center">
							<td  nowrap>
									<a href="javascript:void(0)"
										onClick="SendDi('108001','���ֲ�ѯ');return false;"
										title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("108001".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>���ֲ�ѯ</a>
								</td>
								
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('401001','�������');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("401001".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>�������</a>
								</td>
								
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('401002','��������');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("401002".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>��������</a>
								</td>
								
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('504','');"></a>
								</td>
								
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('105','');"></a>
								</td>
			</tr>
    </table>
 </div>
    	<div id="Operation_Table">
    	   <div class="title">
				<div id="title_zi">��������</div>
		</div>
    <table cellspacing="0">
      <tr align="center">
							<td  nowrap>
									<a href="javascript:void(0)"
										onClick="SendDi('0000','ͳһ��ѯ�˶�');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("0000".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>ͳһ��ѯ�˶�</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('258172','������Ϣ�շ�����');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("258172".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>������Ϣ�շ�����</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('258173','ȡ����Ϣ�շ�����');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("258173".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>ȡ����Ϣ�շ�����</a>
								</td>
								
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTTQ','24Сʱ����Ԥ��ҵ��ͨ');return false;"
										
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTTQ".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>24Сʱ����Ԥ��ҵ��ͨ</a>
								</td>
						<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('QXTQ','24Сʱ����Ԥ��ҵ��ȡ��');return false;"
										
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("QXTQ".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>24Сʱ����Ԥ��ҵ��ȡ��</a>
								</td>
			</tr>
    </table>	
 </div>
 
 <div id="Operation_Table">
    	   <div class="title">
				<div id="title_zi">WLAN�ײͰ���</div>
		</div>
    <table cellspacing="0">
      <tr align="center">
							<td  nowrap>
									<a href="javascript:void(0)"
										onClick="SendDi('KTWLAN30','��ͨ10��WLAN30Ԫ�����ײ�');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTWLAN30".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>��ͨ10��WLAN30Ԫ�����ײ�</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTWLAN50','��ͨ10��WLAN50Ԫ�����ײ�');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTWLAN50".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>��ͨ10��WLAN50Ԫ�����ײ�</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTWLAN100','��ͨ10��WLAN100Ԫ�����ײ�');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTWLAN100".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>��ͨ10��WLAN100Ԫ�����ײ�</a>
								</td>	
			</tr>
              <tr align="center">
							<td  nowrap>
									<a href="javascript:void(0)"
										onClick="SendDi('BGWLAN30','���10��WLAN30Ԫ�����ײ�');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("BGWLAN30".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>���10��WLAN30Ԫ�����ײ�</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('BGWLAN50','���10��WLAN50Ԫ�����ײ�');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("BGWLAN50".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>���10��WLAN50Ԫ�����ײ�</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('BGWLAN100','���10��WLAN100Ԫ�����ײ�');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("BGWLAN100".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>���10��WLAN100Ԫ�����ײ�</a>
								</td>	
			</tr>
             <tr align="center">
							<td  nowrap>
									<a href="javascript:void(0)"
										onClick="SendDi('BGEDU10','���WLAN40Сʱ�����ײ�');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("BGEDU10".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>���WLAN40Сʱ�����ײ�</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('BGEDU20','���WLAN100Сʱ�����ײ�');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("BGEDU20".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>���WLAN100Сʱ�����ײ�</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('BGEDU40','���WLAN250Сʱ�����ײ�');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("BGEDU40".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>���WLAN250Сʱ�����ײ�</a>
								</td>	
			</tr>
             <tr align="center">
							<td  nowrap>
									<a href="javascript:void(0)"
										onClick="SendDi('KTEDU10','��ͨWLAN40Сʱ�����ײ�');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTEDU10".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>��ͨWLAN40Сʱ�����ײ�</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTEDU20','��ͨWLAN100Сʱ�����ײ�');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTEDU20".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>��ͨWLAN100Сʱ�����ײ�</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTEDU40','��ͨWLAN250Сʱ�����ײ�');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTEDU40".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>��ͨWLAN250Сʱ�����ײ�</a>
								</td>	
								
								
								
			</tr>
			<tr align="center">
							<td  nowrap>
									<a href="javascript:void(0)"
										onClick="SendDi('QXWLANTC','ȡ��10��WLAN�����ײ�');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("QXWLANTC".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>ȡ��10��WLAN�����ײ�</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('QXEDUTC','ȡ��WLAN��У�Ż��ʷ��ײ�');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("QXEDUTC".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>ȡ��WLAN��У�Ż��ʷ��ײ�</a>
								</td>
								<td  nowrap >
								</td>	
								
								
								
			</tr>
    </table>	
 </div>
 
<table cellspacing="0">
  <tr align="center">
    <td id="footer">
      &nbsp; <input name=back class="b_foot" onClick="parent.removeTab('<%=opCode%>')" type=button value=�ر�>
      &nbsp; <input name=back class="b_foot" onClick=" showContent();" type=button value=�����>
    </td>
  </tr>
</table>
<%}
%>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
<!--***********************************************************************-->
