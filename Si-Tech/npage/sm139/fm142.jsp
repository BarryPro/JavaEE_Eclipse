<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
  

  String opCode = "m142";
  String opName = "集团订单换号开户";
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
   String orgCode = (String)session.getAttribute("orgCode");
   String workPwd = (String)session.getAttribute("password");
  
String sphoneskh = WtcUtil.repStr(request.getParameter("sphoneskh"), "");
String custnamekh = WtcUtil.repStr(request.getParameter("custnamekh"), "");
String offeridkh = WtcUtil.repStr(request.getParameter("offeridkh"), "");
String dizhikh = WtcUtil.repStr(request.getParameter("dizhikh"), "");
String lianxirenkh = WtcUtil.repStr(request.getParameter("lianxirenkh"), "");
String lianxiphonekh = WtcUtil.repStr(request.getParameter("lianxiphonekh"), "");
String youbiankh = WtcUtil.repStr(request.getParameter("youbiankh"), "");
String dishikh = WtcUtil.repStr(request.getParameter("dishikh"), "");
String iccidkh = WtcUtil.repStr(request.getParameter("iccidkh"), "");

String offerId="";
String offerName="";
String offerComments="";
String band_id="";
String band_name="";

String cccTime=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());
String dateStr2 =  new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>"  id="loginAccept" />
	
	<wtc:service name="sJt4GKhQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeoffer" retmsg="retMsgoffer" outnum="5" >
		<wtc:param value="0"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=workPwd%>"/>
		<wtc:param value="<%=sphoneskh%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=offeridkh%>"/>
	</wtc:service>
	<wtc:array id="retoffer"  scope="end" />
<%
if(retCodeoffer.equals("000000")) {
			if(retoffer.length>0) {
				 offerId=retoffer[0][0];
			   offerName=retoffer[0][1];
				 offerComments=retoffer[0][2];
				 band_id=retoffer[0][3];
				 band_name=retoffer[0][4];
			}
}else {
	%>
      <script language=javascript>
        rdShowMessageDialog('查询资费错误！错误代码：<%=retCodeoffer%><br>错误信息：<%=retMsgoffer%>');
        removeCurrentTab();
      </script>
<%
      return;
	}
%>		
			
  <script language="javascript">
    function save(){

      var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
      if(typeof(ret)!="undefined"){
        if((ret=="confirm")){
          if(rdShowConfirmDialog('确认电子免填单吗？')==1){
            frmCfm();
          }
        }
        if(ret=="continueSub"){
          if(rdShowConfirmDialog('确认要提交信息吗？')==1){
            frmCfm();
          }
        }
      }else{
        if(rdShowConfirmDialog('确认要提交信息吗？')==1){
          frmCfm();
        }
      }
			document.all.simCodeCfm.value = document.all.simCode.value;
      frmCfm();
    }

		function frmCfm(){
      frm.submit();
      return true;
    }

    function showPrtDlg(printType,DlgMessage,submitCfm){  //显示打印对话框 
    var h=198;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   var pType="subprint";
   var billType="1";
   var sysAccept = "<%=loginAccept%>";
   var phone_no	= $("#phoneNo").val();
   
   var mode_code = null;
   
   
   var fav_code = null;
   var area_code = null;
   var printStr = printInfo(printType);
		/* ningtn */
		var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
		iccidInfoStr = iccidInfoStr.replace(/\\/g,"|xg|");
		accInfoStr = accInfoStr.replace(/\\/g,"|xg|");
		/* ningtn */
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;  /** handwrite 工单电子化改造，指向新打印页 **/
   var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phone_no+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   var ret=window.showModalDialog(path,printStr,prop);
   return path;
    }				
			
