<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 新增基本接入号
　 * 版本: v1.0
　 * 日期: 2009年03月04日
　 * 作者: wuxy
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*"%>

<%
	String opCode = "e539";	
	String opName = "新增基本接入号";	//header.jsp需要的参数   
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
	String workName = (String)session.getAttribute("workName");
	String ipAddr = (String)session.getAttribute("ipAddr");
	String orgCode = (String)session.getAttribute("orgCode");
		String loginNo=(String)session.getAttribute("workNo"); 
	String workPwd = (String)session.getAttribute("password");

	String queryInfo = request.getParameter("ecsiid");
	String ecsiname = request.getParameter("ecsiname");	
	String phone_no = request.getParameter("phone_no");	
	System.out.println("queryInfo="+queryInfo);

	String regionCode = orgCode.substring(0,2);
	String sqlStr="";
	String tMemberProperty = "";
	String  currentYear= (String)session.getAttribute("currentYear");
	
	System.out.println("22222222222="+currentYear);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	


	<script>
		//定义应用全局的变量
		var SUCC_CODE   = "0";          //自己应用程序定义
		var ERROR_CODE  = "1";          //自己应用程序定义
		var YE_SUCC_CODE = "0000";      //根据营业系统定义而修改
		var dynTbIndex=1;               //用于动态表数据的索引位置,开始值为1.考虑表头
		
		var oprType_Add = "a";
		var oprType_Upd = "u";
		var oprType_Del = "d";
		var oprType_Qry = "q";
		
		var TOKEN="|";
		var ifEcMASFlag = false;
		
		//core.loadUnit("debug");
		//core.loadUnit("rpccore");
		onload=function()
		{
		    init();
		}
		function init()
		{
			document.all.addRecordNum.value = document.all.dyntb.rows.length-2;
			document.all.BaseCodeType.value="01";
			document.all.ISDNNO.value=""; 
			document.all.dyntb.style.display="";		
		}
		function call_ISDNNOINFO()
		{		
		    if(!checkElement(document.all.ISDNNO)) {
		    	rdShowMessageDialog("基本接入号只能是数字！");
		    	return false;
		    }
		    if(document.all.ISDNNO.value<5) {
		    	rdShowMessageDialog("基本接入号长度不能小于5！");
		    	return false;
		    }
		    /*如果是 云MAS短流程业务接入号 */
		    if(ifEcMASFlag){
		    	var ISDNNO = $.trim($("#ISDNNO").val());
		    	var ISDNNOL = ISDNNO.length;
		    	if(ISDNNOL > 20){
		    		rdShowMessageDialog("云MAS短流程业务接入号最大长度为20位！");
		    		return false;
		    	}
		    	if(ISDNNOL < 9){
		    		rdShowMessageDialog("云MAS短流程业务接入号至少为9位！");
		    		return false;
		    	}
		    	if(ISDNNOL >= 9){
		    		var is8Val = ISDNNO.substring(7,8);
		    		var is9Val = ISDNNO.substring(8,9);
		    		/* if(is8Val != "0"){
		    			rdShowMessageDialog("云MAS短流程业务接入号第8位必须为0！");
		    			return false;
		    		} */
		    		if(is9Val != "9"){
		    			rdShowMessageDialog("云MAS短流程业务接入号第9位必须为9！");
		    			return false;
		    		}
		    	}
		    }
		    check_ISDNNO();		       			
		       
		}
		  function check_ISDNNO()
    {
	      var basecodetype="";
        basecodetype = document.all.BaseCodeType.value;
        var alterCode=document.all.ISDNNO.value;
        var myPacket = new AJAXPacket("fcheckisno.jsp","正在验证基本接入号，请稍候......");
				myPacket.data.add("OprCode","e539");
				myPacket.data.add("queryName",document.all.queryName.value);
 				myPacket.data.add("qryInfo",document.all.qryInfo.value);
		 		myPacket.data.add("alterCodeProp",basecodetype);
		 		myPacket.data.add("alterCode",alterCode);
				core.ajax.sendPacket(myPacket);
				myPacket=null;						
    }
    function doProcess(packet)
    {
        var retCode = packet.data.findValueByName("retCode");
        var retMessage=packet.data.findValueByName("retMessage");


        
        self.status="";
        if(retCode == "000000")          
        {
         dynAddRow();            
        }
        else
        {
           rdShowMessageDialog("操作失败！<br/>错误代码："+retCode+"，错误信息："+retMessage);
           document.all.ISDNNO.value = "";
           document.all.ISDNNO.focus();
           return false;	
        }
        
     }
    	function dynAddRow()
		{
		     var basecode_type="";
        	 var basecode="";
		
		    var tmpStr="";
		    var flag=false;
		
		    
		    var op_type = oprType_Add;
		
		
		    if( op_type == oprType_Add)
		    {
		      basecode_type = document.all.BaseCodeType.value;
          	  basecode = document.all.ISDNNO.value;
		      if(!checkElement(document.all.ISDNNO)) return false;
		    }
		    queryAddAllRow(0,basecode_type,basecode);
		
		}
		function queryAddAllRow(add_type,basecode_type,basecode)
		{
			var tr1="";
    		var i=0;
    		var tmp_flag=false;
    		var typeflag="";
    		
    		if(isNaN(basecode)==true)
				{			
					rdShowMessageDialog("基本接入号只能是数字！");
					return false;
				 
				}
			
    		if(basecode_type=="01")
    		{
    			typeflag="短信";
    				
    		}
    		else if(basecode_type=="02")
    		{
    			typeflag="彩信";
    		}
    		else if(basecode_type=="03")
    		{
    			typeflag="WAPPush";
    		}
    		var exec_status="";
    		if ( parseInt(document.all.addRecordNum.value) > 4 )
    		{
       		 	rdShowMessageDialog("最多只能操作5个号码 !!");
        		return false;
    		}
			
			
			
			  tmp_flag = verifyUnique(typeflag,basecode);
			  if(tmp_flag == false)
			  {
			    rdShowMessageDialog("已经有一条'基本接入号'相同的数据!");
			    return false;
			  }
			
			  tr1=dyntb.insertRow();    //注意：插入的必须与下面的在一起,否则造成空行.yl.
      		  tr1.id="tr"+dynTbIndex;

              tr1.insertCell().innerHTML = '<div align="center"><input id=R0    type=checkBox    size=4 value="删除" onClick="dynDelRow()" ></input></div>';
              tr1.insertCell().innerHTML = '<div align="center"><input id=R1    type=text   size=10 value="'+ typeflag+'"  readonly></input></div>';
              tr1.insertCell().innerHTML = '<div align="center"><input id=R2    type=text   value="'+ basecode+'"  readonly></input></div>';
      

              dynTbIndex++;
      

              document.all.addRecordNum.value = document.all.dyntb.rows.length-2;
              document.all.ISDNNO.value = "";
		}
		function verifyUnique(basecode_type,basecode)
		{
			var tmp_basecode_type="";
        	var tmp_basecode="";
        	
        	var op_type = oprType_Add;
        	//alert (basecode_type);
        	//alert(basecode);
        	
        	
        	for(var a = document.all.dyntb.rows.length-2 ;a>0; a--)//删除从tr1开始，为第三行
        	{
        		 //alert(document.all.R1[a].value);
        		 //alert(document.all.R2[a].value);
        	      tmp_basecode_type = document.all.R1[a].value;
        	      tmp_basecode = document.all.R2[a].value;
        	      
        	
        	     if( op_type == oprType_Add && basecode_type=="03")
        	     {
        	       if( basecode.trim() == tmp_basecode.trim())
        	        {
        	            return false;
        	        }
        	    }else if(op_type == oprType_Add && basecode_type!="03")
        	    	{
        	    		if( (basecode_type.trim() ==tmp_basecode_type.trim())&& (basecode.trim() == tmp_basecode.trim()))
        	        {
        	            return false;
        	        }
        	       }
        	
        	}
        	
        	return true;
	    }
	    function dynDelRow()
		{
		
		    for(var a = document.all.dyntb.rows.length-2 ;a>0; a--)//删除从tr1开始，为第三行
		    {
		        if(document.all.R0[a].checked == true)
		        {
		            document.all.dyntb.deleteRow(a+1);
		            break;
		        }
		    }
		    document.all.addRecordNum.value = document.all.dyntb.rows.length-2;
		
		}
		function dyn_deleteAll()
    	{
        	//清除增加表中的数据
        	for(var a = document.all.dyntb.rows.length-2 ;a>0; a--)//删除从tr1开始，为第三行
        	{
                document.all.dyntb.deleteRow(a+1);
        	}
        	document.all.addRecordNum.value = document.all.dyntb.rows.length-2;
   		 }
   		 function resetJsp()
    	{
    
    		var op_type = oprType_Add;
        	init();
        	dyn_deleteAll();
        	reset_globalVar();

   		}
    	function reset_globalVar()
    	{
      		dynTbIndex=1;
    	}
    	function commitJsp()
    	{
    	    var ind1Str ="";
    	    var ind2Str ="";
    	    var ind3Str ="";
    	    var ind4Str ="";
    	    var ind5Str ="";
    	
    	    var tmpStr="";
    	    
    	
    	    var op_type = oprType_Add;
    	
    	    var procSql = "";
    	
    	    if( op_type == oprType_Qry )
    	    {
    	        rdShowMessageDialog("查询不能确认!");
    	        return false;
    	    }
    	
				if( dyntb.rows.length == 2){//缓冲区没有数据
					rdShowMessageDialog("缓冲区没有数据,请增加数据!!");
					return false;
					}else{
					for(var a=1; a<document.all.R0.length ;a++)//删除从tr1开始，为第三行
					{
						if(document.all.R1[a].value=='短信'){
						ind1Str =ind1Str +"01"+"|";
					  }
					  else if(document.all.R1[a].value=='彩信'){
						ind1Str =ind1Str +"02"+"|";
					  }
					  else if(document.all.R1[a].value=='WAPPush'){
						ind1Str =ind1Str +"03"+"|";
					  }
						ind2Str =ind2Str +document.all.R2[a].value+"|";
					}
				}
			
    	
    	    //2.对form的隐含字段赋值
    	
    	    document.all.tmpR1.value = ind1Str;
    	    document.all.tmpR2.value = ind2Str;
    	    
    	
    	    
    	
    	
    	    //4.提交页面
    	     if( op_type == oprType_Add ){
    	        tmpStr = "增加 " + ",短号";
    	        
    	     }
    	
    	    document.all.opNote.value =  tmpStr;

    	    document.form1.action="fe539_commit.jsp?opType="+op_type+"&tmpR1="+ document.all.tmpR1.value+"&tmpR2=" +document.all.tmpR2.value+"&qryInfo="+document.all.qryInfo.value+"&queryName="+document.all.queryName.value+"&phone_no="+document.all.phone_no.value;
			document.form1.method="post";
			document.form1.submit();
		  
    	}
    	  	
    	
    	function ISDNNO_QryFunc()
		{
			var dataObj;
			var	params = "?";
			params = params + 'BaseCodeType=' + $("#BaseCodeType").val();
			
			var retInfo = window.showModalDialog                                                         
			(                                                                                            
				"fe539_getISDNNO.jsp"+params,                                                                 
				dataObj,                                                                                    
				'dialogHeight:550px; dialogWidth:750px;scrollbars:yes;resizable:no;location:no;status:no'    
			); 
			
			if(retInfo!=undefined)
			{
				$("#ISDNNO").val(retInfo) ;
				call_ISDNNOINFO();
			}
			
			
			
		}
    	
		$(document).ready(function(){
			
			$('#ISDNNO_Qry').click(function(){
			     ISDNNO_QryFunc();
			 });
			 
			
		});
		 function changeThisMaxL(EcVal){
		 	
				var EcValTrim = $.trim(EcVal);
				if(EcValTrim.length >= 7){
					var EcValSubStr = EcValTrim.substring(0,7);
					/*如果以 1065096 1065097 开头，第8位必须为0，第9位必须为9，最长为12位*/
					if(EcValSubStr == "1065097" || EcValSubStr == "1065096"||EcValSubStr == "1065090" || EcValSubStr == "1065091"){
						$("#ISDNNO").attr("maxlength","20");
						ifEcMASFlag = true;
					}else{
						$("#ISDNNO").attr("maxlength","14");
						ifEcMASFlag = false;
					}
				}
			}
		
		
		
    
	</script>
