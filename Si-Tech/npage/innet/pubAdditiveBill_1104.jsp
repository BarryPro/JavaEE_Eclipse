<%
/********************
 version v2.0
开发商: si-tech
update:liutong@2008.09.02
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>

<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>

<%
    HashMap hm=new HashMap();
    hm.put("0","普通");
    hm.put("1","默认");
    hm.put("2","绑定");
	hm.put("3","营销包");
	hm.put("4","多组选一");

	/*HashMap hm_grp=new HashMap();
    hm_grp.put("0","短信");
    hm_grp.put("1","彩信");
    hm_grp.put("2","GPRS");
	hm_grp.put("3","月租类型");
	hm_grp.put("4","最低消费");
	*/

	String[] flag1=new String[]{"否","否","否","否","否","否","否","否","否","否","否","否","否","否","否","否"};
	String[] flag3=new String[]{"否","否","否","否","否","否","否","否","否","否","否","否","否","否","否","否"};

    //得到输入参数
    String opCode = "1104";
	String opName = "普通开户";
	String pageTitle = request.getParameter("pageTitle");
    String modeCode = request.getParameter("modeCode");  
    String fieldNum = "";
    String orgCode = request.getParameter("orgCode");
    String regionCode = orgCode.substring(0,2);
    String districtCode = orgCode.substring(2,4);
    String smCode = request.getParameter("smCode");
	String machineCode=WtcUtil.repNull(request.getParameter("machineCode"));
    String machineType=request.getParameter("machineType");
	String existModeCode=request.getParameter("existModeCode");

	if(machineType==null) machineType="s";
    String sqlStr ="";
	if(machineType.equals("s"))
	{
	  sqlStr= "select b.MODE_TYPE,c.TYPE_NAME,a.ADD_MODE,b.MODE_NAME," + 
			  " a.CHOICED_FLAG,c.MAX_OPEN from cBillBaDepend a ," + 
			  " sBillModeCode b,sBillModeType c where a.REGION_CODE = b.REGION_CODE" + 
			  " and a.REGION_CODE = '" + regionCode + "' and " + 
			  " a.DISTRICT_CODE = any('" + districtCode + "','99') and " + 
			  " a.MODE_CODE = '" + modeCode + "' and" + 
			  " a.ADD_mode = b.MODE_CODE and " +
			  " b.REGION_CODE = c.REGION_CODE and " +
			  " b.MODE_TYPE = c.MODE_TYPE and " + 
			  " sysdate between b.start_time and b.stop_time and " + 
			  " b.sm_code = c.sm_code "+
			  " and b.mode_flag='2' "+
			  " and b.mode_type != 'YnD4' and b.mode_code not in ('fj@@Mdz7','fj@@Mdz8','fj@@Mdz9','fj@@Mdza') " +
			  "  and b.region_code||b.mode_code not in(select region_code||mode_code from sNoDelAddMode where active_flag='Y' and show_flag='Y') "+
			  " and b.mode_type not in(select distinct mode_type from sAddModeType where active_flag='Y') "+
			  " order by b.MODE_TYPE,a.mode_code";
	  //System.out.println("see++++regionCode"+regionCode+"^^^^^^^^^^"+districtCode+"---"+modeCode);
	  //System.out.println("test==================================");
	  System.out.println("see++++^^^^^^^^^^^^^^^^^^^^^^^^"+sqlStr);
	}
	else if(machineType.equals("b"))
	{
         sqlStr="select MODE_TYPE,TYPE_NAME,MODE_code,MODE_NAME,max(CHOICED_FLAG),max_open "+
         " from (select b.MODE_TYPE,c.TYPE_NAME,a.MODE_CODE,b.MODE_NAME,'2' as CHOICED_FLAG,c.max_open "+
         " from sBillPackCode a,sBillModecode b,sBillModeType c where a.region_code=b.region_code "+
         " and a.mode_code=b.mode_code and b.REGION_CODE = c.REGION_CODE and b.MODE_TYPE = c.MODE_TYPE "+
         " and a.mach_code='"+machineCode+"' union select b.MODE_TYPE,c.TYPE_NAME,a.ADD_MODE,b.MODE_NAME,"+
         " a.CHOICED_FLAG,c.MAX_OPEN from cBillBaDepend a ,sBillModeCode b,sBillModeType c "+
         " where a.REGION_CODE = b.REGION_CODE and a.REGION_CODE = '"+regionCode+"' and "+
         " a.DISTRICT_CODE =any('" + districtCode + "','99') and a.MODE_CODE = '"+modeCode+"' "+
         " and a.ADD_mode = b.MODE_CODE and b.REGION_CODE = c.REGION_CODE and "+
         " b.MODE_TYPE = c.MODE_TYPE and b.sm_code = c.sm_code and b.region_code||b.mode_code not in(select region_code||mode_code from sNoDelAddMode where active_flag='Y' and show_flag='Y')) group by MODE_TYPE,TYPE_NAME,MODE_code,"+
         " MODE_NAME,max_open order by mode_type,mode_code";
		 System.out.println("see2222``````````````````````"+sqlStr);
	}
	else if(machineType.equals("r"))
	{
	   sqlStr="select b.MODE_TYPE,c.TYPE_NAME,a.ADD_MODE,b.MODE_NAME," + 
			" a.CHOICED_FLAG,c.MAX_OPEN from cBillBaDepend a ," + 
			" sBillModeCode b,sBillModeType c where a.REGION_CODE = b.REGION_CODE" + 
			" and a.REGION_CODE = '" + regionCode + "' and " + 
			" a.DISTRICT_CODE = any('" + districtCode + "','99') and " + 
			" a.MODE_CODE = '" + modeCode + "' and" + 
			" a.ADD_mode = b.MODE_CODE and " +
			" b.REGION_CODE = c.REGION_CODE and " +
			" b.MODE_TYPE = c.MODE_TYPE and" +
			" sysdate between b.start_time and b.stop_time and " + 
			" b.sm_code = c.sm_code" +
			"  and b.region_code||b.mode_code not in(select region_code||mode_code from sNoDelAddMode where active_flag='Y' and show_flag='Y') "+
			//" b.mode_type='d'"+
			" order by b.MODE_TYPE,a.add_mode";
			System.out.println("see33333``````````````````````"+sqlStr);
	}
    String selType = "M";
    if(selType.compareTo("S") == 0)
    {   selType = "radio";    }
    if(selType.compareTo("M") == 0)
    {   selType = "checkbox";   }
    //=====================
    int chPos = 0;
    String typeStr = "";
    String inputStr = "";
    String valueStr = "";  

	
