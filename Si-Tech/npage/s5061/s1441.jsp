<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-1-13
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page contentType="text/html;charset=GBK"%>

<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ include file="/npage/bill/getMaxAccept.jsp"%>

<head>

<%
  String opCode = "1441";
  String opName = "重新签署协议登记";
%>

<%
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
  	String org_code = (String)session.getAttribute("orgCode");
  	/*gaopeng 2014/01/08 9:20:10 关于哈分公司申请优化模糊验证功能的请示 跳转过来的不进行密码校验*/
  	String pwrfNeed = WtcUtil.repNull(request.getParameter("pwrfNeed"));
  	  //add by wanglma 20110425 
  	  boolean pwrf=false;
  	  String[][] temfavStr = (String[][])session.getAttribute("favInfo");
  	  
      String[] favStr=new String[temfavStr.length];
      for(int i=0;i<favStr.length;i++){
        favStr[i]=temfavStr[i][0].trim();
        System.out.println("0000000000000000000favStr["+i+"]000000000000000000000000        "+favStr[i]);
      }
	  if(WtcUtil.haveStr(favStr,"a272")){
         pwrf=true;
      }
      /*gaopeng 2014/01/08 9:20:10 关于哈分公司申请优化模糊验证功能的请示 跳转过来的不进行密码校验*/
      if(pwrfNeed != null && !"".equals(pwrfNeed)){
      System.out.println("gaopengSeeLog++++==============pwrfNeed:"+pwrfNeed);
      	if("N".equals(pwrfNeed)){
      		pwrf=true;
      	}
     	}
      System.out.println("gaopengSeeLog++++==============pwrf:"+pwrf);
      
      
	  String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	  String printAccept = WtcUtil.repNull(request.getParameter("accept"));
		boolean printFlag = true;
		if ("".equals(printAccept)){
		%>				
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=org_code.substring(0,2)%>"  id="retListString1"/>					
		<%
				printFlag = false;
				printAccept = retListString1;//打印流水
		}

	System.out.println("printAccept==="+printAccept);
%>


	
</head>
<BODY>
<FORM action="s1441Cfm.jsp" method="post" name="frm" >

	<%@ include file="/npage/include/header.jsp" %> 
 <input type="hidden" name="opCode"    value="1441"> 
 
 <input type="hidden" name="cus_id"  value="">
 <input type="hidden" name="time"    value="<%=dateStr%>">
 <input type="hidden" name="qry_cond"  value="2">
 <% if(pwrf){%>  
	<input type="hidden" name="cus_pass"  value="">
 <%}%>
 <input type="hidden" name="smcode"    value="">
 <input type="hidden" name="printAccept"  value="<%=printAccept%>">
 <input type="hidden" name="ReqPageName" id="ReqPageName" value="s1210Login">
	<div class="title">
		<div id="title_zi">重新签署协议登记</div>
	</div>
             <table cellspacing="0" >
                <tr> 
                  <td class="blue">手机号码</td>
                  <td> 
                   <input type="text"  value =<%=activePhone%>  Class="InputGrey" readOnly   name="phone_no" >
				           <input type="button"  value=查询 onclick= "check()" class="b_text" >
                  </td>
                  
                <%
                if(!pwrf){%>  
				<td class="blue">密码</td><td>
				   	<input type="password" name="cus_pass" id="cus_pass" maxlength="6" />
				</td>
				<%}else{%>
				  <td>&nbsp;</td><td>&nbsp;</td>
				<%}%>
                </tr>
               

				<tr> 
                  <td class="blue">客户名称</td>
                  <td> 
                    <input type="text"  name="Contract_name" value="">
                  </td>
                  <td class="blue">客户品牌 </td>
                  <td> 
                    <input type="text"  name="sm_name" value="">
                  </td>
                </tr>

                <tr > 
                  <td class="blue">是否已签新协议</td>
                  <td> 
                   <select   name="protocal" onchange = "dochange()" >
                      <option value="1"  >是</option>
                      <option value="0"  >否</option>
                     </select>
					
                  </td>
				  				<td class="blue">签署日期</td>
                  <td> 
                    <input type="text"   readonly name="date" value="<%=dateStr%>" >
                  </td>
                </tr>
						<tr>
                  <td colspan="6"> 
				 <font class="orange">
                     说明：<br>
					&nbsp;&nbsp;&nbsp;&nbsp;信息核实界面的操作会修改客户资料信息，请谨慎操作。<br>
				  </font>
				   </td>
                </tr>
              
			  </table>
			  
             <table cellspacing=0>	
				<tr> 
                  <td> 
                  	<input type="hidden" name="iccid"  value="">
                  	<input type="hidden" name="custaddress"  value="">
                    <div align="center"> 
                      <input type="button" name="dofind" class="b_foot_long" value="信息核实" onClick="dofound()"   >
                      &nbsp;
					  <input type="button" name="makesure" class="b_foot_long" value="确认&打印" onClick="dosure()"   >
                      &nbsp;
                      <input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab()">
                    </div>
                  </td>
                </tr>
            </table> 

 <%@ include file="/npage/include/footer.jsp" %>
