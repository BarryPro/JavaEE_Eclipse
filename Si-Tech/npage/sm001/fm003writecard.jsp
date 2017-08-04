<%
  /*
   * 黑龙江移动省份商户系统
   * 移动商城开户写卡
   * 日期: 2013/11/29
   * 作者: zhouby
   */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  response.setHeader("Pragma", "No-cache");
  response.setHeader("Cache-Control", "no-cache");
  response.setDateHeader("Expires", 0);
%>
<%!
public String toRMB(double money) {
		char[] s1 = { '零', '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖' };
		char[] s4 = { '分', '角', '元', '拾', '佰', '仟', '万', '拾', '佰', '仟', '亿',
				'拾', '佰', '仟', '万' };
		String str = String.valueOf(Math.round(money * 100 + 0.00001));
		String result = "";

		for (int i = 0; i < str.length(); i++) {
			int n = str.charAt(str.length() - 1 - i) - '0';
			result = s1[n] + "" + s4[i] + result;
		}
		result = result.replaceAll("零仟", "零");
		result = result.replaceAll("零佰", "零");
		result = result.replaceAll("零拾", "零");
		result = result.replaceAll("零亿", "亿");
		result = result.replaceAll("零万", "万");
		result = result.replaceAll("零元", "元");
		result = result.replaceAll("零角", "零");
		result = result.replaceAll("零分", "零");

		result = result.replaceAll("零零", "零");
		result = result.replaceAll("零亿", "亿");
		result = result.replaceAll("零零", "零");
		result = result.replaceAll("零万", "万");
		result = result.replaceAll("零零", "零");
		result = result.replaceAll("零元", "元");
		result = result.replaceAll("亿万", "亿");

		result = result.replaceAll("零$", "");
		result = result.replaceAll("元$", "元整");
		result = result.replaceAll("角$", "角整");

		return result;
	}
%>

<%
	String opCode=request.getParameter("opCode");
  String opName=request.getParameter("opName");
  String loginNo = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
  String work_name =(String)session.getAttribute("workName");
  String workNo = (String)session.getAttribute("workNo");
    
   
  String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
  String phoneNO = WtcUtil.repNull((String)request.getParameter("phoneNO"));
	String kehuxingming = WtcUtil.repNull((String)request.getParameter("kehuxingming"));
	String zhengjianmingcheng = WtcUtil.repNull((String)request.getParameter("zhengjianmingcheng"));
	String zhengjianhaoma = WtcUtil.repNull((String)request.getParameter("zhengjianhaoma"));
	String simming = WtcUtil.repNull((String)request.getParameter("simming"));
	String dingdanzhuangtai = WtcUtil.repNull((String)request.getParameter("dingdanzhuangtai"));
	String yonghupinpai = WtcUtil.repNull((String)request.getParameter("yonghupinpai"));
	String haomaguishu = WtcUtil.repNull((String)request.getParameter("haomaguishu"));
	String kehudizhi = WtcUtil.repNull((String)request.getParameter("kehudizhi"));

	String simnono = WtcUtil.repNull((String)request.getParameter("simnono"));
	String simstypes = WtcUtil.repNull((String)request.getParameter("simtype"));
	String groupids = WtcUtil.repNull((String)request.getParameter("groupids"));
	String yonghubianma = WtcUtil.repNull((String)request.getParameter("yonghubianma"));
		
	String cccTime=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());
    String offerids = WtcUtil.repNull((String)request.getParameter("offerids"));
	String offernames = WtcUtil.repNull((String)request.getParameter("offernames"));
	String offfercomments = WtcUtil.repNull((String)request.getParameter("offfercomments"));
	String prePay = WtcUtil.repNull((String)request.getParameter("prePay"));

%>  
<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
			
			<wtc:service name="sG842Chk" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="2">
	    <wtc:param value="<%=loginAccept%>"/>
	    <wtc:param value="01"/>
	    <wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="<%=password%>"/>
	 		<wtc:param value="<%=phoneNO%>"/>
			<wtc:param value=""/>
			<wtc:param value="查询此号码是否已经写卡成功过"/>		
	</wtc:service>				
		<wtc:array id="dcust2s" scope="end" />	
