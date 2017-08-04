<%@ include file="/include/public_title_name.jsp"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%    
  			ArrayList arrSession = (ArrayList)session.getAttribute("allArr"); 
				String[][] baseInfoSession = (String[][])arrSession.get(0);
				String[][] otherInfoSession = (String[][])arrSession.get(2);
				String[][] pass = (String[][])arrSession.get(4);
			  String loginPasswd  = pass[0][0];       //取操作员密码
        String workNo = (String) session.getAttribute("workNo");
        String workName = (String) session.getAttribute("workName");
				String op_name ="SP业务信息审核"; 
				
				String powerCode= otherInfoSession[0][4];
				String orgCode = baseInfoSession[0][16];
				String ip_Addr = request.getRemoteAddr();
				
				String regionCode = orgCode.substring(0,2);
				String region_Name = otherInfoSession[0][5];
				String town_Name = otherInfoSession[0][7];
				String loginNoPass = pass[0][0];

%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="sLoginAccept" />

<html>
<head>
<title><%=op_name%></title>
<script language=javascript>
		core.loadUnit("debug");
		core.loadUnit("rpccore");
			onload=function()
			{
			 core.rpc.onreceive=doProcess;
			}
		function doProcess(packet)
	{	
		
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var operator_code = packet.data.findValueByName("operator_code");
		var operator_name = packet.data.findValueByName("operator_name");
		var serv_type = packet.data.findValueByName("serv_type");			
		var serv_attr = packet.data.findValueByName("serv_attr");
		var count = packet.data.findValueByName("count");
		var bill_flag = packet.data.findValueByName("bill_flag");
		var other_bal_obj1 = packet.data.findValueByName("other_bal_obj1");
		var other_bal_obj2 = packet.data.findValueByName("other_bal_obj2");
		var valid_date = packet.data.findValueByName("valid_date");
		var expire_date = packet.data.findValueByName("expire_date");
		var bal_prop = packet.data.findValueByName("bal_prop");
		var serv_type = packet.data.findValueByName("serv_type");
		if( parseInt(retCode) == 0 ){
			document.frm.operator_code.value= operator_code;
			document.frm.operator_name.value= operator_name;
			document.frm.serv_type.value= serv_type;
			document.frm.serv_attr.value= serv_attr;
			document.frm.count.value= count;
			document.frm.bill_flag.value= bill_flag;
			document.frm.other_bal_obj1.value= other_bal_obj1;
			document.frm.other_bal_obj2.value= other_bal_obj2;
			document.frm.valid_date.value= valid_date
			document.frm.expire_date.value= expire_date;
			document.frm.bal_prop.value= bal_prop;				
							
		}else{
			rdShowMessageDialog("错误："+retMsg);
		}
	}
  function printCommit()
			{
			       conf();
			       document.frm.systemNote.value="SP业务"+document.frm.operator_name.value+"资料修改";
			}
			
			
	function conf()
			{		  
			      frm.action="f9107_21.jsp";
			      frm.submit();
			} 
			
	function getFlagCode()
{ 
	var verify_code = document.frm.verify_code2.value;
	var message = document.frm.message.value;
	var pageTitle = "SP信息查询";
	var fieldName = "企业代码|业务代码|业务产品名称|生效日期|失效日期|操作流水|";
	var sqlStr = "";
	if(parseInt(verify_code)==0){
	 sqlStr = "select SP_CODE,OPERATOR_CODE,OPERATOR_NAME,VALID_DATE,EXPIRE_DATE,to_char(MAXACCEPT) from TDSMPSPBIZINFOMSG  where SP_CODE like '%' || :message || '%'";
	}else if(parseInt(verify_code)==1){
	 sqlStr = "select SP_CODE,OPERATOR_CODE,OPERATOR_NAME,VALID_DATE,EXPIRE_DATE,to_char(MAXACCEPT) from TDSMPSPBIZINFOMSG  where OPERATOR_CODE like '%' || :message || '%'";	 
	}else if(parseInt(verify_code)==2){
	 sqlStr = "select SP_CODE,OPERATOR_CODE,OPERATOR_NAME,VALID_DATE,EXPIRE_DATE,to_char(MAXACCEPT) from TDSMPSPBIZINFOMSG  where OPERATOR_NAME like '%' || :message || '%'";	 
	}else{
	sqlStr = "select SP_CODE,OPERATOR_CODE,OPERATOR_NAME,VALID_DATE,EXPIRE_DATE,to_char(MAXACCEPT) from TDSMPSPBIZINFOMSG ";}	 		
	var varStr="message="+message;           
	var selType = "S";    //'S'单选；'M'多选
	var retQuence = "5|1|2|3|4|5|";
	var retToField = "operator_code|operator_name|valid_date|expire_date|maxaccept|";
	var serviceName = "TlsPubSelCen";
	var routerKey = "region";
	var routerValue = "<%=regionCode%>";
	PubSimpSel_BD(pageTitle,fieldName,sqlStr,varStr,selType,retQuence,retToField,serviceName,routerKey,routerValue)
  select_spmsg();
}	
 function select_spmsg()
  {
   var maxaccept = document.frm.maxaccept.value;
   var page_type ="2";
   var myPacket = new RPCPacket("select_spmsg.jsp","正在获得SP企业信息，请稍候......");
   myPacket.data.add("maxaccept",maxaccept);
   myPacket.data.add("page_type",page_type);
   core.rpc.sendPacket(myPacket);
	 delete(myPacket);	
  } 