function codeChg(s)
{
  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
  return str;
}
function printInfo(printType)
{
     var retInfo = "";
     var cust_info="";
	 var opr_info="";
	 var note_info1="";
	 var note_info2="";
	 var note_info3="";
	 var note_info4="";
	 
		
    cust_info+="客户姓名：	"+"<%=custnamekh%>"+"|";
    cust_info+="手机号码：	"+"<%=sphoneskh%>"+"|";
    cust_info+="证件号码：	"+"<%=iccidkh%>"+"|";
    cust_info+="客户地址：	"+"<%=dizhikh%>"+"|";
		
		var cTime = "<%=cccTime%>";
		
			opr_info+="业务受理时间："+cTime+"  "+"用户品牌:"+"<%=band_name%>"+"|";
			opr_info+="办理业务：<%=opName%>"+"  "+"操作流水："+document.all.loginAccept.value+"|";

		
		opr_info+= "SIM卡号："+document.all.simCode.value+" SIM卡费: 0 元 |";
		opr_info+= "预存款： 0 元"+"|";
		opr_info+="主资费："+"<%=offerId%>  <%=offerName %>"+"  生效时间：<%=dateStr2 %>  "+"|"; 
		
 		note_info1+=" "+"|";
 		note_info1+="主资费描述：<%=offerComments%>"+"|";


	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
 	return retInfo;	
}
 
    
    function chaCardType(){  //空卡开户
	var nuCardType = document.all.cardTypeN.value;
	
	if(nuCardType=="1"){
 
		document.all.cardtype_bz.value="k";
		document.all.cfmBtn.disabled=true;	 // 空卡开户 提交置灰
		
  		 var phone = $("#phoneNo").val();
  		 /****新增调大唐功能取SIM卡类型****/
  		 /* 
        * diling update for 修改营业系统访问远程写卡系统的访问地址，由现在的10.110.0.125地址修改成10.110.0.100！@2012/6/4
        */
  		 path ="http://10.110.0.100:33000/writecard/writecard/ReadCardInfo.jsp";
  		 var retInfo1 = window.showModalDialog("Trans.html",path,"","dialogWidth:10;dialogHeight:10;"); 
		 if(typeof(retInfo1) == "undefined")     
    	 {	
    		 rdShowMessageDialog("读卡类型出错!");
    		 document.all.cardTypeN.value = "0";  //重置 空卡开户 为否 hejwa add
    		 document.all.cardtype_bz.value="s";  // 空卡开户为否
    		 document.all.checksimN.disabled=false; //资源校验按钮可用 
    		return false;   
    	 }
    	var chPos;
    	chPosn = retInfo1.indexOf("&");
    	if(chPosn < 0)
    	{	
    		rdShowMessageDialog("读卡类型出错!");
    		document.all.cardTypeN.value = "0";  //重置 空卡开户 为否 hejwa add
    		document.all.cardtype_bz.value="s";  // 空卡开户为否
    		document.all.checksimN.disabled=false; //资源校验按钮可用 
    		return false ;	
    	} 
    	retInfo1=retInfo1+"&";
    	var retVal=new Array();   
    	for(i=0;i<4;i++)
    	{   	   
    		var chPos = retInfo1.indexOf("&");
        	valueStr = retInfo1.substring(0,chPos);
        	var chPos1 = valueStr.indexOf("=");
        	valueStr1 = valueStr.substring(chPos1+1);
        	retInfo1 = retInfo1.substring(chPos+1);
        	retVal[i]=valueStr1;
        	
    	} 
    	if(retVal[0]=="0")
    	{
    		var rescode_str=retVal[2]+"|";
    		var rescode_strstr="";
    		var chPosm = rescode_str.indexOf("|");
    		for(i=0;i<4;i++)
    		{   	   
    	
    			var chPos1 = rescode_str.indexOf("|");
        		valueStr = rescode_str.substring(0,chPos1);
        		rescode_str = rescode_str.substring(chPos1+1);
        		if(i==0 && valueStr=="")
        		{
        			rdShowMessageDialog("读卡类型出错!");
        			document.all.cardTypeN.value = "0";  //重置 空卡开户 为否 hejwa add
        			document.all.cardtype_bz.value="s";  // 空卡开户为否
        			document.all.checksimN.disabled=false; //资源校验按钮可用 
    		 		  return false;
        		}
        		if(valueStr!=""){
        			rescode_strstr=rescode_strstr+"'"+valueStr+"'"+",";
        		}
        	
    		} 
    		rescode_strstr=rescode_strstr.substring(0,rescode_strstr.length-1);
    		if(rescode_strstr=="")
    		{
    			rdShowMessageDialog("读卡类型出错!");
    			document.all.cardTypeN.value = "0";  //重置 空卡开户 为否 hejwa add
    			document.all.cardtype_bz.value="s";  // 空卡开户为否
    			document.all.checksimN.disabled=false; //资源校验按钮可用 
    		 	return false;   
    		}
  		}
  		else{
  			 rdShowMessageDialog("读卡类型出错!");
  			 document.all.cardTypeN.value = "0";  //重置 空卡开户 为否 hejwa add
  			 document.all.cardtype_bz.value="s";  // 空卡开户为否
  			 document.all.checksimN.disabled=false; //资源校验按钮可用 
    		 return false;   
    	}
  		 /****取SIM卡类型结束******/
    		 var path = "<%=request.getContextPath()%>/npage/innet/fgetsimno_1104.jsp";
    		 path = path + "?regioncode=" + "<%=regionCode%>";
    	         path = path + "&phone=" + phone + "&rescode=" + rescode_strstr+ "&pageTitle=" + "生成SIM卡号码";
    	       
    		 var retInfo = window.showModalDialog(path,"","dialogWidth:40;dialogHeight:20;");
    		
    		document.all.checksimN.disabled=false;
    		//document.all.b_write.disabled=false;  资源校验成功后才可以写卡
    		 if(typeof(retInfo) == "undefined")     
    			{	return false;   }
    		var simsim=oneTok(oneTok(retInfo,"~",1));
    		var typetype=oneTok(oneTok(retInfo,"~",2));
    		var cardcard=oneTok(oneTok(retInfo,"~",3));
    		document.all.simCode.value=simsim;
    		document.all.simType.value=(cardcard).trim();
    		document.all.simTypeCfm.value=(cardcard).trim();
    		
    		if((typetype).trim()=="null"){
    			
    			}else{
		 document.all.simTypeName.value=(typetype).trim();
    	}
		}else{
			document.all.cardtype_bz.value="s";
			}
	}
	
	function selectCheckSimNo(){
	
	var nuCardType = document.all.cardTypeN.value;
	if(nuCardType=="1"){ //空卡开户
			checksim();
		}else{
			qrySimType();
		}
	        
	}
	
	function qrySimType()
{
  var simCode	= $("#simCode").val().trim();
   //得到sim卡类型
  var getAccountId_Packet = new AJAXPacket("<%=request.getContextPath()%>/npage/s1104/pubGetSimType.jsp","正在获得sim卡类型，请稍候......");
	getAccountId_Packet.data.add("region_code","<%=regionCode%>");
	getAccountId_Packet.data.add("simNo",simCode);
	core.ajax.sendPacket(getAccountId_Packet,doQrySimType,false);
	getAccountId_Packet=null;
}

