<%
   /*
   * 功能: 串号查询的详细页面(1104用到)
　 * 版本: v2.0
　 * 日期: 2006-10-16 19:20
　 * 作者: gaohr
　 * 版权: sitech
   * 修改历史
   * 修改日期      		修改人      修改目的
   * 2009-03-18         chengwen       添加租机费用   
 　*/
%>
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%!
    //得到输入参数
    ArrayList retArray = new ArrayList();
    String return_code,return_message;
    String[][] result = new String[][]{};
%> 	
<%
		ArrayList arr1 = (ArrayList)session.getAttribute("allArr");
		String[][] baseInfoSession = (String[][])arr1.get(0);
		
		String workNo=(String)session.getAttribute("workNo");	
		opCode="qp01";	
		String GroupId = baseInfoSession[0][21];
		String phoneNo=WtcUtil.repNull(request.getParameter("phoneNo"));
    String loginPwd    = (String)session.getAttribute("password");
		String power_right = baseInfoSession[0][5].trim();
		
 		String[][] favInfo = (String[][])arr1.get(3);
 		
		String machinePreFee_Favourable = "readonly";        //a282  租机预存优惠权限
		String machineDeposit_Favourable = "readonly";       //a283  租机押金优惠权限
		String machineFee_Favourable = "readonly";       //a283  租机机器优惠权限
		
for(int i = 0 ; i < favInfo.length ; i ++){

			if(favInfo[i][0].trim().equals("a282")){
				machinePreFee_Favourable = "";
			}//对租机预存优惠权限判断
			if(favInfo[i][0].trim().equals("a283")){
				machineDeposit_Favourable= "";
			}//对租机押金优惠权限判断
			if(favInfo[i][0].trim().equals("a284")){
				machineFee_Favourable= "";
			}//对租机押金优惠权限判断
		
		}
%>
		
<wtc:service name="s1256Init" outnum="80">
		
		<wtc:param value=" "/>
		<wtc:param value=" "/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>	
		<wtc:param value="<%=loginPwd%>"/>		
		<wtc:param value="<%=phoneNo%>"/>	
		<wtc:param value=" "/>
			
</wtc:service>

	<%
	if(!retCode.equals("000000"))
  {
  %>
  		<script language="javascript">
  			rdShowMessageDialog("失败["+'<%=retCode%>'+"]:"+'<%=retMsg%>');
  			window.close();
  		</script>
 <%
 	}
	%>
		
<%

/*
SQL语句        sql_content
选择类型       sel_type   
标题           title      
字段1名称      field_name1
*/
    String imeiNo = request.getParameter("imeiNo");
    String pageTitle = request.getParameter("pageTitle");
    String fieldNum = "";
    String fieldName = request.getParameter("fieldName");
    String sqlStr = request.getParameter("sqlStr");
    System.out.println("sql ******************* "+sqlStr);
    String selType = request.getParameter("selType");
    String retQuence = request.getParameter("retQuence");    
    String regionCode = request.getParameter("regionCode");
    String smCode = request.getParameter("smCode");
    
    if(selType.compareTo("S") == 0)
    {   selType = "radio";    }
    if(selType.compareTo("M") == 0)
    {   selType = "checkbox";   }
    //=====================
    int chPos = 0;
    String typeStr = "";
    String inputStr = "";
    String inputStr2 = "";
    String inputStr3 = "";
    String inputStr4 = "";
    String inputStr5 = "";
    String valueStr = "";
    
    String[] fieldNames={"模版","模版名称","合同期限(月)","销售价格(元)","在网年限(月)","押金(元)","在网金额(元)","预存话费(元)","月消费底线(元)","资费套餐","本地话费比率"}; 
    String resName = "";
/*    
    String selType = "";
    String pageTitle = "";
    
    String fieldNum = "2";
    String sqlStr = request.getParameter("sqlStr");
    String fieldName = "标识|名称|性别|年龄|";
        
*/    
%>
<wtc:pubselect  name="sPubSelect"  outnum="1">
	<wtc:sql>select r.res_name from dChnResMobInfo m ,sChnResCode r where m.imei_no=upper('?') and m.res_code=r.res_code</wtc:sql>
	<wtc:param value="<%=imeiNo%>"/>
