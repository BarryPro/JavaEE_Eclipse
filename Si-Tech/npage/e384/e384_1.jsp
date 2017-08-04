<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 赠送预存款 8379
   * 版本: 1.0
   * 日期: 2010/3/12
   * 作者: sunaj
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
	request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>赠送预存款</title>
<%
    //String opCode="8379";
	//String opName="赠送预存款";

    String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");	
	String phoneNo = (String)request.getParameter("activePhone");
    String workNo=(String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String regionCode=(String)session.getAttribute("regCode");
    String[][] favInfo=(String[][])session.getAttribute("favInfo");
	boolean workNoFlag=false;
	if(workNo.substring(0,1).equals("k"))
		workNoFlag=true;
%>
<%
  /****得到打印流水****/
  String printAccept="";
  printAccept = getMaxAccept();

  //xl add for 查询wchargecardmsgnew
  String card_sql = "select card_no from wchargecardmsg where phone_no1='?' and op_code='e384'  ";
  //end
%>
<wtc:pubselect name="TlsPubSelBoss" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
		<wtc:sql><%=card_sql%></wtc:sql>
		<wtc:param value="<%=phoneNo%>"/>	
	</wtc:pubselect>
	<wtc:array id="result2" scope="end" />
<%
	String errCode2 = retCode2;
	String errMsg2 = retMsg2;
	String[] cardNo =new String[]{""};
	
	//xl add for sunaj e384下拉框 活动代码
	String[] inParas2 = new String[2]; 
	inParas2[0]="select b.award_detail_code||'-->'||b.award_detail_name,b.award_code||','||b.award_detail_code from dbgiftrun.schnresactivecode a,sawarddetail b where b.region_code=:s_region and a.child_code in ('026664','029319','029448','028738') and a.child_code = b.award_code||b.award_detail_code and a.valid_flag=1 ";
	//测试inParas2[0]="select b.award_detail_code||'-->'||b.award_detail_name,b.award_code||','||b.award_detail_code from dbgiftrun.schnresactivecode a,sawarddetail b where b.region_code=:s_region and a.child_code in ('026664','029319','029448','028738','027128') and a.child_code = b.award_code||b.award_detail_code and a.valid_flag=1 ";
	inParas2[1]="s_region="+regionCode;
%>		
<!--定义-->
<script language="javascript">
	var card_code = new Array();
	var  str; 
<%
	System.out.println("qweqwe1888888888888888888888888888881111111111111");
	if(result2.length >0){
		for(int m=0;m<result2.length;m++)
		  {
			out.println("card_code["+m+"]='"+result2[m][0]+"';\n");
			 
		  }
	}
	else{
	System.out.println("qweqwe9888800000000000000000111");
	}

	
%>
	
	//alert("str is "+str.split(","));
</script>

<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="SpecCode" retmsg="SpecMsg" outnum="2">
<wtc:param value="<%=inParas2[0]%>"/>
<wtc:param value="<%=inParas2[1]%>"/>
</wtc:service>
<wtc:array id="SpecResult"  scope="end" />

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

</head>  
<body onload="init1()">
<form action="" name="frm" method="POST">
 	<input type="hidden" name="opcode" value = "e384" >
	<input type="hidden" name="opname" value = "赠送充值卡充值" >
	<%@ include file="/npage/include/header.jsp" %>

<div id="Operation_Table0"> 
<div class="title">
	<div id="title_zi">赠送充值卡手工充值</div>
</div>	 
	<table cellspacing="0">
	   
		<tr> 
			<td class="blue">手机号码 </td>
			<td> 
				<input type="text" size="12" name="srv_no" value="<%=activePhone%>" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0" class="InputGrey" readOnly>
				&nbsp;&nbsp;&nbsp;&nbsp;	 
		 
				
			 
				 
			</td>
		</tr>
		<tr> 
			<td class="blue">活动代码 </td>
			<td> 
				<select name="pay_note" id="selOp" width=3100px>
					<option value="0" selected>---请选择</option>
					<%for(int i=0; i<SpecResult.length; i++){%>
					<option value="<%=SpecResult[i][1]%>">
					
					<%=SpecResult[i][0]%></option>
					<%}%>

				</select>	 
		 
				
			 
				<input type=button class="b_foot" name="check2" value="查询" onclick="check1()" >
			</td>
		</tr>
		
		
	</table>
</div>
 
<!-- xl add 针对非转增客户-->
<input type="hidden" name="beginNo"><!--为了算卡号-->
<input type="hidden" name="oGroupSize">
<div id="Operation_Table2"> 
<div class="title">
	<div id="title_zi">手工充值</div>
</div>
 
</div>
<!--  xl add end 针对非转增客户--> 
 
</table>
<input type = "hidden" name="custName">
 
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
<script language="javascript">
	
	function init1()
	{
		document.getElementById("Operation_Table2").style.display="none";
		//check1();
		
		 
	}
	function check1()
	{
		var objSel = document.getElementById("selOp");
		var detail_id = objSel.value;
		//alert(detail_id);
		if(detail_id==0)
		{
			rdShowMessageDialog("请选择活动代码！");
			return false;
		}
		else
		{
			var myPacket = new AJAXPacket("e384_check.jsp","正在提交，请稍候......");
			myPacket.data.add("phoneNo",document.frm.srv_no.value);
			var cpid = document.all.pay_note[document.all.pay_note.selectedIndex].value;
			//alert(cpid);
			myPacket.data.add("cpid",cpid);
			myPacket.data.add("detail_id",detail_id);
			core.ajax.sendPacket(myPacket);
			myPacket=null;
		}
		
	}
	
	function doProcess(packet)
	{
		var flagConfirm =  packet.data.findValueByName("flag1");
		var iNumLen = packet.data.findValueByName("iNumLen");//有2组数据
		//alert("flagConfirm is "+flagConfirm);
		//flagConfirm=0;
		if(flagConfirm==1 )
		{
			var errCode2 =  packet.data.findValueByName("errCode");
			var errMsg2 =  packet.data.findValueByName("errMsg");
			rdShowMessageDialog("操作失败！错误代码："+errCode2+",失败原因："+errMsg2);
			return false;
		}
		
		if(flagConfirm==0)
		{
			document.getElementById("Operation_Table2").style.display="block";
			document.all.check2.disabled=true;
			<%
					String rownumNew = request.getParameter("rownumNew");
					int j =0;
					
			%>
			//多个值的情况下 单选选择~~试一下
			//iNumLen=1;
			 
			for(k=0;k<iNumLen;k++)
			{
				
				 
				var oStoreNo  = packet.data.findValueByName("oStoreNo"+k);
				document.all.beginNo.value=oStoreNo;
				var oEndStoreNo  = packet.data.findValueByName("oEndStoreNo"+k); //号码段
				var oTranMianzhi  = packet.data.findValueByName("oTranMianzhi"+k);
				var icardNum = packet.data.findValueByName("icardNum"+k);
				 
			//	alert("第 "+k+" 组的记录，oStoreNo is "+oStoreNo+"结束卡号是 "+oEndStoreNo+" and 有卡片 "+icardNum+"张");
				//var rowNum = parseInt(oEndStoreNo-oStoreNo);
				var cardNoNew = "";
				var str1 = card_code.join();
			//alert("11 oStoreNo is "+oStoreNo+" and oEndStoreNo is "+oEndStoreNo);
			     
				for(i=0;i<icardNum;i++)
				{
					var newNo = oStoreNo.substr(oStoreNo.length-16);//尾部
					var cardNoPre = parseInt(newNo)+i;
					var cardNo = oStoreNo.replace(oStoreNo.substr(oStoreNo.length-16),cardNoPre) ;//字符串替换
					
					//var cardNo = oStoreNo+i;
				//	alert("第 "+k+"组 ,第 "+i+"个 ");
					//alert("第 "+i+" 个卡号 cardNoPre "+cardNoPre+" and cardNo is "+cardNo+" and oStoreNo is "+oStoreNo);
					var test = str1.match(cardNo);
					if(test!=null)
					{
						//alert("2 ");
						document.getElementById("Operation_Table2").innerHTML += '<table cellspacing="0" id="table1"><tr><td>卡号：<input type="text" name="cardNo"  value="'+cardNo+'" readOnly></td><td>卡面值：<input type="text" name="mz" value="'+oTranMianzhi+'" readOnly></td><td><input type="button" " value="已充值" class="b_foot"    disabled></td></tr></table>';
						 
						 
					}	
					else 
					{
						//alert("3 ");
						document.getElementById("Operation_Table2").innerHTML += '<table cellspacing="0" id="table1"><tr><td>卡号：<input type="text" name="cardNo"  value="'+cardNo+'" readOnly></td><td>卡面值：<input type="text" name="mz" value="'+oTranMianzhi+'" readOnly></td><td><input type="button" id="cfms'+i+'" readOnly value="充值" class="b_foot" name="cfm"  onClick=docfm("'+cardNo+'","'+oTranMianzhi+'")></td></tr></table>';
						
						
					}
					
				} //end of 内层循环
			} //end of 外层循环

		}
		
		
		

	}
	function docfm(rowId,mz)
	{
		/*var h=480;
		var w=650;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;

		var prop = "dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
		var phoneNo = document.all.srv_no.value;
		var cardNo = document.all.beginNo.value;
		var returnValue = window.showModalDialog('e384_2.jsp?rowId='+rowId+"&phoneNo="+phoneNo+"&cardNo="+cardNo,"",prop);
		*/
		var phoneNo = document.all.srv_no.value;
		var cardNo = document.all.beginNo.value;
		var rowIds = rowId;
		//alert("Id is "+rowIds+" and tes is "+rowId);
		var cardNoNew = parseFloat(cardNo)+rowId;
		var kmz = mz;
		//alert("mz is "+kmz);
		var actions = "e384_2.jsp?rowId="+rowId+"&phoneNo="+phoneNo+"&cardNoNew="+rowIds+"&kmz="+kmz;
		document.all.frm.action=actions;
		document.all.frm.submit();
		
	}
	
 

</script>
 
 