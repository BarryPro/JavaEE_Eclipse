<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-22 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>


<%
		String opName = "普通开户";
		String opCode = "1104";
		String groupId =(String)session.getAttribute("groupId");
    int chPos = 0;
    String typeStr = "";
    String inputStr = "";
    String valueStr = "";  
    String sys_Date = "";
    String showType = "";

		String  sqlStr = "select to_char(sysdate,'YYYYMMDD') as sys_Date from dual";
%>
		<wtc:pubselect name="sPubSelect" retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="sysDateArr" scope="end" />
<%
		if(sysDateArr!=null&&sysDateArr.length>0){
				sys_Date = sysDateArr[0][0];	
		}
/*
 [sfunclist]
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 REGION_CODE                               NOT NULL CHAR(2)
 SM_CODE                                   NOT NULL CHAR(2)
 FUNCTION_TYPE                             NOT NULL CHAR(1)
 FUNCTION_CODE                             NOT NULL CHAR(2)
 FUNCTION_NAME                             NOT NULL CHAR(20)
 COMMAND_CODE                              NOT NULL CHAR(2)
 FUNCTION_FEE                              NOT NULL NUMBER(19,4)
 DEFAULT_ADD_FLAG                          NOT NULL CHAR(1)
 ORDER_CODE                                NOT NULL NUMBER(5)
 SHOW_FLAG                                 NOT NULL CHAR(1)
 PREPAY_LIMIT                              NOT NULL NUMBER(19,4)
 BEGIN_FLAG                                NOT NULL CHAR(1)
 END_FLAG                                  NOT NULL CHAR(1)
 MONTH_LIMIT                               NOT NULL NUMBER(5)
 ADD_FLAG                                  NOT NULL CHAR(1)
 ADDNO_FLAG                                NOT NULL CHAR(1)
 NET_TYPE                                  NOT NULL CHAR(1)
 FUNCTION_RATE                                      NUMBER
 代码 名称 月费 预存 开始时间 结束时间 开通标志 附加号码 查询 
*/
    String pageTitle = request.getParameter("pageTitle");
    String fieldNum = "";
    String fieldName = "代码|名称|月费|预存|开始时间|结束时间|附加号码|";
    String orgCode = request.getParameter("orgCode");
    String smCode = request.getParameter("smCode");
    String modeCode = request.getParameter("modeCode");
    String belongCode = request.getParameter("belongCode");
    String regionCode = request.getParameter("regionCode");

    showType = request.getParameter("showType");   //显示类型 All：显示全部;Default:只显示默认的   
    String tital = request.getParameter("pageTitle");   //显示类型 All：显示全部;Default:只显示默认的   
		//System.out.println("2222222222222:" + showType + smCode+orgCode+belongCode+regionCode+modeCode);
		if(showType == null || showType.compareTo("Default") == 0) //只显示默认特服时的列标题
		{	fieldName = "代码|名称|月费|预存|";		}    
    /*
    String sqlStr = "select FUNCTION_CODE,FUNCTION_NAME,FUNCTION_FEE," + 
                    "PREPAY_LIMIT,ADDNO_FLAG from sfunclist where REGION_CODE ='" + regionCode + 
                    "' and SM_CODE='" + smCode + "'";   
    */                                  
    String selType = "M";
    if(selType.compareTo("S") == 0)
    {   selType = "radio";    }
    if(selType.compareTo("M") == 0)
    {   selType = "checkbox";   }
%>

<HTML><HEAD><TITLE>黑龙江移动BOSS<%=pageTitle%></TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312"></HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<BODY>

<SCRIPT type=text/javascript>
	
	$(function(){
		$("*[classCode]")&&$("*[classValue]").each(function(){
			$(this).tooltip();
		}); 
	}); 
	
