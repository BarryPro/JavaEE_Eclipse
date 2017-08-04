<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>

<head>

	<%
   response.setHeader("Pragma","No-cache");
   response.setHeader("Cache-Control","no-cache");
   response.setDateHeader("Expires", 0);

		String opCode = "e277";
		String opName = "网上预约选号和营销案的绑定";
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		int recordNum=0;
	  int i=0;
		%>
		<script language="javascript">
					 function chkType()
		      {			
		 			//yuanqs add 2010/10/28 15:16:46 分层需求 begin
		 			var regionCode = "<%=regionCode%>";
					var sqlStr = "select b.grade_name,a.note "+
						 " from sProjectCode a,ssalegrade b "+
						 " where a.sale_project_code = b.project_code "+
						 " and a.sale_grade_code = b.grade_code "+
						 " and b.grade_status='Y' "+
						 " and a.region_code in('"+regionCode+"','**') "+
						 " and a.valid_flag='Y' and a.sale_project_code='"+document.frm.projectType.value+"'";
					// 大兴安岭申请签约赠礼   哈尔滨高端预存赠礼   鹤岗新客户成长礼
					if((document.all.OLD_PROJECT_TYPE.value == "0011" && "<%=regionCode%>"=="12") || (document.all.OLD_PROJECT_TYPE.value == "0025" && "<%=regionCode%>"=="01") || (document.all.OLD_PROJECT_TYPE.value == "0026" && "<%=regionCode%>"=="08")){
						sqlStr += " and months_between(sysdate,to_date('"+document.frm.openTime.value+"','yyyy.mm.dd')) >= a.innet_lower and months_between(sysdate,to_date('"+document.frm.openTime.value+"','yyyy.mm.dd')) < a.innet_upper ";
					}
			
					var myPacket = new AJAXPacket("getDetailNote.jsp","正在查询请稍候......");
					myPacket.data.add("sqlStr",sqlStr);
					myPacket.data.add("retType",'01');
					core.ajax.sendPacket(myPacket);
					//rdShowMessageDialog("3");
					myPacket=null;
					
					//yuanqs add 2010/10/28 15:17:04 分层需求 end
			 	
					document.all.Gift_Code.value ="";
				 	document.all.Gift_Name.value ="";
				 	document.all.Base_Fee.value ="";
				 	document.all.Free_Fee.value ="";
				 	document.all.Mark_Subtract.value ="";
				 	document.all.Consume_Term.value ="";
				 	document.all.Mon_Base_Fee.value ="";
				 	document.all.Prepay_Fee.value ="";
				 	document.all.New_Mode_Name.value ="";
				 	document.all.do_note.value ="";
		     }
		 function doProcess(packet){
		 		errorCode = packet.data.findValueByName("errorCode");
				errorMsg =  packet.data.findValueByName("errorMsg");
				retType = packet.data.findValueByName("retType");
				retResult= packet.data.findValueByName("retResult");
				self.status="";
				var tmpObj="";
				var i=0;
				var j=0;
				var ret_code=0;
				var tmpstr="";
		
				//rdShowMessageDialog("retType="+retType);
				ret_code =  parseInt(errorCode);
				
				//yuanqs add 2010/10/28 15:43:53 分层需求 begin
				if(retType=="01") {
						var detailCount = packet.data.findValueByName("detailCount");
						var js_detail_msg = packet.data.findValueByName("js_detail_msg");
						showMsg(js_detail_msg, detailCount);
				}
				//yuanqs add 2010/10/28 15:44:04 分层需求 end
				if(retType=="getProjectType")
				{
					if(ret_code!=0){
						rdShowMessageDialog("取信息错误:"+errorMsg+"!");
						return;
					}
					document.all.OLD_PROJECT_TYPE.value=retResult;
				 }
		
		 }
		//yuanqs add 2010/10/29 10:35:38 分层需求
		function showMsg(js_detail_msg, detailCount) {
				var msgStr = "";
				if(1==detailCount) {				
						msgStr = "备注：" + js_detail_msg[0][1];
				} else {
						var msgStr = "方案名称<br>";
						for(var p=0; p<js_detail_msg.length; p++) {
								msgStr = msgStr + (p+1) + "：" + js_detail_msg[p][0] + "<br>";
						}
				}
				$("#msgDiv").children("span").html(msgStr);
				
					var msgNode = $("#msgDiv").css("border","1px solid #999").width("260px")
		                            .css("position","absolute").css("z-index","99")
		                            .css("background-color","#dff6b3").css("padding","8");
		    	var pt = $("#projectType");
		    	msgNode.css("left",pt.offset().left + 300 + "px").css("top",pt.offset().top + 0 + "px");
		    	msgNode.show();
		}
		function hideMessage() {
				$("#msgDiv").hide();
		}
		
		 function getInfo_code()
		{
			var myPacket = new AJAXPacket("queryProjectType.jsp","取project_type信息，请稍候......");
			myPacket.data.add("retType","getProjectType");
			myPacket.data.add("sale_project_code",(document.frm.projectType.value).trim());
			core.ajax.sendPacket(myPacket);
			myPacket=null;
		
		
		// add by dujl*************************************************
			// wanglei modify sql and 简化代码
			var regionCode = "<%=regionCode%>";
			var pageTitle = "营销方案选择";
			var fieldName = "方案代码|方案名称|底线预存|活动预存|扣减积分|消费期限|月底线|总预存|备注|系统使用|";//弹出窗口显示的列、列名
			var selType = "S";    //'S'单选；'M'多选
			var retQuence = "10|0|1|2|3|4|5|6|7|8|9|";//返回字段
			var retToField = "Gift_Code|Gift_Name|Base_Fee|Free_Fee|Mark_Subtract|Consume_Term|Mon_Base_Fee|Prepay_Fee|New_Mode_Name|OLD_PROJECT_TYPE|";//返回赋值的域
			var sqlStr = "select a.sale_grade_code,b.grade_name,a.base_fee,a.free_fee,a.consume_mark,a.consume_term,a.mon_base_fee,a.prepay_fee,a.note,a.project_type OLD_PROJECT_TYPE "+
						 " from sProjectCode a,ssalegrade b "+
						 " where a.sale_project_code = b.project_code "+
						 " and a.sale_grade_code = b.grade_code "+
						 " and b.grade_status='Y' "+
						 " and a.region_code in('"+regionCode+"','**') "+
						 " and b.grade_code in"+	//fusk 20110519 因 申告添加 grade_code in
						      " (select c.grade_code"+
						      "  from ssalegradepackage c "+
						      " where c.project_code = b.project_code"+
		                          " and c.region_code ='"+regionCode+"'"+
		                          " and c.status ='Y')"+
						 " and a.valid_flag='Y' and a.sale_project_code='"+document.frm.projectType.value+"'";
			//rdShowMessageDialog(document.all.OLD_PROJECT_TYPE.value);
		
			// 大兴安岭申请签约赠礼   哈尔滨高端预存赠礼   鹤岗新客户成长礼
			if((document.all.OLD_PROJECT_TYPE.value == "0011" && "<%=regionCode%>"=="12") || (document.all.OLD_PROJECT_TYPE.value == "0025" && "<%=regionCode%>"=="01") || (document.all.OLD_PROJECT_TYPE.value == "0026" && "<%=regionCode%>"=="08")){
				sqlStr += " and months_between(sysdate,to_date('"+document.frm.openTime.value+"','yyyy.mm.dd')) >= a.innet_lower and months_between(sysdate,to_date('"+document.frm.openTime.value+"','yyyy.mm.dd')) < a.innet_upper ";
			}
			//begin huangrong add 根据用户入网时间和选择的方案类型选择性的展示具体的方案代码 2011-4-26 16:56	 
		
			if(document.frm.projectType.value=="241738" || document.frm.projectType.value=="241743")
			{

			}	
			//end huangrong add 根据用户入网时间和选择的方案类型选择性的展示具体的方案代码 2011-4-26 16:56	
			if(MySimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,80));
			//document.all.do_note.value = "统一预存赠礼，方案代码："+document.all.Gift_Code.value;
			// rdShowMessageDialog(document.all.OLD_PROJECT_TYPE.value);
		}
				function MySimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,dialogWidth)
			  {
			    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel.jsp";
			    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
			    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
			    path = path + "&selType=" + selType;
			    retInfo = window.showModalDialog(path,"","dialogWidth:"+dialogWidth);
			    if(retInfo ==undefined)
			    {   return false;   }
			    var chPos_field = retToField.indexOf("|");
			    var chPos_retStr;
			    var valueStr;
			    var obj;
			    while(chPos_field > -1)
			    {
			        obj = retToField.substring(0,chPos_field);
			        chPos_retInfo = retInfo.indexOf("|");
			        valueStr = retInfo.substring(0,chPos_retInfo);
			        document.all(obj).value = valueStr;
			        retToField = retToField.substring(chPos_field + 1);
			        retInfo = retInfo.substring(chPos_retInfo + 1);
			        chPos_field = retToField.indexOf("|");
			
			    }
				return true;
			 }
			 
		  function printCommit()
			{


				if(document.all.Gift_Code.value==""){
					rdShowMessageDialog("请选择方案代码!");
					document.all.Gift_Code.focus();
					return false;
				}	
				if(document.all.do_note.value.trim()==""){
				document.all.do_note.value = "进行网上预约选号和营销案的绑定，方案代码："+document.all.Gift_Code.value;
				}		
				if(frm.feefile.value.length<1)
				{
					rdShowMessageDialog("数据文件错误，请重新选择数据文件！");
					document.frm.feefile.focus();
					return false;
				}

					document.frm.action="fe277_1.jsp?remark="+document.frm.do_note.value+"&projectType="+document.frm.projectType.value+"&Gift_Code="+document.frm.Gift_Code.value;
					document.frm.submit();

				frm.submit();
			}
		</script>
		<body   >
		<form name="frm" method="POST" action="fe277_1.jsp" ENCTYPE="multipart/form-data">
	<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table cellspacing="0">
	

		<tr>
			<td class="blue" >方案类型</td>
			<td>
		<select id=projectType name=projectType onblur="hideMessage();" onChange="chkType()" style="width:300px;" >
		    <%
		    //yuanqs add onblur="hideMessage();" 2010/11/3 9:48:45 
		    	String[] inParas1 = new String[2];
		    	inParas1[0] =
				"select trim(a.project_code),trim(a.project_name) " +
				"  from ssaleproject a, ssaleop b " +
				" where a.project_code = b.project_code " +
				"   and a.region_code in( :region_code, '**') " +
				"   and b.op_code = :op_code " +
				"   and a.project_status = 'Y' " +
				"   and a.start_date <=sysdate and a.end_date >=sysdate " +
				"   and exists (select 1 from sSaleGrade c ,sSaleGradePackage d " +
				"   where c.project_code = a.project_code  and c.grade_status='Y'  and d.status ='Y' " +
				"   and c.project_code = d.project_code and c.grade_code = d.grade_code and d.region_code='"+regionCode+"') and a.project_code='287101' order by a.op_time desc ";
				// yuanqs add order by 2010/11/3 9:49:10 
				inParas1[1] = "region_code="+regionCode+",op_code=2289";
				//System.out.println("op_code=2289:方案类型 = "+ inParas1[0] );
				//System.out.println("regionCode="+ regionCode+",op_code="+opCode);