</script>	
</head>
<BODY bgcolor="#FFFFFF" text="#000000" background="../../images/jl_background_2.gif" leftmargin = "0" topmargin = "0" marginwidth = "0" marginheight = "0">
<form name="frm" method="POST" >
<input type="hidden" name="loginAccept" value="<%=sLoginAccept%>">
<input type="hidden" name="maxaccept" value="">
<input type="hidden" name="workno" value="<%=workNo%>">	 
<%@ include file="/include/header.jsp"%>
<table  width=98% height=25 border="0" align="center" bgcolor="#FFFFFF">
 	      <tr> 
            <td width="16%" bgcolor="#eeeeee" nowrap> 
              <div align="left">查询方式：</div>
            </td>
            <td nowrap bgcolor="#eeeeee" colspan="1"> 
              <div align="left"> 
               <select size=1 name=verify_code2 >                
                 <option value="0">SP代码</option>
                 <option value="1">业务代码</option>
                 <option value="2">业务名称</option>
                 <option value="3">全部</option>
               </select>
              </div>
            </td>
            <td nowrap bgcolor="#eeeeee" colspan="6">
            </td>	
          </tr>
          <tr>
            <td width="16%" bgcolor="#eeeeee" nowrap> 
              <div align="left">查询内容：</div>
            </td>
            <td nowrap width="16%" bgcolor="#eeeeee" colspan="1" >
            	<input name="message" type="text" maxlength="30" id="message" value="">
            	</td>
            <td nowrap bgcolor="#eeeeee" colspan="6">
            	<div align="left"><input name="select" class="button" type="button"  value="查询" onClick="getFlagCode()"></div>
             </td>
          </tr>
 </table>  
 <table  width=98% height=25 border="0" align="center" bgcolor="#FFFFFF">
 	 	   <tr bgcolor="#eeeeee" class="title"> 
            <td width="13%" bgcolor="eeeeee" colspan="8"> 
            <div align="left">审核后SP信息列表：</div>
            </td>
        </tr>               
        <tr bgcolor="#eeeeee"> 
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">业务代码:</div>
          </td>
          <td colspan="7" bgcolor="eeeeee"> 
          <input type="text" name="operator_code" value="" size=20 >	
          </td>
        </tr>
        <tr bgcolor="#eeeeee"> 
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">业务产品名称：</div>
          </td>
          <td colspan="7" bgcolor="eeeeee"> 
          <input type="text" name="operator_name" value="" size=60>	
          </td>
        </tr>
        <tr bgcolor="#eeeeee"> 
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">业务类型：</div>
          </td>
          <td colspan="1" bgcolor="eeeeee"> 
          <input type="text" name="serv_type" value="" size=11>	
          </td>
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">业务属性：</div>
          </td>
          <td colspan="1" bgcolor="eeeeee"> 
          <input type="text" name="serv_attr" value="" size=20>	
          </td>
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">包次次数/包天天数：</div>
          </td>
          <td colspan="3" bgcolor="eeeeee"> 
          <input type="text" name="count" value="" size=20>	
          </td>
        </tr>
         <tr bgcolor="#eeeeee"> 
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">计费类型：</div>
          </td>
          <td colspan="1" bgcolor="eeeeee"> 
          <input type="text" name="bill_flag" value="" size=11 maxlength=3>	
          </td>
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">其他结算方式1：</div>
          </td>
          <td colspan="1" bgcolor="eeeeee"> 
          <input type="text" name="other_bal_obj1" value="" size=11 maxlength=3>	
          </td>
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">其他结算方式2：</div>
          </td>
          <td colspan="3" bgcolor="eeeeee"> 
          <input type="text" name="other_bal_obj2" value="" size=11>	
          </td>
        </tr>
        <tr bgcolor="#eeeeee"> 
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">生效日期：</div>
          </td>
          <td colspan="1" bgcolor="eeeeee"> 
          <input type="text" name="valid_date" value="" size=14>	
          </td>
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">失效日期：</div>
          </td>
          <td colspan="3" bgcolor="eeeeee"> 
          <input type="text" name="expire_date" value="" size=14>	
          </td>
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">算比例：</div>
          </td>
          <td colspan="1" bgcolor="eeeeee"> 
          <input type="text" name="bal_prop" value="" size=10>	
          </td>
        </tr>       
        <tr bgcolor="eeeeee"> 
        <td nowrap width="10%"> 
          <div align="left">系统备注：</div>
        </td>
        <td nowrap colspan="7"> 
          <div align="left"> 
            <input type="text" class="button" name="systemNote" id="systemNote" size="60" readonly maxlength=60>
          </div>
        </td>
      </tr>
      <tr bgcolor="eeeeee"> 
        <td nowrap width="10%"> 
          <div align="left">用户备注：</div>
        </td>
        <td nowrap colspan="7"> 
          <div align="left"> 
            <input type="text" class="button" name="opNote" id="opNote" size="60" v_maxlength=60  v_type=string  v_name="用户备注" index="28" maxlength=60>
          </div>
        </td>
      </tr>
      <tr bgcolor="eeeeee"> 
                  <td nowrap colspan="8"> 
                    <div align="center"> 
                      <input class="button" type="button" name="b_print" value="确认" onClick="printCommit()" index="29">
                      <input class="button" type="button" name="b_clear" value="清除" onClick="frm.reset();" index="30">
                      <input class="button" type="button" name="b_back" value="返回" onClick="location='f9107_1.jsp'" index="31">
                    </div>
                  </td>
      </tr>
</table>          
<%@ include file="/include/footer.jsp"%>	
</form>	 	
</body>	
</html>