%>

<HTML><HEAD><TITLE>黑龙江BOSS-<%=pageTitle%></TITLE>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<BODY bgColor=#FFFFFF leftmargin="0" topmargin="0">

<SCRIPT type=text/javascript>
var js_flag1=new Array("否","否","否","否","否","否","否","否","否","否","否","否","否","否","否","否");
var js_flag3=new Array("否","否","否","否","否","否","否","否","否","否","否","否","否","否","否","否");

function saveTo()
{
      var rIndex;        //选择框索引
      var retValue = ""; //返回值
      var chPos;         //字符位置
      var obj;
      var addNum = 0;				//选择的附加资费数量
      var maxNum = 0;
      var retCode = "";
     
      var retName = "";
      var addType = "";		//附加资费类型
      var addName = "";
      var addFlag1=0;      //默认资费的选中数量
	  var addFlag3=0;      //组绑定资费的选中数量
	  var grpSerial=-1;     //组序号

       //返回单条记录
          for(i=0;i<document.pubAdditiveBill.elements.length;i++)
          {  //*附加资费类型遍历
    		 if(pubAdditiveBill.elements[i].tableType == "additiveType")
    		 {
    		     addNum = 0;
    		     addType = pubAdditiveBill.elements[i].additiveType;   //得到附加资费类型
    		     maxNum = 1*pubAdditiveBill.elements[i].value;     //得到最大可选附加数量
    		     addName = pubAdditiveBill.elements[i].addName;          //得到附加资费类型名称
				 grpSerial++;
                 //rdShowMessageDialog(addName);
    		     for(j=0;j<document.pubAdditiveBill.elements.length;j++)
    		     {	 //$同一资费类型选择
	    		     if((pubAdditiveBill.elements[j].name=="List")&&	    		     	
	    		     	(pubAdditiveBill.elements[j].additiveType == addType))
	    		      {    //判断是否是单选或复选框
	    				   if ((pubAdditiveBill.elements[j].checked==true))
	    				   {     //判断是否被选中
	        			         rIndex = pubAdditiveBill.elements[j].RIndex;
	        			         obj = "Rinput" + rIndex + 2;
	        			         retCode = retCode + document.all(obj).value + "~";
	        			         
	        			         obj = "Rinput" + rIndex + 3;
	        			         retName = retName +  "[" + document.all(obj).value + "]";
	        			         addNum = 1*addNum + 1;
								 
								 if(document.all(obj).flag0123=="1")
									 addFlag1++;
								 if(document.all(obj).flag0123=="4")
									 addFlag3++;	 
	                       }
	    		      }
    		    }//end$
    		    //判断选择的附加资费数量是否大于规定的可选数量
                if(js_flag1[grpSerial]=="是")
				{
                  if(addFlag1==0)
				  {
                     rdShowMessageDialog("您至少应选择一种[" + addName + "]的默认可选资费！",0);
					 return false;
				  }
				}
				addFlag1=0;

    		    if(addNum > maxNum)
    		    {	
    		    	rdShowMessageDialog("选择的[" + addName + "]可选资费数量(" + addNum + ")已经超过了最大可选数量(" + maxNum + ")！",0);
    		    	return false;
    		    }
    		 }//end*
    	   }
    	   
    	   if(js_flag3[0]=="是" || js_flag3[1]=="是" || js_flag3[2]=="是" || js_flag3[3]=="是" || js_flag3[4]=="是")
			{
              if(addFlag3==0)
			  {
                 rdShowMessageDialog("您至少应选择一种多组选一的可选资费！",0);
				 return false;
			  }
			}
					
	   if(retCode =="")
	   {
	        rdShowMessageDialog("请至少选择一种可选资费！");
		    return false;
	   }
       retValue = retCode + "|" + retName;
       window.returnValue = retValue;  		   
       window.close(); 		
}