%>
			<wtc:service name="TlsPubSelCrm"  outnum="2" retcode="retCode1" retmsg="regMsg1">
				<wtc:param value="<%=inParas1[0]%>"/>
				<wtc:param value="<%=inParas1[1]%>"/>
			</wtc:service>
			<wtc:array id="result" scope="end"/>
<%

				recordNum = result.length;
				System.out.println("recordNum======="+recordNum);
				for(i=0;i<recordNum;i++)
				{
					out.println("<option class='button' value='" + result[i][0] + "'>" + result[i][0]+"-->"+result[i][1] + "</option>");
				}
		   %>
		   </select>
			</td>

			<td class="blue" >方案代码</td>
			<td>
							<input class="InputGrey" type="text" name="Gift_Code" id="Gift_Code" readonly><input class="b_text" type="button" name="qryId_No" value="查询" onClick="getInfo_code()" >
			<font class="orange">*</font>
	</td>	
		</tr>
		<tr>
				<td class="blue" >底线预存</td>
			<td>
							<input name="Base_Fee" type="text" class="InputGrey" id="Base_Fee" readonly>
			<font class="orange">*</font>
	</td>
		<td class="blue" >活动预存</td>
			<td>
						<input name="Free_Fee" type="text" class="InputGrey" id="Free_Fee"   readonly>
			<font class="orange">*</font>
	</td>
		</tr>
			<tr>
				<td class="blue" >消费期限</td>
			<td>
							<input name="Consume_Term" type="text" class="InputGrey" id="Consume_Term"   readonly>
			<font class="orange">*</font>
	</td>
		<td class="blue" >应收金额</td>
			<td>
						<input name="Prepay_Fee" type="text" class="InputGrey" id="Prepay_Fee"   readonly>
			<font class="orange">*</font>
	</td>
		</tr>
	

		              <tbody> 
			           
			              <tr>
			              	<td class="blue"  width="20%">号码导入</td>
			                <td colspan="3"> 
			                  <input type="file" name="feefile">
			                </td>
			              </tr>
			                 <tr> 
				                <td class="blue"  width="20%">操作备注</td>
				                <td colspan="3"> 
				                  	<input name="do_note" type="text" class="button" id="do_note" value="" size="60" maxlength="60" >
				                </td>
			              </tr>
			              <tr> 
				                <td colspan="4">说明：<br>
				        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">号码导入格式为TXT文件</font>：<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">请注意号码的正确性</font>：<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;手机号码  回车<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;如： <br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13604511111 <br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13704511111 <br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13804511111 <br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13904511111 
				                </td>
			              </tr>
		              </tbody> 
		      </table>

	 
	 	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
					<input type="button" name="quchoose" class="b_foot" value="确定" onclick="printCommit()" />		
				&nbsp;
				<input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();"/>
			</div>
			</td>
		</tr>
	</table>
		<div id="msgDiv">
	    <span></span>
	</div>
	<input type="hidden" name="OLD_PROJECT_TYPE" >
	<input type="hidden" name="New_Mode_Name" value=" ">
	<input type="hidden" name="Gift_Name"  >
	<input type="hidden" name="Mon_Base_Fee"  >
	<input type="hidden" name="Mark_Subtract"  >
</form>
</body>
</html>