</wtc:pubselect>
<wtc:array id="rows1">
        <%
        	if (rows1.length!=0 && rows1[0].length!=0){
				resName=rows1[0][0];
				//System.out.println("resName---------------------------------------- "+resName);
				%>
				<wtc:pubselect   name="sPubSelect"  outnum="1">
					<wtc:sql>SELECT COUNT(1)  FROM DCHNRESMOBINFo WHERE group_id in (select group_id from dchngroupinfo where parent_group_id='?') AND imei_no ='?'</wtc:sql>
					<wtc:param value="<%=GroupId%>"/>
					<wtc:param value="<%=imeiNo%>"/>
				</wtc:pubselect>
				<wtc:array id="rows2" scope="end"/>
				
				<%
				if(rows2.length ==0 ||rows2[0][0].equals("0")) 
					{//-----
					%>
				<script language="javascript">
					alert("手机归属不正确");
					window.close();
				</script>
				<%}
					else{%>
					<wtc:pubselect   name="sPubSelect"  outnum="1">
					<wtc:sql>SELECT COUNT(1)  FROM DCHNRESMOBINFo WHERE group_id in (select group_id from dchngroupinfo where parent_group_id='?') AND imei_no ='?'  AND status_code in('10','11','20','21')</wtc:sql>
					<wtc:param value="<%=GroupId%>"/>
					<wtc:param value="<%=imeiNo%>"/>
				</wtc:pubselect>
				<wtc:array id="rows3" scope="end"/>
						
						<%
							if(rows3.length ==0 ||rows3[0][0].equals("0")) {							
												%>
								<script language="javascript">
									alert("手机状态不可用");
									window.close();
								</script>
								<%}
							}
						}			  
			else {
				resName = "未知的手机型号";
				%>
				<script language="javascript">
					alert("该号码无租机模版信息");
					window.close();
				</script>
				<%
				}
		%>
</wtc:array>

<HTML><HEAD><TITLE>山西电信-<%=pageTitle%></TITLE>
	<base target="_self">
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<BODY bgColor=#FFFFFF leftmargin="0" topmargin="0">

<SCRIPT type=text/javascript>