function blank()
{
  window.returnValue="|";
  window.close();
}

</SCRIPT>

<!--**************************************************************************************-->
</HEAD>
<BODY>
         
     
      
<FORM method=post name="pubAdditiveBill">
	
	<%@ include file="/npage/include/header_pop.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=pageTitle%></div>
		</div>
	
  <table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#FFFFFF">
    <tr>
<%
    String modeType = "";   //可选包类型
    int lineSize = 0;       //每行的列数
 
	boolean oneHaveFlag=false;
    //根据传人的Sql查询数据库，得到返回结果
	try
 	{
 	
 	%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="return_code" retmsg="return_Message" outnum="7">
<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />

<%
 	
 		if(result!=null)
		{
      		int recordNum = result.length;

            //================================================
			String modeTy="";
			int nowGrp=-1;
			for(int i=0;i<recordNum;i++)
			{
              if(modeTy.compareTo(result[i][0]) != 0)
	      	  {
                  nowGrp++;
				  modeTy = result[i][0];
			  }
			  else
			  {
                if(result[i][4].equals("1"))
				{
                  flag1[nowGrp]="是";
%>
                  <script>
	               js_flag1[<%=nowGrp%>]="是";
	              </script>
<%
				}
				else if(result[i][4].equals("4"))
				{
				  flag3[nowGrp]="是"; 
%>
                  <script>
	               js_flag3[<%=nowGrp%>]="是";
	              </script>
<%
				}
			  }
			}
			//================================================

            nowGrp=-1;
			System.out.println("@@@@@@@@@@@@@@@@@@@"+recordNum);
      		for(int i=0;i<recordNum;i++)
      		{
      		    lineSize = lineSize + 1;
      		    if(modeType.compareTo(result[i][0]) != 0)
	      		{
					//处理一组套餐是单数的情况
					if(lineSize==3)
                    {						
      		    	  inputStr = inputStr + "<td colspan=3></td>";
					  out.print(inputStr); 
					  inputStr = "";						 
					}
                    nowGrp++;
					oneHaveFlag=false;
				out.print("<TR>");
	                
					out.print("<TD colspan=3>&nbsp;资费类型："+result[i][1]+"&nbsp;&nbsp;&nbsp;可选数量："+result[i][5]+"</TD>");						
					out.print("<TD colspan=3>&nbsp;本组默认项选择标志："+flag1[nowGrp]+"&nbsp;&nbsp;&nbsp;多组选一标志："+flag3[nowGrp]+"</TD>");

				    out.print("</TR>");
				     out.print("<TR >");
						out.print("<TH width='14%'><div align='center'>资费代码</div></TH>");
						out.print("<TH width='28%'><div align='center'>资费名称</div>" + "<input type='hidden'" + 
							" name='additiveName" + i + "' value='" + result[i][1] + "'> </TH>");
						out.print("<TH width='8%' nowrap><div align='center'>选择方式</div></TH>");
						out.print("<TH width='14%'><div align='center'>资费代码</div></TH>");
						out.print("<TH width='28%'><div align='center'>资费名称</div>" + "<input type='hidden'" +
							" name='additiveNum" + i + "' value='" + result[i][5] + "'" + 
							" tableType='additiveType' addName='" + result[i][1] + "'" +
							" additiveType='" + result[i][0] + "'></TD>");
						out.print("<TH width='8%' nowrap><div align='center'>选择方式</div></TH>");
				     out.print("</TR>");
				     modeType = result[i][0];
				     lineSize = 1;					      			
	      		}


	      		if(lineSize == 1)
	      		{	out.print("<TR>");	}

                //start write the most important col.===========资费代码=================
				inputStr = inputStr + "<TD>&nbsp;<input type=checkbox " +  
					"' name='List' style='cursor:hand' RIndex='" + i + "'" + 
					" additiveType='" + result[i][0] + "'" + 
					"onkeydown='if(event.keyCode==13)saveTo();'";
				if(existModeCode.equals(""))
				{
					if((result[i][4]).compareTo("1") == 0)
					{
						if(oneHaveFlag==false)
						{
						  inputStr = inputStr + " checked";	
						  oneHaveFlag=true;
						}
					}
					if((result[i][4]).compareTo("2") == 0)
					{				 
						inputStr = inputStr + " checked disabled";	
					}
				}
				else
				{
   					if((result[i][4]).compareTo("2") == 0)
					{				 
						inputStr = inputStr + " checked disabled";	
					}
                    else
					{
                       	if(existModeCode.indexOf(result[i][2])!=-1)
						  inputStr+=" checked ";
					}
				}
				inputStr = inputStr + ">";
	            inputStr = inputStr + result[i][2] + "<input type='hidden' " +
					" id='Rinput" + i + "2' class='button' value='" + 
					result[i][2] + "' additiveType='" + result[i][0] +"'></TD>";
				//end write the most important col.========资费代码====================


				//start write the second important col.====资费名称========================
	            inputStr = inputStr + "<TD>" + result[i][3] + "<input type='hidden' " +
					" id='Rinput" + i + "3' class='button' value='" + 
					result[i][3] + "' additiveType='" + result[i][0] + "'  flag0123='"+result[i][4]+ "'></TD>";				
				//end write the second important col.====资费名称========================
				
				inputStr+="<TD><div align=center>"+(String)(hm.get(result[i][4]))+"</div></TD>";
				
				lineSize = lineSize + 1;			 
				if(lineSize == 4)
      		    {	
      		    	lineSize = 0;
      		    	inputStr = inputStr + "</TR>";					
					out.print(inputStr); 
					inputStr = "";	     		    			
      		    }
				
			 }	 //循环结束

            //若最后一组是单数的情况，下列语句将在页面上画出最后一行
 		    if(lineSize==2)
			{						
			  inputStr = inputStr + "<td colspan=3></td>";
			  out.print(inputStr); 
			  inputStr = "";						 
			}
 		  }
			           		                     		                  		            
     	}
     	catch(Exception e)
     	{
     	
     	}          
%>
   </tr>
  </table>


<!------------------------------------------------------>
 
    <TABLE cellSpacing="0">
    <TBODY>
        <TR> 
            <TD align=center id="footer">
                <input class="b_foot" name=commit onClick="saveTo()" style="cursor:hand" type=button value=确认>&nbsp;
                <input class="b_foot" name=back onClick="blank()" style="cursor:hand" type=button value=清除>&nbsp;
            </TD>
        </TR>
    </TBODY>
    </TABLE>
 
 <%@ include file="/npage/include/footer_pop.jsp" %>    
  <!------------------------>  
</FORM>
</BODY></HTML>    
