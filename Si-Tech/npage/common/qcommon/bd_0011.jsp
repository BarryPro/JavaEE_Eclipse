<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<!--取地址信息-->
<%
	String objectId_0011=(String)session.getAttribute("objectId");	//当前处理局
	System.out.println("objectId  in  ba0011=========="+objectId_0011);
%>

<script>
	var branchNo_selNumJudge="<%=branchNo%>";
	function chooseNewAddress(){
		var newAddress=document.all.newAddress.value;
		var objectId="<%=objectId_0011%>";
    var myPacket = new AJAXPacket("/npage/common/qcommon/bd_0011_cfm.jsp","正在获取地址信息，请稍候......");       
    myPacket.data.add("newAddress",newAddress.toUpperCase());
    myPacket.data.add("objectId",objectId);
    core.ajax.sendPacket(myPacket,doProcess_ba0011);
		chkPacket =null;
}

	function doProcess_ba0011(packet)
{
	var error_code = packet.data.findValueByName("errorCode");
	var error_msg =  packet.data.findValueByName("errorMsg");
	var verifyType = packet.data.findValueByName("verifyType");	
	//alert("retCode="+error_code);
	//alert("retMsg="+error_msg);
    self.status="";
	if (verifyType=="chooseAddress"){
    	if( parseInt(error_code) != 0 ){	
					rdShowMessageDialog("<br>错误代码："+error_code+"</br>错误信息:"+error_msg);
					document.all.AddrSelect.length=0;
		      return false;
			}else{
 //返回值格式:addrId, ADDR_SHORT，addrName,branchNo,typeNum,branchSer,lowNo,branchName,highNo,BUREAU_ID ,objectId,zipcode 
					addrArr = packet.data.findValueByName("arrMsg");
					document.all.AddrSelect.length = 0;//地址信息
					for(var i=0; i<addrArr.length ; i++){
						 	var tmpStr = "";
				      if (addrArr[i][4] == "1") 
				      {
				      	 tmpStr = "单号";
				      }
		          else if (addrArr[i][4] == "0") 
		          {
		          	 tmpStr = "双号";
		          }
		          else if (addrArr[i][4] == "Q") 
		          {
		          	 tmpStr = "混合";
		          }
		          document.all.sAddrStand.value=addrArr[i][0];//addrId
		          document.all.printAddr.value=addrArr[i][2];//printAddr
		          var opt = new Option();
				     	opt.value = addrArr[i][0];//addrId
				     	opt.text  = addrArr[i][2]+"("+addrArr[i][6]+"--"+addrArr[i][8]+")"+tmpStr;
				     	opt.v_branchNo  = addrArr[i][3];						//局站编号
				     	opt.branch_name = addrArr[i][7];						//局站名称
				     	opt.v_typeNum   = addrArr[i][4];						//门牌类型
				     	opt.v_branchSer = addrArr[i][5];					//局站编码
				     	opt.v_lowNo     = addrArr[i][6].toString();	//门牌下限
				     	opt.v_highNo    = addrArr[i][8].toString();	//门牌上限
				     	opt.v_zipcode   = addrArr[i][11];	//邮政编码
				     	document.all.AddrSelect.options.add(opt);		//地址信息
				     
					}
					chgAddrSel();//地址变化时变更局站
	  			//crtAddr();//根据地址选择后生成地址
	  				
			}
	}
	
			
}

			//地址选择时变换局站
		function chgAddrSel()
		{
			//branchNo_selNumJudge=document.all.newbranchno.value.trim();
			//alert( "地址查询"+document.all.AddrSelect.options[document.all.AddrSelect.selectedIndex].v_branchNo);
			//alert("局站查询"+document.all.newbranchno.value);
			document.all.newbranchno.value = document.all.AddrSelect.options[document.all.AddrSelect.selectedIndex].v_branchNo;//变换局站
			document.all.newbranchno_name.value = document.all.AddrSelect.options[document.all.AddrSelect.selectedIndex].branch_name;//变换局站名称
			document.all.zip.value = document.all.AddrSelect.options[document.all.AddrSelect.selectedIndex].v_zipcode;//邮政编码
			//alert(document.all.zip.value);
			document.all.AddrNum.value ="";//住宅号
			document.all.addrTransIn.value ="";//详细地址
			controlSelNum ();                 //判断选号按纽是否可用 
			//selectDisabled(document.all.newbranchno); //地址变换时 局站仍然可以选择变换
		}
		

		function crtAddr()
		{
	if (document.all.AddrSelect.length == 0||document.all.AddrNum.value=='') return false;
			var typeNum = document.all.AddrSelect.options[document.all.AddrSelect.selectedIndex].v_typeNum; //1单号,0双号,Q混合
			var valNum = document.all.AddrNum.value.trim();//住宅号
			if (_isInteger(valNum))
			{ 
				var lowNo  = document.all.AddrSelect.options[document.all.AddrSelect.selectedIndex].v_lowNo;
				var highNo = document.all.AddrSelect.options[document.all.AddrSelect.selectedIndex].v_highNo;
				var intNum = parseInt(valNum); 
						if (intNum > parseInt(highNo) || intNum < parseInt(lowNo))
						{
								rdShowMessageDialog("门牌号码请输入["+lowNo+"--"+highNo+"]之间的号码,谢谢！",0);
								document.all.AddrNum.select();
								return false;
						}
						if (typeNum == "1")//单号
						{
									if (intNum%2 == 0)
									{
										rdShowMessageDialog("门牌号码请输入奇数号码,谢谢！",0);
										document.all.AddrNum.select();
										return false;
									}
						}else if (typeNum == "0"){//双号
									if (intNum%2 == 1)
									{
										rdShowMessageDialog("门牌号码请输入偶数号码,谢谢！",0);
										document.all.AddrNum.select();
										return false;
									}			
						}
				}else
				{
					rdShowMessageDialog("门牌号码只能输入数字,谢谢！",0);
					document.all.AddrNum.select();
					return false;
				}
				
			if (document.all.newAddress.value.trim() != "")
			{
				var temp = document.all.AddrSelect.options[document.all.AddrSelect.selectedIndex].text.toString();
				var addrStr = temp.substring(0,temp.indexOf("("));
				if (valNum != "")
				{
					addrStr += valNum+"号";	
				}
				//document.all.phone_addr.value = addrStr;
				//alert(document.all.phone_addr.value);
			}
}
	function _isInteger(valNum)
	{			//alert(valNum);
	      var re = /^[0-9]+[0-9]*]*$/;   //判断正整数 /^[1-9]+[0-9]*]*$/   
	     if (!re.test(valNum))
	     {
	        return false;
	     }
	     return true;
	}
	
	function  getBranch(objectId){
		var  path = "/npage/common/qcommon/selBranch.jsp?object_id="+objectId;
		var retVal = window.showModalDialog(path,"","dialogWidth:600px;dialogHeight:500px;");
		if(typeof(retVal)!="undefined"){
			document.all.newbranchno.value = retVal.split("-")[0];
			document.all.newbranchno_name.value = retVal.split("-")[1];
//			document.all.newbranchno_name.focus();
			controlSelNum();
		}
	}
