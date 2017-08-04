<%
/********************
 version v1.0
开发商: si-tech
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
		<TITLE>短信分流</TITLE>
<%
  String opCode = "K085";
  String opName = "短信分流";
  String workNo = (String)session.getAttribute("workNo");
  String workName=(String)session.getAttribute("workName");
  String Department=(String)session.getAttribute("orgCode");
  String phone_no=(String)session.getAttribute("phone_no");
  String regionCode = Department.substring(0,2);	
%>
</HEAD>

<body onload="doFresh()">
<SCRIPT language="JavaScript">
//两城一家，非常假期
function showList(flag){
	var time     = new Date();
	var winParam = 'dialogWidth=550px;dialogHeight=480px';
	window.showModalDialog("./K085_showList.jsp?time="+time+"&flag="+flag,window, winParam);
}

//设置亲情短信号码
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
		
		window.top.similarMSNPop("发送成功:"+"~"+phone_no+"~"+msg_name);
	}else{
		window.top.similarMSNPop("操作失败:"+"~"+phone_no+"~"+msg_name);
	}
}
function SendDi(msg_code,msg_name)
{

	var contactId =  window.top.document.getElementById("contactId").value;
	var phone_no = window.top.cCcommonTool.getCaller();   //新的号码
	var mobile= document.getElementById("condText").value;//受理号码
	if(!checkphone(mobile))
	{
		return;
	}
	//update by wench 20111103
	if(parent.parent.current_CurState !=5){
				rdShowMessageDialog("非接续状态，不能发送!",0);
				return;
		}
	var chkInfoPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K085/K085_msgDi_do.jsp","正在发送,请稍候...");
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
   rdShowMessageDialog("您输入的手机号码长度不是11位！");
   return false;
  }
  else if(!isMatch(phoneNumber, "^[0-9-]+$"))
  {
   rdShowMessageDialog("请输入数字！");
   return false;
  }else return true;
 }
 
 function isMatch(Str, Patrn)
 {
   var re = new RegExp(Patrn,"gim");
   return re.test(Str);
 }
 //收起键 触发 0为展开 1为收起
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
//手机商界 展开 0为展开 1为收起
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
				<div id="title_zi">条件信息</div>
			</div>
			<table cellspacing="0">
        <tr>
          <td class="blue" align="center" nowrap> 手机号码</td>
          <td>
          	<input type="text" name="condText" size="20" maxlength="60">
          	<input type="button" name="Button1" class="b_text" value="刷新主叫号码" onclick="getPhoneNo()">
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
				<div id="title_zi">话费查询</div>
		</div>
    <table cellspacing="0">
      <tr align="center">
				<td class="">
					<a href="javascript:void(0)" onClick="SendDi('101','查询话费');"  
						title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						if("101".equals(map.get("SENDCODE").toString())){
						out.println(map.get("SENDCONTENT").toString());
						}
						}%>">查询话费</a>
				</td>
				<td nowrap>
					<a href="javascript:void(0)"
						onClick="SendDi('102','查询余额');return false;"
						title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("102".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
						>查询余额</a>
				</td>
								
					<!--			<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('103','查询帐单');return false;" 
							title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						if("103".equals(map.get("SENDCODE").toString())){
						out.println(map.get("SENDCONTENT").toString());
						}
						}%>">查询帐单</a>
								</td>  -->
								
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('106001','定制短信帐单服务');return false;"
										title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("106001".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>定制短信帐单服务</a>
								</td>
								
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('107','帐户余额提醒');return false;"  
							title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("107".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>">帐户余额提醒</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('403','查询归属地');return false;"
										title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("403".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										
										>查询归属地</a>
								</td>							
			</tr>
			<tr align="center">								
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('106003','定制彩信帐单服务');return false;"
										title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("106003".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>定制彩信帐单服务</a>
								</td>
								
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('106002','取消短信账单服务');return false;"
										title="<%
							   for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("106002".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>取消短信账单服务</a>
								</td>
								
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('106004','取消彩信账单服务');return false;"
										title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("106004".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>取消彩信账单服务</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('109005','查询GPRS流量');return false;"
										title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("109005".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>查询GPRS流量</a>
								</td>	
								<td nowrap ></td>
			</tr>	
							
    </table>
  </div>
    	<div id="Operation_Table">
    <div class="title">
				<div id="title_zi">热点推荐</div>
		</div>
    <table cellspacing="0">
      <tr align="center">
								<td nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('901003','彩信、来电提醒相关业务');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("901003".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>彩信、来电提醒相关业务</a>
								</td>
								<td nowrap ></td>
			</tr>
    </table>
     </div>
    	<div id="Operation_Table">
    <div class="title">
				<div id="title_zi">业务办理</div>
		</div>
    <table cellspacing="0">
      <tr align="center">

								<td  nowrap>
									<a href="javascript:void(0)"
										onClick="SendDi('306','彩铃');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("306".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>彩铃</a>
								</td>
								
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('258','亲情长话、信誉度、歌曲下载相关业务');return false;"
										title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("258".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>亲情长话、信誉度、歌曲下载相关业务</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('310','号簿管家(PIM)');return false;"
																title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("310".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>号簿管家(PIM)</a>
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
										onClick="SendDi('311001','无线音乐俱乐部普通会员');return false;"
																				title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("311001".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>无线音乐俱乐部普通会员</a>
								</td>								
							</tr>
							<tr align="center">								
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('311002','无线音乐俱乐部高级会员');return false;"
																				title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("311002".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>无线音乐俱乐部高级会员</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('307','飞信相关业务');return false;"
																				title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("307".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>飞信相关业务</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('326001','东方电视');return false;"
																				title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("326001".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>东方电视</a>
								</td>
								
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('309016','央视');return false;"
																				title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("309016".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>央视</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('308','139邮箱');return false;"
																				title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("308".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>139邮箱</a>
								</td>																								
							</tr>
							<tr align="center">																				
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('305','来电提醒');return false;"
																				title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("305".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>来电提醒</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('302','GPRS功能及套餐');return false;"
																				title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("302".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>GPRS功能及套餐</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('302004','GPRS流量提醒');return false;"
																				title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("302004".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>GPRS流量提醒</a>
								</td>
     					<td   nowrap ><a href="javascript:void(0)"
							onClick="SendDi('KTRMRB','开通人民日报');return false;"
		                    title="<%
							for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("KTRMRB".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>" >开通人民日报</a></td> 											
								</td>
					<td   colspan="1" nowrap ><a href="javascript:void(0)"
							onClick="SendDi('QXRMRB','取消人民日报');return false;"
		                    title="<%
							for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("QXRMRB".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>" >取消人民日报</a></td>																														
							</tr>
							<tr align="center">									            			
                     <td nowrap ><a href="javascript:void(0)"
							onClick="SendDi('KTCXP','开通新闻早晚报');return false;"
		                    title="<%
							for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("KTCXP".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>"
										>开通新闻早晚报</a></td>	
         <td  nowrap ><a href="javascript:void(0)"
							onClick="SendDi('QXCXP','取消新闻早晚报');return false;"
		                    title="<%
							for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("QXCXP".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>" >取消新闻早晚报</a></td>  
          <td  nowrap ><a href="javascript:void(0)"
							onClick="SendDi('KTLDXS','开通来电显示');return false;"
		                    title="<%
							for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("KTLDXS".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>" >开通来电显示</a></td>	
              <td nowrap ><a href="javascript:void(0)"
							onClick="SendDi('330001','全能助理');return false;"
		                    title="<%
							for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("330001".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>"
										>全能助理</a></td>
                 <td nowrap ><a href="javascript:void(0)"
							onClick="SendDi('361','在线听歌及相关业务');return false;"
		                    title="<%
							for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("361".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>"
										>在线听歌及相关业务</a></td>																         														         							
			</tr>		
            		<tr align="center">           			                                        			
             <td nowrap ><a href="javascript:void(0)"
							onClick="SendDi('KTBIS98','开通黑莓个人邮箱业务（98元套餐）');return false;"
		                    title="<%
							for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("KTBIS98".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>"
										>开通黑莓个人邮箱业务（98元套餐）</a></td>
                <td  nowrap ><a href="javascript:void(0)"
							onClick="SendDi('KTBIS108','开通黑莓个人邮箱业务（108元套餐）');return false;"
		                    title="<%
							for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("KTBIS108".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>" >开通黑莓个人邮箱业务（108元套餐）</a></td>  
              <td  nowrap ><a href="javascript:void(0)"
							onClick="SendDi('QXBIS','取消黑莓个人邮箱业务');return false;"
		                    title="<%
							for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("QXBIS".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>" >取消黑莓个人邮箱业务</a></td>  
							<td  nowrap ><a href="javascript:void(0)"
							onClick=showPhone();return false;"
							title="<%
           		for(int i = 0; i < queryList.size(); i++){   
					    	Map map = (Map)queryList.get(i);  
						    if("CXJXD".equals(map.get("SENDCODE").toString())){
						    	out.println(map.get("SENDCONTENT").toString());
						    }
						  }						
							%>">手机商界</a></td>		
							<td nowrap ></td>					         					         																							         					         
                    </tr>
                   <tbody id='hidenSection' style="display:none">    
                  </tbody>
         <tbody id='hidenPhone' style="display:none">           	    
          <tr align="center">
          <td nowrap ><a href="javascript:void(0)"
							onClick="SendDi('325001','移动商会WAP业务');return false;"
		               title="<%for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("325001".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>"
										>移动商会WAP业务</a></td>
            <td  nowrap ><a href="javascript:void(0)"
							onClick="SendDi('325002','商务专刊彩信业务');return false;"
		                    title="<%
							for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("325002".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>" >商务专刊彩信业务</a></td>
                                 
           <td  nowrap ><a href="javascript:void(0)"
							onClick="SendDi('325003','商务专刊体验版彩信');return false;"
		                    title="<%
							for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("325003".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>" >商务专刊体验版彩信</a></td>
                                 <td  nowrap ><a href="javascript:void(0)"
							onClick="SendDi('325004','商务简讯短信业务');return false;"
		                    title="<%
							for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("325004".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>" >商务简讯短信业务</a></td>
                                    <td  nowrap ><a href="javascript:void(0)"
							onClick="SendDi('325005','商务简讯体验版短信');return false;"
							title="<%for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("325005".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }                 }
						         %>"
		                    >商务简讯体验版短信</a></td>                
           </tr>
         <tr align="center">
          <td nowrap ><a href="javascript:void(0)"
							onClick="SendDi('325006','商情慧眼短信业务');return false;"
		               title="<%for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("325006".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>"
										>商情慧眼短信业务</a></td>
            <td  nowrap ><a href="javascript:void(0)"
							onClick="SendDi('325007','商业会刊短信业务');return false;"
		                    title="<%
							for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("325007".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>" >商业会刊短信业务</a></td>
                                 
           <td  nowrap ><a href="javascript:void(0)"
							onClick="SendDi('325008','致富商讯');return false;"
		                    title="<%
							for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("325008".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>" >致富商讯</a></td>
                                 <td  nowrap ><a href="javascript:void(0)"
							onClick="SendDi('325009','钢铁快报');return false;"
		                    title="<%
							for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("325009".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>" >钢铁快报</a></td>
                                    <td  nowrap ><a href="javascript:void(0)"
							onClick="SendDi('325010','化工快报');return false;"
							         title="<%for(int i = 0; i < queryList.size(); i++){   
					              Map map = (Map)queryList.get(i);  
						       if("325010".equals(map.get("SENDCODE").toString())){
						         out.println(map.get("SENDCONTENT").toString());
						          }
						                            }
						         %>"
		                    >化工快报</a></td>                
           </tr>
         </tbody>
              
    </table>
     </div>
    	<div id="Operation_Table">
  <div class="title">
				<div id="title_zi">套餐办理</div>
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
										>两城一家</a>
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
										>非常假期</a>
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
           	取消两城一家</a></td>
								
								<td nowrap="nowrap" ><a href="javascript:void(0)" onclick="showList(4);return false;" title="<%
           		for(int i = 0; i < queryList.size(); i++){   
					    	Map map = (Map)queryList.get(i);  
						    if("QXFCJQ".equals(map.get("SENDCODE").toString())){
						    	out.println(map.get("SENDCONTENT").toString());
						    } 
						  }
           	%>"
           	>
           	取消非常假期</a></td>
								
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQSW58','全球通上网58套餐');return false;"
																				title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQSW58".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>全球通上网58套餐</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQSW88','全球通上网88套餐');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQSW88".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>全球通上网88套餐</a>
								</td>
			</tr>
			 <tr align="center">
			 					<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQSW128','全球通上网128套餐');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQSW128".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>全球通上网128套餐</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQSL58','全球通商旅58套餐');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQSL58".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>全球通商旅58套餐</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQSL88','全球通商旅88套餐');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQSL88".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>全球通商旅88套餐</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQSL128','全球通商旅128套餐');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQSL128".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>全球通商旅128套餐</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQSL158','全球通商旅158套餐');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQSL158".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>全球通商旅158套餐</a>
								</td>
									<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQSL188','全球通商旅188套餐');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQSL188".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>全球通商旅188套餐</a>
								</td>
			</tr>
			 <tr align="center">
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQSL288','全球通商旅288套餐');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQSL288".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>全球通商旅288套餐</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQSL388','全球通商旅388套餐');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQSL388".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>全球通商旅388套餐</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQSL588','全球通商旅588套餐');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQSL588".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>全球通商旅588套餐</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQSL888','全球通商旅888套餐');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQSL888".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>全球通商旅888套餐</a>
								</td>
												<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQBD58','全球通本地58套餐');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQBD58".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>全球通本地58套餐</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQBD88','全球通本地88套餐');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQBD88".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>全球通本地88套餐</a>
								</td>
			</tr>
		  <tr align="center">
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQBD128','全球通本地128套餐');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQBD128".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>全球通本地128套餐</a>
								</td>
								
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQDXB','全球通套餐专属短信包');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQDXB".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>全球通套餐专属短信包</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQCXB','全球通套餐专属彩信报');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQCXB".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>全球通套餐专属彩信报</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQZXB','全球通尊享包');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQZXB".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>全球通尊享包</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQYDB','全球通阅读包');return false;"
										
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQYDB".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>全球通阅读包</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQYYB','全球通音乐包');return false;"
										
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQYYB".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>全球通音乐包</a>
								</td>
			</tr>
					  <tr align="center">
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTQFHZXB','全球通凤凰资讯包');return false;"
										
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQFHZXB".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>全球通凤凰资讯包</a>
								</td>
                                <td  nowrap ><a href="javascript:void(0)"
										onClick="SendDi('KTQQDX','开通亲情短信');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTQQDX".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>开通亲情短信</a></td>
                                         <td nowrap ><a href="javascript:void(0)"
										onClick="SendDi('QXQQDX','取消亲情短信');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("QXQQDX".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>取消亲情短信</a></td>
         <td  nowrap><a  href="javascript:void(0)"  
             onClick="writePhoneNo('开通定向国内长途')"    
             title='<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("DXCT".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>'
             
             >开通定向国内长途</a></td>
        <td  nowrap="nowrap" ><a  href="javascript:void(0)"
             onClick="writePhoneNo('变更定向国内长途')" 
              title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("BGDXCT".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
             
             
             >变更定向国内长途</a></td>
      <td nowrap="nowrap" ><a  href="javascript:void(0)"
             onClick="writePhoneNo('取消定向国内长途')" 
             
            title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("QXDXCT".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
             
             >取消定向国内长途</a></td>
             </tr>
          <!-- add by jiyk 2012-05-28 -->
          <tr align="center">
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('CXQQDXHM','查询亲情短信号码');return false;"
										
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("CXQQDXHM".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>查询亲情短信号码</a>
								</td>
                                <td  nowrap ><a href="javascript:void(0)"
										onClick="SendDi('SZQQDXHM','设置亲情短信号码');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("SZQQDXHM".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>设置亲情短信号码</a></td>
                                         <td nowrap ><a href="javascript:void(0)"
										onClick="SendDi('XGQQDXHM','修改亲情短信号码');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("XGQQDXHM".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>修改亲情短信号码</a></td>
         <td  nowrap><a  href="javascript:void(0)"  
             onClick="SendDi('CXDXCT','查询定向国内长途');return false;" 
             title='<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("CXDXCT".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>'
             
             >查询定向国内长途</a></td>
        <td  nowrap="nowrap" ><a  href="javascript:void(0)"
            onClick="SendDi('JSDXCT','介绍定向国内长途');return false;" 
              title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("JSDXCT".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
             
             
             >介绍定向国内长途</a></td>
            <td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('245007','彩信包月');return false;"
																				title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("245007".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>彩信包月</a>
								</td>
       <tbody id='hidenSection1' style="display:none">
					  <tr align="center">
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTDX3','开通短信3元包月');return false;"
										
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTDX3".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>开通短信3元包月</a>
								</td>
                                <td  nowrap ><a href="javascript:void(0)"
										onClick="SendDi('QXDX3','取消短信3元包月');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("QXDX3".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>取消短信3元包月</a></td>
                                         <td nowrap ><a href="javascript:void(0)"
										onClick="SendDi('KTDX5','开通短信5元包月');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTDX5".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>开通短信5元包月</a></td>
         <td  nowrap><a  href="javascript:void(0)"  
             onClick="SendDi('QXDX5','取消短信5元包月')"    
             title='<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("QXDX5".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>'
             
             >取消短信5元包月</a></td>
        <td  nowrap="nowrap" ><a  href="javascript:void(0)"
             onClick="SendDi('KTDX10','开通短信10元包月')" 
              title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTDX10".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
             
             
             >开通短信10元包月</a></td>
      <td nowrap="nowrap" ><a  href="javascript:void(0)"
             onClick="SendDi('QXDX10','取消短信10元包月')" 
             
            title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("QXDX10".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
             
             >取消短信10元包月</a></td>
						
			</tr>
		
					  <tr align="center">
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTDX15','开通短信15元包月');return false;"
										
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTDX15".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>开通短信15元包月</a>
								</td>
                                <td  nowrap ><a href="javascript:void(0)"
										onClick="SendDi('QXDX15','取消短信15元包月');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("QXDX15".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>取消短信15元包月</a></td>
                                         <td nowrap ><a href="javascript:void(0)"
										onClick="SendDi('KTDX20','开通短信20元包月');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTDX20".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>开通短信20元包月</a></td>
         <td  nowrap><a  href="javascript:void(0)"  
             onClick="SendDi('QXDX20','取消短信20元包月')"    
             title='<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("QXDX20".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>'
             
             >取消短信20元包月</a></td>
<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('SQQQ','申请亲情畅聊');return false;"
										
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("SQQQ".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>申请亲情畅聊</a>
								</td> 
 <td  nowrap ><a href="javascript:void(0)"
										onClick="SendDi('QXQQ','取消亲情畅聊');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("QXQQ".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>取消亲情畅聊</a></td>								            						
			</tr>
				<!-- add by jiyk 2012-05-28 -->			
			<tr align="center">              
        <td nowrap ><a href="javascript:void(0)"
										onClick="SendDi('SZQQCL','设置亲情畅聊');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("SZQQCL".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>设置亲情畅聊</a></td>
         <td  nowrap><a  href="javascript:void(0)"  
             onClick="SendDi('XGQQHM','变更亲情畅聊')"    
             title='<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("XGQQHM".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>'
              
             >变更亲情畅聊</a></td>
        <td  nowrap="nowrap" ><a  href="javascript:void(0)"
             onClick="SendDi('CXQQCL','查询亲情畅聊')" 
              title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("CXQQCL".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
             
             
             >查询亲情畅聊</a></td>
      <td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('245006','IP优惠礼包');return false;"
																				title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("245006".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>IP优惠礼包</a>
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
				<div id="title_zi">积分与密码服务</div>
		</div>
    <table cellspacing="0">
      <tr align="center">
							<td  nowrap>
									<a href="javascript:void(0)"
										onClick="SendDi('108001','积分查询');return false;"
										title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("108001".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>积分查询</a>
								</td>
								
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('401001','变更密码');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("401001".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>变更密码</a>
								</td>
								
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('401002','重置密码');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("401002".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>重置密码</a>
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
				<div id="title_zi">梦网服务</div>
		</div>
    <table cellspacing="0">
      <tr align="center">
							<td  nowrap>
									<a href="javascript:void(0)"
										onClick="SendDi('0000','统一查询退订');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("0000".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>统一查询退订</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('258172','定制信息收费提醒');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("258172".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>定制信息收费提醒</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('258173','取消信息收费提醒');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("258173".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>取消信息收费提醒</a>
								</td>
								
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTTQ','24小时天气预报业务开通');return false;"
										
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTTQ".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>24小时天气预报业务开通</a>
								</td>
						<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('QXTQ','24小时天气预报业务取消');return false;"
										
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("QXTQ".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>24小时天气预报业务取消</a>
								</td>
			</tr>
    </table>	
 </div>
 
 <div id="Operation_Table">
    	   <div class="title">
				<div id="title_zi">WLAN套餐办理</div>
		</div>
    <table cellspacing="0">
      <tr align="center">
							<td  nowrap>
									<a href="javascript:void(0)"
										onClick="SendDi('KTWLAN30','开通10版WLAN30元包月套餐');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTWLAN30".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>开通10版WLAN30元包月套餐</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTWLAN50','开通10版WLAN50元包月套餐');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTWLAN50".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>开通10版WLAN50元包月套餐</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTWLAN100','开通10版WLAN100元包月套餐');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTWLAN100".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>开通10版WLAN100元包月套餐</a>
								</td>	
			</tr>
              <tr align="center">
							<td  nowrap>
									<a href="javascript:void(0)"
										onClick="SendDi('BGWLAN30','变更10版WLAN30元包月套餐');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("BGWLAN30".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>变更10版WLAN30元包月套餐</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('BGWLAN50','变更10版WLAN50元包月套餐');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("BGWLAN50".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>变更10版WLAN50元包月套餐</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('BGWLAN100','变更10版WLAN100元包月套餐');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("BGWLAN100".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>变更10版WLAN100元包月套餐</a>
								</td>	
			</tr>
             <tr align="center">
							<td  nowrap>
									<a href="javascript:void(0)"
										onClick="SendDi('BGEDU10','变更WLAN40小时包月套餐');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("BGEDU10".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>变更WLAN40小时包月套餐</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('BGEDU20','变更WLAN100小时包月套餐');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("BGEDU20".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>变更WLAN100小时包月套餐</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('BGEDU40','变更WLAN250小时包月套餐');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("BGEDU40".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>变更WLAN250小时包月套餐</a>
								</td>	
			</tr>
             <tr align="center">
							<td  nowrap>
									<a href="javascript:void(0)"
										onClick="SendDi('KTEDU10','开通WLAN40小时包月套餐');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTEDU10".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>开通WLAN40小时包月套餐</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTEDU20','开通WLAN100小时包月套餐');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTEDU20".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>开通WLAN100小时包月套餐</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('KTEDU40','开通WLAN250小时包月套餐');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("KTEDU40".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>开通WLAN250小时包月套餐</a>
								</td>	
								
								
								
			</tr>
			<tr align="center">
							<td  nowrap>
									<a href="javascript:void(0)"
										onClick="SendDi('QXWLANTC','取消10版WLAN包月套餐');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("QXWLANTC".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>取消10版WLAN包月套餐</a>
								</td>
								<td  nowrap >
									<a href="javascript:void(0)"
										onClick="SendDi('QXEDUTC','取消WLAN高校优惠资费套餐');return false;"
											title="<%
							for(int i = 0; i < queryList.size(); i++){   
					       Map map = (Map)queryList.get(i);  
						    if("QXEDUTC".equals(map.get("SENDCODE").toString())){
						       out.println(map.get("SENDCONTENT").toString());
						      }
						         }
						         %>"
										>取消WLAN高校优惠资费套餐</a>
								</td>
								<td  nowrap >
								</td>	
								
								
								
			</tr>
    </table>	
 </div>
 
<table cellspacing="0">
  <tr align="center">
    <td id="footer">
      &nbsp; <input name=back class="b_foot" onClick="parent.removeTab('<%=opCode%>')" type=button value=关闭>
      &nbsp; <input name=back class="b_foot" onClick=" showContent();" type=button value=收起键>
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
