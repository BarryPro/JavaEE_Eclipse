 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:2015/02/12 12:54:23 gaopeng
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
		String opCode=request.getParameter("opCode");	
		String opName=request.getParameter("opName");

	String workno = (String)session.getAttribute("workNo");
	String regioncode=(String)session.getAttribute("regCode");
	String noPass = (String)session.getAttribute("password");
	String orgcode = (String)session.getAttribute("orgCode");
  String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
  String regionCode= (String)session.getAttribute("regCode");


%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regioncode%>"  id="sysAccept" />

<HTML>
	<HEAD>
		<TITLE><%=opName%></TITLE>
		<script language="JavaScript">
		$(document).ready(function(){
			var radioFlag = $("input[name='opType'][checked]").val();
			if(radioFlag == "simple"){
				$("#isgua option[value='1']").remove();
				$("#simpleEx").show();
			}
			changeType();			
		
		});
		function doCommit()
		{
			var radioFlag = $("input[name='opType'][checked]").val();
			if(radioFlag == "simple"){
				if(!checkElement(document.all.cardNo)){
					return false;
				}
				if(!checkElement(document.all.phoneNo)){
					return false;
				}
				if(!checkElement(document.all.custName)){
					return false;
				}
				if(!checkElement(document.all.idIccid)){
					return false;
				}
			}else if(radioFlag == "piliang"){
				
				if(!checkElement(document.all.phoneNo)){
					return false;
				}
				if(!checkElement(document.all.custName)){
					return false;
				}
				if(!checkElement(document.all.idIccid)){
					return false;
				}
			}		
			var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
			if(typeof(ret)!="undefined")
			  {
			    if((ret=="confirm"))
			    {
			      if(rdShowConfirmDialog('确认电子免填单吗？')==1)
			      {
				   		formConfirm();
			      }
					}
				if(ret=="continueSub")
				{
			      if(rdShowConfirmDialog('确认提交信息么？')==1)
			      {
				    	formConfirm();
			      }
				}
			  }
			else
			  {
			     if(rdShowConfirmDialog('确认提交信息么？')==1)
			     {
				     formConfirm();
			     }
			  }	
			  return true;
			}
		
		function formConfirm(){
			
			var phoneNo = $.trim($("#phoneNo").val());
			var radioFlag = $("input[name='opType'][checked]").val();
			var iImp_flag = "";
			var iCard_no = "";
			var iCard_static ="";
			if(radioFlag == "simple"){
				iImp_flag="0";
				iCard_no = $.trim($("#cardNo").val());
				/*有价卡状态*/
				iCard_static = $.trim($("#cardStatus").val());
			}else if(radioFlag == "piliang"){
				iImp_flag="1";
				iCard_no = $("input[name='serviceFileName']").val();
				/*有价卡状态*/
				iCard_static = "";
			}
			
			/*是否刮卡*/
			var iUse_flag = $("select[name='isgua']").find("option:selected").val();
			/*是否充值*/
			var iPre_flag = $("select[name='ischong']").find("option:selected").val();
			/*客户姓名*/
			var iCust_name = $.trim($("#custName").val());
			/*证件类型*/
			var iId_type = $("select[name='idType']").find("option:selected").val();
			/*证件号码*/
			var idIccid = $.trim($("#idIccid").val());
			/*备注*/
			var iNote = $.trim($("#reply_content").text());
			if(iNote.length > 500){
				rdShowMessageDialog("备注信息必须在500字以内！",1);
				return false;
			}
			
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm241/fm241Cfm.jsp","正在获得数据，请稍候......");
			
			var iLoginAccept = "<%=sysAccept%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=workno%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = phoneNo;
			var iUserPwd = "";
			
			
			
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			
			getdataPacket.data.add("iImp_flag",iImp_flag);
			getdataPacket.data.add("iCard_no",iCard_no);
			getdataPacket.data.add("iUse_flag",iUse_flag);
			
			getdataPacket.data.add("iPre_flag",iPre_flag);
			getdataPacket.data.add("iCust_name",iCust_name);
			getdataPacket.data.add("iId_type",iId_type);
			getdataPacket.data.add("iId_iccid",idIccid);
			getdataPacket.data.add("iCard_static",iCard_static);
			getdataPacket.data.add("iNote",iNote);
			
			
			core.ajax.sendPacket(getdataPacket,doRetCfm);
			getdataPacket = null;
		}
		
		function doRetCfm(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			
			
			
			
			if(retCode == "000000"){
				
				rdShowMessageDialog("操作成功！",2);
				doclear();
				
			}else if(retCode == "000001"){
				
				rdShowMessageDialog("操作成功，此号码为外地号码！",2);
				doclear();
				
			}else{
				
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
				doclear();
				
			}
			
		}


		 function showPrtDlg(printType,DlgMessage,submitCfm)
		  {  //显示打印对话框
			var pType="print";                     // 打印类型print 打印 subprint 合并打印
		  var billType="1";                      //  票价类型1电子免填单、2发票、3收据
			var sysAccept ="<%=sysAccept%>";                       // 流水号
			var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
			var mode_code=null;                        //资费代码
			var fav_code=null;                         //特服代码
			var area_code=null;                    //小区代码
			var opCode =   "<%=opCode%>";                         //操作代码
			var phoneNo = "";                           //客户电话

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
		  	
		  	var phoneNo = $.trim($("#phoneNo").val());
				var radioFlag = $("input[name='opType'][checked]").val();
				var iImp_flag = "";
				var iCard_no = "";
				var iCard_static ="";
				if(radioFlag == "simple"){
					iImp_flag="0";
					iCard_no = $.trim($("#cardNo").val());
					/*有价卡状态*/
					iCard_static = $.trim($("#cardStatus").val());
				}else if(radioFlag == "piliang"){
					iImp_flag="1";
					iCard_no = $("input[name='serviceFileName']").val();
					/*有价卡状态*/
					iCard_static = "";
				}
				
				/*是否刮卡*/
				var iUse_flag = $("select[name='isgua']").find("option:selected").html();
				/*是否充值*/
				var iPre_flag = $("select[name='ischong']").find("option:selected").html();
				/*客户姓名*/
				var iCust_name = $.trim($("#custName").val());
				/*证件类型*/
				var iId_type = $("select[name='idType']").find("option:selected").html();
				/*证件号码*/
				var idIccid = $.trim($("#idIccid").val());
				/*备注*/
				var iNote = $.trim($("#reply_content").text());
			    
			         		
        var cust_info=""; //客户信息
      	var opr_info=""; //操作信息
      	var retInfo = "";  //打印内容
      	var note_info1=""; //备注1
      	var note_info2=""; //备注2
      	var note_info3=""; //备注3
      	var note_info4=""; //备注4

				cust_info+=" "+"|";
				if(radioFlag == "simple"){
					opr_info+="客户姓名:"+iCust_name+"            手机号码:"+phoneNo+"|";
					opr_info+="证件号码:" + $("#idIccid").val() +"             原充值卡卡号:"+iCard_no+"|";
					
				}else if(radioFlag == "piliang"){
					opr_info+="客户姓名:"+iCust_name+"            手机号码:"+phoneNo+"|";
				}
				opr_info+="业务类型:<%=opName%>            业务流水：<%=sysAccept%>"+"|";
				var radioFlag = $("input[name='opType'][checked]").val();
				
				if($("#isgua").val() == "1" && $("#ischong").val() == "2"){
					note_info1+="尊敬的客户您好，根据您反馈的充值卡情况，发现您的充值卡涂层尚未刮开但已充值，存在被他人盗用的可能，我公司将视情况向公安机关报案。请您留存以下相关信息以便配合调查，谢谢。|";
				}else if($("#isgua").val() == "0" && $("#ischong").val() == "3"){
					note_info1+="尊敬的客户您好，由于我公司系统升级，导致您的充值卡未能充值（涂层已刮开）的情况，由此给您带来的不便，敬请谅解。请您留存以下相关信息，谢谢。|";
				}else if($("#isgua").val() == "1" && $("#ischong").val() == "3"){
					note_info1+="尊敬的客户您好，由于我公司系统升级，导致您的充值卡未能充值（涂层未刮开）的情况，由此给您带来的不便，敬请谅解。请您留存以下相关信息，谢谢。|";
				}else if($("#isgua").val() == "0" && $("#ischong").val() == "2"){
					note_info1+="尊敬的客户您好，您的充值卡涂层已刮开并已充值。如充值行为非您本人完成操作，建议您立即到公安机关报案。同时，我公司也会协助配合调查。请您留存以下相关信息。|";
				}
				note_info1+="请您核实以上相关信息内容，如确认无误请签字确认。|";
					
				retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  	      	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式

	    	    return retInfo;
		  }

	


		function doclear()
		{
		        window.location.href = "fm241.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		}
		
function changeType(opCode){
	
	var radioFlag = $("input[name='opType'][checked]").val();
	if(radioFlag == "simple"){
		$("#dyntb").show();
		$("#mutiConstants").hide();
		$("#isgua option[value='1']").remove();
		$("#simpleEx").show();
	}else if(radioFlag == "piliang"){
		$("#dyntb").hide();
		$("#mutiConstants").show();
		$("#isgua").append("<option value='1'>未刮</option>");
		$("#simpleEx").hide();
	}
	
}

function checkcards() {
			
			
			var radio1 = document.getElementsByName("opType");
				   for(var i=0;i<radio1.length;i++)
				  {
					    if(radio1[i].checked)
						{
						  var opFlag = radio1[i].value;
								  if(opFlag=="simple")
								{	
									
									if(!checkElement(document.all.cardNo)){
										return false;
									}
									
									var phoneNo = $.trim($("#phoneNo").val());
									var cardNo = $.trim($("#cardNo").val());
					        var packet = new AJAXPacket("fm241Check.jsp","正在获得数据，请稍候......");
					      	packet.data.add("cardNo",cardNo);
					      	packet.data.add("phoneNo",phoneNo);
					      	packet.data.add("opCode","<%=opCode%>");
					      	packet.data.add("opName","<%=opName%>");
					      	
					      	core.ajax.sendPacket(packet,dogetOfferInfo);
					      	packet = null;     		    

						    }
						    else {
						     			 	
						    						    	
						    }
				    }
		     }
		
}
	
	/*上传txt文件的方法*/
		function uploadBroad(){
			if($("#workNoList").val() == ""){
				rdShowMessageDialog("请上传有价卡信息文件！");
				$("#workNoList").focus();
				return false;
			}
			var formFile=frm.workNoList.value.lastIndexOf(".");
			var beginNum=Number(formFile)+1;
			var endNum=frm.workNoList.value.length;
			formFile=frm.workNoList.value.substring(beginNum,endNum);
			formFile=formFile.toLowerCase(); 
			if(formFile!="txt"){
				rdShowMessageDialog("上传文件格式只能是txt，请重新选择有价卡信息文件！",1);
				document.frm.workNoList.focus();
				return false;
			}
			else
				{
					/*准备上传*/
					document.frm.target="hidden_frame";
			    document.frm.encoding="multipart/form-data";
			    document.frm.action="/npage/sm241/fm241Upload.jsp";
			    document.frm.method="post";
			    document.frm.submit();
					return true;
				}
			
		}
		/*上传成功后要做的事儿*/
		function doSetFileName(oldFileName,newFileName,newFilePath){
			rdShowMessageDialog("上传文件"+oldFileName+"成功！",2);
			$("input[name='serviceFileName']").val(newFileName);
			$("input[name='serviceFilePath']").val(newFilePath);
			/*上传置无效*/
			$("#uploadFile").attr("disabled","disabled");
			/*提交置有效*/
			$("#quchoose").attr("disabled","");
			/*单选按钮置无效*/
			$("input[name='opType']").each(function(){
				$(this).attr("disabled","disabled");
			});
		}
		/*上传失败后要做的事儿*/
		function showUploadError(errorInfo){
			rdShowMessageDialog(errorInfo,1);
			window.location.href='/npage/sm241/fm241Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
			
		}
		
	function dogetOfferInfo(packet){
      var retcode = packet.data.findValueByName("retcode");
      var retmsg = packet.data.findValueByName("retmsg");
      var cardStatus = packet.data.findValueByName("cardStatus");
      if(retcode != "000000"){
        rdShowMessageDialog("校验卡号失败！错误代码：" + retcode + "，错误信息：" + retmsg,0);
        document.all.quchoose.disabled=true;
      }else{
      	/*
      	if(cardStatus != "已售"){
      		rdShowMessageDialog("只有已售的卡可以办理！",0);
      		$("#quchoose").attr("disabled","disabled");
      	}else{
      	*/
	     		rdShowMessageDialog("校验卡号成功",2);
	     		$("#cardStatus").val(cardStatus);
	     		$("#quchoose").attr("disabled","");
	     		
		     	$("#cardNo").attr("readonly","readonly");
					$("#cardNo").attr("class","InputGrey");
					
					/*单选按钮置无效*/
					$("input[name='opType']").each(function(){
						$(this).attr("disabled","disabled");
					});
					$("#compBtn").attr("disabled","disabled");
	     	/*
     		}
     		*/
     		
 				
      }
    }	
    
   function tellMore1000(){
			rdShowMessageDialog("最多只能上传1000条数据！，请重新选择文件",1);
			return false;
		}
		
	</script>
</HEAD>
<BODY >
	<FORM action="" method=post name="frm" ENCTYPE="multipart/form-data">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="sysAccept" value="<%=sysAccept%>"> 
	<input type="hidden" name="opflag" value="0">

        <table id=""  cellspacing="0">      	
        	  <tr>

			        		<td width=16% class="blue">操作类型</td>

			        		<td width=84% colspan="3">

			        			<input type="radio" name="opType"	value="simple"   onclick="changeType(this.value);" checked/>单个录入 &nbsp;&nbsp;

			        			<input type="radio" name="opType"	value="piliang"  onclick="changeType(this.value);"/>批量导入 &nbsp;&nbsp;

			        		</td>

        				</tr>
       </table>
       
       <table   cellspacing="0" style="display:block">
       	        	  <tr id="dyntb">

			        		<td width=16% class="blue">卡号</td>

			        		<td width=34% >
                       <input type="text" name="cardNo" id="cardNo" value="" v_must="1" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')">
			        				 &nbsp;&nbsp;<input  name="compBtn" id="compBtn" class="b_foot" type="button" value="验证" onclick="checkcards()">
			        		</td>
			        		<td width=16% class="blue">
			        				卡状态
			        		</td>
									
			        		<td width=34% >
                       <input type="text" name="cardStatus" id="cardStatus" value="" readOnly class="InputGrey">
			        		</td>
			        		

        				</tr>
        				
        				  <tr>

			        		<td width=16% class="blue">是否刮卡</td>

			        		<td width=34% >
                       <select id="isgua" name="isgua">
                       	<option value="0">已刮</option>
                       	<option value="1">未刮</option>
                       </select>
			        		</td>
			        		<td width=16% class="blue">是否充值</td>

			        		<td width=34% >
                       <select id="ischong" name="ischong">
                       	<option value="2">已充</option>
                       	<option value="3">未充</option>
                       </select>
			        		</td>
			        		
        				</tr>
        				
        				 <tr>

			        		<td width=16% class="blue">手机号码</td>

			        		<td width=34% >
                       <input type="text" name="phoneNo" id="phoneNo" value="" v_type="mobphone"   v_must="1">
			        		</td>
			        		<td width=16% class="blue">客户姓名</td>

			        		<td width=34% >
                       <input type="text" name="custName"  id="custName" value="" v_must="1">&nbsp;&nbsp;&nbsp;&nbsp;
              
			        		</td>

        				</tr>
        				 <tr>
                  <td width="16%" class="blue"> 证件类型</td>
                  <td>
                     <SELECT  id="idType" name="idType"> 
                     		<OPTION selected value="0">身份证</OPTION> 
                     		<OPTION value="1">军官证</OPTION> 
                     		<OPTION value=2>户口簿</OPTION> 
                     		<OPTION value=3>港澳通行证</OPTION> 
                     		<OPTION value=4>警官证</OPTION> 
                     		<OPTION value=5>台湾通行证</OPTION> 
                     		<OPTION value=6>外国公民护照</OPTION>
                     </SELECT>
                  </td>
                  <td width="16%" class="blue"> 证件号码 </td>
                  <td>
                      <input type="text"  id="idIccid" name="idIccid" v_must="1">
                  </td>
         					<tr>
                  <td width="16%" class="blue"> 备注</td>
                  <td colspan="3"> 
                    <textarea id="reply_content" style="width:100%;word-break:break-all"  name="reply_content" rows=4 cols="60" width="%100" ></textarea>
                  </td>
                </tr>
                <tr id="simpleEx">
                	<td colspan='4'>
                			<font color="red">
                				<b>注意：</b><br>
                				1、如果充值卡为未刮开，未充值的情况，请到“m240·特定有价卡换卡 ”进行办理。<br>
                				2、如果充值卡为未刮开，已充值的情况，请到“m242·未刮开已充值的充值卡换卡”进行办理。
                			</font>
                		
                	</td>
                </tr>
        				
              </table>

        				
  <div id="mutiConstants" >
			<table>
				<tr>
					<td width="20%" class="blue">
						批量信息导入
					</td>
					<td>
						<input type="file" name="workNoList" id="workNoList" class="button"
						style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />
						&nbsp;&nbsp;
						<input type="button" name="uploadFile" id="uploadFile" class="b_text" value="上传" onclick="uploadBroad();"/>
					</td>
				</tr>
				<tr>
					<td class="blue">
						文件格式说明
					</td>
		      <td> 
		          上传文件文本格式为“20150212777706300”，示例如下：<br>
		          <font class='orange'>
		          	&nbsp;&nbsp; 20150212777706300<br/>
		          	&nbsp;&nbsp; 20150212777706301<br/>
		          	&nbsp;&nbsp; 20150212777706302<br/>
		          	&nbsp;&nbsp; 20150212777706303<br/>
		          	&nbsp;&nbsp; 20150212777706304<br/>
		          	&nbsp;&nbsp; 20150212777706305<br/>
		          	&nbsp;&nbsp; 20150212777706306<br/>
		          	&nbsp;&nbsp; 20150212777706307<br/>
		          	&nbsp;&nbsp; 20150212777706308
		          </font>
		          <b>
		          <br>&nbsp;&nbsp; 注：格式中的每一项均不允许存在空格,且每条信息都需要回车换行。
		          </b> 
		      </td>
		    </tr>
			</table>
		</div>

        				       	
     
             <table cellspacing="0">
              	<tbody>
              		<tr>
                		<td id="footer">
                                    <input  name="quchoose" id="quchoose" class="b_foot" type="button" value="确认&打印"  onclick="doCommit();" disabled="disabled">
                                    &nbsp;
                                  	<input  name="clear" class="b_foot" type=reset value="重置" onclick="doclear()">
                                  	&nbsp;                  			

                		</td>
              		</tr>
              </tbody>
            </table>
      <!--流水号 -->
			<input type="hidden" name="printAccept" value="<%=sysAccept%>">
			<!-- 操作代码 -->
			<input type="hidden" name="opCode" value="<%=opCode%>">		
			<!-- 操作代码 -->
			<input type="hidden" name="opName" value="<%=opName%>">		
			<!--上传文件名 -->	
			<input type="hidden" name="serviceFileName" value=""/>
			<!--上传文件全路径名 -->	
			<input type="hidden" name="serviceFilePath" value=""/>
			<iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>
	     <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>

