<%
/********************
 version v2.0
开发商: si-tech
create by wanglm 20110321
********************/
%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
  request.setCharacterEncoding("GBK");
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String current_timeNAME=new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date());
		String regionCode= (String)session.getAttribute("regCode");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>"  id="loginAccept" />

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
  onload=function()
  {
  
  }

 function doCfm(){

 				
	    	if(!checkElement(document.all.sr_phone)){
						return false;
					}    
	     
	      	 var banlitype = $("#banlitype").val();	
 
	     if(banlitype=="01")   {//新增

	 			var sr_phones = $("#sr_phone").val();				
				if(sr_phones.trim()=="") {
	        rdShowMessageDialog("受让人手机号码不能为空！");
   			  return false;					
				}
					 	
	 					var sr_cardno = $("#sr_cardno").val();				
				if(sr_cardno.trim()=="") {
	       // rdShowMessageDialog("受让人证件号码不能为空！");
   			 // return false;					
				}
	 			
	    }
	     
	     else if(banlitype=="02")   {//tihuan

	 			var sr_phones = $("#sr_phone").val();				
				if(sr_phones.trim()=="") {
	        rdShowMessageDialog("受让人手机号码不能为空！");
   			  return false;					
				}
					 	
	 					var sr_cardno = $("#sr_cardno").val();				
				if(sr_cardno.trim()=="") {
	       // rdShowMessageDialog("受让人证件号码不能为空！");
   			 // return false;					
				}
	 			
	    }
	    else if(banlitype=="03")   {//xiugai
				 	
	 				var sr_cardno = $("#sr_cardno").val();				
				if(sr_cardno.trim()=="") {
	       // rdShowMessageDialog("受让人证件号码不能为空！");
   			  //return false;					
				}
	 			
	    }
	    
	    if(banlitype!="01")   {//新增
	    	var xuanzhongsrephone = $("#srephonenumber").val();	
	    	if(xuanzhongsrephone=="") {
	    		rdShowMessageDialog("请选择要操作的受让人号码！");
   			  return false;			
	    		}
	    	}
	    		
				document.form1.confirm.disabled=true;
	     
				document.form1.action = "fm181Cfm.jsp";
   			document.form1.submit();
   		
 }
 
		
		function listtype()
{
		var phoneNo = $("#sr_phone").val();
		
		if(!checkElement(document.all.sr_phone)){
			return false;
		}

		if(phoneNo.trim()!="") {
    var myPacket = new AJAXPacket("queryCustname.jsp", "正在查询客户信息，请稍候......");
    myPacket.data.add("phoneNo", phoneNo);
    core.ajax.sendPacket(myPacket,doShowName);
    myPacket = null;
    }
}

function doShowName(packet){
  var retCode = packet.data.findValueByName("retCode");
  var retMsg = packet.data.findValueByName("retMsg");
  var custname = packet.data.findValueByName("custname");
  if(retCode!="000000"){
    rdShowMessageDialog("取用户名出错，错误代码："+retCode+"<br>错误信息："+retMsg,0);
    return false;
  }else{			
			$("#sr_name").val(custname);
  }
}

function returnvalues(srephonenumber) {
	
	$("#srephonenumber").val(srephonenumber);	
		
}

 	function resetPage(){
 		window.location.href = "fm181.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>";
	}
	
	function opchange(){
		
 	 var banlitype = $("#banlitype").val();	
 
	 if(banlitype=="01")   {
	 	
 				var markDiv=$("#showTab"); 
				markDiv.empty();
				
				$("#shourangreninfo").show();
				$("#srephonenumber").val("");	
				$("#zhengjianleide").show();

				
	}else {
			if(banlitype=="02")   {
				$("#shourangreninfo").show();
			}else {
				$("#shourangreninfo").hide();
			}
			
			if(banlitype=="04" || banlitype=="05") {
				$("#zhengjianleide").hide();
			}else {
				$("#zhengjianleide").show();
			}
			
			
			
			$("#srephonenumber").val("");
	var myPacket = new AJAXPacket("fm181Qry.jsp","正在查询信息，请稍候......");
	myPacket.data.add("phone_no",$("#zr_phone").val());
	myPacket.data.add("banlitype","00");

	core.ajax.sendPacketHtml(myPacket,querinfo,true);
	getdataPacket = null;
	
	}   

 }
 
  				function querinfo(data){
				//找到添加表格的div
				var markDiv=$("#showTab"); 
				markDiv.empty();
				markDiv.append(data);
				
		}
		