</FORM>

<SCRIPT >
  
  

  function doProcess(packet)
  {
  //alert();
	var cussid = packet.data.findValueByName("cussid");
	var custnumber = packet.data.findValueByName("custnumber");
	var idno = packet.data.findValueByName("idno");
	var custname = packet.data.findValueByName("custname");
	var smcode = packet.data.findValueByName("smcode");
	var smname = packet.data.findValueByName("smname");
	var iccid = packet.data.findValueByName("iccid");
	var custaddress = packet.data.findValueByName("custaddress");
	
	//alert(idno);
	//alert(custname);
	//alert(smcode);
	document.frm.cus_id.value = idno ;
	if(custname.substring(0,5)=="标准神州行")
	{
   rdShowMessageDialog("该客户为标准神州行用户，签约前请进行客户资料变更！");
	}

	       if(idno==""){
	       rdShowConfirmDialog("手机号码无效，不需要重新登记！");
	       document.frm.makesure.disabled=true;
		   return false;
		    window.close();
	       }else{
			  if(custnumber !=""){
			  	
				  document.frm.protocal.value="1";
				  // add by wanglma 20110422 start 将其置灰 防止能再选
				  document.frm.protocal.disabled = true;
				   // add by wanglma 20110422 end 
                  document.frm.Contract_name.value=custname;
				  document.frm.sm_name.value=smname;
				  document.frm.smcode.value=smcode;
	              document.frm.date.value=custnumber;
				  document.frm.makesure.disabled=true;
				  document.frm.iccid.value=iccid;
				  document.frm.custaddress.value=custaddress;
				  
		          return ;
				
		         }else{
		             document.frm.protocal.value="0";
	                 document.frm.Contract_name.value=custname;
					 document.frm.sm_name.value=smname;
					 document.frm.smcode.value=smcode;
					 document.frm.date.value=<%=dateStr%>;
					 document.frm.makesure.disabled=true;
					 document.frm.iccid.value=iccid;
				   document.frm.custaddress.value=custaddress;
		             return ;
		         }
		
	        }
  
   }


 function check()
  {
  if (document.frm.phone_no.value.length == 0) 
	  {
      rdShowMessageDialog("手机号码不能为空，请重新输入 !!");
      document.frm.phone_no.focus();
      return false;
      }
  
  if (document.frm.phone_no.value.length < 11) 
	  {
        rdShowMessageDialog("手机号码不能小于11位，请重新输入 !!");
        document.frm.phone_no.focus();
         return false;
       } 
  var myPacket = new AJAXPacket("qrycustmsg.jsp","正在查询客户信息，请稍候......");
	myPacket.data.add("Phoneno",document.all.phone_no.value);
	core.ajax.sendPacket(myPacket);
	myPacket = null;

 }
/* function change(){
  with(document.frm){
   if(protocal.value=="0"){
    window.close();
   }
  }
 }
 */
 function dofound(){
	if("<%=pwrf%>" == "false"){
		if($("#cus_pass").val() == ""){
			rdShowMessageDialog("密码不能为空!!");
			return;
		}
	}
	document.frm.action = "<%=request.getContextPath()%>/npage/s1210/s1210Main.jsp?vopcode=1441&pwrfNeed=<%=pwrfNeed%>";
    document.frm.submit();
    
 }
 function dochange(){
	if(document.frm.protocal.value=="1")
	 {
		document.frm.makesure.disabled=false;
	 }
 }
 
 function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框 
    
     var h=180;
     var w=350;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;
   
     var printStr = printInfo(printType);
   
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 

     var pType="subprint";                  // 打印类型print 打印 subprint 合并打印
     var billType="1";                      //  票价类型1电子免填单、2发票、3收据
     var sysAccept ='<%=printAccept%>';       // 流水号
     var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
     var mode_code=null;                        //资费代码
     var fav_code=null;                         //特服代码
     var area_code=null;                        //小区代码
     var opCode =   "<%=opCode%>";                         //操作代码
     var phoneNo = '<%=activePhone%>';                            //客户电话
     
	   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	       path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+document.frm.phone_no.value+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	   var ret=window.showModalDialog(path,printStr,prop);   
}

