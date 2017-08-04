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
		<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>

		<script language="JavaScript">
    var quanjusum=0;
    
    $(document).ready(function(){ 
    	if("<%=opCode%>"=="m272") {
	     document.all.opType[0].checked=true;
	     changeType("add");
	     }
    	if("<%=opCode%>"=="m273") {
	     document.all.opType[1].checked=true;
	     changeType("query");
	     }	     
	     
    	});
    
		function doCommit()
		{
	
					  			  		  
			  
			var radio1 = document.getElementsByName("opType");
				   for(var i=0;i<radio1.length;i++)
				  {
					    if(radio1[i].checked)
						{
						var opFlag = radio1[i].value;
						if(opFlag=="add")
								{
       		    					if(!checkElement(document.all.ywaccept)){
										return false;
									}
       		    					if(!checkElement(document.all.workorgcode)){
										return false;
									}
									
									if($("#ywaccept").val().trim()=="0"){
					         		rdShowMessageDialog("业务流水不允许录入0,请重新输入!");
					         		return false;
								}
									

    						document.all.quchoose.disabled=true;
     		        		document.form1.action="fm272Cfm.jsp?opCode=<%=opCode%>&opName=<%=opName%>&workorgcode="+$('#workorgcode').val()+"&ywaccept="+$('#ywaccept').val();
		            		document.form1.submit();
		            	}
						else if(opFlag=="pladd")
						{	
		       		    		if(!checkElement(document.all.workorgcodepl)){
		       		    		rdShowMessageDialog("请输入员工编号!");
									return false;
								}
								if(document.all.uploadFile.value.length<1)
								{
									rdShowMessageDialog("数据文件错误，请重新选择数据文件！");
									document.all.uploadFile.focus();
									return false;
								}
					
								var formFile=document.all.uploadFile.value.lastIndexOf(".");
								var beginNum=Number(formFile)+1;
								var endNum=document.all.uploadFile.value.length;
								formFile=document.all.uploadFile.value.substring(beginNum,endNum);
								formFile=formFile.toLowerCase(); 
						        if(formFile!="txt")
						        {
						        	rdShowMessageDialog("上传文件格式只能是txt，请重新选择数据文件！");
									document.document.all.uploadFile.focus();
									return false;
						        }
	
	    						document.all.quchoose.disabled=true;
			     		        document.form1.action="fm272Upload.jsp?opCode=<%=opCode%>&opName=<%=opName%>&workorgcode="+$('#workorgcodepl').val();
					            document.form1.submit();
						    }
						    else if(opFlag=="plquery")
							{
							
								if($("#plstarttimes").val()==""){
					         		rdShowMessageDialog("开始时间不能为空,请输入!");
					         		return false;
								}
								if($("#plendtimes").val()==""){
					         		rdShowMessageDialog("结束时间不能为空,请输入!");
					         		return false;
								}
								
								if(compareDatesByType($("#plstarttimes").val(),$("#plendtimes").val(),"date_time")==1){
					         		rdShowMessageDialog("结束时间应大于开始时间,请重新输入!");
					         		return false;
								}
								
								var startdatess=$("#plstarttimes").val().trim();
								
								
								var enddatess=$("#plendtimes").val().trim();
								
    
	    	          			var myPacket = new AJAXPacket("fm272_plqry.jsp","正在查询信息，请稍候......");
							    myPacket.data.add("plworkorgcode", $("#plworkorgcode").val().trim());
							    myPacket.data.add("plstarttimes", startdatess);
							    myPacket.data.add("plendtimes", enddatess);
								core.ajax.sendPacketHtml(myPacket,plquerinfo,true);
								getdataPacket = null;
						    }
						    else {
	

       		    				if(!checkElement(document.all.workorgcodequery)){
										return false;
									}
									
								if(compareDatesByType($("#starttimes").val(),$("#endtimes").val(),"date_time")==1){
					         rdShowMessageDialog("结束时间应大于开始时间,请重新输入!");
					         return false;
								}
								
								var startdatess=$("#starttimes").val().trim();
									if(startdatess!=""){
										startdatess=startdatess+"000000"
									}
								
								var enddatess=$("#endtimes").val().trim();
									if(enddatess!=""){
										enddatess=enddatess+"235959"
									}
    
    	          			var myPacket = new AJAXPacket("fm272_qry.jsp","正在查询信息，请稍候......");
						    myPacket.data.add("workorgcodequery", $("#workorgcodequery").val().trim());
						    myPacket.data.add("opcodess", $("#opcodess").val().trim());
						    myPacket.data.add("starttimes", startdatess);
						    myPacket.data.add("endtimes", enddatess);
								core.ajax.sendPacketHtml(myPacket,querinfo,true);
								getdataPacket = null;
	
 						    						    	
						    }
    
				    }
		     }
		
		

		      
		}

  		function querinfo(data){
			//找到添加表格的div
			var markDiv=$("#squerys"); 
			markDiv.empty();
			markDiv.append(data);
				
		}
		function plquerinfo(data){
			//找到添加表格的div
			var markDiv=$("#squerys"); 
			markDiv.empty();
			markDiv.append(data);
				
		}
		
		function plshowDetail(){
			alert("aaaa");
		}
	