function doQrySimType(packet){
		var retCode = packet.data.findValueByName("retCode"); 
    var retMessage = packet.data.findValueByName("retMessage");	
    
         var sim_type = packet.data.findValueByName("sim_type");    	    
         var sim_typename = packet.data.findValueByName("sim_typename");

	    if(retCode=="000000")
		  {  
	     document.all.simTypeCfm.value = sim_type;
       document.all.simType.value = sim_type;  
			 if(sim_typename=="null"){
			 		
			 	}else{
			 		document.all.simTypeName.value=(sim_typename).trim();
			 		}
		
		  }else
	      {
				retMessage = retMessage + "[errorCode2:" + retCode + "]";
				rdShowMessageDialog(retMessage,0);
				return false;
      }
      
      checksim();
	}

function checksim(){
	
    

    var operType = document.all.newSmCode.value;
    var sim_type = document.all.simTypeCfm.value;
		 var phoneNo = $("#phoneNo").val();
		 
		     if(document.all.simCode.value == "")
    {
        rdShowMessageDialog("请输入SIM卡号码！",0);
        return false;
    } 
    
		var checkResource_Packet = new AJAXPacket("fm142CheckSim.jsp","正在进行资源校验，请稍候......");
		checkResource_Packet.data.add("retType","checkResource");
    checkResource_Packet.data.add("sIn_Phone_no",phoneNo);
    checkResource_Packet.data.add("sIn_OrgCode","<%=orgCode%>");
    checkResource_Packet.data.add("sIn_Sm_code",operType);
    checkResource_Packet.data.add("sIn_Sim_no",document.all.simCode.value);
    checkResource_Packet.data.add("custIccid","<%=iccidkh%>");
    checkResource_Packet.data.add("sIn_Sim_type",sim_type);
    checkResource_Packet.data.add("workno","<%=workNo%>");
    checkResource_Packet.data.add("offerId","0");
    
    
    var nuCardType = document.all.cardTypeN.value;
		if(nuCardType=="1"){
			//空卡开户
			checkResource_Packet.data.add("simType",document.all.simTypeCfm.value);
		}else{
			checkResource_Packet.data.add("simType","");
		}

    checkResource_Packet.data.add("zph","aaa");
    checkResource_Packet.data.add("sIn_cardtype",document.all.cardtype_bz.value);
		core.ajax.sendPacket(checkResource_Packet,doChecksim,false);
		checkResource_Packet=null;  
		
		
	}
	
	function doChecksim(packet){
					
		var retCode = packet.data.findValueByName("retCode");
		var retMessage = packet.data.findValueByName("retMessage");
		

 		 if(retCode=="0"||retCode=="000000"){
    	
		            rdShowMessageDialog("资源校验成功！");

								//漫游改造需求 ningtn end
		            if(document.all.cardTypeN.value=="0"){   //非空卡开户资源校验成功后才能提交
									document.all.cfmBtn.disabled=false;		            	
		            }
								document.all.checksimN.disabled=true;
		            
						 if(document.all.cardtype_bz.value=='k'){
				  			document.all.b_write.disabled=false;
				  		}
					  document.all.simCode.readOnly=true;
					  document.all.simCode.className="InputGrey";			

    	}else{
    		    document.all.cfmBtn.disabled=true;
						document.all.checksimN.disabled=false;

						document.all.simCode.value="";/*20100128 add*/
						document.all.simCode.className = "";
						document.all.simCode.readOnly = false;
    	    	retMessage = retMessage + "[errorCode8:" + retCode + "]";
    				rdShowMessageDialog(retMessage,0);
    				return false;
    	}
}