function relatLink_m185(){
		parent.parent.parent.L('2','m185','积分转赠','sm181/fm185.jsp','1');
}	

</script>
</head>
<body>
<form name="form1" id="form1" method="POST" >
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
      <table cellspacing="0">
         <tr> 
            <td width="16%"  > 
              <div align="left" class="blue">转让人手机号码</div>
            </td>
            <td colspan="3"> 
            <div align="left"> 
                <input class="InputGrey" type="text" name="zr_phone" id="zr_phone" v_must="1" v_type="mobphone" v_must=1 value="<%=activePhone%>"  maxlength=11 index="3" readonly />
                </div>
            </td>
         
       
         </tr>
                  <tr id="shourangreninfo" > 
            <td width="16%"  > 
              <div align="left" class="blue">受让人手机号码</div>
            </td>
            <td > 
            <div align="left"> 
                <input   type="text"  name="sr_phone" id="sr_phone" v_minlength=1 v_maxlength=16 v_type="mobphone"   maxlength="11"  value =""  onBlur="listtype()">
                <font class='orange'>*</font>
                </div>
            </td>
                     <td width="16%"  > 
              <div align="left" class="blue">受让人姓名</div>
            </td>
            <td > 
            <div align="left"> 
                <input class="InputGrey" type="text" name="sr_name" id="sr_name"  readOnly />
                </div>
            </td>
       
         </tr>
         		       <TR  id='zhengjianleide'> 
	          <TD width="16%" class="blue">受让人证件类型</TD>
              <TD >
							<select id="sr_zjlx" name="sr_zjlx"  style="width:180px;">
						<option value="01">身份证号</option>
						<option value="02">护照</option>
						<option value="03">中国人民解放军军人保障卡</option>
						<option value="04">军官证</option>
						<option value="05">武警警官证</option>
						<option value="06">士兵证</option>
						<option value="07">军队学员证</option>
						<option value="08">军队文职干部证</option>
						<option value="09">军队离退休干部证</option>
						<option value="10">港澳居民来往内地通行证</option>
						<option value="11">中华人民共和国来往港澳通行证</option>
						<option value="12">台湾居民来往大陆通行证</option>
						<option value="13">大陆居民来往台湾通讯证</option>
						<option value="14">外国人居留证</option>
						<option value="15">外国人出入境证</option>
						<option value="16">外交官证</option>
						<option value="17">领事馆证</option>
						<option value="18">海员证</option>
						<option value="19">外交部开具的外国人身份证明</option>

							</select>
	          </TD>
	                             <td width="16%"  > 
              <div align="left" class="blue">受让人证件号码</div>
            </td>
            <td > 
            <div align="left"> 
                <input  type="text" name="sr_cardno" id="sr_cardno"  value="" />
                <font class='orange'></font>
                </div>
            </td>
         </TR> 

		       <TR  > 
	          <TD width="16%" class="blue">操作类型</TD>
              <TD colspan="3">
							<select id="banlitype" name="banlitype" onChange="opchange()">
						<option value="01">新增</option>
						<option value="02">替换</option>
						<option value="03">修改</option>
						<option value="04">停用</option>
						<option value="05">启用</option>

							</select>
	          </TD>
	        
         </TR> 
	</table>

	<div id="showTab" ></div>
	

              <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">	
              <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">
              <input class="b_foot" type=button name=back value="清除" onClick="resetPage()">
		      <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab()">
              </div>
            </td>
          </tr>
        </table>
      <input type="hidden" name="opCode" id="opCode" value="<%=opCode%>" />
      <input type="hidden" name="opName" id="opName" value="<%=opName%>" />
      <input type="hidden" name="srephonenumber" id="srephonenumber" />
      <input type="hidden" name="loginAccept" id="loginAccept" value="<%=loginAccept%>" />
    <%@ include file="/npage/include/footer_simple.jsp"%>
       <div class="relative_link">
					<span>相关链接：</span><a href="#" onclick="relatLink_m185()">m185·积分转赠 </a>
				</div>
   </form>
</body>
</html>