function deleteoffer(accept,workbianhao){
	
	
	  var	prtFlag = rdShowConfirmDialog("确定删除此条记录？");
		 
			if (prtFlag==1)
		    {
	
		document.form1.action="fm273_del.jsp?accepts="+accept+"&workorgcode="+workbianhao;
		document.form1.submit(); 
			}else {

			}	
}
	


		function doclear()
		{
		        window.location.href = "fm272.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		}
		
function changeType(opCode){

	
	if(opCode == "add"){
		document.all.querysss.disabled=true;
		document.all.quchoose.disabled=false;
		$("#add").show();
		$("#query").hide();
		$("#pladd").hide();
		$("#plquery").hide();
	    $("#squerys").empty();    
	    $("#ywaccept").val("");
	    $("#workorgcode").val("");
	    hiddenTip(document.all.workorgcodequery);
	    hiddenTip(document.all.plworkorgcode);
	}
	
	if(opCode == "query"){
		document.all.quchoose.disabled=true;
		document.all.querysss.disabled=false;	
		$("#add").hide();
		$("#query").show();
		$("#pladd").hide();
		$("#plquery").hide();
		hiddenTip(document.all.workorgcode);
		hiddenTip(document.all.plworkorgcode);
		$("#squerys").empty();    
	    $("#workorgcodequery").val("");
	    $("#opcodess").val("");
	    $("#starttimes").val("");
	    $("#endtimes").val("");
	}
	
	if(opCode == "pladd"){
		document.all.querysss.disabled=true;
		document.all.quchoose.disabled=false;
		$("#add").hide();
		$("#query").hide();
		$("#pladd").show();
		$("#plquery").hide();
	    $("#squerys").empty();    
	    $("#workorgcodepl").val("");
	    hiddenTip(document.all.workorgcodequery);
	    hiddenTip(document.all.plworkorgcode);
	}
	
	if(opCode == "plquery"){
		document.all.quchoose.disabled=true;
		document.all.querysss.disabled=false;		
		$("#add").hide();
		$("#query").hide();
		$("#pladd").hide();
		$("#plquery").show();
		hiddenTip(document.all.workorgcode);
		hiddenTip(document.all.workorgcodequery);
		$("#squerys").empty();    
	    $("#plworkorgcode").val("");
	    $("#plstarttimes").val("");
	    $("#plendtimes").val("");
	}
}

 
 function clearNoNum(obj){   obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符  

 obj.value = obj.value.replace(/^\./g,"");  //验证第一个字符是数字而不是. 

  obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的.   

obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");

} 


function compareDatesByType(obj1,obj2,type)

{

	var date1=obj1;

	var dateformat1 = '';

	var date2=obj2;

	var dateformat2 = '';

	if(type == 'date_time') {

		dateformat1	= 'yyyy-MM-dd HH:mm:ss';

		dateformat2	= 'yyyy-MM-dd HH:mm:ss';

	}else if(type == 'date') {

		dateformat1	= 'yyyyMMdd';

		dateformat2	= 'yyyyMMdd';	

	}

	var d1=getDateFromFormat(date1,dateformat1);

	var d2=getDateFromFormat(date2,dateformat2);

	if (d1==0 )

		return -1;

	else if(d2==0)

		return -2;

	else if (d1 > d2)

		return 1;

	return 0;

} 
		
	</script>
</HEAD>
<BODY >
	<FORM action="" method=post name="form1" ENCTYPE="multipart/form-data" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="loginAccept" id="loginAccept" value="<%=sysAccept%>"> 
	

        <table id=""  cellspacing="0" >  	
        	  <tr>

			        		<td width=16% class="blue">操作类型</td>

			        		<td width=84% colspan="3">

			        			<input type="radio" name="opType"	value="add"   onclick="changeType(this.value);" />录入 &nbsp;&nbsp;

			        			<input type="radio" name="opType"	value="query"  onclick="changeType(this.value);"/>删除 &nbsp;&nbsp;
			        			
			        			<input type="radio" name="opType"	value="pladd"  onclick="changeType(this.value);"/>批量导入 &nbsp;&nbsp;
			        			
			        			<input type="radio" name="opType"	value="plquery"  onclick="changeType(this.value);"/>批量结果查询 &nbsp;&nbsp;

			        		</td>

        				</tr>
       </table>
       
        				  <table id="add" style="display:block">
       	        <tr>

					        <td class='blue' width=16%>业务流水</td>

					        <td>

								<input type="text" value="" name="ywaccept" id="ywaccept" v_type="string"  maxlength="14"  v_must ='1' onblur="checkElement(this)"/>

								<font class="orange">*</font>

					        </td>

					        <td class='blue'>员工编号</td>

					        <td>

					        	<input type="text" value="" name="workorgcode" id="workorgcode" v_type="0_9"  v_minlength="8"  maxlength="8" v_must ='1' onblur="checkElement(this)" />

					        	<font class="orange">*</font>

					        	</td>

					        </tr>    				
        			
        				
              </table>



		<table id="query" cellspacing="0" style="display: none">
			<tr>
				<td class='blue' width=16%>员工编号</td>
				<td><input type="text" value="" name="workorgcodequery"
					id="workorgcodequery" v_type="0_9" v_minlength="8" maxlength="8"
					v_must='1' onblur="checkElement(this)" /> <font class="orange">*</font>
				</td>
				<td class="blue">业务代码</td>

				<td><input type="text" value="" name="opcodess" id="opcodess"
					v_type="string" maxlength="4" onblur="checkElement(this)" /></td>
			</tr>
			<tr>
				<td class='blue'>任务录入开始时间</td>
				<td><input name="starttimes" type="text" id="starttimes"
					readOnly
					onclick="WdatePicker({el:'starttimes',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					v_type="date" maxlength="19" onblur="checkElement(this)" /> <img
					id="imgCustStart"
					onclick="WdatePicker({el:'starttimes',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16"
					height="22" align="absmiddle"></td>
				<td class='blue'>任务录入结束时间</td>
				<td><input name="endtimes" type="text" id="endtimes" readOnly
					onclick="WdatePicker({el:'endtimes',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					v_type="date" value="" maxlength="19" onblur="checkElement(this)" />
					<img id="imgCustEnd"
					onclick="WdatePicker({el:'endtimes',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16"
					height="22" align="absmiddle"></td>
			</tr>
		</table>
		<!-- 2016-07-19 关于增加M272批量导入功能的需求的函 -->
	  <table id="pladd" style="display: none">
 	        			<tr>
       <td class='blue'>员工编号</td>
        <td>
        	<input type="text" value="" name="workorgcodepl" id="workorgcodepl" v_type="0_9"  v_minlength="8"  maxlength="8" v_must ='1' onblur="checkElement(this)" />
        	<font class="orange">*</font>
        </td>
        <td>数据文件</td>
		<td>
			<input type="file" name="uploadFile">
			<font color="#FF0000">*</font>
		</td>
       </tr> 
      <tr> 
      	<td colspan="4">说明：<br>
				  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">此次批量导入字段：业务流水</font><br>
				  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">数据文件为TXT文件</font><br>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">一次最大允许导入500个</font><br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;如： <br>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;11223344 <br>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;33445566 <br>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;44556677 <br>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;55667788 
        </td>
      </tr>
 			</table>
		<table id="plquery" cellspacing="0" style="display: none">
			<tr>
				<td class='blue' width=16%>员工编号</td>
				<td><input type="text" value="" name="plworkorgcode"
					id="plworkorgcode" v_type="0_9" v_minlength="8" maxlength="8"/>
				</td>
				<td class="blue"></td>
				<td></td>
			</tr>
			<tr>
				<td class='blue'>开始时间</td>
				<td><input name="plstarttimes" type="text" id="plstarttimes"
					readOnly
					onclick="WdatePicker({el:'plstarttimes',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					v_type="date" maxlength="19" onblur="checkElement(this)" /> <img
					id="imgCustStart"
					onclick="WdatePicker({el:'plstarttimes',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16"
					height="22" align="absmiddle"><font class="orange">*</font></td>
				<td class='blue'>结束时间</td>
				<td><input name="plendtimes" type="text" id="plendtimes" readOnly
					onclick="WdatePicker({el:'plendtimes',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					v_type="date" value="" maxlength="19" onblur="checkElement(this)" />
					<img id="imgCustEnd"
					onclick="WdatePicker({el:'plendtimes',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16"
					height="22" align="absmiddle"><font class="orange">*</font></td>
			</tr>
		</table>
		
		
		<table cellspacing="0">
              	<tbody>
              		<tr>
                		<td id="footer">
                                    <input  name="quchoose" id="quchoose" class="b_foot" type=button value=录入  onclick="doCommit()" >
                                    &nbsp;
                                    <input  name="querysss" id="querysss" class="b_foot" type=button value=查询  onclick="doCommit()" >
                                    &nbsp;
                                  	<input  name="clear" class="b_foot" type=reset value=清除 onclick="doclear()">
                                  	&nbsp;                  			
                		</td>
              		</tr>
              </tbody>
            </table>
            
          <div id="squerys">
	      </div>
	      <div id="squerys1">
	      </div>
	     <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>                                                                                                                                                                                                                                                                                                                                                                                        