<%	
String kongkakahao="";
String biaozhiwei="";/*0是写卡成功直接调用确认服务即可，1是未写卡成功，需要按照流程操作*/
if(retCode2.equals("000000")) {
		if(dcust2s.length>0) {
				biaozhiwei=dcust2s[0][0];
				kongkakahao=dcust2s[0][1];
		}
}
//biaozhiwei="0";
//kongkakahao="0806001650003224";
System.out.println("是否已经写卡成功"+biaozhiwei);
System.out.println("空卡卡号"+kongkakahao);
		
%>	
<HTML>
<HEAD>
    <TITLE>移动商城开户写卡</TITLE>
<script language="javascript">
 	function goBack(){
	  window.location.href="fm003Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}
</script>
</HEAD>
<body>
<form name="frme964" method="post" >
 	<input type="hidden" id="opCode" name="opCode"  value="<%=opCode%>" />
 	<input type="hidden" id="opName" name="opName"  value="<%=opName%>" />
	<%@ include file="/npage/include/header.jsp" %>
  <div class="title">
    <div id="title_zi">用户信息</div>
  </div>
	<table>
		<tr>
			<td class="blue" width="15%">客户姓名</td>
			<td width="15%">
				<%=kehuxingming%>
			</td>
		  <td class="blue" width="15%">服务号码</td>
			<td>
				<%=phoneNO%>
			</td>
					 <td class="blue" width="15%">用户品牌</td>
			<td>
				动感地带
			</td>
			<tr>
		  <td class="blue" width="15%">用户编码</td>
			<td>
				<%=yonghubianma%>
			</td>
				<td class="blue" width="15%">证件名称</td>
			<td>
				<%=zhengjianmingcheng%>
			</td>
	
		  <td class="blue" width="15%">证件号码</td>
			<td>
				<%=zhengjianhaoma%>
			</td>

		</tr>
		<tr>
			<td class="blue" width="15%">sim卡名</td>
			<td>
				<%=simming%>
			</td>
			<td class="blue" width="15%">号码归属</td>
			<td>
				<%=haomaguishu%>
			</td>
		   <td class="blue" width="15%">订单状态</td>
			<td>
			<%
				String orderStatus = dingdanzhuangtai;
				if(orderStatus.equals("00")) {
					out.print("未出库或未写卡");
				}else if(orderStatus.equals("01")) {
					out.print("已出库或已写卡未邮寄");
				}else if(orderStatus.equals("02")) {
					out.print("已邮寄未反馈结果");
				}else if(orderStatus.equals("03")) {
					out.print("配送成功");
				}else if(orderStatus.equals("04")) {
					out.print("配送失败");
				}else if(orderStatus.equals("05")) {
					out.print("用户拒收");
				}else if(orderStatus.equals("06")) {
					out.print("外呼预占");
				}else if(orderStatus.equals("07")) {
					out.print("物流单下单预占");
				}else if(orderStatus.equals("08")) {
					out.print("移动商城开户外呼预占");
				} else if(orderStatus.equals("09")) {
					out.print("外呼成功待写卡");
				} else if(orderStatus.equals("10")) {
					out.print("移动商城外呼失败");
				} else if(orderStatus.equals("11")) {
					out.print("移动商城写卡预占");
				} 
			%>
			</td>


		</tr>
		<tr>
			<td class="blue" width="15%">客户地址</td>
			<td colspan="6">
				<%=kehudizhi%>
			</td>
		</tr>
		<tr>
      <td colspan="6">
        <hr>
      </td>
    </tr>
    <tr>
			<td class="blue" width="15%">sim卡号</td>
			<td colspan="6">
			  <div align="left">
			    <%=simnono%>
          <font color="red">*</font>
           <input class="b_text" type="button" name="ducard" value="读卡" onClick="readcardss()"  index="19"  <%if(biaozhiwei.equals("0")){%> disabled<%}%>/>
           <input class="b_text" type="button" name="b_write" value="写卡" onmouseup="writechg(this)" onkeyup="if(event.keyCode==13)writechg()"  index="19" disabled/>
          <input type="hidden" name="flg_normal" id="flg_normal" value="0">
        </div>
			</td>
		</tr>
		<tr > 
			  <td colspan="6" align="center" id="footer">
			<input class="b_foot" name="gengxins" onClick="gengxinsj()" type="button" value="更新SIM信息" disabled/>
			&nbsp; 
			<input class="b_foot" name="resultcommit" onClick="addresult()" type="button" value="确定&打印"   <%if(!biaozhiwei.equals("1")){%> disabled<%}%>/>
			&nbsp; 
			<input class="b_foot" name="back" onClick="goBack()" type="button" value="返回" />
			&nbsp; 
			<input name="back" onClick="removeCurrentTab();" type="button" class="b_foot" value="关闭" />
			&nbsp;
			</td>
		</tr>
	</table>
</div>

<input type="text" name="cardNo" id="cardNo" value=""  />


  <%@ include file="/npage/include/footer.jsp" %>
</form>
<script language="javascript">
	
	function test() {
		//liujian ceshi 
    	//billdeal('13503632819','<%=kehuxingming%>','123456123413');	
    	
    	var ret =showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
		if(typeof(ret)!="undefined"){
			if((ret=="confirm")){
				if(rdShowConfirmDialog('确认电子免填单吗？如确认,将提交本次业务!')==1){
				 // frmCfm();
				}
			}
			if(ret=="continueSub"){
				if(rdShowConfirmDialog('确认要提交信息吗？')==1){
				//  frmCfm();
				}
			}
		}else{
			if(rdShowConfirmDialog('确认要提交信息吗？')==1){
			// frmCfm();
			}
		}
			
	}
	
	var simtypess="";
	var simNumber="";
	function readcardss() {
	
		//document.all.b_write.disabled=false;
  		 var phone = '<%=phoneNO%>';
  		 simtypess="";
  		 /****新增调大唐功能取SIM卡类型****/
  		 /* 
        * diling update for 修改营业系统访问远程写卡系统的访问地址，由现在的10.110.0.125地址修改成10.110.0.100！@2012/6/4
        */
  		 path ="http://10.110.0.100:33000/writecard/writecard/ReadCardInfo.jsp";
  		 var retInfo1 = window.showModalDialog("<%=request.getContextPath()%>/npage/sg529/Trans.html",path,"","dialogWidth:10;dialogHeight:10;"); 
		 if(typeof(retInfo1) == "undefined")     
    	 {	
    		 rdShowMessageDialog("读卡类型出错!");

    		return false;   
    	 }
    	var chPos;
    	chPosn = retInfo1.indexOf("&");
    	if(chPosn < 0)
    	{	
    		rdShowMessageDialog("读卡类型出错!");
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

    		 	return false;   
    		}
  		}
  		else{
  			 rdShowMessageDialog("读卡类型出错!");

    		 return false;   
    	}
    	simtypess=rescode_strstr.substr(1,rescode_strstr.length-2);
    	simNumber=retVal[1];
    	 document.all.b_write.disabled=false;
    	 
    	 
    }
	var retsimno="";
  function writechg(obj){

	var phonenos="";
	var simnos="";
	var simtypes="";
	var groupids="";
	var phonesnames="";
	var smssarry= new Array();
	<%-- alert('<%=regionCode%>'+"-"+'<%=simstypes%>'+"-"+'<%=simnono%>'+"-"+'<%=opCode%>'+"-"+'<%=phoneNO%>'); --%>


    var path = "<%=request.getContextPath()%>/npage/sg529/fg529_fwritecard.jsp";
    path = path + "?regioncode=" + "<%=regionCode%>";
    path = path + "&sim_type=" +simtypess;
    path = path + "&sim_no=" +"<%=simnono%>";
    path = path + "&op_code=" +"<%=opCode%>";
    path = path + "&phone="+"<%=phoneNO%>"+"&pageTitle=" + "写卡";
    path = path + "&deleteShowCardNoFlag=" +"isDelCardNo"; 
    var retInfo = window.showModalDialog(path,"","dialogWidth:40;dialogHeight:20;");
    
    if(typeof(retInfo) == "undefined"){	
    	rdShowMessageDialog("写卡失败",0);
    	document.frme964.gengxins.disabled=false;
    	return false;   
    } 
    var retsimcode=oneTok(oneTok(retInfo,"|",1));//89860034085945097137
    retsimno=oneTok(oneTok(retInfo,"|",2));
    var cardstatus=oneTok(oneTok(retInfo,"|",3));
    var cardNo=oneTok(oneTok(retInfo,"|",4));
    $("#cardNo").val(cardNo);
   
   

    
    
    if(retsimcode=="0"){
		rdShowMessageDialog("写卡成功");
		document.frme964.resultcommit.disabled=false;
		
    }else{
      rdShowMessageDialog("写卡失败,0");
      document.frme964.gengxins.disabled=false;
    }
  }

	function doSetStsDate(packet){
		var retcode = packet.data.findValueByName("retcode");
		var retmsg = packet.data.findValueByName("retmsg");
		if(retcode=="000000"){
			var ret =showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
			if(typeof(ret)!="undefined"){
				if((ret=="confirm")){
					if(rdShowConfirmDialog('确认电子免填单吗？如确认,将提交本次业务!')==1){
					 // frmCfm();
					}
				}
				if(ret=="continueSub"){
					if(rdShowConfirmDialog('确认要提交信息吗？')==1){
					//  frmCfm();
					}
				}
			}else{
				if(rdShowConfirmDialog('确认要提交信息吗？')==1){
				// frmCfm();
				}
			}
    
			rdShowMessageDialog("受理成功，开始打印发票！");
			var liushui1 = packet.data.findValueByName("liushui");
			var phonesno = packet.data.findValueByName("phonesno");
			billdeal(phonesno,'<%=kehuxingming%>',liushui1);
		}else {
			rdShowMessageDialog("受理失败！错误代码"+retcode+"，错误原因："+retmsg,0);
		}
	}
	
	function addresult() {
			var cadnos = $("#cardNo").val();
			var myPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/sg529/fg530writecardsub.jsp","正在入库写卡信息请稍候......");
			
			<%
			if(biaozhiwei.equals("0")){
			%> 
			myPacket.data.add("cardNo","<%=kongkakahao%>");
			<%
		  }else {
		  %> 
			myPacket.data.add("cardNo",cadnos);
		  <%			
			}
			%>

		myPacket.data.add("simtypes",'<%=simstypes%>');
		myPacket.data.add("simnos",retsimno);
		myPacket.data.add("phonenos",'<%=phoneNO%>');
		myPacket.data.add("opcode",'<%=opCode%>');
		myPacket.data.add("groupids",'<%=groupids%>');
		myPacket.data.add("phonesnames",'<%=kehuxingming%>');
		core.ajax.sendPacket(myPacket,doSetStsDate);
		myPacket = null;
		
	}
	
	function gengxinsj() {
		var myPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/sg603/fg603Update.jsp","正在更新sim信息请稍后......");
		myPacket.data.add("phonenos",'<%=phoneNO%>');
		myPacket.data.add("opcode",'<%=opCode%>');
		core.ajax.sendPacket(myPacket,doreturnmsgs);
		myPacket = null;
	}
	
	function doreturnmsgs(packet){
		var retcode = packet.data.findValueByName("retcode");
		var retmsg = packet.data.findValueByName("retmsg");
		if(retcode=="000000"){
			rdShowMessageDialog("数据更新成功，请重新操作！",2);
			goBack();
		}else {
			rdShowMessageDialog("数据更新失败！错误代码"+retcode+"，错误原因："+retmsg,0);
		}
	}						  	
		
	function billdeal(phoneno,phonenames,liushui){

	  	var infoStr="";	
		infoStr+="<%=workNo%>  <%=work_name%>"+"       写卡"+"|";//工号
		infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		infoStr+=phonenames+"|";
		infoStr+=" "+"|";
		infoStr+=phoneno+"|";
		infoStr+=" "+"|";//协议号码
		infoStr+=" "+"|";
		
		infoStr+="<%=toRMB(Double.parseDouble(prePay))%>"+"|";//合计金额(大写)
		infoStr+="<%=prePay%>"+"|";//小写
		infoStr+="SIM卡费：0元~入网预存费：<%=prePay%>元"+"|";
		
		infoStr+="<%=work_name%>"+"|";//开票人
		infoStr+=" "+"|";//收款人
		infoStr+=" "+"|";//收款人
		
		infoStr+=" "+"|";
		/*
		dirtPate = "/npage/sm001/fm003Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=<%=opCode%>&loginAccept="+liushui+"&dirtPage="+codeChg(dirtPate);
		*/
		var  billArgsObj = new Object();
		$(billArgsObj).attr("10001","<%=workNo%>");
		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
	 	$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
	 	$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
		$(billArgsObj).attr("10005",phonenames);
		$(billArgsObj).attr("10006","移动商城开户写卡");
		$(billArgsObj).attr("10008",phoneno);
		$(billArgsObj).attr("10015","<%=prePay%>");//小写
		$(billArgsObj).attr("10016","<%=prePay%>");//合计金额(大写) 传小写，公共页转换
		$(billArgsObj).attr("10017","*");//本次缴费：现金
		$(billArgsObj).attr("10020","");//入网费
		$(billArgsObj).attr("10021","");//手续费
		$(billArgsObj).attr("10022","");//选号费
		$(billArgsObj).attr("10023","");//押金
		$(billArgsObj).attr("10024","0");//SIM卡费
		$(billArgsObj).attr("10025","<%=prePay%>");//预存金额
		$(billArgsObj).attr("10026","");//机器费
		$(billArgsObj).attr("10027","");//其他费
		$(billArgsObj).attr("10028","");//参与的营销活动名称
		$(billArgsObj).attr("10047","");//活动代码
		$(billArgsObj).attr("10030",liushui);//业务流水
		$(billArgsObj).attr("10036","<%=opCode%>");
		$(billArgsObj).attr("10031","<%=work_name%>");//开票人
		
		var printInfo = "";
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
		
		//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=确实要进行发票打印吗？";
		
					//发票项目修改为新路径
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=确实要进行发票打印吗？";
	
	
		
		var path = path + "&infoStr="+printInfo+"&loginAccept="+liushui+"&opCode=<%=opCode%>&submitCfm=submitCfm";
		var ret = window.showModalDialog(path,billArgsObj,prop); 
		location = "/npage/sm001/fm003Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}
  
  function showPrtDlg(printType,DlgMessage,submitCfm)
  {  
  		var pType="subprint";                     // 打印类型print 打印 subprint 合并打印
     	var billType="1";                      //  票价类型1电子免填单、2发票、3收据
		var sysAccept ="<%=loginAccept%>";                       // 流水号
		var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
		var mode_code=null;                        //资费代码
		var fav_code=null;                         //特服代码
		var area_code=null;                    //小区代码
		var opCode =   "<%=opCode%>";                         //操作代码
		var phoneNo = "<%=phoneNO%>";                         //客户电话		  
  
	  	//显示打印对话框
	    	var h=200;
	    	var w=410;
	     	var t=screen.availHeight/2-h/2;
	     	var l=screen.availWidth/2-w/2;
	     	
	     	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 	   
	   	var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);     	
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
    
    cust_info+="客户姓名：<%=kehuxingming%>	"+"|";
    cust_info+="手机号码：<%=phoneNO%>	"+"|";
    cust_info+="证件号码：<%=zhengjianhaoma%>"+"|";
    cust_info+="客户地址：<%=kehudizhi%>"+"|";
    
			opr_info+="业务受理时间：<%=cccTime%>   "  +"用户品牌:"+"动感地带"+"|";
			opr_info+="办理业务：写卡"+"  "+"操作流水：<%=loginAccept%>"+"|";
			
    opr_info+="SIM卡号："+retsimno+""+"  SIM卡费：0元"+"|";
    opr_info+="预存款："+"<%=prePay%>元"+"|";
    opr_info+="主资费："+"<%=offerids%>-<%=offernames%>"+"|";
    
    note_info1+="主资费描述："+"<%=offfercomments%>"+"|";
    note_info1+="备注：操作员"+"<%=workNo%>"+""+"对客户"+"<%=phoneNO%>"+"进行移动商城开户写卡操作!"+"|";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
		
} 
</script>
</BODY>
</HTML>







