<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<!--ȡ��ַ��Ϣ-->
<%
	String objectId_0011=(String)session.getAttribute("objectId");	//��ǰ�����
	System.out.println("objectId  in  ba0011=========="+objectId_0011);
%>

<script>
	var branchNo_selNumJudge="<%=branchNo%>";
	function chooseNewAddress(){
		var newAddress=document.all.newAddress.value;
		var objectId="<%=objectId_0011%>";
    var myPacket = new AJAXPacket("/npage/common/qcommon/bd_0011_cfm.jsp","���ڻ�ȡ��ַ��Ϣ�����Ժ�......");       
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
					rdShowMessageDialog("<br>������룺"+error_code+"</br>������Ϣ:"+error_msg);
					document.all.AddrSelect.length=0;
		      return false;
			}else{
 //����ֵ��ʽ:addrId, ADDR_SHORT��addrName,branchNo,typeNum,branchSer,lowNo,branchName,highNo,BUREAU_ID ,objectId,zipcode 
					addrArr = packet.data.findValueByName("arrMsg");
					document.all.AddrSelect.length = 0;//��ַ��Ϣ
					for(var i=0; i<addrArr.length ; i++){
						 	var tmpStr = "";
				      if (addrArr[i][4] == "1") 
				      {
				      	 tmpStr = "����";
				      }
		          else if (addrArr[i][4] == "0") 
		          {
		          	 tmpStr = "˫��";
		          }
		          else if (addrArr[i][4] == "Q") 
		          {
		          	 tmpStr = "���";
		          }
		          document.all.sAddrStand.value=addrArr[i][0];//addrId
		          document.all.printAddr.value=addrArr[i][2];//printAddr
		          var opt = new Option();
				     	opt.value = addrArr[i][0];//addrId
				     	opt.text  = addrArr[i][2]+"("+addrArr[i][6]+"--"+addrArr[i][8]+")"+tmpStr;
				     	opt.v_branchNo  = addrArr[i][3];						//��վ���
				     	opt.branch_name = addrArr[i][7];						//��վ����
				     	opt.v_typeNum   = addrArr[i][4];						//��������
				     	opt.v_branchSer = addrArr[i][5];					//��վ����
				     	opt.v_lowNo     = addrArr[i][6].toString();	//��������
				     	opt.v_highNo    = addrArr[i][8].toString();	//��������
				     	opt.v_zipcode   = addrArr[i][11];	//��������
				     	document.all.AddrSelect.options.add(opt);		//��ַ��Ϣ
				     
					}
					chgAddrSel();//��ַ�仯ʱ�����վ
	  			//crtAddr();//���ݵ�ַѡ������ɵ�ַ
	  				
			}
	}
	
			
}

			//��ַѡ��ʱ�任��վ
		function chgAddrSel()
		{
			//branchNo_selNumJudge=document.all.newbranchno.value.trim();
			//alert( "��ַ��ѯ"+document.all.AddrSelect.options[document.all.AddrSelect.selectedIndex].v_branchNo);
			//alert("��վ��ѯ"+document.all.newbranchno.value);
			document.all.newbranchno.value = document.all.AddrSelect.options[document.all.AddrSelect.selectedIndex].v_branchNo;//�任��վ
			document.all.newbranchno_name.value = document.all.AddrSelect.options[document.all.AddrSelect.selectedIndex].branch_name;//�任��վ����
			document.all.zip.value = document.all.AddrSelect.options[document.all.AddrSelect.selectedIndex].v_zipcode;//��������
			//alert(document.all.zip.value);
			document.all.AddrNum.value ="";//סլ��
			document.all.addrTransIn.value ="";//��ϸ��ַ
			controlSelNum ();                 //�ж�ѡ�Ű�Ŧ�Ƿ���� 
			//selectDisabled(document.all.newbranchno); //��ַ�任ʱ ��վ��Ȼ����ѡ��任
		}
		

		function crtAddr()
		{
	if (document.all.AddrSelect.length == 0||document.all.AddrNum.value=='') return false;
			var typeNum = document.all.AddrSelect.options[document.all.AddrSelect.selectedIndex].v_typeNum; //1����,0˫��,Q���
			var valNum = document.all.AddrNum.value.trim();//סլ��
			if (_isInteger(valNum))
			{ 
				var lowNo  = document.all.AddrSelect.options[document.all.AddrSelect.selectedIndex].v_lowNo;
				var highNo = document.all.AddrSelect.options[document.all.AddrSelect.selectedIndex].v_highNo;
				var intNum = parseInt(valNum); 
						if (intNum > parseInt(highNo) || intNum < parseInt(lowNo))
						{
								rdShowMessageDialog("���ƺ���������["+lowNo+"--"+highNo+"]֮��ĺ���,лл��",0);
								document.all.AddrNum.select();
								return false;
						}
						if (typeNum == "1")//����
						{
									if (intNum%2 == 0)
									{
										rdShowMessageDialog("���ƺ�����������������,лл��",0);
										document.all.AddrNum.select();
										return false;
									}
						}else if (typeNum == "0"){//˫��
									if (intNum%2 == 1)
									{
										rdShowMessageDialog("���ƺ���������ż������,лл��",0);
										document.all.AddrNum.select();
										return false;
									}			
						}
				}else
				{
					rdShowMessageDialog("���ƺ���ֻ����������,лл��",0);
					document.all.AddrNum.select();
					return false;
				}
				
			if (document.all.newAddress.value.trim() != "")
			{
				var temp = document.all.AddrSelect.options[document.all.AddrSelect.selectedIndex].text.toString();
				var addrStr = temp.substring(0,temp.indexOf("("));
				if (valNum != "")
				{
					addrStr += valNum+"��";	
				}
				//document.all.phone_addr.value = addrStr;
				//alert(document.all.phone_addr.value);
			}
}
	function _isInteger(valNum)
	{			//alert(valNum);
	      var re = /^[0-9]+[0-9]*]*$/;   //�ж������� /^[1-9]+[0-9]*]*$/   
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
          			<th> ��ַ��ƴ��</th>
          			<td>
									<input class="numOrLetter" type="text" id=newAddress name="newAddress"  value="" onkeyup="if(event.keyCode == 13)chooseNewAddress()">
								</td>  
            
              	  <th>��ַ��Ϣ��</th>
            	    <td>
										<select name="AddrSelect" onChange="chgAddrSel()"></select>
									</td>		
									
									<th>סլ�ţ�</th>
									<td>
										<input  type="text" id=AddrNum name="AddrNum" onblur="crtAddr()" value="">
									</td>	
									
														
							</tr>
							<tr>
								<th id="bb0011"><span class="red">*��վ��</span></th>
								<td>
									<!--
									<select class="required" name="newbranchno" onChange="controlSelNum()">
									</select>
									-->
									<input  type="text" class="required" name="newbranchno_name" id="newbranchno_name_0011" readonly />
									<input  type="hidden"  name="newbranchno"/>
									<input  type="button"  class="b_text"   value="ѡ��"   onclick="getBranch(new String('<%=objectId_0011%>'));"/>
				        </td>
				         	<th><span class="red">*�µ�ַ������</span></th>
									<td colspan=3>
										<input  type="text" class="required" id=addrTransIn name="addrTransIn"  value="" size="60">
									</td>
										<input type="hidden" name="sAddrStand" value=""/>
										<input type="hidden" name="zip"/>
										<input type="hidden" name="printAddr"/>
							</tr>
					 </table>
				</div>