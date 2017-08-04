 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-12 页面改造,修改样式
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
	String orgcode = (String)session.getAttribute("orgCode");
  String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
  String regionCode= (String)session.getAttribute("regCode");


%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regioncode%>"  id="sysAccept" />

<HTML>
	<HEAD>
		<TITLE><%=opName%></TITLE>
		<script language="javascript" type="text/javascript" src="cardNumIndex.js"></script>
		<script language="JavaScript">
    var quanjusum=0;
    
    $(document).ready(function(){ 
    	document.all.opType[1].checked=true;
    	changeType("piliang");
    	});
    
		function doCommit()
		{
	

				var phone_nos   = $("#phone_no").val();
			  if(phone_nos.trim() ==""){
			  rdShowMessageDialog("请输入手机号码！",1);
			  return false;
			  }
	
				var custnamess  = $("#custnames").val();
			  if(custnamess.trim() ==""){
			  rdShowMessageDialog("请输入客户姓名！",1);
			  return false;
			  }	
				var iccidhaos  = $("#iccidhao").val();
			  if(iccidhaos.trim() ==""){
			  rdShowMessageDialog("请输入证件号码！",1);
			  return false;
			  }	
				var isyouji  = $("#isyouji").val();
			  if(isyouji.trim() =="zz"){
			  rdShowMessageDialog("请选择是否邮寄！",1);
			  return false;
			  }					  			  		  
			  
			var radio1 = document.getElementsByName("opType");
				   for(var i=0;i<radio1.length;i++)
				  {
					    if(radio1[i].checked)
						{
						  var opFlag = radio1[i].value;
								  if(opFlag=="simple")
								{	
							
						$("#opflag").val("1");     
						$("#duiduansheng").val($("#suoshushengfen").val()); 							
      	
				  var  ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
		    
		     if(typeof(ret)!="undefined"){
        if((ret=="confirm")){
          if(rdShowConfirmDialog('确认要提交信息吗？')==1){
            		document.form1.action="fm254Cfm.jsp";
		            document.form1.submit();
          }
        }
        if(ret=="continueSub"){
          if(rdShowConfirmDialog('确认要提交信息吗？')==1){
            		document.form1.action="fm254Cfm.jsp";
		            document.form1.submit();
          }
        }
      }else{
        if(rdShowConfirmDialog('确认要提交信息吗？')==1){
            		document.form1.action="fm254Cfm.jsp";
		            document.form1.submit();
        }
      }
       		    

						    }
						    else {
						    	$("#opflag").val("2");

						    	var checkonecol=0;
						    	var checkonecol1=0;
						    	var checkonecol2=0;
						    	var kahaoss="";
						    	var qianshuss="";
						    	var zongqianshuxianshi=0;
						    	var shuliangss=0;
						    	var duiduanshengss="";
						    	var kami="";
						    	var checkonecol3=0;

						    	  $("#dyntb2 tr").each(
									    function(){
												//alert($(this).find("td:eq(1) input").val());
												if($(this).find("td:eq(1) input").val()!=undefined) {
																			
													if($(this).find("td:eq(1) input").val().trim()=="") {
														checkonecol++;
														return false;
													}
													if($(this).find("td:eq(1) input").val().trim().length !=17) {
														checkonecol1++;
														return false;
													}
													if($(this).find("td:eq(3) input").val().trim()=="") {
														checkonecol2++;
														return false;
													}
													if($(this).find("td:eq(5) select").val().trim()=="zz") {
														checkonecol3++;
														return false;
													}													
													
													duiduanshengss=$(this).find("td:eq(7) input").val().trim();
													kami=kami+""+$(this).find("td:eq(3) input").val().trim()+"|";		
													
													kahaoss=kahaoss+""+$(this).find("td:eq(1) input").val().trim()+"|";		
													qianshuss=qianshuss+""+$(this).find("td:eq(5) select").val().trim()+"|";			
													zongqianshuxianshi= zongqianshuxianshi+parseFloat($(this).find("td:eq(5) select").val().trim());		
													shuliangss++;	
												}
										  }
							     );
							     
							 if(checkonecol!=0)   {
								rdShowMessageDialog("请输入旧有价卡卡号！",1);
			          return false;						 	
							 	}
							 if(checkonecol1!=0)   {
								rdShowMessageDialog("卡号为17位有效数字！",1);
				        return false;							 	
							 	}
							 if(checkonecol2!=0)   {
								rdShowMessageDialog("请输入旧有价卡卡密！",1);
			          return false;						 	
							 	}
								 if(checkonecol3!=0)   {
								rdShowMessageDialog("请选择有价卡金额！",1);
			          return false;						 	
							 	}								 	
							 	
							     
							if(hasRepeat()!="0" && hasRepeat()!=undefined) {
						  rdShowMessageDialog("有重复的卡号输入"+hasRepeat()+"，请确认！",1);
					     return false;								
							}
							
     		var zongmoney=zongqianshuxianshi;
     		$("#infilling_number").val(shuliangss);
     		$("#infilling_price").val(zongmoney);
     		$("#duiduansheng").val(duiduanshengss);
     		$("#lisankahao").val(kahaoss);
     		$("#lisanjine").val(qianshuss);
     		$("#kami").val(kami);
     		

     		
     		
				    var  ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
		    
		     if(typeof(ret)!="undefined"){
        if((ret=="confirm")){
          if(rdShowConfirmDialog('确认要提交信息吗？')==1){
            		document.form1.action="fm254Cfm.jsp";
		            document.form1.submit();
          }
        }
        if(ret=="continueSub"){
          if(rdShowConfirmDialog('确认要提交信息吗？')==1){
            		document.form1.action="fm254Cfm.jsp";
		            document.form1.submit();
          }
        }
      }else{
        if(rdShowConfirmDialog('确认要提交信息吗？')==1){
            		document.form1.action="fm254Cfm.jsp";
		            document.form1.submit();
        }
      }
      
							     						    						    	
						    }
    
				    }
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

		   	var h=150;
		   	var w=350;
		   	var t=screen.availHeight/2-h/2;
		   	var l=screen.availWidth/2-w/2;

		   	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
			var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
			var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
			var ret=window.showModalDialog(path,printStr,prop);
		  }

		  function printInfo(printType)
		  {
			    var count=$("#infilling_number").val();
			    var count1=$("#infilling_price").val();
			         		
		        var cust_info=""; //客户信息
		      	var opr_info=""; //操作信息
		      	var retInfo = "";  //打印内容
		      	var note_info1=""; //备注1
		      	var note_info2=""; //备注2
		      	var note_info3=""; //备注3
		      	var note_info4=""; //备注4

						 cust_info+="手机号码：   "+$("#phone_no").val()+"|";
			       cust_info+="客户姓名：   "+$("#custnames").val()+"|";
			       cust_info+="证件号码：   "+$("#iccidhao").val()+"|";
			       
			var radio1 = document.getElementsByName("opType");
				   for(var i=0;i<radio1.length;i++)
				  {
					    if(radio1[i].checked)
						{
						  var opFlag = radio1[i].value;
								  if(opFlag=="simple")//连续卡号<1000
								{
									
									if(parseFloat(count1)<1000) {
                    opr_info+="投诉流水号："+$("#tousudanhao").val()+"|";
                    opr_info+="是否刮开："+$("#isgua").find('option:selected').text()+"|";
                    opr_info+="办理业务：千元以下外省充值卡在我省换卡|";
                    opr_info+="操作流水：<%=sysAccept%>       充值卡换卡费：0元|";
                    opr_info+="原开始卡号："+$("#oldbegin").val()+"    原结束卡号："+$("#oldend").val()+"    所属省份："+$("#suoshushengfen").val()+"    单张面额："+$("#danzhangmiane").val()+"元|";
                    opr_info+="有价卡张数:"+count+"            总金额："+count1+"|";
										opr_info+="备注：原充值卡返还给营业人员处理。"+"|";

									}else {//>=1000
                    opr_info+="投诉流水号："+$("#tousudanhao").val()+"|";
                    opr_info+="是否刮开："+$("#isgua").find('option:selected').text()+"|";
                    opr_info+="办理业务：千元以上外省充值卡，我省收卡邮寄|";
                    opr_info+="操作流水：<%=sysAccept%>       充值卡换卡费：0元|";
                    opr_info+="原开始卡号："+$("#oldbegin").val()+"    原结束卡号："+$("#oldend").val()+"    所属省份："+$("#suoshushengfen").val()+"    单张面额："+$("#danzhangmiane").val()+"元|";
                    opr_info+="有价卡张数:"+count+"            总金额："+count1+"|";
										opr_info+="备注：客户将充值卡交于黑龙江移动，由黑龙江移动将充值卡载明的相关信息反馈至发卡公司，并由发卡公司向黑龙江公司反馈充值卡是否经过充值。其中，对于未经过充值的，发卡公司将上述金额充值卡的等值金额充值卡至黑龙江公司。"+"|";
																				
									}
								}else {		
									
			
										if(parseFloat(count1)<1000) {
                    opr_info+="投诉流水号："+$("#tousudanhao").val()+"|";
                    opr_info+="是否刮开："+$("#isgua").find('option:selected').text()+"|";
                    opr_info+="办理业务：千元以下外省充值卡在我省换卡|";
                    opr_info+="操作流水：<%=sysAccept%>       充值卡换卡费：0元|";
				           
									  $("#dyntb2 tr").each(
									    function(){
												//alert($(this).find("td:eq(1) input").val());
												if($(this).find("td:eq(1) input").val()!=undefined) {
													
													opr_info+="原充值卡号："+$(this).find("td:eq(1) input").val()+"    所属省份："+$(this).find("td:eq(7) input").val()+"    原充值卡面值："+$(this).find("td:eq(5) select").val()+"元|";
													
												}
										  }
							     );
                    
                    opr_info+="有价卡张数:"+count+"            总金额："+count1+"|";
										opr_info+="备注：原充值卡返还给营业人员处理。"+"|";

									}else {//>=1000
                    opr_info+="投诉流水号："+$("#tousudanhao").val()+"|";
                    opr_info+="是否刮开："+$("#isgua").find('option:selected').text()+"|";
                    opr_info+="办理业务：千元以上外省充值卡，我省收卡邮寄|";
                    opr_info+="操作流水：<%=sysAccept%>       充值卡换卡费：0元|";
                    
                    	$("#dyntb2 tr").each(
									    function(){
												//alert($(this).find("td:eq(1) input").val());
												if($(this).find("td:eq(1) input").val()!=undefined) {
													
													opr_info+="原充值卡号："+$(this).find("td:eq(1) input").val()+"    所属省份："+$(this).find("td:eq(7) input").val()+"    原充值卡面值："+$(this).find("td:eq(5) select").val()+"元|";
													
												}
										  }
							     );
							     
                    opr_info+="有价卡张数:"+count+"            总金额："+count1+"|";
										opr_info+="备注：客户将充值卡交于黑龙江移动，由黑龙江移动将充值卡载明的相关信息反馈至发卡公司，并由发卡公司向黑龙江公司反馈充值卡是否经过充值。其中，对于未经过充值的，发卡公司将上述金额充值卡的等值金额充值卡至黑龙江公司。"+"|";
																				
									}
									
								}
							}
						}


				retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  	      	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式

	    	    return retInfo;
		  }

	


		function doclear()
		{
		        window.location.href = "fm254.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		}
		
function changeType(opCode){
	document.all.comp.disabled=false;
	document.all.quchoose.disabled=true;
	if(opCode == "simple"){
		
	$("#dyntb").show();
	$("#dyntb2").hide();
 	
		$("#infilling_number").val("0");
    $("#infilling_price").val("0");
    $("#squerys").empty();    
    $("#oldbeginjiu").val("");
    $("#miane").val("");
    $("#ssshengfen").val("");   
    document.all.addyjk.disabled=false;
	}
	if(opCode == "piliang"){
	$("#dyntb").hide();
	$("#dyntb2").show();
	
 	  $('#oldbegin').attr("readonly","");
    $('#oldend').attr("readonly","");    
		$("#oldbegin").val("");
		$("#oldend").val("");
		$("#infilling_number").val("0");
    $("#infilling_price").val("0");
    $("#suoshushengfen").val("");
   	    
	}	
}

function checkcards() {
	
				var phone_nos   = $("#phone_no").val();
			  if(phone_nos.trim() ==""){
			  rdShowMessageDialog("请输入手机号码！",1);
			  return false;
			  }
	
				var custnamess  = $("#custnames").val();
			  if(custnamess.trim() ==""){
			  rdShowMessageDialog("请输入客户姓名！",1);
			  return false;
			  }	
				var iccidhaos  = $("#iccidhao").val();
			  if(iccidhaos.trim() ==""){
			  rdShowMessageDialog("请输入证件号码！",1);
			  return false;
			  }		
				var isyouji  = $("#isyouji").val();
			  if(isyouji.trim() =="zz"){
			  rdShowMessageDialog("请选择是否邮寄！",1);
			  return false;
			  }				  
			  		  		  
			  
			var radio1 = document.getElementsByName("opType");
				   for(var i=0;i<radio1.length;i++)
				  {
					    if(radio1[i].checked)
						{
						  var opFlag = radio1[i].value;
								  if(opFlag=="simple")
								{	
									

		     var oldbegin = $("#oldbegin").val();
		     var oldend   = $("#oldend").val();
			  if(oldbegin.trim() ==""){
			  rdShowMessageDialog("请输入旧开始卡号！",1);
			  return false;
			  }
			  if(oldend.trim() ==""){
			  rdShowMessageDialog("请输入旧结束卡号！",1);
			  return false;
			  }	
			  if(oldbegin.trim().length !=17 ){
			  rdShowMessageDialog("卡号为17位有效数字！",1);
			  return false;
			  }	 
			  if(oldend.trim().length !=17 ){
			  rdShowMessageDialog("卡号为17位有效数字！",1);
			  return false;
			  }	 			   

        var packet = new AJAXPacket("fm254Check.jsp","正在获得数据，请稍候......");
      	packet.data.add("oldbegin",oldbegin);
      	packet.data.add("oldend",oldend);      	
      	packet.data.add("opFlag","0");
      	
      	core.ajax.sendPacket(packet,dogetOfferInfo);
      	packet = null;     		    

						    }
						    else {

						    	var checkonecol=0;
						    	var checkonecol1=0;
						    	var checkonecol2=0;
						    	var zongqianshuxianshi=0;
						    	var shuliangss=0;
						    	var checkonecol3=0;
						    	  $("#dyntb2 tr").each(
									    function(){
												//alert($(this).find("td:eq(1) input").val());
												if($(this).find("td:eq(1) input").val()!=undefined) {
																			
													if($(this).find("td:eq(1) input").val().trim()=="") {
														checkonecol++;
														return false;
													}
													if($(this).find("td:eq(1) input").val().trim().length !=17) {
														checkonecol1++;
														return false;
													}

													if($(this).find("td:eq(3) input").val().trim()=="") {
														checkonecol2++;
														return false;
													}	
													if($(this).find("td:eq(5) select").val().trim()=="zz") {
														checkonecol3++;
														return false;
													}
																									
		
													zongqianshuxianshi= zongqianshuxianshi+parseFloat($(this).find("td:eq(5) select").val().trim());		
													shuliangss++;	
												}
										  }
							     );
							     
							 if(checkonecol!=0)   {
								rdShowMessageDialog("请输入旧有价卡卡号！",1);
			          return false;						 	
							 	}
							 if(checkonecol1!=0)   {
								rdShowMessageDialog("卡号为17位有效数字！",1);
				        return false;							 	
							 	}
							 if(checkonecol2!=0)   {
								rdShowMessageDialog("请输入旧有价卡卡密！",1);
			          return false;						 	
							 	}
								 if(checkonecol3!=0)   {
								rdShowMessageDialog("请选择有价卡金额！",1);
			          return false;						 	
							 	}						 	
							 	
							 	
							 //alert(hasRepeat());    
							if(hasRepeat()!="0" && hasRepeat()!=undefined) {
						  rdShowMessageDialog("有重复的卡号输入"+hasRepeat()+"，请确认！",1);
					     return false;								
							}
							
     		var zongmoney=zongqianshuxianshi;
     		$("#infilling_number").val(shuliangss);
     		$("#infilling_price").val(zongmoney);
     		
     		rdShowMessageDialog("校验卡号成功",2);
     		document.all.addyjk.disabled=true;
     		document.all.quchoose.disabled=false;
	 			document.all.comp.disabled=true;		
							     						    						    	
						    }
    
				    }
		     }
		
}

function hasRepeat(){ 
			var arr = []; 
			$("#dyntb2 tr").each(function(){ 
			//alert($("td:eq(1) input",this).val());
    if($("td:eq(1) input",this).val()!=undefined) {
			arr.push($("td:eq(1) input",this).val());  
		}					    
			}); 

			var nary=arr.sort();
			for(var i=0;i<arr.length;i++){		
			if (nary[i]==nary[i+1]){			
			return nary[i];			
			}	
			}
} 
		
	function dogetOfferInfo(packet){
      var retcode = packet.data.findValueByName("errCode");
      var retmsg = packet.data.findValueByName("errMsg");
      var scounts = packet.data.findValueByName("scounts");
           
      if(retcode != "000000"){
        rdShowMessageDialog("校验卡号失败！错误代码：" + retcode + "，错误信息：" + retmsg,0);
        document.all.quchoose.disabled=true;
      }else{
      	if(scounts<=0) {
        rdShowMessageDialog("校验卡号失败！",0);
        document.all.quchoose.disabled=true;
 			 }else {
 	     		rdShowMessageDialog("校验卡号成功",2);
	     		var danmoney = $("#danzhangmiane").val();
	     		var zongmoney=parseFloat(danmoney)*parseFloat(scounts).toFixed(2);;
	     		$("#infilling_number").val(scounts);
	     		$("#infilling_price").val(zongmoney);
	     		$('#oldbegin').attr("readonly","readonly");
	     		$('#oldend').attr("readonly","readonly");
	     		
	 				document.all.quchoose.disabled=false;
	 				document.all.comp.disabled=true;			 	
 			 }
      }
    }
    
     function changemoneys() {
        var danmoney = $("#danzhangmiane").val();
        var conutss=$("#infilling_number").val();
     		var zongmoney=parseFloat(danmoney)*parseFloat(conutss);;     		
     		$("#infilling_price").val(zongmoney);
     	}
    	
    
    function addcardinput() {
    	
			var scount=0;		   	
		  $("#dyntb2 tr").each(
		    function(){
		    	scount++;
			}
	    );
				
			if(scount==31) {
				alert("最多只能填写30张卡的信息！");
				return;
			}
			
    										var tr_str='';  
									         tr_str+="<tr><td  class='blue'>旧有价卡卡号</td><td ><input type='text' name='oldbegin"+quanjusum+"' id='oldbegin"+quanjusum+"'  v_must ='1'  onkeyup=this.value=this.value.replace(/\D/g,'') onafterpaste=this.value=this.value.replace(/\D/g,'') onBlur=setTdVals(this.value,'ssshengfen"+quanjusum+"')><font class='orange'>*</font></td>";  
									         tr_str+="<td  class='blue'>卡密</td><td ><input type='text' name='kami"+quanjusum+"' id='kami"+quanjusum+"' value='' size='19' v_must ='1'  /><font class='orange'>*</font></td><td class='blue'>面额（元）</td><td><select id='miane' name='miane' ><option value='zz'>--请选择--</option><option value='10'>10</option><option value='20'>20</option><option value='30'>30</option><option value='50'>50</option><option value='100'>100</option><option value='200'>200</option><option value='300'>300</option><option value='500'>500</option></select><font class='orange'>*</font></td>";  
									         
									         tr_str+="<td  class='blue'> 所属省份</td><td><input type='text' readonly id='ssshengfen"+quanjusum+"' name='ssshengfen"+quanjusum+"' size='14' class=InputGrey >";  
									         tr_str+="&nbsp;&nbsp;&nbsp;&nbsp;<input type='button' value='删除' class='b_text' onClick='deletzhka(this)'></td></tr>";    
									         tr_str+="</tr>";  
									         $("#squerys").append(tr_str);  
									         quanjusum++; 
                
    }
    
     function deletzhka(k) {
 	  $(k).parent().parent().remove();  
 }
 
 
 function clearNoNum(obj){   obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符  

 obj.value = obj.value.replace(/^\./g,"");  //验证第一个字符是数字而不是. 

  obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的.   

obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");

}  
		
	</script>
</HEAD>
<BODY >
	<FORM action="" method=post name="form1" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="loginAccept" id="loginAccept" value="<%=sysAccept%>"> 
	<input type="hidden" name="opflag" id="opflag">
	<input type="hidden" name="duiduansheng" id="duiduansheng">
	<input type="hidden" name="lisankahao" id="lisankahao">
	<input type="hidden" name="lisanjine" id="lisanjine">
	<input type="hidden" name="kami" id="kami">
	

        <table id=""  cellspacing="0" style="display:none">  	
        	  <tr>

			        		<td width=16% class="blue">操作类型</td>

			        		<td width=84% colspan="3">

			        			<input style="display:none" type="radio" name="opType"	value="simple"   onclick="changeType(this.value);" checked/>连续卡号 &nbsp;&nbsp;

			        			<input type="radio" name="opType"	value="piliang"  onclick="changeType(this.value);"/>离散卡号 &nbsp;&nbsp;

			        		</td>

        				</tr>
       </table>
       
       <table   cellspacing="0" >
       	<tr>
					        <td class='blue'>手机号码</td>
					        <td>
								<input type="text" value="" name="phone_no" id="phone_no"    v_must ='1'/>
								<font class="orange">*</font>
					        </td>
					        <td class='blue'>客户姓名</td>
					        <td>
					        	<input type="text" value="" name="custnames" id="custnames" maxlength="30" v_must ='1' onblur="checkElement(this)"/>
					        	<font class="orange">*</font>
					        	</td>
					        </tr>
       	        	  <tr>
       	<tr>
					        <td class='blue'>证件号码</td>
					        <td>
								<input type="text" value="" name="iccidhao" id="iccidhao"   v_must ='1'  onblur = "checkElement(this)"/>
								<font class="orange">*</font>
					        </td>
					        <td class='blue'>投诉单号</td>
					        <td>
					        	<input type="text" value="" name="tousudanhao" id="tousudanhao" maxlength="100"  onblur="checkElement(this)"/>
					        	</td>
					        </tr>

        				
        				  <tr>

			        		<td width=16% class="blue">是否刮卡</td>

			        		<td width=34% >
                       <select id="isgua" name="isgua">
                       	<option value="0">未刮</option>
                       	<option value="1">已刮</option>
                       </select>
			        		</td>
			        		<td width=16% class="blue">是否邮寄</td>

			        		<td width=34% >
                       <select id="isyouji" name="isyouji">
                       	<option value="zz">--请选择--</option>
                       	<option value="1">是</option>
                       	<option value="0">否</option>
                       </select>
                       <font class="orange">*</font>
			        		</td>
			        		
        				</tr>
        				 </table>
        				  <table id="dyntb" style="display:block">
        				       	        	  <tr>       	        	  	

			        		<td width=16% class="blue">旧开始卡号</td>

			        		<td width=34% >
                       <input type="text" name="oldbegin" id="oldbegin" value="" v_must ='1'  onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" onBlur="setTdVals(this.value,'suoshushengfen')">
                       <font class="orange">*</font>
			        		</td>
			        		<td width=16% class="blue">旧结束卡号</td>

			        		<td width=34% >
                       <input type="text" name="oldend" id="oldend" value="" v_must ='1' onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" onBlur="setTdVals(this.value,'suoshushengfen')">
                       <font class="orange">*</font>
			        		</td>
			        		

        				</tr>
  
          				
        				 <tr>
                  <td width="16%" class="blue"> 单张面额（元）</td>
                  <td>
                    
                       <select id="danzhangmiane" name="danzhangmiane" onChange="changemoneys()">
                       	<option value="zz">--请选择--</option>
                       	<option value="10">10</option>
                       	<option value="20">20</option>
                       	<option value="30">30</option>
                       	<option value="50">50</option>
                       	<option value="100">100</option>
                       	<option value="200">200</option>
                       	<option value="300">300</option>
                       	<option value="500">500</option>
                       </select>
                  </td>
                  <td width="16%" class="blue"> 所属省份</td>
                  <td>
  										<input type="text" readonly id="suoshushengfen" name="suoshushengfen" size="14" class=InputGrey >
                  </td>
         

                </tr>      				
        			
        				
              </table>

        				
   <table id="dyntb2"  cellspacing="0" style="display:none">
						   	<tr>
						   			<td  colspan="8"><input  name="addyjk" id="addyjk"  class="b_text" type=button value="增加旧有价卡输入" onclick="addcardinput()"></td>
						   	</tr>
								<tr>
			        		<td  class="blue">旧有价卡卡号</td>

			        		<td >
                       <input type="text" name="oldbeginjiu" id="oldbeginjiu" value="" size="19" v_must ='1'  onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" onBlur="setTdVals(this.value,'ssshengfen')" />
                       <font class="orange">*</font>
			        		</td>
			        		<td  class="blue">卡密</td>
			        		<td >
                       <input type="text" name="kamiss" id="kamiss" value="" size="19" v_must ='1'  />
                       <font class="orange">*</font>
			        		</td>
			        		<td class="blue">面额（元）</td>

			        		<td>                   
                   		  <select id="miane" name="miane" >
                   		 <option value="zz">--请选择--</option>
                       	<option value="10">10</option>
                       	<option value="20">20</option>
                       	<option value="30">30</option>
                       	<option value="50">50</option>
                       	<option value="100">100</option>
                       	<option value="200">200</option>
                       	<option value="300">300</option>
                       	<option value="500">500</option>
                       </select><font class="orange">*</font>
			        		</td>
			        		

                  <td width="16%" class="blue"> 所属省份</td>
                  <td >
  										<input type="text" readonly id="ssshengfen" name="ssshengfen" size="19" class=InputGrey />
                  </td>
         

                </tr>      				
        				
									<tbody id="squerys">
	                </tbody>
         

      </table>
      <table   cellspacing="0" >
              				  <tr>
                  <td width="16%" class="blue"> 有价卡张数</td>
                  <td>
                     <input type="text" readonly id="infilling_number" name="infilling_number" size="14" value="0" class=InputGrey />
                  </td>
                  <td width="16%" class="blue"> 总金额 </td>
                  <td colspan="3">
                      <input type="text"  id="infilling_price" name="infilling_price" size="14" value="0" class=InputGrey />
                  </td>
                  </tr> 

        </table>				       	
     
             <table cellspacing="0">
              	<tbody>
              		<tr>
                		<td id="footer">
                			              <input  name="comp" class="b_foot" type=button value=验证 onclick="checkcards()" />
                                    <input  name="quchoose" id="quchoose" class="b_foot" type=button value=确认&打印  onclick="doCommit()" disabled>
                                    &nbsp;
                                  	<input  name="clear" class="b_foot" type=reset value=清除 onclick="doclear()">
                                  	&nbsp;                  			

                		</td>
              		</tr>
              </tbody>
            </table>
	     <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>

