 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-16 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%		
	  String opCode = "8072";	
	  String opName = "大兴安岭签约赠礼";	//header.jsp需要的参数  
	  
	  String regionCode = (String)session.getAttribute("regCode");
	  String loginNo =(String)session.getAttribute("workNo");  
	  String loginName = (String)session.getAttribute("workName");
	  String child_code = "010194";
 
  
%>
<%
	String retFlag="",retMsg=""; 
  	String[] paraAray1 = new String[4];
  	String phoneNo = request.getParameter("srv_no");
  	String opcode = request.getParameter("opcode");
  	String passwordFromSer="";
  	String back_accept = "";
  	String op_name = "";
  	String disable_type = "";
	if(opcode.equals("8072")){
		  back_accept = "0";
		  op_name = "申请";
		  disable_type ="";
	}else{
		  back_accept = request.getParameter("backaccept");
		  op_name = "冲正";
		  disable_type ="disabled";		
	}
	  
	  paraAray1[0] = phoneNo;		/* 手机号码   */ 
	  paraAray1[1] = opcode; 	    /* 操作代码   */
	  paraAray1[2] = loginNo;	    /* 操作工号   */
	  paraAray1[3] = back_accept;	    /* 操作流水   */

	  for(int i=0; i<paraAray1.length; i++)
	  {		
		if( paraAray1[i] == null )
		{
		  paraAray1[i] = "";
		  
		}
	  }
	
  	//retList = impl.callFXService("s8072Init", paraAray1, "18","phone",phoneNo);
  %>
  	<wtc:service name="s8072Init" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="18" >
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>
		<wtc:param value="<%=paraAray1[3]%>"/>		
	</wtc:service>	
	<wtc:array id="tempArr"  scope="end"/>	
  <%
  	String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",posint="",prepay_fee="",
  	vContactPhone="",vContactPost="",vResCode="",vResName="", vPrepayFee="",vLogicCode="";
  	//String[][] tempArr= new String[][]{};
  	String  errCode = retCode1;
  	String errMsg = retMsg1;
  if(tempArr == null)
  {
	if(!retFlag.equals("1"))
	{
	   System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s8072Init查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }
  else
  {
  	System.out.println("errCode="+errCode);
  	System.out.println("errMsg="+errMsg);
	if(!errCode.equals("000000")){%>
		<script language="JavaScript">
			rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>",0);
			history.go(-1);
		</script>
	<%}
	else
	{
	  //tempArr = (String[][])retList.get(2);
	  if(tempArr.length>0){
		    bp_name = tempArr[0][2];//机主姓名
		    System.out.println(bp_name);			
		    bp_add = tempArr[0][3];//客户地址		
		    cardId_type = tempArr[0][4];//证件类型		
		    cardId_no = tempArr[0][5];//证件号码		
		    sm_code = tempArr[0][6];//业务品牌		
		    region_name = tempArr[0][7];//归属地		
		    run_name = tempArr[0][8];//当前状态		
		    posint = tempArr[0][9];//当前积分		
		    prepay_fee = tempArr[0][10];//可用预存		
		    vContactPhone = tempArr[0][11];//联系电话	
		    vContactPost = tempArr[0][12];//个人邮编		
		    vResCode = tempArr[0][13];//res_code
			System.out.println(vResCode);		
		    vResName = tempArr[0][0];//res_name
			System.out.println(vResName);	 		 
		    vPrepayFee = tempArr[0][15];//消费的预存
		    System.out.println(vPrepayFee);	 		 
		    vLogicCode = tempArr[0][16];//等级代码
		    System.out.println(vLogicCode);	 		 
		    passwordFromSer = tempArr[0][17];  //密码
	 }
	}
  }

%>
	<%
	//******************得到下拉框数据***************************//
	String printAccept="";
	printAccept = getMaxAccept();
	System.out.println(printAccept);		  
       //手机品牌
	 
	%>

<html>
<head>
<title>大兴安岭签约赠礼</title>
<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
<script language="JavaScript" src="/npage/s1400/pub.js"></script>
	<%if(retFlag.equals("1")){%>
		<script language=javascript>
	    		rdShowMessageDialog("<%=retMsg%>");
	   	 	history.go(-1);
	   	</script>
	  <%}%>
	 <script language=javascript>
		<!-- 
		  onload=function()
		  {	
			 init();  	 
		  }  
				
		  //定义应用全局的变量
		  var SUCC_CODE	= "0";   		//自己应用程序定义
		  var ERROR_CODE  = "1";			//自己应用程序定义
		  var YE_SUCC_CODE = "0000";		//根据营业系统定义而修改
		
		  var oprType_Add = "a";
		  var oprType_Upd = "u";
		  var oprType_Del = "d";
		  var oprType_Qry = "q";
		
		  var arrPhoneType = new Array();//手机型号代码
		  var arrPhoneName = new Array();//手机型号名称
		  var arrAgentCode = new Array();//代理商代码
		  var selectStatus = 0;
		  
		  var arrsalecode =new Array();
		  var arrsaleName=new Array();
		  var arrsalePrice=new Array();
		  var arrsaleLimit=new Array();
		  var arrsaletype=new Array();
		
		  //***
		  function frmCfm()
		  {
		 	frm.submit();
			return true;
		  }
		 //***
		
		function init()
		{
			if("<%=opcode%>"=="8073")
			{
				document.frm.logic_code.value="<%=vLogicCode%>";
				document.frm.res_code.value="<%=vResCode%>";
				document.frm.out_prepay_fee.value="<%=vPrepayFee%>";
		
			}
		}
		 
		 function printCommit()
		 { 
		 	getAfterPrompt();
		  //校验
		  //if(!check(frm)) return false;
		    with(document.frm){
		    if("<%=opcode%>"=="8072"){
				if(logic_code.value==""){
					rdShowMessageDialog("请选择中奖等级!");
					logic_code.focus();
					confirm.disabled=true;
					return false;
				}
				if(res_code.value==""){
					rdShowMessageDialog("请选择奖品名称!");
					res_code.focus();
					confirm.disabled=true;
					return false;
				}
			
				if(parseFloat(prepay_fee.value)<parseFloat(out_prepay_fee.value)){
					rdShowMessageDialog("预存款小于消费金额，不允许办理此业务!");
					confirm.disabled=true;
					return false;
				}
			}
		  }
		 //打印工单并提交表单
		  var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
		  if(typeof(ret)!="undefined")
		  {
		    if((ret=="confirm"))
		    {
		      if(rdShowConfirmDialog('确认电子免填单吗？')==1)
		      {
			    frmCfm();
		      }
			}
			if(ret=="continueSub")
			{
		      if(rdShowConfirmDialog('确认要提交信息吗？')==1)
		      {
			    frmCfm();
		      }
			}
		  }
		  else
		  {
		     if(rdShowConfirmDialog('确认要提交信息吗？')==1)
		     {
			   frmCfm();
		     }
		  }
		  return true;
		}
		
	       function showPrtDlg(printType,DlgMessage,submitCfm)
		  {  	//显示打印对话框 
		  	
		  	var pType="subprint";                     // 打印类型print 打印 subprint 合并打印
	     	var billType="1";                      //  票价类型1电子免填单、2发票、3收据
			var sysAccept ="<%=printAccept%>";                       // 流水号
			var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
			var mode_code=null;                        //资费代码
			var fav_code=null;                         //特服代码
			var area_code=null;                    //小区代码
			var opCode =   "<%=opCode%>";                         //操作代码
			var phoneNo = <%=phoneNo%>;                           //客户电话		  
	  
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;

		     
		    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 	   
		   	var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
			var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
			var ret=window.showModalDialog(path,printStr,prop);     	
		  }
		
		function printInfo(printType)
		{
		 	vUnitId="",vUnitName="",vUnitAddr="",vUnitZip="",vServiceNo="",vServiceName="",vContactPhone="",vContactPost="";
			var pay = document.all.out_prepay_fee.value;
			
		  
			/*var retInfo = "";
			retInfo+='<%=loginNo%>'+' '+'<%=loginName%>'+"|";
			retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			retInfo+="移动电话号码："+document.all.phone_no.value+"|";
			retInfo+="客户名称："+document.all.cust_name.value+"|";
			retInfo+="联系电话:"+'<%=vContactPhone%>'+"|";
			retInfo+="住宅地址："+document.all.cust_addr.value+"|";	
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+="业务种类：大兴安岭包年签约赠礼--<%=op_name%>"+"|";
		  	retInfo+="业务流水："+document.all.login_accept.value+"|";
		  	retInfo+="中奖等级: "+document.all.logic_code[document.all.logic_code.selectedIndex].text+"|";
			retInfo+="奖品名称："+document.all.res_code[document.all.res_code.selectedIndex].text+"|";
		 	retInfo+="预存话费"+parseInt(document.all.out_prepay_fee.value)+"元"+"|";
			retInfo+="业务执行时间:"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd ", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
		    	return retInfo;	*/
		    	
	    	var cust_info=""; //客户信息
      	    var opr_info=""; //操作信息
      		var retInfo = "";  //打印内容
      		var note_info1=""; //备注1
      		var note_info2=""; //备注2
      		var note_info3=""; //备注3
      		var note_info4=""; //备注4 
      		
      		cust_info+="客户姓名："+document.all.cust_name.value+"|";
  			cust_info+="手机号码："+document.all.phone_no.value+"|";
  			cust_info+="客户地址："+document.all.cust_addr.value+"|";
  				
  			opr_info+="联系人电话："+'<%=vContactPhone%>'+"|";
      		opr_info+="业务种类：大兴安岭包年签约赠礼--<%=op_name%>"+"|";
		  	opr_info+="业务流水："+document.all.login_accept.value+"|";
		  	opr_info+="中奖等级："+document.all.logic_code[document.all.logic_code.selectedIndex].text+"|";
			opr_info+="奖品名称："+document.all.res_code[document.all.res_code.selectedIndex].text+"|";
		 	opr_info+="预存话费："+parseInt(document.all.out_prepay_fee.value)+"元"+"|";
			opr_info+="业务执行时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd ", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			
			note_info1+="备注："+"|";
		    			    	
			retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  	      	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式
    	    return retInfo;		
		    	
		}
		var change_flag = "";//定义RPC联动全局变量 查询等级:flag_grade  查询奖品:flag_res 默认:""
		
		function chagePrepayFee()
		{
			var logic_code=document.frm.logic_code.value;
		
			switch(logic_code){
				case '01' :
					document.frm.out_prepay_fee.value="10000";
					break;
				case '02':
					document.frm.out_prepay_fee.value="8000";
					break;
				case '03':
					document.frm.out_prepay_fee.value="5000";
					break;
				case '04':
					document.frm.out_prepay_fee.value="2000";
					break;
				case '05':
					document.frm.out_prepay_fee.value="1200";
					break;
				case '06':
					document.frm.out_prepay_fee.value="800";
					break;
				case '07':
					document.frm.out_prepay_fee.value="500";
					break;
				default :
					document.frm.out_prepay_fee.value="0";
			}
			change_flag = "flag_res";
			var myPacket = new AJAXPacket("resCode_rpc.jsp","正在获得奖品名称信息，请稍候......");
			var sqlStr = "select a.res_code,b.res_name from dbgiftrun.sChnActiveGradeCfg a, dbgiftrun.schngiftrescode b ,dbgiftrun.sChnActiveGrade c ,dbgiftrun.schnresactivecode d where a.res_code =b.res_code and a.grade_code=c.grade_code and c.active_code=d.active_code  and c.grade_logic_code='"+logic_code+"' and d.child_code='<%=child_code%>'";
			myPacket.data.add("sqlStr",sqlStr);
			core.ajax.sendPacket(myPacket);
			myPacket=null;
					
		}
		function doProcess(packet)
		{
			var retCode = packet.data.findValueByName("retCode");
		    	var retMsg = packet.data.findValueByName("retMsg");
			var retResult = packet.data.findValueByName("retResult");
			var rpc_page=packet.data.findValueByName("rpc_page");
			var triListData = packet.data.findValueByName("tri_list"); 
		  	var triList=new Array(triListData.length);
		   	if(change_flag == "flag_res")
				{
					triList[0]="res_code";
					document.all("res_code").length=0;
					document.all("res_code").options.length=triListData.length+1;//triListData[i].length;
					for(j=0;j<triListData.length;j++)
					{
						document.all("res_code").options[j+1].text=triListData[j][1];
						document.all("res_code").options[j+1].value=triListData[j][0];
					}//奖品名称
				}
		}
		
		//-->
	</script>
</head>


<body>
<form name="frm" method="post" action="f8072Cfm.jsp" onKeyUp="chgFocus(frm)" >
	<%@ include file="/npage/include/header.jsp" %>     	
	<div class="title">
		<div id="title_zi">大兴安岭签约赠礼</div>
	</div>	
        <table  cellspacing="0" >
	 <tr> 
            <td class="blue">操作类型</td>
            <td colspan="3">大兴安岭签约赠礼--<%=op_name%></td>           
          </tr>     
            
	  <tr> 
            <td class="blue">客户姓名</td>
            <td>
		<input name="cust_name" value="<%=bp_name%>" type="text"  v_must=1 readonly class="InputGrey" id="cust_name" maxlength="20"> 
            </td>
            <td class="blue">客户地址</td>
            <td>
		<input name="cust_addr" value="<%=bp_add%>" type="text"  v_must=1 readonly class="InputGrey" id="cust_addr" maxlength="20" > 
            </td>
         </tr>
         
         <tr> 
            <td class="blue">证件类型</td>
            <td>
		<input name="cardId_type" value="<%=cardId_type%>" type="text"  v_must=1 readonly class="InputGrey" id="cardId_type" maxlength="20" > 
            </td>
            <td class="blue">证件号码</td>
            <td>
		<input name="cardId_no" value="<%=cardId_no%>" type="text"  v_must=1 readonly class="InputGrey" id="cardId_no" maxlength="20" > 
            </td>
         </tr>
         
         <tr> 
            <td class="blue">业务品牌</td>
            <td>
		<input name="sm_code" value="<%=sm_code%>" type="text"  v_must=1 readonly class="InputGrey" id="sm_code" maxlength="20" > 
            </td>
            <td class="blue">运行状态</td>
            <td>
		<input name="run_type" value="<%=run_name%>" type="text"  v_must=1 readonly class="InputGrey" id="run_type" maxlength="20" > 
            </td>
        </tr>
        
        <tr> 
            <td class="blue">可用预存</td>
            <td>
		<input name="prepay_fee" value="<%=prepay_fee%>" type="text"  v_must=1 readonly class="InputGrey" id="prepay_fee" maxlength="20" > 
            </td>
	    <td class="blue">用户归属</td>
	    <td>
		<input name="region_name" value="<%=region_name%>" type="text"  v_must=1 readonly class="InputGrey" id="region_name" maxlength="20" > 
	    </td>
	</tr>
	
	<tr>
	   <td class="blue">中奖等级</td>
	   <td>	
			<select size=1 name="logic_code" id="logic_code" v_must=1  onchange="chagePrepayFee()" <%=disable_type%> >
			  <option value ="">--请选择--</option>
			  <option value ="01">一等奖 </option>
			  <option value ="02">二等奖 </option>
			  <option value ="03">三等奖 </option>
			  <option value ="04">四等奖 </option>
			  <option value ="05">五等奖 </option>
			  <option value ="06">六等奖 </option>
			  <option value ="07">七等奖 </option>
              		</select>
			<font class="orange">*</font>
	  </td>
	 
	 <td class="blue">消费金额</td>
	 <td>
		<input name="out_prepay_fee" value="0" type="text"  v_must=1 readonly class="InputGrey" id="out_prepay_fee" maxlength="5" > 元
	 </td>
       </tr>
       
       <tr>
		<td class="blue">奖品名称</td>
		  <td colspan="3">
			<select name="res_code"   <%=disable_type%> >
			<%
                 try
                 {
                      //ArrayList retArray1 = new ArrayList();
                     // String[][] result1 = new String[][]{};
                      //S1100View callView1 = new S1100View();                    
                      
                      String sqlStr1 = "select a.res_code,b.res_name from dbgiftrun.sChnActiveGradeCfg a, dbgiftrun.schngiftrescode b  ,dbgiftrun.sChnActiveGrade c ,dbgiftrun.schnresactivecode d where a.res_code =b.res_code and a.grade_code=c.grade_code and c.active_code=d.active_code and d.child_code='"+child_code+"'"  ;
                      System.out.println("sqlStr1="+sqlStr1);
                      //retArray1 = callView1.view_spubqry32("2",sqlStr1);
                       %>
                     	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
				<wtc:sql><%=sqlStr1%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result1" scope="end" />
                     <%
                      //result1 = (String[][])retArray1.get(0);
                      int recordNum1 = result1.length;      		
                      for(int i=0;i<recordNum1;i++)
                      {
                        out.println("<option class='button' value='" + result1[i][0] + "'>" + result1[i][1] + "</option>");
                      }
                 }catch(Exception e){
                      
				 }          
			%>
	        </select>             
		  </td>		  
	</tr>
	
	<tr> 
            <td class="blue">备注</td>
            <td colspan="3" >
             <input name="opNote" type="text"  readonly class="InputGrey" id="opNote" size="60" maxlength="60" value="大兴安岭签约赠礼" > 
            </td>
       </tr>
       </table>
       
       <table  cellspacing="0" >
          <tr> 
            <td id="footer"> 
                <input name="confirm" class="b_foot_long" type="button"  index="2" value="确认&打印" onClick="printCommit()">
                &nbsp; 
                <input name="reset" class="b_foot"  type="reset"  value="清除" >
                &nbsp; 
                <input name="back" class="b_foot" onClick="history.go(-1);" type="button"  value="返回">
                &nbsp; 
            </td>
          </tr>
        </table>
 
    	<input type="hidden" name="phone_no" value="<%=phoneNo%>">
    	<input type="hidden" name="work_no" value="<%=loginName%>">
	<input type="hidden" name="opcode" value="<%=opcode%>">
    	<input type="hidden" name="login_accept" value="<%=printAccept%>">
	<input type="hidden" name="child_code" value="<%=child_code%>">  
	<input type="hidden" name="back_accept" value="<%=back_accept%>">
	<input type="hidden" name="logic_code_back" value="<%=vLogicCode%>">
	<input type="hidden" name="res_code_back" value="<%=vResCode%>">
	
	<%@ include file="/npage/include/footer.jsp" %>    

</form>
</body>
</html>