</script>
 	<div class="input">
 				<table>
						  <tr>
          			<th> 地址简拼：</th>
          			<td>
									<input class="numOrLetter" type="text" id=newAddress name="newAddress"  value="" onkeyup="if(event.keyCode == 13)chooseNewAddress()">
								</td>  
            
              	  <th>地址信息：</th>
            	    <td>
										<select name="AddrSelect" onChange="chgAddrSel()"></select>
									</td>		
									
									<th>住宅号：</th>
									<td>
										<input  type="text" id=AddrNum name="AddrNum" onblur="crtAddr()" value="">
									</td>	
									
														
							</tr>
							<tr>
								<th id="bb0011"><span class="red">*局站：</span></th>
								<td>
									<!--
									<select class="required" name="newbranchno" onChange="controlSelNum()">
									</select>
									-->
									<input  type="text" class="required" name="newbranchno_name" id="newbranchno_name_0011" readonly />
									<input  type="hidden"  name="newbranchno"/>
									<input  type="button"  class="b_text"   value="选择"   onclick="getBranch(new String('<%=objectId_0011%>'));"/>
				        </td>
				         	<th><span class="red">*新地址描述：</span></th>
									<td colspan=3>
										<input  type="text" class="required" id=addrTransIn name="addrTransIn"  value="" size="60">
									</td>
										<input type="hidden" name="sAddrStand" value=""/>
										<input type="hidden" name="zip"/>
										<input type="hidden" name="printAddr"/>
							</tr>
					 </table>
				</div>