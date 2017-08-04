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
		<script language="JavaScript">

		function doCommit()
		{
	
			var radio1 = document.getElementsByName("opType");
				   for(var i=0;i<radio1.length;i++)
				  {
					    if(radio1[i].checked)
						{
						  var opFlag = radio1[i].value;
								  if(opFlag=="simple")
								{	//连续卡号提交
									
		    var  ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
		    
		     if(typeof(ret)!="undefined"){
        if((ret=="confirm")){
          if(rdShowConfirmDialog('确认要提交信息吗？')==1){
          			document.all.quchoose.disabled=true;
            		document.form1.action="fm240Commit.jsp";
		            document.form1.submit();
          }
        }
        if(ret=="continueSub"){
          if(rdShowConfirmDialog('确认要提交信息吗？')==1){
          			document.all.quchoose.disabled=true;
            		document.form1.action="fm240Commit.jsp";
		            document.form1.submit();
          }
        }
      }else{
        if(rdShowConfirmDialog('确认要提交信息吗？')==1){
        				document.all.quchoose.disabled=true;
            		document.form1.action="fm240Commit.jsp";
		            document.form1.submit();
        }
      }
		    
						    }
						    else {
						    	

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
		      	var oldbegin = $("#oldbegin").val();
				    var oldend   = $("#oldend").val();
				    var newbegin = $("#newbegin").val();
				    var newend   = $("#newend").val();

				cust_info+=" "+"|";
				opr_info+="业务类型:<%=opName%>            业务流水：<%=sysAccept%>"+"|";
				opr_info+="业务受理时间：" + "<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>" +  "|";
				opr_info+="旧开始卡号:"+oldbegin+"            旧结束卡号："+oldend+"|";
				opr_info+="新开始卡号:"+newbegin+"            旧开始卡号："+newend+"|";
				opr_info+="有价卡张数:"+count+"            总金额："+count1+"|";
				

	 			note_info1+=""+"|";

				retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  	      	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式

	    	    return retInfo;
		  }

	


		function doclear()
		{
		        window.location.href = "fm240.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		}
		
function changeType(opCode){
	document.all.comp.disabled=false;
	document.all.quchoose.disabled=true;
	if(opCode == "simple"){
		
	$("#dyntb").show();
	$("#dyntb2").hide();
	
						 $(function () { 
				     $('#feefile').parents('form').attr('enctype', '"application/x-www-form-urlencoded').get(0).encoding = 'application/x-www-form-urlencoded'; 
			     });

   	    
   	    
	}
	if(opCode == "piliang"){
	$("#dyntb").hide();
	$("#dyntb2").show();
	
						 $(function () { 
				     $('#feefile').parents('form').attr('enctype', 'multipart/form-data').get(0).encoding = 'multipart/form-data'; 
			     });

   	   
   	    
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
									
	
		     var oldbegin = $("#oldbegin").val();
		     var oldend   = $("#oldend").val();
		     var newbegin = $("#newbegin").val();
		     var newend   = $("#newend").val();
			  if(oldbegin.trim() ==""){
			  rdShowMessageDialog("请输入旧开始卡号！",1);
			  return false;
			  }
			  if(oldend.trim() ==""){
			  rdShowMessageDialog("请输入旧结束卡号！",1);
			  return false;
			  }
			  if(newbegin.trim() ==""){
			  rdShowMessageDialog("请输入新开始卡号！",1);
			  return false;
			  }			  
			  if(newend.trim() ==""){
			  rdShowMessageDialog("请输入新结束卡号！",1);
			  return false;
			  }				  

        var packet = new AJAXPacket("fm240Check.jsp","正在获得数据，请稍候......");
      	packet.data.add("oldno",oldbegin+"|"+oldend);
      	packet.data.add("newno",newbegin+"|"+newend);
      	packet.data.add("opFlag","0");
      	
      	core.ajax.sendPacket(packet,dogetOfferInfo);
      	packet = null;     		    

						    }
						    else {
						     			 	if(form1.feefile.value.length<1){
													rdShowMessageDialog("请上传文件!");
													document.form1.feefile.focus();
													return false;
												}
								
										 		var fileVal = getFileExt($("#feefile").val());
												if("txt" == fileVal){
													//扩展名是txt
												}else{
													rdShowMessageDialog("上传文件的扩展名不正确",0);
													return false;
												}
												document.all.comp.disabled=true;
						    		    document.form1.action="fm240Upload.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		                    document.form1.submit();
						    						    	
						    }
				    }
		     }
		
}

	function getFileExt(obj)
	{
	    var pos = obj.lastIndexOf(".");
	    return obj.substring(pos+1);
	}
		
	function dogetOfferInfo(packet){
      var retcode = packet.data.findValueByName("retcode");
      var retmsg = packet.data.findValueByName("retmsg");
      var moneys = packet.data.findValueByName("moneys");
      var numss = packet.data.findValueByName("numss");
      if(retcode != "000000"){
        rdShowMessageDialog("校验卡号失败！错误代码：" + retcode + "，错误信息：" + retmsg,0);
        document.all.quchoose.disabled=true;
      }else{
     		rdShowMessageDialog("校验卡号成功",2);
     		$("#infilling_number").val(numss);
     		$("#infilling_price").val(moneys);
     		$('#oldbegin').css("readonly","true");
     		$('#oldend').css("readonly","true");
     		$('#newbegin').css("readonly","true");
     		$('#newend').css("readonly","true");
     		
 				document.all.quchoose.disabled=false;
 				document.all.comp.disabled=true;
      }
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
	<input type="hidden" name="sysAccept" value="<%=sysAccept%>"> 
	<input type="hidden" name="opflag" value="0">

        <table id=""  cellspacing="0">      	
        	  <tr>

			        		<td width=16% class="blue">操作类型</td>

			        		<td width=84% colspan="3">

			        			<input type="radio" name="opType"	value="simple"   onclick="changeType(this.value);" checked/>连续卡号 &nbsp;&nbsp;

			        			<input type="radio" name="opType"	value="piliang"  onclick="changeType(this.value);"/>批量导入 &nbsp;&nbsp;

			        		</td>

        				</tr>
       </table>
       
       <table id="dyntb"  cellspacing="0" style="display:block">
       	        	  <tr>

			        		<td width=16% class="blue">旧开始卡号</td>

			        		<td width=34% >
                       <input type="text" name="oldbegin" id="oldbegin" value="" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')">
			        		</td>
			        		<td width=16% class="blue">旧结束卡号</td>

			        		<td width=34% >
                       <input type="text" name="oldend" id="oldend" value="" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')">
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

			        		<td width=16% class="blue">新开始卡号</td>

			        		<td width=34% >
                       <input type="text" name="newbegin" id="newbegin" value="" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')">
			        		</td>
			        		<td width=16% class="blue">新结束卡号</td>

			        		<td width=34% >
                       <input type="text" name="newend"  id="newend" value="" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')">&nbsp;&nbsp;&nbsp;&nbsp;
              
			        		</td>

        				</tr>
        				                              <tr>
                  <td width="16%" class="blue"> 有价卡张数</td>
                  <td>
                     <input type="text" readonly id="infilling_number" name="infilling_number" size="14" class=InputGrey >
                  </td>
                  <td width="16%" class="blue"> 总金额 </td>
                  <td>
                      <input type="text" readonly id="infilling_price" name="infilling_price" size="14" class=InputGrey>
                  </td>
         

                </tr>
        				
              </table>

        				
   <table id="dyntb2"  cellspacing="0" style="display:none">
		<tr id="fileUpLoad">
			<td width=16% class="blue">
				文件上传
			</td>
			<td width=34% >
				<input type="file" name="feefile" id="feefile">
			</td>
			<td width=16% class="blue">
				文件上传说明
			</td>
			<td width=34% >
				<span>
					数据文件必须为<font color="red">txt</font>格式，每行记录为旧卡卡号竖线“|”新卡卡号<br />
					一次最多操作1000个卡号<br />
					&nbsp;如：<br />
					&nbsp;&nbsp;&nbsp;150000000000000000|160000000000000000<br/>
					&nbsp;&nbsp;&nbsp;170000000000000000|180000000000000000<br/>

			</span>
			</td>
		</tr>

      </table>

        				       	
     
             <table cellspacing="0">
              	<tbody>
              		<tr>
                		<td id="footer">
                			              <input  name="comp" class="b_foot" type=button value=验证 onclick="checkcards()">
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