function check()
{	//特服数据有效性判断
    /*
    1、预约开通 
		必须输入开始时间，和结束时间
		开始时间不能大于结束时间
		开始时间不能小于系统时间
		不能输入附加号码
	2、立即开通
		只输入结束时间为立即开通
		不能输入附加号码
	3、有短号码开通
		必须ADDNO_FLAG 为 ‘Y’
		不能输入开始时间和结束时间
	*/	

}
//-------------------------------------------------------------------
function turnToDepend()
{
    var OneInFour=0;
		var OneInTwo=0;
	
		var retCode_Now = "";
		var retCode_After = "";
		var retCode_AddNo = "";
		var retName_Now = "24小时之内生效特服：";
		var retName_After = "预约特服：";
		var retName_AddNo = "带附加号码特服：";
		var tempCode = "";
		var tempName = "";
		var tempStr = "";   
		var sys_Date = "<%=sys_Date%>";
		var totalPrepay = 0;
	//代码|名称|费用|预存|开始时间|结束时间|附加号码|

	for(var i=0;i<pubService.elements.length;i++)
	{ 
		if (pubService.elements[i].name=="List")
		{    //判断是否是单选或复选框
			if((pubService.elements[i].checked==true))//&&(pubService.elements[i].disabled == false))
			{   							
			    //判断是否被选中
 				rIndex = pubService.elements[i].RIndex;
 				objCode = "Rinput" + rIndex + 1;
 				objName = "Rinput" + rIndex + 2;
 				objFee = "Rinput" + rIndex + 3;
 				objPreFee = "Rinput" + rIndex + 4;
				objBegin = "Rinput" + rIndex + 5; 
				objEnd = "Rinput" + rIndex + 6; 
				objAdd = "Rinput" + rIndex + 7; 
				totalPrepay = totalPrepay + parseInt(document.all(objPreFee).value);

				if(document.all(objName).value=="本地市漫游" || document.all(objName).value=="省内漫游" || document.all(objName).value=="全国漫游" || document.all(objName).value=="国际漫游")
				{
				  OneInFour++;
				}

				if(document.all(objName).value=="国内直拨" || document.all(objName).value=="国际直拨")
				{
				  OneInTwo++;
				}

				if((document.all(objAdd).type == "text")&&(document.all(objAdd).value != ""))
				{						
					//判断有附加号码,则不能输入开始时间和结束时间
					if((document.all(objEnd).value != "")||(document.all(objBegin).value != ""))
					{
						rdShowMessageDialog("有附加号码的特服信息不能输入开始时间和结束时间！");
						document.all(objBegin).value = "";
						document.all(objEnd).value = "";
						return false;
					}
					else
					{
						retCode_AddNo = retCode_AddNo + document.all(objCode).value + 
						                document.all(objAdd).value + "|";
						retName_AddNo = retName_AddNo + "[" + 
						                document.all(objName).value + "]";                						
					}
				}
				else
				{
					
					beginDate = document.all(objBegin).value.trim();
					endDate = document.all(objEnd).value.trim(); 
					//立即生效特服（只输入结束时间，或开始、结束时间都不输入）   
					if(beginDate == "")
					{	
						retCode_Now = retCode_Now + document.all(objCode).value + endDate + "|";
						retName_Now = retName_Now + "[" + 
						                document.all(objName).value + "]";    						              
					}
					//预约特服（开始时间、结束时间都必须输入，开始时间要小于结束时间）
					if((beginDate != "")&&( endDate != ""))
					{	
						if(checkElement(objBegin)!= true)
						{	
						    document.all(objBegin).value = "";
							return false;	
						}	
						if(checkElement(objEnd)!= true)
						{	
						    document.all(objEnd).value = "";
							return false;	
						}											
						if(beginDate > endDate)
						{
							rdShowMessageDialog("开始时间应小于结束时间！");
							document.all(objBegin).value = "";
							document.all(objBegin).focus();
							return false;							
						}
						if(sys_Date > beginDate)
						{
							rdShowMessageDialog("特服的开始、结束时间都应该大于当前系统时间（系统时间：" + sys_Date + "）！");
							document.all(objBegin).value = "";
							document.all(objEnd).value = "";
							document.all(objBegin).focus();							
							return false;							
						}						
						retCode_After = retCode_After + document.all(objCode).value + 
						                document.all(objBegin).value + 
						                document.all(objEnd).value + "|";
						retName_After = retName_After + "[" + 
						                document.all(objName).value + "]"; 						                
					}
									
				}                         
			}
		}
	}
	
/*
	if(OneInFour<1)
	{
       	rdShowMessageDialog("本地市漫游，省内漫游，全国漫游，国际漫游之中必须选择一种！");
	 	return false;
	}

	if(OneInFour>1)
	{
       	rdShowMessageDialog("本地市漫游，省内漫游，全国漫游，国际漫游之中只能选择一种！");
	 	return false;
	}

	if(OneInTwo<1)
	{
       	rdShowMessageDialog("国内直拨，国际直拨之中必须选择一种！");
	 	return false;
	}

	if(OneInTwo>1)
	{
       	rdShowMessageDialog("国内直拨，国际直拨之中只能选择一种！");
	 	return false;
	}
*/

    var retCode = retCode_Now + "&" + retCode_After + "&" + retCode_AddNo + "&"; 
	var retName = retName_Now + retName_After + retName_AddNo;
    if(retCode == "")
    {	
    	rdShowMessageDialog("请选择特服信息！");
    	return false;
    }
    var retInfo = retCode + "~" + totalPrepay + "#"+ retName;
    window.returnValue= retInfo;  
    window.close(); 

}
//-----------------------------------------------
function queryPhoneNo(retToField_Name)
{
	var belongCode = "<%=belongCode%>";
	var district_code = belongCode.substring(2,3);
	var town_code = belongCode.substring(4,6);
	var sqlStr = "select phone_no from dcustRes where " + 
	             " region_code = substr('" + belongCode + "',1,2) and " + 
	             " (district_code = substr('" + belongCode + "',1,2) or district_code = '99') and " + 
	             " (town_code = substr('" + belongCode + "',1,2) or town_code = '999') and " +
	             " no_type='c' and resource_code='0' and rownum < 11";
    var pageTitle = "附加号码查询";
    var fieldName = "附加号码|";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "1|0|";
    var retToField = retToField_Name + "|";
    PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField); 
}
//------------------------------------------------
function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{   //公共查询

    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
    var retInfo = window.showModalDialog(path);
    if(typeof(retInfo)=="undefined")    
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
}
//-------------------------------------------------
function allChoose()
{   //复选框全部选中
    for(i=0;i<pubService.elements.length;i++)
    { 
        if(pubService.elements[i].type=="checkbox")
        {    //判断是否是单选或复选框
            if(pubService.elements[i].disabled == false)
            {   pubService.elements[i].checked = true;	}
        }
    }  
}
function cancelChoose()
{   //取消复选框全部选中
    for(i=0;i<pubService.elements.length;i++)
    { 
        if(pubService.elements[i].type =="checkbox")
        {    //判断是否是单选或复选框
            if(pubService.elements[i].disabled == false)
            {   pubService.elements[i].checked = false;		}
        }
    }  
}
</SCRIPT>