function writechg(){
	if(document.all.simCode.value==""){
		rdShowMessageDialog("sim卡号不能是空!");
		return false;
	}
	if(document.all.cardtype_bz.value=="k"){
		var phone = $("#phoneNo").val();
  			document.all.b_write.disabled=true;
    		 var path = "<%=request.getContextPath()%>/npage/innet/fwritecard.jsp";
    		 path = path + "?regioncode=" + "<%=regionCode%>";
    		 path = path + "&sim_type=" +document.all.simTypeCfm.value;
    		 path = path + "&sim_no=" +document.all.simCode.value;
    		 path = path + "&op_code=" +"<%=opCode%>";
    	         path = path + "&phone=" + phone + "&pageTitle=" + "写卡";
    	         path = path + "&deleteShowCardNoFlag=" +"isDelCardNo"; //add by diling  for 关于哈分公司申请优化远程写卡操作步骤的请示
    		 var retInfo = window.showModalDialog(path,"","dialogWidth:40;dialogHeight:20;");
    		 if(typeof(retInfo) == "undefined")     
    			{	
    				 
    				document.all.writecardbz.value="1"; 
    				//document.all.b_write.disabled=false;
    				document.all.cfmBtn.disabled=true;   //写卡失败不能提交 hejwa add 
    				rdShowMessageDialog("写卡失败");
    				return false;   
    				
    			}
    		 
    		 var retsimcode=oneTok(oneTok(retInfo,"|",1));
    		 var retsimno=oneTok(oneTok(retInfo,"|",2));
    		 var cardstatus=oneTok(oneTok(retInfo,"|",3))
    		 
    		 if(retsimcode=="0"){rdShowMessageDialog("写卡成功");
    		 document.all.writecardbz.value="0";
    		 document.all.simCode.value=retsimno;
    		 document.all.simCodeCfm.value=retsimno;
    		 document.all.cardstatus.value=cardstatus;
    		 document.all.cfmBtn.disabled=false;
    		 
    		 	//if(cardstatus=="3"){document.all.simFee.value="0";}
    		 
    		 }else{
    		 	document.all.writecardbz.value="1";
    		 	//document.all.b_write.disabled=false;
    		 	document.all.cfmBtn.disabled=true;
    		 	rdShowMessageDialog("写卡失败");
    		 }
	}
	else{
		rdShowMessageDialog("实卡不能写卡");
		document.all.cfmBtn.disabled=true;   //写卡失败不能提交 hejwa add 
		document.all.b_write.disabled=true;
		return false;
	}
}

	
		</script>
		<body>
		  <form name="frm" method="POST" action="fm142Cfm.jsp">
	    <%@ include file="/npage/include/header.jsp" %>
		    <div class="title">
		      <div id="title_zi"><%=opName%></div><p align="center"></p>
	      </div>
	      <div class="title">
	<div id="title_zi">销售品信息</div>
</div>

<TABLE cellSpacing=0>
  <TR>
    <Td class="blue" width=17%>品牌</td>
  	<TD width=33%><%=band_name%>  
  		<input type="hidden" name="orderInfoV" value="0" />

    <Td class="blue"  width=17%>销售品名称</td>
     <TD id="td_offerName"><%=(offerId+"-->"+offerName)%> </TD>
	</TR>
	<tr>
    <Td class="blue">描述</Td>
    <TD colspan="3"><%=offerComments%></TD>
   </TR>
  </table>  