onload=function()
{

}
function doProcess(packet)
{	
    //RPC处理函数findValueByName
	var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode"); 
    var retMessage = packet.data.findValueByName("retMessage");	
    self.status="";

 	if(jtrim(retCode)=="")
	{
      	rdShowMessageDialog("调用"+retType+"服务时失败！");
      	return false;
	}
	if(retType == "billmodeflag")
	{
		if(retCode=="000000")
	  	{
	  		var triListData = packet.data.findValueByName("tri_list"); 
	    	var triList=new Array(triListData.length);
			triList[0]="chnModeCode";
			document.all("chnModeCode").length=0;
			document.all("chnModeCode").options.length=triListData.length;//triListData[i].length;
			for(j=0;j<triListData.length;j++)
			{
			document.all("chnModeCode").options[j].text=triListData[j][1];
			document.all("chnModeCode").options[j].value=triListData[j][0];
			}
	  		
			
		}
	}
}
function chgModeCode()	
{
		var RinputIndex=document.all.RinputIndex.value;
		var chnModeCode=document.all.chnModeCode.value;

		var chnModeCode1=chnModeCode.substring(0,chnModeCode.indexOf("|"));
		
		var chnModeCode2=chnModeCode.substring(chnModeCode.indexOf("|")+1);

		document.all("Rinput"+RinputIndex+"-9").value=chnModeCode1;
		alert("Rinput"+RinputIndex+"-9");
		alert(document.all("Rinput"+RinputIndex+"-9").value);
		document.all.modeCodeName.value=chnModeCode2;
		
}
function resDetail(bindcode)	
{
		var pageTitle = "绑定资源明细";
	    var fieldName = "组织机构|资源绑定模板|资源|销售单价|绑定数量|主资源标志|";
		
		var sqlStr ="SELECT b.group_name,c.mode_name,d.res_name,a.SALE_PRICE,a.BIND_NUM,a.PRIMARY_FLAG "+
								" FROM sChnResBindModeItem a,dchngroupmsg b, sChnResBindMode c,schnrescode d  "+
								" WHERE a.BIND_MODE='"+bindcode+"'  "+
								" and a.group_id=b.group_id  "+
								" and a.bind_mode=c.bind_mode "+
								" and a.res_code=d.res_code ";
		var selType ='N';
		
	    var retQuence = "6|0|1|2|3|4|5|";
	    var retToField = "teamRelation|";
		PubSimpSel_self1(pageTitle,fieldName,sqlStr,selType,retQuence,retToField); 	
}
function PubSimpSel_self1(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,valueStr)
{

    var path = "<%=request.getContextPath()%>/page/public/fPubSimpSel.jsp";
    //var path = "../public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
	path = path + "&inStr=" + valueStr; 

    retInfo = window.showModalDialog(path,"","dialogWidth:45;dialogHeight:35;");
    if(typeof(retInfo) == "undefined")     
    {   return false;   }
    var chPos_retInfo = retInfo.indexOf("|");
    var valueStr;
    var tmpStr="";
    var flag=0;


    
    document.form1.teamRelation.value =retInfo;
    
}
function fillBillMode(i,sale_mode)
{	

	 document.all.sale_mode.value = sale_mode;
}
function saveTo()
{

      var rIndex;        //选择框索引
      var retValue = ""; //返回值
      var chPos;         //字符位置
      var obj;
      var obj2;
      var retValue2 = ""; //返回值2,用于主页面显示套餐
      var retValue3 = ""; //
      var retValue33 = "";
      var retValue5 = "0"; //押金
      var retValue7 = "0"; //预存
      var fieldNo;        //返回域序列号
      var retFieldNum = document.fPubSimpSel.retFieldNum.value;
      var retQuence = document.fPubSimpSel.retQuence.value;  //返回字段域的序列
      var retNum = retQuence.substring(0,retQuence.indexOf("|"));
      retQuence = retQuence.substring(retQuence.indexOf("|")+1);
      
      var tempQuence;
      if(retFieldNum == "")	
      {     return false;   }
       //返回单条记录
       //alert(retNum);
          for(i=0;i<document.fPubSimpSel.elements.length;i++)
          { 
    		      if (document.fPubSimpSel.elements[i].name=="List")
    		      {    //判断是否是单选或复选框
    				   if (document.fPubSimpSel.elements[i].checked==true)
    				   {     //判断是否被选中
        				    //alert(document.fPubSimpSel.elements[i].value);
        			         rIndex = document.fPubSimpSel.elements[i].RIndex;
        			         tempQuence = retQuence;
        			         for(n=0;n<retNum;n++)
        			         {   
        			            chPos = tempQuence.indexOf("|");
        			            fieldNo = tempQuence.substring(0,chPos);

        			            obj = "Rinput" + rIndex +"-"+ fieldNo;

        			            if (fieldNo==3) 
        			            {	
        			            	retValue33=document.all(obj).value;
        			            }
        			            if (fieldNo==5) 
        			            {	
        			            	retValue5=document.all(obj).value;
        			            }
        			            if (fieldNo==7) 
        			            {	
        			            	retValue7=document.all(obj).value;
        			            }
        			            if (fieldNo==9) 
        			            {	

        			            	retValue2=document.all.modeCodeName.value+"("+document.all(obj).value+")";
        			            	retValue3=document.all(obj).value;
        			            	
        			            }
        			            if(fieldNo!=9) 
        			            retValue = retValue + document.all(obj).value + "~";
        			            
        			            tempQuence = tempQuence.substring(chPos + 1);
        			         }
    
                             retValue=retValue+document.all.mobRentCode.value + "~";   
                                  
                            //rdShowMessageDialog(retValue);                    
        					 window.returnValue= retValue;
        					

                       }
    		    }
    		}
    		var obj33 = window.dialogArguments;
  			
  			obj33.rentDeposit.value = retValue5;
  			obj33.rentCostPre.value = retValue7;

            /* added by ranlf at 2007-07-24 添加租机费用  begin*/

			obj33.hid_rentDeposit.value = retValue5 ;
			obj33.hid_rentCostPre.value  = retValue7 ;
			obj33.hid_sale_mode.value= document.all.sale_mode.value;
			/* added by ranlf at 2007-07-24 添加租机费用  end*/
  	
		if(retValue =="")
		{
		    rdShowMessageDialog("请选择模板！",0);
		    return false;
		}
window.close(); 
}
</SCRIPT>

