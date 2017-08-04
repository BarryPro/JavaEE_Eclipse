<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-19 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
<HEAD>
<TITLE>
可选套餐明细
</TITLE>
</HEAD>
<!----------------------------------页头显示区域----------------------------------------->
<body>

<%
//获得服务参数
String opCode = "1270";
String opName = "可选资费";
String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
/* liujian 安全加固修改 2012-4-6 16:18:13 begin */
String op_strong_pwd = (String) session.getAttribute("password");
/* liujian 安全加固修改 2012-4-6 16:18:13 end */
String op_code = "1270"; 
String cust_id = WtcUtil.repNull(request.getParameter("cust_id"));                        //客户ID
String maincash_no = WtcUtil.repNull(request.getParameter("maincash_no"));                //主资费代码
String newcash_no = WtcUtil.repNull(request.getParameter("ip"));                          //新主资费代码
if(newcash_no.indexOf(" ")!=-1){
	newcash_no = newcash_no.substring(0,newcash_no.indexOf(" ")); 
}
String belong_code = WtcUtil.repNull(request.getParameter("belong_code"));                //belong_code
String temmode_type = WtcUtil.repNull(request.getParameter("mode_type"));
String mode_type = temmode_type;                                           //mode_type
String sendflag = WtcUtil.repNull(request.getParameter("sendflag"));                      //生效方式
String mode_name = WtcUtil.repNull(request.getParameter("mode_name"));                    //套餐名称
String minopen = WtcUtil.repNull(request.getParameter("minopen"));											  //得到最大，最小开通数
String maxopen = WtcUtil.repNull(request.getParameter("maxopen"));
String loginNo =(String)session.getAttribute("workNo"); 									//工号

//String mode_type = temmode_type.substring(0,1);                       //mode_type
String ret_code="";
String ret_msg="";
System.out.println("op_code1111============"+op_code);
System.out.println("cust_id============"+cust_id);
System.out.println("maincash_no============"+maincash_no);
System.out.println("newcash_no============"+newcash_no);
System.out.println("belong_code============"+belong_code);
System.out.println("mode_type============"+mode_type);
System.out.println("sendflag============"+sendflag);
System.out.println("mode_name============"+mode_name);

	//调用s1270Init 服务，提取附加资费信息
  //the1270InitList = callView.s1270InitProcess(op_code, cust_id,maincash_no, newcash_no,belong_code ,mode_type,sendflag,mode_name).getList();
%>
				<wtc:service name="s1270InitNew" routerKey="region" routerValue="<%=regionCode%>" outnum="15" >
					<wtc:param value=""/>
					<wtc:param value="01"/>										
					<wtc:param value="<%=op_code%>"/>
					<wtc:param value="<%=loginNo%>"/>
					<wtc:param value="<%=op_strong_pwd%>"/>	
					<wtc:param value=""/>
					<wtc:param value=""/>
					<wtc:param value="<%=cust_id%>"/>
					<wtc:param value="<%=maincash_no%>"/>
					<wtc:param value="<%=newcash_no%>"/>
					<wtc:param value="<%=belong_code%>"/>
					<wtc:param value="<%=mode_type%>"/>
					<wtc:param value="<%=sendflag%>"/>
					<wtc:param value="<%=mode_name%>"/>
				</wtc:service>
				<wtc:array id="result3" start="0" length="2" scope="end"/>	
				<wtc:array id="result3_2" start="2" length="13" scope="end"/>	