<br>
	<div class="title">
		<div id="title_zi">基本信息</div>
	</div> 
        <table cellspacing="0">
				  <tr>
			      <td class="blue" width="16%">手机号码</td>
			      <td>
						  <input type="text" id="phoneNo" name="phoneNo"   readOnly  Class="InputGrey" value ="<%=sphoneskh%>"/>
		
	          </td>
	          <td class="blue" width="16%">用户姓名</td>
			      <td>
							<input type="text" id="custname" name="custname"   readOnly  Class="InputGrey" value ="<%=custnamekh%>"/>
			
	          </td>
		    
		      	
			      <td class="blue" width="16%">证件号码</td>
			      <td>
						  <input type="text" id="iccidkh" name="iccidkh"   readOnly  Class="InputGrey" value ="<%=iccidkh%>"/>
		
	          </td>
	            </tr>
	             <tr>
	          <td class="blue" width="16%">邮编</td>
			      <td>
							<input type="text" id="youbian" name="youbian"   readOnly  Class="InputGrey" value ="<%=youbiankh%>"/>
			
	          </td>
		      
		     
		      				 
			      <td class="blue" width="16%">联系人</td>
			      <td>
						  <input type="text" id="lianxiren" name="lianxiren"   readOnly  Class="InputGrey" value ="<%=lianxirenkh%>"/>
		
	          </td>
	          <td class="blue" width="16%">联系人电话</td>
			      <td>
							<input type="text" id="lianxirenphone" name="lianxirenphone"   readOnly  Class="InputGrey" value ="<%=lianxiphonekh%>"/>
			
	          </td>
		      </tr>
          
          <tr>
          	                   <TD width="16%" class="blue"><div align="left">密码</div></TD>
								<TD ><input name="userpwd" type="password"  value="123321" onKeyPress="return isKeyNumberdot(0)" maxlength="6">
									<font class="orange">*</font> 
								</TD>
							<td class="blue" width="16%">地址</td>
                  <TD colspan="3">
							<input name="dizhi"  id="dizhi"    size=60  readOnly  Class="InputGrey" value ="<%=dizhikh%>" >

                   
                  </TD>
                   </tr>
                     </table>  
                    <table>
   <br>                
  <div class="title">
		<div id="title_zi">资源信息</div>
	</div>     
             <tr> 

                  <td class="blue">空卡开户 </td>
			 <td>
			  	<select align="left" id="cardTypeN" name="cardTypeN"  index="28" onchange="chaCardType()">
		        <option value="0" selected>否</option>
		        <option value="1">是</option>
		      </select>	
		   </td>

			   <td class="blue">SIM卡号 </td>
			  <td colspan="6" >
			  	<input name=simType type=hidden value="">
			  	<input name=simTypeName type=text  readonly index="11" Class="InputGrey">
			  	<input type='text' name='simCode' id='simCode' maxlength="20" class="required numOrLetter" value="">
			  	<input type="button" id="checksimN" name="checksimN" value="资源校验" class="b_text" onClick="selectCheckSimNo()"> <font class="orange">*</font>
			  	<input type="button" name="b_write" value="写卡" class="b_text" onClick="writechg()" disabled > 
			  	</td>
			</tr>
		                  
     
          
        </table>
  <br>      
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=loginAccept%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>

        <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">	
                <input type="button" id="cfmBtn" name="cfmBtn" class="b_foot" value="确定&打印" onclick="save()" disabled/>		
                &nbsp;
                <input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();">
              </div>
            </td>
          </tr>
        </table>
        <input type="hidden" id="opCode" name="opCode"  value="<%=opCode%>" />
        <input type="hidden" id="opName" name="opName"  value="<%=opName%>" />
   
      	<input type="hidden" name="offerId" id="offerId" value="<%=offerId%>" />
      	<input type="hidden" name="offerName" id="offerName"  value="<%=offerName%>" />
      	<input type="hidden" name="offerComments" id="offerComments" value="<%=offerComments%>" />
      	<input type="hidden" name="newSmCode" id="newSmCode" value="<%=band_id%>" />
      	<input type="hidden" name="band_name" id="band_name"  value="<%=band_name%>" />
      	

      	<input type="hidden" name="simTypeCfm" id="simTypeCfm"   />
      	<input type="hidden" name="simCodeCfm" id="simCodeCfm"   />
      	<input name=cardtype_bz type=hidden value="s">
      	<input name=writecardbz type=hidden value="">
      	<input name="cardstatus" type=hidden value="">
      	
      	<input name="loginAccept" type=hidden value="<%=loginAccept%>">
      	<%@ include file="/npage/include/footer_new.jsp" %>
      </form>
      <frameset rows="0,0,0,0" cols="0" frameborder="no" border="0" framespacing="0" >
  <frame src="../common/evalControlFrame.jsp"    name="evalControlFrame" id="evalControlFrame" />
</frameset>
    </body>
    <%@ include file="/npage/public/hwObject.jsp" %> 
</html>