<!--**************************************************************************************-->
</HEAD>
<BODY>
<FORM method=post name="pubService">
<%@ include file="/npage/include/header_pop.jsp" %>
  <table cellspacing="0">
    <tr>
<%  //绘制界面表头  
     chPos = fieldName.indexOf("|");
     out.print("<TR align='center'>");
     String titleStr = "";
     int tempNum = 0;
     while(chPos != -1)
     {  
        valueStr = fieldName.substring(0,chPos);
        titleStr = "<th>&nbsp;&nbsp;" + valueStr + "</th>";
        out.print(titleStr);
        fieldName = fieldName.substring(chPos + 1);
        tempNum = tempNum +1;
        chPos = fieldName.indexOf("|");
     }
     out.print("</TR>");
     fieldNum = String.valueOf(tempNum);
     
%> 

<%
    //根据传人的Sql查询数据库，得到返回结果
    		fieldNum = "6";
    		
    		String choiceFlag = "0";
        //retArray = callView.view_sGetOpenFunc(orgCode,smCode,modeCode);
 %>
 				
		 	<wtc:service name="sGetOpenFunc" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="8" >
			<wtc:param value="<%=orgCode%>"/>
			<wtc:param value="<%=smCode%>"/>
			<wtc:param value="<%=modeCode%>"/>
			</wtc:service>
			<wtc:array id="retInfo" start="0" length="2" scope="end"/>
			<wtc:array id="result" start="2" length="6" scope="end"/>
 <%
      		if((retInfo[0][0]).compareTo("000000") == 0)
      		{
      			/**
						for(int i=0;i<result.length;i++){
							for(int j=0;j<result[i].length;j++){
								System.out.println("#################################result["+i+"]["+j+"]->"+result[i][j]);
							}
						}
						**/
						
						/**依据注意事项库,添加"事中提示";
							*classCode为10431,代表"特服";
							*请查阅相关文档,以确定classCode的值;
							**/
						String [] classValueArr = new String[result.length];
						String classCode = "10431";
						
						/**服务需要classValue的一维数组**/
						if(result!=null){
							for(int i=0;i<result.length;i++){
								classValueArr[i] = result[i][1];
							}
						}
%>
						<!--这个服务根据输入参数,输出事中提示内容-->
						<wtc:service name="s9611Cfm2" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="ret_code" retmsg="ret_message"  outnum="4" >
				    <wtc:param value="<%=opCode%>"/>
				    <wtc:param value="1"/>
				    <wtc:param value="12"/>
				    <wtc:param value="<%=groupId%>"/>
				 		<wtc:params value="<%=classValueArr%>"/>
				    <wtc:param value="<%=classCode%>"/>
				    <wtc:param value="<%=regionCode%>"/>
				    <wtc:param value="<%=smCode%>"/>
						</wtc:service>	
						<wtc:array id="s9611Cfm2Arr" scope="end" />				
<%
								
	      		String addNo_Flag = "N";  //附加号码标志
	      		int recordNum = result.length;
	      		outer: for(int i=0;i<recordNum;i++)
	      		{
	      		
	      			/**依据注意事项库,添加"事中提示"**/
	      			String insertImpPromptStr = "";
	      			String impPromptStr = "";
	      			int pos=0;
	      			if(ret_code.equals("000000")){
	      				if(s9611Cfm2Arr!=null){
	      					for(int m=0;m<s9611Cfm2Arr.length;m++){ //如果它们(classValue)的值一样.则拼成串.加在tr或者input中
      							if(s9611Cfm2Arr[m][2].equals(result[i][1])){//实际上,s9611Cfm2Arr[m][2]的值(classValue)在s9611Cfm2Arr中可能有重复的.
      									if(m==0)
      									{
      										impPromptStr += s9611Cfm2Arr[m][2]+"-"+s9611Cfm2Arr[m][3]+"<br/>"
      																+(pos+1)+"."+s9611Cfm2Arr[m][0]+"<br/>";
      									}else
												{
													if(s9611Cfm2Arr[m][2].equals(s9611Cfm2Arr[m-1][2]))//同一code
													{
														impPromptStr +=(pos+1)+"."+s9611Cfm2Arr[m][0].trim()+"<br/>";
													}else //新一条code
													{
														pos=0;
														impPromptStr +=s9611Cfm2Arr[m][2].trim()+"-"+s9611Cfm2Arr[m][3].trim()+"<br/>"
																   +(pos+1)+"."+s9611Cfm2Arr[m][0].trim()+"<br/>";
													}
												}
      							pos++;
      							}
      							
	      					}
	      				}
	      			}
	      			
	      			/**这个拼接的参数将写入tr或者input**/
	      			insertImpPromptStr += "class='promptBlue' title='"+impPromptStr+"' classCode='"+classCode+"'  classValue='"+result[i][1]+"' ";
      				//System.out.println("###############insertImpPromptStr->"+insertImpPromptStr);
      				
	      		    typeStr = "";
	      		    inputStr = "";
	      		    choiceFlag = "0";
	      		    if(showType.compareTo("Default") == 0)
	      		    {	//只显示默认特服
	      		    	//========================================================
		      		    for(int j=0;j<Integer.parseInt(fieldNum);j++)
		      		    {
			                    if(j==0)
			                    {
			                    	choiceFlag = result[i][j];
			                    	if(choiceFlag.compareTo("1") != 0 && choiceFlag.compareTo("2") != 0)
			                    	{	continue outer;	}
			                    	out.print("<TR align='center' "+insertImpPromptStr+">");
			                    }
			                    else if(j==1)
			                    {
			                        //复选框
			                        typeStr ="<TD>&nbsp;<input type='" + selType +  
			          		            "' name='List' style='cursor:hand' RIndex='" + i + "'" +  
			                            "onkeydown='if(event.keyCode==13)turnToDepend();'";
			                        //判断是否是默认特服
			                        if(choiceFlag.compareTo("1") == 0 || choiceFlag.compareTo("2") == 0)
			                        {  	typeStr = typeStr + "checked disabled"; }  
			                        typeStr = typeStr + ">";    
			                        //代码信息    
			                        typeStr = typeStr + result[i][j] + "<input type='hidden' " +
			          		            " id='Rinput" + i + j + "'   value='" + 
			          		            result[i][j] + "'readonly></TD>";          		            
			                    }
			                    else if(j==5)
			                    {	addNo_Flag = result[i][j];	}
			                    else
			                    {        		        
			          		        inputStr = inputStr + "<TD>&nbsp;" + result[i][j] + 
			          		            "<input type='hidden' " +
			          		            " id='Rinput" + i + j + "'   value='" + 
			          		            result[i][j] + "'readonly></TD>";          		            
			                    }      		            
		      		    }
		                inputStr = inputStr + "</TD>";
		      		    out.print(typeStr + inputStr);
		      		    out.print("</TR>");	 		    	
	      		    	//========================================================
	      		    }
	      		    else
	      		    {	//显示全部特服
		      		    out.print("<TR align='center' "+insertImpPromptStr+">");
		      		    for(int j=0;j<Integer.parseInt(fieldNum);j++)
		      		    {
			                    if(j==0)
			                    {
			                    	choiceFlag = result[i][j];
			                    }
			                    else if(j==1)
			                    {
			                        //复选框
			                        typeStr ="<TD>&nbsp;<input type='" + selType +  
			          		            "' name='List' style='cursor:hand' RIndex='" + i + "'" +  
			                            "onkeydown='if(event.keyCode==13)turnToDepend();'";
			                        //判断是否是默认特服
			                        if(choiceFlag.compareTo("1") == 0)
			                        {  	typeStr = typeStr + "checked "; }
															else if(choiceFlag.compareTo("2") == 0)
                                    {  	typeStr = typeStr + "checked disabled "; }
															else if(choiceFlag.compareTo("3") == 0)
                                    {  	typeStr = typeStr + "disabled "; }

			                        typeStr = typeStr + ">";    
			                        //代码信息    
			                        typeStr = typeStr + result[i][j] + "<input type='hidden' " +
			          		            " id='Rinput" + i + j + "'   value='" + 
			          		            result[i][j] + "'readonly></TD>";          		            
			                    }
			                    else if(j==5)
			                    {	addNo_Flag = result[i][j];	}
			                    else
			                    {        		        
			          		        inputStr = inputStr + "<TD>&nbsp;" + result[i][j] + 
			          		            "<input type='hidden' " +
			          		            " id='Rinput" + i + j + "'   value='" + 
			          		            result[i][j] + "'readonly></TD>";          		            
			                    } 
			                    tempNum = j -1;        		            
		      		    }
		      		    for(int n=0;n<2;n++)
		      		    {
			      		    tempNum = tempNum + 1;
			      		    inputStr = inputStr + "<TD>&nbsp;<input v_type='date' v_must=0 type='text' " +
			          		            " id='Rinput" + i + tempNum + "'   maxlength=8>&nbsp;&nbsp;";
		                } 
		                tempNum = tempNum + 1;
		                if(addNo_Flag.compareTo("Y") == 0)
		                {
		                	//查询按钮
		                	inputStr = inputStr + "<TD>&nbsp;<input type='text' " +
			          		            " id='Rinput" + i + tempNum + "'  >&nbsp;&nbsp;";
			                inputStr = inputStr + "<input name=custIdQuery type=button " + 
			                           " onClick= queryPhoneNo('Rinput" + i + tempNum + 
			                           "') class='b_text' style='cursor:hand' " + 
			                           " id='Query" + i + tempNum + "' value=查询>";                    
			            }
			            else
			            {	
			          		inputStr = inputStr + "<TD>&nbsp;无<input type='hidden' " +
			          		            " id='Rinput" + i + tempNum + "'   value=''" + 
			          		            " readonly></TD>"; 	            	
			            }
		                inputStr = inputStr + "</TD>";
		      		    out.print(typeStr + inputStr);
		      		    out.print("</TR>");
		      		}
						}	      		    
     			}
 
%>   
   </tr>
  </table>


<!------------------------------------------------------>
    <TABLE cellSpacing="0">
    <TBODY>
        <TR> 
            <TD id="footer">
<%
    if(selType.compareTo("checkbox") == 0)
    {           
        out.print("<input class='b_foot' name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=全选>&nbsp");
        out.print("<input class='b_foot' name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=取消全选>&nbsp");       
    } 
%>         
                <input class="b_foot" name=commit onClick="turnToDepend()" style="cursor:hand" type=button value=确认>&nbsp;
                <input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value=返回>&nbsp;
            </TD>
        </TR>
    </TBODY>
    </TABLE>      
  <!------------------------> 
  <input type="hidden" name="modeCode" >
  <input type="hidden" name="modeName" >
  <!------------------------>  
  <%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY></HTML>    