<%

        String test[][] = result3_2;

        System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++");
        for(int outer=0 ; test != null && outer< test.length; outer++)
        {
                for(int inner=0 ; test[outer] != null && inner< test[outer].length; inner++)
                {
                        System.out.print(" | "+test[outer][inner]);
                }
                System.out.println(" | ");
        }
        System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++"+ret_code);
		if(result3!=null&&result3.length>0){
			  ret_code = result3[0][0].trim();//错误代码
			  ret_msg = result3[0][1];//错误信息	
		}

   //对返回信息的控制
	  if(ret_msg.equals("")){
				ret_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(ret_code));
				if( ret_msg.equals("null")){
					ret_msg ="未知错误信息";
				}
			}
 /* 
   0 返回代码            oRetCode           
   1 返回信息            oRetMsg            
   2 可选套餐代码        oModeCode          
   3 可选套餐名称        oModeName          
   4 可选套餐的状态      oModeStatus        
   5 可选套餐的开始时间  oTmBegin           
   6 可选套餐的结束时间  oTmEnd             
   7 可选套餐的类别      oModeType          
   8 可选套餐的生效方式  oSendFlagStr       
   9 可选套餐的开通流水  oOldAccept         
  10 choiced_flag        oModeChoiced  [0/c]
*/
%>        
 <%
	if(!ret_code.trim().equals("000000")&&!ret_code.equals("17022")){
%>
	  <script language='javascript'>
			  rdShowMessageDialog("查询错误！错误代码：'<%=ret_code%>'。错误信息：'<%=ret_msg%>'。");
			  window.close();
	  </script>
<%
	}
%>
	  
		<%@ include file="/npage/include/header_pop.jsp" %>     	
		<div class="title">
			<div id="title_zi">可选资费明细</div>
		</div>
      
        <TABLE id=thetab cellSpacing="0">
			   <tr align="center">
        		<th>选择</th>            
						<th>可选套餐名称</th>               
						<th>状态</th>    
						<th>开始时间</th> 		   
						<th>结束时间</th> 	   
						<th>套餐类别</th> 
            <th>生效方式</th>   
            <th>可选方式</th> 
			   </tr>																	   
			   <tr style="display:none">
					   <td><input type="checkbox" name="checkId" id="checkId"></td>
		         <td><div align="center"><input type="text" id="Rinput1" value=""></div></td>
					   <td><div align="center"><input type="text" id="Rinput2" value=""></div></td>
					   <td><div align="center"><input type="text" id="Rinput3" value=""></div></td>
					   <td><div align="center"><input type="text" id="Rinput4" value=""></div></td>
					   <td><div align="center"><input type="text" id="Rinput5" value=""></div></td>
					   <td><div align="center"><input type="text" id="Rinput6" value=""></div></td>
					   <td><div align="center">
					   		 <input type="text" id="Rinput7" value="">
	               <input type="text" id="Rinput8" value="">
							   <input type="text" id="Rinput9" value="">
							   <input type="text" id="Rinput10" value="">
							   <input type="text" id="Rinput11" value="">
							   <input type="text" id="Rinput12" value="">
							   <input type="text" id="Rinput13" value="">
								 </div>
						  </td>
			   </tr>
			   
<!----------------------------------------------------------------------->

<%
			String[][] data= new String[][]{};
			data = result3_2;
      int kk = 0;
	  if(data.length>0){
	    kk = data[0].length - 2 ;
	  }
	  	String tbclass="";
      for(int y=0;y<data.length;y++){
					if(y%2==0){
	      		tbclass="Grey";
	      	}else{
	      		tbclass="";	
	      	}
	  			String addstr = data[y][0] +"#" +data[y][1]+"#"+y;	  
		  %>
  <tr align="center">
  <%if(data[y][kk].equals("0")){//可改不选中%>
  <td class="<%=tbclass%>"><input type="checkbox" name="checkId"  value="<%=addstr%>"></td>

  <%}if(data[y][kk].equals("c")){//不可改不选中%>
  <td class="<%=tbclass%>"><input type="checkbox" name="checkId"  value="<%=addstr%>" onclick="
	if(document.all.checkId[<%=y%>+1].checked==true){
	document.all.checkId[<%=y%>+1].checked=false;}
	rdShowMessageDialog('因生效方式与结束时间冲突而不能申请!');
	return false;
	"></td>
  <%     }
		 // System.out.println("data[0].length="+data[0].length);
      for(int j=0;j<data[0].length;j++){
    String tbstr="";
    String temp="";
	//System.out.println("data["+y+"]["+j+"]"+data[y][j].trim());
	if(j==1)
	{
	String habitus ="";
	if(data[y][j].trim().equals("Y"))habitus="已开通";
	if(data[y][j].trim().equals("N"))habitus="未开通";
	tbstr = "<td class='"+tbclass+"'>" + habitus + "<input type='hidden' " +
          		            " id='Rinput" + (j+1) + "' name='Rinput" + (j+1) + "'  value='" + 
          		            (data[y][j]).trim() + "'readonly></TD>";
	}
	else if(j>6)
	{
	tbstr = " <input type='hidden' " +
          		            " id='Rinput" + (j+1) + "' name='Rinput" + (j+1) + "'  value='" + 
          		            (data[y][j]).trim() + "'readonly>";
	}
	else
	{
	tbstr = "<td class='"+tbclass+"'>" + data[y][j].trim() + "<input type='hidden' " +
          		            " id='Rinput" + (j+1) + "' name='Rinput" + (j+1) + "'  value='" + 
          		            (data[y][j]).trim() + "'readonly></TD>";
	}
	out.println(tbstr);
%>

<%
	}
%>
</tr>
<%
    }