</head>
<body>
<form name="form1" method="post">
	<input type="hidden" name="pageOpCode" value="<%=opCode%>">
	<input type="hidden" name="pageOpName" value="<%=opName%>">
<%@ include file="/npage/include/header.jsp" %>

	<div class="title">
		<div id="title_zi">新增基本接入号 </div>
	</div>
	<table cellspacing="0">
		<tr > 
			<td class="blue">基本接入号类型</td>   
			<td >
				<select name="BaseCodeType" id="BaseCodeType" >
					<option value="01" >短信</option>	
					<option value="02" >彩信</option>
					<option value="03" >WAPPush</option>
				</select>
			</td> 
			<td class="blue">基本接入号</td>   
			<td >
				<input type="text" name="ISDNNO" id="ISDNNO" value=""  v_must="1" v_type="0_9"　  maxlength="14" onkeyup="changeThisMaxL(this.value);">&nbsp;
				<input type="button" class="b_text" id="ISDNNO_Qry" value="查询" >
			</td>  
			<td >
			   <input name="addCondConfirm" type="button" class="b_text" id="addCondConfirm" value="增加" onClick="call_ISDNNOINFO()">
			</td> 
		</tr>
    </table>
	<table cellspacing="0" id="dyntb">	
		<TBODY>	          	
		                <tr>
		                	
		                  	<td align="center" class="blue">删除操作</td>
		                    
		                    
		                  	<td align="center"class="blue">基本接入号属性</td>
		                  	
		                  	
		                  	<td align="center" class="blue">基本接入号</td>  
		                  	
		                </tr>
		                <tr id="tr0" style="display:none">
			                  <td>
				                    <div align="center">
				                      	<input type="checkBox" id="R0" value="">
				                    </div>
		                  	</td>
			                  <td>
				                    <div align="center">
				                      	<input type="text" id="R1" value="">
				                    </div>
			                  </td>
			                  <td>
				                    <div align="center">
				                      	<input type="text" id="R2" value="">
				                    </div>
			                  </td>
			                  
		                </tr>
		                </TBODY>		               
		           </table>
	<table cellspacing="0">
			  <TBODY>
			    <tr> 
			    	<td id="footer"> 
			    		<input name="confirm" type="button" class="b_foot" value="确认" onClick="commitJsp()">
			    		&nbsp;
			        <input name="reset" type="button" class="b_foot" value="清除" onClick="resetJsp()">
			         &nbsp;
			        <input class="b_foot" name=back onClick="window.location='fe539.jsp'" style="cursor:hand" type=button value=返回>
			   	</td>
			    </tr>
			    </TBODY>
  			</table>	
 <input type="hidden" name="addRecordNum" type="text" class="button" id="addRecordNum" value="" size=7 readonly> 	
 <input type="hidden" name="tmpR1" id="tmpR1" value="">
 <input type="hidden" name="tmpR2" id="tmpR2" value="">
 <input type="hidden" name="opNote" id="opNote" value="">	
 <input type="hidden" name="qryInfo" id="qryInfo" value="<%=queryInfo%>">	
 <input type="hidden" name="queryName" id="queryName" value="<%=ecsiname%>" >	   
 <input type="hidden" name="phone_no" id="phone_no" value="<%=phone_no%>" >		
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>