<!--**************************************************************************************-->
</HEAD>
<BODY>
<div id="operation">
<FORM method=post name="fPubSimpSel">
 <div id="operation_table">
 		<div class="input">	
  <table>
<wtc:sequence name="sPubSelect" key="s_termcontract_id"  id="seq"/>

<TR> 
  	<th nowrap >&nbsp;&nbsp;租机协议号：</th>
	<TD nowrap ><span  class="red">* 
     	<%=seq%></span>
   	</TD>
    <th nowrap >手机串号：</th>
	<TD nowrap ><span  class="red">*
     	<%=imeiNo%></span>
   	</TD>
   	<th nowrap >手机型号：</th>
	<TD nowrap ><span  class="red">* 
     	<%=resName%></span>
   	</TD>
</TR>  	
<TR> 
  
    <th nowrap >租机类型：</th>
	<TD nowrap  colspan="5">
		<select name="mobRentCode">
		<wtc:qoption  name="sPubSelect"  outnum="2">
			<wtc:sql>select rent_code,rent_code||'->'||rent_name from smobrentcode  where valid_flag='1' </wtc:sql>
		</wtc:qoption>
		</select>
   	</TD>
</TR>  	
    <tr>
<%  //绘制界面表头  
/*
     chPos = fieldName.indexOf("|");
     out.print("<TR bgcolor='EEEEEE' height=25> ");
     String titleStr = "";
     int tempNum = 0;
     while(chPos != -1)
     {  
        valueStr = fieldName.substring(0,chPos);
        titleStr = "<TD>&nbsp;&nbsp;" + valueStr + "</TD>";
        out.print(titleStr);
        fieldName = fieldName.substring(chPos + 1);
        tempNum = tempNum +1;
        chPos = fieldName.indexOf("|");
     }
     out.print("</TR>");
     fieldNum = String.valueOf(tempNum);
     */
%> 