%>
<input type="hidden" name="maxopen" value="<%=maxopen%>">
<input type="hidden" name="minopen" value="<%=minopen%>">
          </TABLE>
          
          
		  <TABLE cellSpacing="0">
          <TBODY>
            <TR> 
              <TD id="footer">
						  <!-------------------------------有记录时------------------------------------>
						  <input class="b_foot" name=sure  type=button value=确认 onclick="if(maxopen()) returndata();">
              <input class="b_foot" name=close  type=button value=关闭 onclick="window.close()">
					  	<!-------------------------
		              <input name=sure  type=button value=确认 onclick="senddata();">
					 		------无记录时------------------------------------>
              </TD>
            </TR>
          </TBODY>
        </TABLE>
        <%@ include file="/npage/include/footer_simple.jsp" %>
		  <body>
		  </html>
		  
		  
<script language="javascript">
/*----------------------------对页面选中数据进行传输--------------------------------*/
function returndata()
{
   
var end = "";
var obj = "";
var thestr = "";
  
for(var i = 1; i<document.all.checkId.length;i++)
	{
		 if(document.all.checkId[i].checked==true)
			{

			 thestr = thestr + document.all.Rinput1[i].value +"|";
			 thestr = thestr + document.all.Rinput2[i].value +"|";
       thestr = thestr + document.all.Rinput3[i].value+"|";
			 thestr = thestr + document.all.Rinput4[i].value+"|";
			 thestr = thestr + document.all.Rinput5[i].value+"|";
			 thestr = thestr + document.all.Rinput6[i].value+"|";
			 thestr = thestr + document.all.Rinput7[i].value+"|";
			 thestr = thestr + document.all.Rinput8[i].value+"|";
			 thestr = thestr + document.all.Rinput9[i].value+"|";
			 thestr = thestr + document.all.Rinput10[i].value+"|";
			 thestr = thestr + document.all.Rinput11[i].value+"|";
			 thestr = thestr + document.all.Rinput12[i].value+"|";
			 if(document.all.Rinput13[i].value==""){
				thestr = thestr +"无描述信息"+"|";
			 }else{
				 thestr = thestr + document.all.Rinput13[i].value+"|";
			 }
			 //rdShowMessageDialog("thestr="+thestr);
			/* for(var t=1;t<13;t++)
				 {
				  obj = "Rinput"+ t;
				  thestr = thestr + document.all[i](obj).value +"|";
				 }
			*/
			 }   
    }
          end = thestr;
//rdShowMessageDialog("end="+end);
   window.returnValue=end;
   window.close();
}
function maxopen()
{
	var flag = 0;
	var maxopen1 = '<%=maxopen%>';
	var minopen1 = '<%=minopen%>';
	for(var z = 1;z<document.all.checkId.length;z++)
	{
		if(document.all.checkId[z].checked==true)
		   {flag++;}
	}
	
  var maxopen = parseInt(maxopen1);
	var minopen = parseInt(minopen1);	
	
	if(flag>maxopen||flag<minopen){//最终的开通数与最大开通数比较
		rdShowMessageDialog("本次开通数为'"+flag+"'应在'"+minopen+"'－'"+maxopen+"'之间！");
	  	return false;
	 	} 
	else{return true;}
}
</script>