function printInfo(printType)
{		
	/*
	  var retInfo = "";
      retInfo+='<%=workno%>  <%=workname%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:MM:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      
	    retInfo+="手机号码"+document.frm.phone_no.value+"|";
      retInfo+="客户名称" +document.frm.Contract_name.value+"|";
      retInfo+="证件号码: "+document.frm.iccid.value+"|";
      retInfo+="客户地址: "+document.frm.custaddress.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";

      
      retInfo+="用户品牌"+document.frm.sm_name.value+"  "+"办理业务签约"+"|";
      retInfo+="操作流水"+"<%=printAccept%>"+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";  
      retInfo+=" "+"|";
      retInfo+=" "+"|";     
      retInfo+=" "+"|";
      retInfo+=" "+"|";
	    retInfo+=" "+"|";
	    
      retInfo+="主资费描述"+"|";
      retInfo+="　　暂不向“标准神州行”客户提供呼叫转移、GPRS业务，签约后可享受详单查询、帐单查询服务，"+"|";
      retInfo+="如客户进行资费变更后，可享受与普通客户同等的服务。"
	    retInfo+=" "+"|";
	    retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";

	  return retInfo;
	  */
	  
	    var retInfo    = "";
			var note_info1 = "";
			var note_info2 = "";
			var note_info3 = "";
			var note_info4 = "";
			var opr_info   = "";
			var cust_info  = "";
		
		
			cust_info+="手机号码："+document.frm.phone_no.value+"|";
			cust_info+="客户姓名：" +document.frm.Contract_name.value+"|";
			cust_info+="证件号码： "+document.frm.iccid.value+"|";
			cust_info+="客户地址： "+document.frm.custaddress.value+"|";
      
 
      opr_info+="用户品牌："+document.frm.sm_name.value+"  "+"办理业务签约"+"|";
      opr_info+="操作流水："+"<%=printAccept%>"+"|";

      note_info1+="主资费描述："+"|";
      note_info2+="　　暂不向“标准神州行”客户提供呼叫转移、GPRS业务，签约后可享受详单查询、帐单查询服务，"+"|";
      note_info3+="如客户进行资费变更后，可享受与普通客户同等的服务。|";
<%
			if (printFlag){
%>
					note_info3 += '您本次签约业务是通过模糊验证的方式进行办理，并未出具业务工单凭据，若日后由于其他客户|';
					note_info3 += '出具相关凭据而产生纠纷，我公司有权收回号码并重新处置，由此引起的法律责任由您自行承担。';
<%					
			}
%>
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式

    return retInfo;
    
}

 function dosure(){
 	getAfterPrompt();
  if (document.frm.Contract_name.value.length == 0) {
      rdShowMessageDialog("客户名称不能为空，请重新输入 !!");
      document.frm.Contract_name.focus();
      return false;
   } 

  if (document.frm.sm_name.value.length == 0) {
      rdShowMessageDialog("客户品牌不能为空，请重新输入 !!");
      document.frm.sm_name.focus();
      return false;
   } 
   
    var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
    if(typeof(ret)!="undefined")
     {
        if((ret=="confirm"))
        {
          if(rdShowConfirmDialog('确认电子免填单吗？如确认,将提交本次业务!')==1)
          {
	           document.frm.action="s1441Cfm.jsp"; 
             document.frm.submit();
          }
	      }
	      if(ret=="continueSub")
	      {
          if(rdShowConfirmDialog('确认要提交信息吗？')==1)
          {
	          document.frm.action="s1441Cfm.jsp"; 
            document.frm.submit();
          }
	      }
	    }
	    else
      {
        if(rdShowConfirmDialog('确认要提交信息吗？')==1)
        {
	          document.frm.action="s1441Cfm.jsp"; 
            document.frm.submit();
        }
      }	
  
 }
</SCRIPT>