<%
    //根据传人的Sql查询数据库，得到返回结果
	try
 	{
 	
%>
<wtc:pubselect   name="sPubSelect"  outnum="<%=String.valueOf(WtcUtil.countSqlCol(sqlStr))%>">
	<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="rows">
	<% 
		//System.out.println("rows.length-------------->   "+rows.length);
		if (rows.length==0 || rows[0].length==0) result=null;
		else 
			result = rows; 
		
		
	%>
</wtc:array>	 
 	
<% 	
      		int recordNum = result.length;
      		
      		for(int i=0;i<recordNum;i++)
      		{
      		    typeStr = "";
      		    inputStr = "";
      		    inputStr2 = "";
      		    inputStr3 = "";
      		    inputStr4 = "";
      		    inputStr5 = "";
      		    out.print("<TR bgcolor='#D5EEF1'>");
      		    
                   
                        typeStr ="<TD>&nbsp;<input type='" + selType +  
          		            "' name='List' style='cursor:hand' RIndex='" + i + "' value='" +  result[i][0] + "'"+
                            "onClick='fillBillMode("+i+",this.value);' onkeydown='if(event.keyCode==13)saveTo();'" + ">";
                        typeStr = typeStr + " "+fieldNames[0]+(i+1)+"</TD><TD colspan='3'>"+result[i][0] +"->"+result[i][1]+"<input type='hidden' " +
          		            " id='Rinput" + i +"-"+ 0 + "' class='likebutton2' value='" + 
          		            result[i][0] + "'readonly><input type='hidden' " + " id='Rinput" + i +"-"+ 1 + "' class='likebutton2' value='" + 
          		            seq + "'readonly></TD>";          		            
                         		        
          		             		            
                        
          		              		            
      		    
      		    inputStr = inputStr + "<TD colspan='2'><a style='CURSOR: hand;' href='javascript:onclick=resDetail("+result[i][9]+");'  value='1'>绑定资源明细</a></TD>";
      		    out.print(typeStr + inputStr);
      		    out.print("</TR>");
      		    
      		    out.print("<TR bgcolor='#EEEEEE'>");
      		    
          		        inputStr2 = inputStr2 + "<TD>"+fieldNames[2]+"</TD><TD><input type='text' " +
          		            " id='Rinput" + i +"-"+ 2 + "'  value='" + 
          		            result[i][2] + "'readonly></TD>";      
          		        inputStr2 = inputStr2 + "<TD>"+fieldNames[3]+"</TD><TD><input type='text' " +
          		            " id='Rinput" + i +"-"+ 3 + "'  value='" + 
          		            result[i][3] + "' "+machineFee_Favourable+"></TD>";     
          		        inputStr2 = inputStr2 + "<TD>"+fieldNames[4]+"</TD><TD><input type='text' " +
          		            " id='Rinput" + i +"-"+ 4 + "'  value='" + 
          		            result[i][4] + "'readonly></TD>";          		            
      		    
      		    out.print(inputStr2);
      		    out.print("</TR>");
      		    
      		    out.print("<TR bgcolor='#EEEEEE'>");
      		    
          		        inputStr3 = inputStr3 + "<TD>"+fieldNames[5]+"</TD><TD><input type='text' " +
          		            " id='Rinput" + i +"-"+ 5 + "'  value='" + 
          		            result[i][5] + "' "+machineDeposit_Favourable+"></TD>";  
          		            
      		            inputStr3 = inputStr3 + "<TD>"+fieldNames[6]+"</TD><TD><input type='text' " +
      		            " id='Rinput" + i +"-"+ 6 + "'  value='" + 
      		            result[i][6] + "'readonly></TD>";  
      		            
      		            inputStr3 = inputStr3 + "<TD>"+fieldNames[7]+"</TD><TD><input type='text' " +
      		            " id='Rinput" + i +"-"+ 7 + "'  value='" + 
      		            result[i][7] + "' "+machinePreFee_Favourable+"></TD>";          		            
      		    
      		    out.print(inputStr3);
      		    out.print("</TR>");
      		    
      		    out.print("<TR bgcolor='#EEEEEE'>");
      		    
          		        inputStr4 = inputStr4 + "<TD>"+fieldNames[8]+"</TD><TD><input type='text' " +
          		            " id='Rinput" + i +"-"+ 8 + "'  value='" + 
          		            result[i][8] + "'readonly></TD>";         
          		             		            
      		    		inputStr4 = inputStr4 + "<TD>"+fieldNames[10]+"</TD><TD colspan=3><input type='text' " +
          		            " id='Rinput" + i +"-"+ 10 + "'  value='" + 
          		            result[i][10] + "'readonly></TD>";
          		        
          		        inputStr4 = inputStr4 + "<input type='hidden' " +
          		            " id='Rinput" + i +"-"+ 9 + "'  value='' readonly>";    
          		            
      		    out.print(inputStr4);
      		    
      		    for(int j=11;j<13;j++)
      		    {
          		        inputStr5 = inputStr5 + "<input type='hidden' " +
          		            " id='Rinput" + i +"-"+ j + "'  value='" + 
          		            result[i][j] + "'readonly>";          		            
      		    }
      		    out.print(inputStr5);
      		    out.print("</TR>");
      		    
      		}
     	}catch(Exception e){
       		
     	}          
%>
<%


%>   
   
   
   </tr>
  </table>
</div>
</div>

 
 <div id="operation_button">
 	<input class="b_foot" name=commit onClick="saveTo()" style="cursor:hand" type=button value=确认>&nbsp;
  <input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value=返回>&nbsp;
 </div>           
 
  <!------------------------> 
  <input type="hidden" name="retFieldNum" value="13">
  <input type="hidden" name="RinputIndex" value="">
  <input type="hidden" name="modeCodeName" value="">
  <input type="hidden" name="retQuence" value=<%=retQuence%>>
  <input type="hidden" name="sale_mode" value="">
  <!------------------------>  
</FORM>
</div>
</BODY></HTML>    
